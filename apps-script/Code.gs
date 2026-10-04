/**
 * Wafelverkoop eindejaarsreis TSM — backend in Google Apps Script.
 *
 * Elke bestelling van de bestelpagina komt als rij in het tabblad "Bestellingen".
 * Het tabblad "Overzicht" telt alles op (dozen per product, bedragen, betaald).
 * Zie SETUP.md voor de installatie.
 */

// ---- Pas dit aan -----------------------------------------------------------
const CONFIG = {
  BEGUNSTIGDE: 'Pauwels Björn',           // naam op de rekening
  IBAN: 'BE60 9731 7768 8270',            // rekeningnummer voor de betalingen
  LEERLING: 'Annais Van Camp',            // leerling voor wie de verkoop loopt
  BIC: '',                                // optioneel, bv. 'GEBABEBB'
  DEADLINE: '2026-10-28T23:59:59+01:00',  // laatste moment om te bestellen
  BEVESTIGINGSMAIL: true,                 // koper krijgt een mail met betaalgegevens
  MELDING_NAAR: '',                       // jouw e-mailadres voor een melding per bestelling (leeg = geen)
};
// ----------------------------------------------------------------------------

const PRODUCTS = [
  { id: 'vanille',    name: 'Vanillewafels 700 g',      price: 8 },
  { id: 'choco',      name: 'Chocoladewafels 700 g',    price: 8 },
  { id: 'carre',      name: 'Carré-confiture 700 g',    price: 8 },
  { id: 'frangi',     name: 'Frangipane 700 g',         price: 8 },
  { id: 'brownies',   name: 'Brownies 23 stuks',        price: 10 },
  { id: 'mix',        name: 'Assortimentsmix 800 g',    price: 10 },
  { id: 'suikervrij', name: 'Suikervrije wafels 700 g', price: 10 },
];

const SHEET_ORDERS = 'Bestellingen';
const SHEET_SUMMARY = 'Overzicht';
const HEADERS = ['Tijdstip', 'Bestelnr', 'Naam', 'E-mail', 'Gsm']
  .concat(PRODUCTS.map(p => p.name))
  .concat(['Aantal dozen', 'Totaal (€)', 'Mededeling', 'Betaald', 'Geleverd', 'Opmerking']);
const COL = name => HEADERS.indexOf(name) + 1;

/** Eenmalig uitvoeren vanuit de editor: maakt de tabbladen aan. */
function setup() {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  const orders = ss.getSheetByName(SHEET_ORDERS) || ss.insertSheet(SHEET_ORDERS);
  orders.getRange(1, 1, 1, HEADERS.length).setValues([HEADERS]).setFontWeight('bold').setWrap(true);
  orders.setFrozenRows(1);
  orders.getRange('A:A').setNumberFormat('dd/mm/yyyy hh:mm');
  orders.getRange(1, COL('Totaal (€)'), orders.getMaxRows(), 1).setNumberFormat('€ #,##0.00');

  const sum = ss.getSheetByName(SHEET_SUMMARY) || ss.insertSheet(SHEET_SUMMARY);
  sum.clear();
  const letter = c => orders.getRange(1, c).getA1Notation().replace(/\d+/g, '');
  const paid = letter(COL('Betaald'));
  const rows = [['Product', 'Dozen (alle)', 'Dozen (betaald)', 'Bedrag (alle)']];
  PRODUCTS.forEach((p, i) => {
    const c = letter(COL(p.name));
    rows.push([
      p.name,
      `=SUM(${SHEET_ORDERS}!${c}2:${c})`,
      `=SUMIF(${SHEET_ORDERS}!${paid}2:${paid},TRUE,${SHEET_ORDERS}!${c}2:${c})`,
      `=B${i + 2}*${p.price}`,
    ]);
  });
  const tot = letter(COL('Totaal (€)'));
  const n = PRODUCTS.length + 2;
  rows.push(['Totaal', `=SUM(B2:B${n - 1})`, `=SUM(C2:C${n - 1})`, `=SUM(D2:D${n - 1})`]);
  rows.push(['', '', '', '']);
  rows.push(['Aantal bestellingen', `=COUNTA(${SHEET_ORDERS}!B2:B)`, '', '']);
  rows.push(['Ontvangen (betaald)', `=SUMIF(${SHEET_ORDERS}!${paid}2:${paid},TRUE,${SHEET_ORDERS}!${tot}2:${tot})`, '', '']);
  rows.push(['Nog te ontvangen', `=SUMIF(${SHEET_ORDERS}!${paid}2:${paid},FALSE,${SHEET_ORDERS}!${tot}2:${tot})`, '', '']);
  sum.getRange(1, 1, rows.length, 4).setValues(rows);
  sum.getRange(1, 1, 1, 4).setFontWeight('bold');
  sum.getRange(n, 1, 1, 4).setFontWeight('bold');
  sum.getRange(2, 4, n - 1, 1).setNumberFormat('€ #,##0.00');
  sum.getRange(n + 3, 2, 2, 1).setNumberFormat('€ #,##0.00');
  sum.autoResizeColumns(1, 4);
}

/** Statuscheck voor de bestelpagina. */
function doGet() {
  return json({ ok: true, open: isOpen() });
}

