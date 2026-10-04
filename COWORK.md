# Opdracht voor Claude Cowork: wafelverkoop online zetten

Hallo Claude. Werk deze opdracht af in de browser. Bjorn (Björn Pauwels) is ingelogd bij Google en GitHub. Volg de stappen in volgorde en vink ze af.

## Waarom

Er is al een online bestelpagina gebouwd voor een wafelverkoop ten voordele van de eindejaarsreis van TSM. Er moet nog twee dingen gebeuren:
- de backend (Google Apps Script + Google Sheet) installeren in Bjorns Google-account
- de pagina publiceren via GitHub Pages

Alle code is klaar. Je hoeft niets te programmeren, alleen te installeren en te klikken.

- Repo: https://github.com/pauwelsbjorn-cyber/claude-koekjes (nu nog privé)
- Pull request met alles: https://github.com/pauwelsbjorn-cyber/claude-koekjes/pull/1 (branch `claude/whatsapp-registration-orders-4111c3`)
- Het volledige script staat onderaan dit bestand, en ook in de repo als `apps-script/Code.gs`.

## Wanneer je Bjorn iets moet vragen

- **Stap 5**: Bjorn kijkt de pull request zelf na en voegt ze zelf samen. Doe dat niet in zijn plaats.
- Google of GitHub vraagt een wachtwoord, 2FA-code of toont een inlogscherm.
- Een stap loopt anders dan hier beschreven en je moet een keuze maken.

Bjorn heeft al beslist dat de repo publiek mag worden (stap 6). Klik nooit op iets dat geld kost, en verander niets buiten deze repo en deze ene nieuwe Sheet.

---

## Stap 1. Google Sheet en script

1. Open **https://sheets.new** (Bjorns Google-account).
2. Klik op de titel "Naamloze spreadsheet" en noem de Sheet **Wafelverkoop eindejaarsreis**.
3. Kies in het menu **Extensies → Apps Script**. Er opent een nieuw tabblad met de editor en het bestand `Code.gs`.
4. Noem het project **Wafelverkoop backend** (klik op "Naamloos project" bovenaan).
5. Selecteer alle code in de editor (Ctrl+A / Cmd+A) en vervang ze door het **volledige script** onderaan dit bestand: alles tussen de regels `// ===== BEGIN Code.gs =====` en `// ===== EINDE Code.gs =====`.
   - Werkt plakken niet goed in de editor, open dan het bestand in GitHub (PR → *Files changed* → `apps-script/Code.gs` → knop **Raw**), kopieer het daar en plak het opnieuw.
   - Controleer na het plakken: het script begint met `/**` en eindigt met de functie `json(obj)`. De editor toont geen rode foutmarkeringen.
6. Klik op **Opslaan** (diskette-icoon, of Ctrl+S).

## Stap 2. Tabbladen aanmaken (functie `setup`)

1. Kies in de werkbalk, in de keuzelijst naast "Fouten opsporen", de functie **setup**.
2. Klik op **Uitvoeren**.
3. Google vraagt toestemming ("Autorisatie vereist"):
   - klik op **Rechten controleren** en kies Bjorns account
   - je ziet "Google heeft deze app niet geverifieerd": klik op **Geavanceerd** en dan op **Ga naar Wafelverkoop backend (onveilig)**. Dat is normaal: het is Bjorns eigen script.
   - klik op **Toestaan** (rechten voor Sheets en e-mail versturen)
4. Wacht tot het uitvoeringslogboek "Uitvoering voltooid" meldt.
5. Ga terug naar het tabblad van de Sheet. Er moeten twee tabbladen zijn: **Bestellingen** (met kolomkoppen) en **Overzicht** (met formules per product). Zie je dat niet, herlaad de Sheet.

## Stap 3. Publiceren als webapp

1. Klik in de Apps Script-editor rechtsboven op **Implementeren → Nieuwe implementatie**.
2. Klik op het tandwiel naast "Type selecteren" en kies **Web-app**.
3. Vul in:
   - Beschrijving: `v1`
   - Uitvoeren als: **Ik (Bjorns e-mailadres)**
   - Wie heeft toegang: **Iedereen** (niet "Iedereen met een Google-account")
4. Klik op **Implementeren**. Vraagt Google opnieuw toestemming, doe dan hetzelfde als in stap 2.
5. Kopieer de **URL van de web-app**. Die ziet eruit als `https://script.google.com/macros/s/AKfy.../exec`. Bewaar ze, je hebt ze nodig in stap 4.
6. Controleer de URL: open ze in een nieuw tabblad. Je moet `{"ok":true,"open":true}` zien.

## Stap 4. URL in de bestelpagina zetten (GitHub)

1. Open https://github.com/pauwelsbjorn-cyber/claude-koekjes/blob/claude/whatsapp-registration-orders-4111c3/docs/index.html
2. Klik op het **potloodje** (Edit this file). Controleer dat bovenaan de branch **claude/whatsapp-registration-orders-4111c3** staat, niet `main`.
3. Zoek de regel:
   ```js
   const SCRIPT_URL = "";
   ```
   en vervang ze door (met de URL uit stap 3):
   ```js
   const SCRIPT_URL = "https://script.google.com/macros/s/AKfy.../exec";
   ```
   Verander verder niets in het bestand.
4. Klik op **Commit changes...**, kies **Commit directly to the claude/whatsapp-registration-orders-4111c3 branch**, bericht: `Set Apps Script web app URL`, en bevestig.

## Stap 5. Bjorn voegt de pull request samen

1. Vraag Bjorn om https://github.com/pauwelsbjorn-cyber/claude-koekjes/pull/1 te openen, na te kijken en zelf op **Ready for review**, **Merge pull request** en **Confirm merge** te klikken.
2. Wacht tot Bjorn bevestigt dat dat gebeurd is. Controleer dat de PR de status **Merged** heeft, en ga dan verder.

## Stap 6. Repo publiek maken en GitHub Pages aanzetten

1. Open https://github.com/pauwelsbjorn-cyber/claude-koekjes/settings
2. Scroll naar **Danger Zone → Change repository visibility → Change visibility → Change to public**. Volg de bevestigingen (je moet de reponaam `pauwelsbjorn-cyber/claude-koekjes` intypen). Vraagt GitHub om een wachtwoord of 2FA-code, vraag die aan Bjorn.
3. Open https://github.com/pauwelsbjorn-cyber/claude-koekjes/settings/pages
4. Bij *Build and deployment*:
   - Source: **Deploy from a branch**
   - Branch: **main**, map: **/docs**
   - klik op **Save**
5. Wacht 1 à 2 minuten en herlaad de pagina tot bovenaan "Your site is live at https://pauwelsbjorn-cyber.github.io/claude-koekjes/" staat.

## Stap 7. Testbestelling

1. Open **https://pauwelsbjorn-cyber.github.io/claude-koekjes/** (doe een harde herlaad als je een oude versie ziet).
2. Controleer: 7 producten met foto, en geen melding "Bestellen is nog niet geactiveerd".
3. Plaats een testbestelling: 1 doos Vanillewafels, naam `TEST`, Bjorns e-mailadres, opmerking `test, mag weg`.
4. Controleer:
   - de pagina toont bestelnummer **W0001**, € 8,00, rekening BE60 9731 7768 8270, een mededeling `+++260/0000/00170+++` en een QR-code
   - in de Sheet, tabblad **Bestellingen**, staat een rij voor TEST
   - in Bjorns mailbox staat een bevestigingsmail (kan een minuutje duren, kijk ook bij spam)
5. Ruim de test op:
   - verwijder de TEST-rij in **Bestellingen** (rechtsklik op het rijnummer → Rij verwijderen)
   - zet de teller terug: in de Apps Script-editor → **Projectinstellingen** (tandwiel links) → **Scripteigenschappen** → verwijder de eigenschap **seq**. De eerste echte bestelling krijgt dan weer W0001.

## Stap 8. Afronden

Geef Bjorn een kort verslag:
- de link voor de WhatsApp-groep: **https://pauwelsbjorn-cyber.github.io/claude-koekjes/**
- de link naar de Google Sheet (zet die ook in zijn bladwijzers)
- of de testbestelling, de mail en de opruiming gelukt zijn
- wat er eventueel niet lukte, en waarom

Stel daarna een kort WhatsApp-bericht voor dat Bjorn in de groep kan zetten, bijvoorbeeld:

> Hallo allemaal! Annais verkoopt wafels en koekjes voor de eindejaarsreis van TSM 🧇
> Bestellen kan tot 28/10 via deze link: https://pauwelsbjorn-cyber.github.io/claude-koekjes/
> Je betaalt vooraf via overschrijving (QR-code voor je bankapp). Levering eind november. Bedankt voor jullie steun!

---

## Het volledige script (`Code.gs`)

```js
// ===== BEGIN Code.gs =====
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
// ===== EINDE Code.gs =====
```