/** Ontvangt een bestelling van de bestelpagina. */
function doPost(e) {
  let data;
  try {
    data = JSON.parse(e.postData.contents);
  } catch (err) {
    return json({ ok: false, error: 'Ongeldige aanvraag.' });
  }
  if (data.website) return json({ ok: false, error: 'Ongeldige aanvraag.' }); // spam-val
  if (!isOpen()) return json({ ok: false, error: 'De bestelperiode is afgelopen.' });

  const name = clean(data.name, 100);
  const email = clean(data.email, 150);
  const phone = clean(data.phone, 30);
  const note = clean(data.note, 500);
  if (!name) return json({ ok: false, error: 'Vul je naam in.' });
  if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) return json({ ok: false, error: 'Vul een geldig e-mailadres in.' });

  const qty = PRODUCTS.map(p => {
    const q = Math.floor(Number((data.qty || {})[p.id]) || 0);
    return Math.max(0, Math.min(99, q));
  });
  const count = qty.reduce((a, b) => a + b, 0);
  if (!count) return json({ ok: false, error: 'Kies minstens één doos.' });
  const total = qty.reduce((s, q, i) => s + q * PRODUCTS[i].price, 0);

  const lock = LockService.getScriptLock();
  lock.waitLock(20000);
  let seq, ref, row;
  try {
    const props = PropertiesService.getScriptProperties();
    seq = Number(props.getProperty('seq') || 0) + 1;
    props.setProperty('seq', String(seq));
    ref = structuredRef(seq);
    const sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName(SHEET_ORDERS);
    sheet.appendRow([new Date(), orderNo(seq), cell(name), cell(email), cell(phone)]
      .concat(qty)
      .concat([count, total, ref, false, false, cell(note)]));
    row = sheet.getLastRow();
    sheet.getRange(row, COL('Betaald'), 1, 2).insertCheckboxes();
  } finally {
    lock.releaseLock();
  }

  const lines = PRODUCTS.map((p, i) => ({ name: p.name, qty: qty[i], price: p.price })).filter(l => l.qty);
  const result = {
    ok: true,
    orderNo: orderNo(seq),
    total: total,
    count: count,
    reference: ref,
    iban: CONFIG.IBAN,
    bic: CONFIG.BIC,
    beneficiary: CONFIG.BEGUNSTIGDE,
    lines: lines,
  };

  try {
    if (CONFIG.BEVESTIGINGSMAIL) sendConfirmation(email, name, result);
    if (CONFIG.MELDING_NAAR) {
      MailApp.sendEmail(CONFIG.MELDING_NAAR, `Nieuwe bestelling ${result.orderNo} – ${euro(total)}`,
        `${name} (${email}${phone ? ', ' + phone : ''}) bestelde ${count} doos/dozen voor ${euro(total)}.\n` +
        lines.map(l => `- ${l.qty} × ${l.name}`).join('\n') + (note ? `\nOpmerking: ${note}` : ''));
    }
  } catch (err) {
    // De bestelling staat in de Sheet; een mislukte mail mag de bestelling niet blokkeren.
    console.error(err);
  }

  return json(result);
}

function sendConfirmation(to, name, r) {
  const rows = r.lines.map(l =>
    `<tr><td>${l.qty} ×</td><td>${esc(l.name)}</td><td style="text-align:right">${euro(l.qty * l.price)}</td></tr>`).join('');
  const html =
    `<p>Dag ${esc(name)},</p>
     <p>Bedankt voor je bestelling bij ${esc(CONFIG.LEERLING)} voor de eindejaarsreis van TSM! Je bestelnummer is <b>${r.orderNo}</b>.</p>
     <table cellpadding="4">${rows}
       <tr><td></td><td><b>Totaal</b></td><td style="text-align:right"><b>${euro(r.total)}</b></td></tr></table>
     <p><b>Betaal vooraf via overschrijving</b>. Je bestelling is pas definitief na betaling.</p>
     <table cellpadding="4">
       <tr><td>Bedrag</td><td><b>${euro(r.total)}</b></td></tr>
       <tr><td>Rekening</td><td><b>${esc(r.iban)}</b></td></tr>
       <tr><td>Begunstigde</td><td>${esc(r.beneficiary)}</td></tr>
       <tr><td>Mededeling</td><td><b>${r.reference}</b></td></tr>
     </table>
     <p>Gebruik zeker de gestructureerde mededeling, dan kunnen we je betaling aan je bestelling koppelen.</p>
     <p>De levering gebeurt op school eind november.</p>
     <p>Bedankt voor je steun!<br>${esc(CONFIG.LEERLING)} en de laatstejaarsleerlingen van TSM</p>`;
  MailApp.sendEmail({ to: to, subject: `Je bestelling ${r.orderNo} – wafelverkoop eindejaarsreis`, htmlBody: html });
}

// ---- Hulpfuncties ----------------------------------------------------------

function isOpen() {
  return new Date() <= new Date(CONFIG.DEADLINE);
}

function orderNo(seq) {
  return 'W' + String(seq).padStart(4, '0');
}

/** Belgische gestructureerde mededeling: +++ddd/dddd/ddddd+++ (10 cijfers + mod-97-controle). */
function structuredRef(seq) {
  const base = 2600000000 + seq; // 26 = schooljaar 2026
  const check = base % 97 || 97;
  const d = String(base) + String(check).padStart(2, '0');
  return `+++${d.slice(0, 3)}/${d.slice(3, 7)}/${d.slice(7)}+++`;
}

function clean(v, max) {
  return String(v == null ? '' : v).replace(/[\u0000-\u001f]/g, ' ').trim().slice(0, max);
}

/** Voorkomt dat ingevulde tekst als formule in de Sheet belandt. */
function cell(s) {
  return /^[=+\-@]/.test(s) ? "'" + s : s;
}

function esc(s) {
  return String(s).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
}

function euro(n) {
  return '€ ' + n.toFixed(2).replace('.', ',');
}

function json(obj) {
  return ContentService.createTextOutput(JSON.stringify(obj)).setMimeType(ContentService.MimeType.JSON);
}
