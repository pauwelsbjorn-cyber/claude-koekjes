// =====================================================================
//  Carl von Linné - eigen insert om te 3D-printen
//
//  Versie 2: maten gemeten (oktober 2026), alle kaarten in hoesjes.
//  Alleen de dikte van munten en lenzen en de maat van het roer zijn
//  nog geschat (SCHATTING).
//
//  Gebruik: open in OpenSCAD (2021.01 of nieuwer), kies onder
//  Window > Customizer het onderdeel, druk F6 (render) en F7 (STL).
//  De console toont na elke render een controlelijst (OK / LET OP).
//
//  Indeling (bovenaanzicht, voorkant onderaan):
//
//    achter  +---------+-------------------+--------+
//            | A       | B kaarten klein   | C      |
//            | kaarten | + gevorderd       | voor-  |
//            | groot   | + solo (roer erop)| raad   |
//            +---------+---------+---------+--------+
//            | D staaltegels (trekbak)     | F  | G  |
//            | 6 vakken                    |    |    |
//            |                             +----+----+
//            +-----------------------------+ H  | I  |
//            | E overige tegels            |    |    |
//    voor    +-----------------------------+----+----+
//
//  Alle bakjes zijn even hoog; de borden en het regelboek liggen er
//  plat bovenop, zodat de doos ook rechtop kan staan.
// =====================================================================

/* [Wat tonen of exporteren] */
// Kies "overzicht" om alles in de doos te zien, of één bakje om als STL te exporteren
onderdeel = "overzicht"; // [overzicht, uiteen, plattegrond, kaarten_groot, kaarten_klein, voorraad, stalen, tegels, speler]

/* [1. Doos - gemeten] */
// Binnenmaat links-rechts (mm)
doos_breedte = 290;
// Binnenmaat voor-achter (mm)
doos_diepte = 290;
// Binnenhoogte van de bodemdoos, tot de rand (mm)
doos_hoogte = 71;
// Vrije hoogte boven alle borden en het regelboek in de doos (mm)
vrije_hoogte = 41;

/* [2. Kaarten met hoesje - gemeten] */
// Reis-, start-, promo- en opzetkaarten (31 stuks): breedte x lengte, stapelhoogte
kaart_groot = [72, 123, 27];
// Boekkaarten (36): hoesje 70 x 70
kaart_boek = [73, 73, 28];
// Briefkaarten (40): Dragon Shield American Mini
kaart_brief = [45.5, 67, 28];
// Solokaarten (20) + solovoorraadfiche erop
kaart_solo = [45.5, 67, 21.5];

/* [3. Tegels en fiches - gemeten] */
// Dikte van een kartonnen tegel (mm)
tegel_dikte = 2.3;
staaltegel = 53;
schetstegel = 23;
// Score- en starttegel
scoretegel = 26;
vijvertegel = 21;
tuinbeloning = [47, 32];
beurtvolgorde = [59, 21];
containerfiche = 21;
gereedschapsfiche = 17;
// Histoire Naturelle-fiche (Buffon)
buffonfiche = [62, 14];
// Canvas- en metamorfosefiche (Merian)
merianfiche = 17;
// Bestemmingsfiche (Baret), rond
baretfiche = 17;
// Lenzen (verbeterd 24, basis en solo 23), dikte - SCHATTING
lens = 24;
lens_dikte = 2.3;
// Metalen munten: 2 Daler en 1 Daler, dikte - SCHATTING
munt_2 = 25;
munt_1 = 20;
munt_dikte = 2.5;
// Roer (hout): grootste breedte met handvatten, dikte - SCHATTING
roer = 62;
roer_dikte = 12;

/* [4. Hout per speler - gemeten] */
// Bloemtegel: zijde en dikte (stapels van 4)
bloemtegel = [22, 6];
// Achthoekige marker: breedte en hoogte (30 per speler)
marker = [11, 10];
// Ontdekker (grootste stuk): breedte x hoogte x dikte
ontdekker = [25, 27, 15];

/* [5. Printinstellingen] */
// Wanddikte buitenkant (mm): 1.6 = 4 lijnen met een 0.4 mm-nozzle
wand = 1.6;
// Wanddikte tussen twee vakken (mm)
binnenwand = 1.2;
// Bodemdikte (mm)
bodem = 1.2;
// Vrije ruimte rondom tussen bakjes en doos, per zijde (mm)
speling_doos = 1.0;
// Vrije ruimte tussen bakjes en borden (mm)
speling_boven = 1.0;
// Ruimte tussen twee bakjes naast elkaar (mm)
tussenruimte = 0.5;
// Minimale speling rond kaarten en tegels in hun vak, per zijde (mm)
speling_vak = 0.5;
// Afronding van de buitenhoeken (mm)
hoek_r = 2;
// Breedte van de vingergleuf (mm)
vinger_breedte = 22;
// Straal van de afgeronde bodem in schepvakken (mm)
schep_r = 10;
// Grootste afmeting die je printer aankan (mm): Bambu Lab A1 = 256
printbed = 256;
// Afstand tussen de bakjes in de "uiteen"-weergave (mm)
uiteen_afstand = 30;

/* [6. Verdeling van de doos] */
// Diepte van de achterste rij: kaarten en voorraad (mm)
rij_achter = 129;
// Breedte van bakje A en C (mm)
breedte_a = 77;
breedte_c = 58;
// Breedte van de staaltegelbak (mm)
breedte_d = 171;
// Diepte van het bakje met de overige tegels (mm)
diepte_e = 42;
// Bakje B: breedte van de kolom boek/brief en diepte van het deel gevorderd spel (mm)
kolom_boek = 76;
diepte_gevorderd = 64;

/* [Hidden] */
$fn = 64;

// ---------------------------------------------------------------------
//  Afgeleide maten
// ---------------------------------------------------------------------

BB = doos_breedte - 2 * speling_doos;   // bruikbare breedte
DD = doos_diepte - 2 * speling_doos;    // bruikbare diepte
H = vrije_hoogte - speling_boven;       // hoogte van alle bakjes
t = tussenruimte;
w = wand;
bw = binnenwand;

rij_voor = DD - rij_achter - t;
breedte_b = BB - breedte_a - breedte_c - 2 * t;
diepte_d = rij_voor - diepte_e - t;
breedte_spelers = BB - breedte_d - t;
speler_b = (breedte_spelers - t) / 2;
speler_d = (rij_voor - t) / 2;

function som(l, n) = n <= 0 ? 0 : l[n - 1] + som(l, n - 1);
// Begin van vak i in een rij vakken met maten l, na de buitenwand
function rij(l, i) = w + som(l, i) + i * bw;
// Wat overblijft voor het laatste vak als de andere maten l hebben
function rest(totaal, l) = totaal - 2 * w - som(l, len(l)) - len(l) * bw;

// Een vak: [x, y, breedte, diepte, vloer, stijl, gleuf, naam]
//   vloer: hoogte van de bodem van het vak (bodem = gewoon vak)
//   stijl: "plat" (kaarten, tegels) of "schep" (losse fiches)
//   gleuf: vingergleuf in de buitenwand: "voor", "achter", "links", "rechts" of ""

// --- A: grote kaarten ------------------------------------------------
vakken_a = [
    [w, w, breedte_a - 2 * w, rij_achter - 2 * w, bodem, "plat", "links",
     "reis 20 + start 4 + promo 3 + opzet 4"]];

// --- B: kleine kaarten, gevorderd spel, solo -------------------------
bx2 = w + kolom_boek + bw;                       // begin rechterkolom
bw2 = breedte_b - w - bx2;                       // breedte rechterkolom
brief_d = rest(rij_achter, []) - (kaart_boek[1] + 2 * speling_vak) - bw;
solo_y = w + diepte_gevorderd + bw;              // begin solo-deel
solo_d = rij_achter - w - solo_y;
roer_vloer = H - roer_dikte - 1;
g_kol = [16, 28, bw2 - 16 - 28 - 2 * bw];        // Buffon, start, Merian/Baret
g_x = [for (i = [0 : 2]) bx2 + som(g_kol, i) + i * bw];

vakken_b = [
    [w, w, kolom_boek, brief_d, bodem, "plat", "voor", "brief (40)"],
    [w, w + brief_d + bw, kolom_boek, rij_achter - 2 * w - brief_d - bw, bodem, "plat", "achter", "boek (36)"],
    [g_x[0], w, g_kol[0], diepte_gevorderd, bodem, "plat", "voor", "Buffon (12)"],
    [g_x[1], w, g_kol[1], 28, bodem, "plat", "voor", "starttegels (15)"],
    [g_x[1], w + 28 + bw, g_kol[1], diepte_gevorderd - 28 - bw, bodem, "schep", "", "sololenzen (9) + Humboldt"],
    [g_x[2], w, g_kol[2], 40, bodem, "plat", "voor", "Merian (18)"],
    [g_x[2], w + 40 + bw, g_kol[2], diepte_gevorderd - 40 - bw, bodem, "schep", "", "Baret (8) + schip"],
    [bx2, solo_y, bw2, solo_d - kaart_solo[0] - 2 * speling_vak - bw, bodem, "plat", "", "Linné (9)"],
    [bx2, rij_achter - w - kaart_solo[0] - 2 * speling_vak, bw2, kaart_solo[0] + 2 * speling_vak,
     bodem, "plat", "achter", "solo (20) + solofiche"],
    [bx2, solo_y, bw2, solo_d, roer_vloer, "plat", "", "roer erop"]];

// --- C: voorraad -----------------------------------------------------
c_d = [lens + 2, gereedschapsfiche + 2, containerfiche + 2, 26];
c_l = concat(c_d, [rest(rij_achter, c_d)]);
c_naam = ["lenzen (27)", "gereedschap (24)", "containers (24)", "munten 1 (40)", "munten 2 (25)"];
c_stijl = ["schep", "plat", "plat", "schep", "schep"];
c_gleuf = ["", "rechts", "rechts", "", ""];
vakken_c = [for (i = [0 : 4])
    [w, rij(c_l, i), breedte_c - 2 * w, c_l[i], bodem, c_stijl[i], c_gleuf[i], c_naam[i]]];

// --- D: staaltegels (trekbak) ----------------------------------------
d_vb = (breedte_d - 2 * w - 2 * bw) / 3;
d_vd = (diepte_d - 2 * w - bw) / 2;
d_naam = ["exotisch (9)", "exotisch (9)", "start 6 + promo 6",
          "gewoon rood (15)", "gewoon groen (15)", "gewoon blauw (15)"];
vakken_d = [for (j = [0 : 1], i = [0 : 2])
    [w + i * (d_vb + bw), w + j * (d_vd + bw), d_vb, d_vd, bodem, "plat",
     j == 0 ? "voor" : "achter", d_naam[j * 3 + i]]];

// --- E: overige tegels -----------------------------------------------
e_l0 = [schetstegel + 1.5, schetstegel + 1.5, schetstegel + 1.5, scoretegel + 1.5];
e_l = concat(e_l0, [rest(breedte_d, e_l0)]);
e_naam = ["schets (13)", "schets (13)", "schets (13)", "score 7 + vijver 9", "tuin 6 + beurtvolgorde 5"];
vakken_e = [for (i = [0 : 4])
    [rij(e_l, i), w, e_l[i], diepte_e - 2 * w, bodem, "plat", "voor", e_naam[i]]];

// --- F t/m I: spelersbakje -------------------------------------------
s_bloem = bloemtegel[0] + 2;
s_x2 = w + s_bloem + bw;
s_b2 = speler_b - w - s_x2;
s_bd = (speler_d - 2 * w - 2 * bw) / 3;
s_markers = 44;
vakken_speler = concat(
    [for (j = [0 : 2])
        [w, w + j * (s_bd + bw), s_bloem, s_bd, bodem, "plat", "links", str("bloemtegels ", j + 1)]],
    [[s_x2, w, s_b2, s_markers, bodem, "schep", "", "markers (30)"],
     [s_x2, w + s_markers + bw, s_b2, speler_d - 2 * w - s_markers - bw, bodem, "schep", "",
      "schepen, lenzen, wolkjes, fiches, ontdekker, onderzoeker"]]);

// Per bakje: [breedte, diepte, vakken, kleur, aantal te printen, inhoud]
function bak(n) =
    n == "kaarten_groot" ? [breedte_a, rij_achter, vakken_a, "SteelBlue", 1, "A: reis-, start-, promo- en opzetkaarten"] :
    n == "kaarten_klein" ? [breedte_b, rij_achter, vakken_b, "LightSteelBlue", 1, "B: boek, brief, solo, gevorderd spel, roer"] :
    n == "voorraad"      ? [breedte_c, rij_achter, vakken_c, "Goldenrod", 1, "C: munten, containers, gereedschap, lenzen"] :
    n == "stalen"        ? [breedte_d, diepte_d, vakken_d, "OliveDrab", 1, "D: staaltegels (75)"] :
    n == "tegels"        ? [breedte_d, diepte_e, vakken_e, "DarkSalmon", 1, "E: schets-, score-, vijver-, tuin- en beurtvolgordetegels"] :
    n == "speler"        ? [speler_b, speler_d, vakken_speler, "IndianRed", 4, "F-I: alles van één speler"] :
    undef;

// Plaats in de doos: [bakje, x, y]
layout = [
    ["kaarten_groot", 0, rij_voor + t],
    ["kaarten_klein", breedte_a + t, rij_voor + t],
    ["voorraad", BB - breedte_c, rij_voor + t],
    ["stalen", 0, diepte_e + t],
    ["tegels", 0, 0],
    ["speler", breedte_d + t, speler_d + t],
    ["speler", breedte_d + t + speler_b + t, speler_d + t],
    ["speler", breedte_d + t, 0],
    ["speler", breedte_d + t + speler_b + t, 0]];

// ---------------------------------------------------------------------
//  Vormen
// ---------------------------------------------------------------------

module blok(bb, d, h, r) {
    hull() for (x = [r, bb - r], y = [r, d - r])
        translate([x, y, 0]) cylinder(r = r, h = h);
}

// Vak met afgeronde voor- en achterkant onderaan
module schepvak(vb, vd, hh) {
    r = min(schep_r, vd / 2, hh - 1);
    hull() {
        for (y = [r, vd - r])
            translate([0, y, r]) rotate([0, 90, 0]) cylinder(r = r, h = vb);
        translate([0, 0, hh - 0.01]) cube([vb, vd, 0.01]);
    }
}

// U-vormige gleuf door één buitenwand; de onderkant komt tot net boven
// de vloer van het vak, zodat je ook de onderste kaart of tegel pakt.
module vingergleuf(v, bb, d) {
    r = min(vinger_breedte, v[2] - 2, v[3] - 2) / 2;
    z = v[4] + r + 1;
    // gleuf in de richting y (voor/achter) of x (links/rechts)
    if (v[6] == "voor" || v[6] == "achter")
        translate([v[0] + v[2] / 2, v[6] == "voor" ? -1 : v[1] + v[3] - 0.01, 0])
            hull() {
                translate([0, 0, z]) rotate([-90, 0, 0]) cylinder(r = r, h = w + 2);
                translate([-r, 0, H]) cube([2 * r, w + 2, 1]);
            }
    if (v[6] == "links" || v[6] == "rechts")
        translate([v[6] == "links" ? -1 : v[0] + v[2] - 0.01, v[1] + v[3] / 2, 0])
            hull() {
                translate([0, 0, z]) rotate([0, 90, 0]) cylinder(r = r, h = w + 2);
                translate([0, -r, H]) cube([w + 2, 2 * r, 1]);
            }
}

module bakje(bb, d, vakken) {
    difference() {
        blok(bb, d, H, hoek_r);
        for (v = vakken) {
            translate([v[0], v[1], v[4]])
                if (v[5] == "schep") schepvak(v[2], v[3], H - v[4] + 1);
                else cube([v[2], v[3], H]);
            if (v[6] != "") vingergleuf(v, bb, d);
        }
    }
}

module bak_vorm(n) {
    p = bak(n);
    if (p == undef) echo(str("LET OP  onbekend onderdeel: ", n));
    else bakje(p[0], p[1], p[2]);
}

// ---------------------------------------------------------------------
//  Overzicht
// ---------------------------------------------------------------------

// Doos zonder voor- en rechterwand, zodat je erin kijkt
module doos_doorsnede() {
    color("Tan") {
        translate([-2, -2, -2]) cube([doos_breedte + 2, doos_diepte + 4, 2]);
        translate([-2, doos_diepte, 0]) cube([doos_breedte + 2, 2, doos_hoogte]);
        translate([-2, -2, 0]) cube([2, doos_diepte + 4, doos_hoogte]);
    }
}

module overzicht(uiteen = 0, met_doos = false) {
    if (met_doos) {
        translate([-speling_doos, -speling_doos, 0]) doos_doorsnede();
        color("Wheat")
            translate([0, 0, H + speling_boven]) cube([BB, DD, doos_hoogte - vrije_hoogte]);
    }
    for (e = layout) {
        p = bak(e[0]);
        color(p[3])
            translate([e[1] * (1 + uiteen / 100), e[2] * (1 + uiteen / 100), 0])
                bak_vorm(e[0]);
    }
}

module plattegrond() {
    overzicht();
    for (e = layout) {
        p = bak(e[0]);
        for (v = p[2]) if (v[7] != "roer erop")
            color("Black")
                translate([e[1] + v[0] + v[2] / 2, e[2] + v[1] + v[3] / 2, H + 2])
                    resize([min(v[2] - 2, len(v[7]) * 2.2), 0], auto = true)
                        text(v[7], size = 3, halign = "center", valign = "center");
    }
}

// ---------------------------------------------------------------------
//  Controle (verschijnt in de console)
// ---------------------------------------------------------------------

function r1(x) = round(x * 10) / 10;
function ok(test) = test ? "OK      " : "LET OP  ";
function vak(n, i) = bak(n)[2][i];
// Past iets van b x l mm, h mm hoog, in vak i van bakje n?
function past(n, i, b, l, h) =
    let(v = vak(n, i), vb = min(v[2], v[3]), vl = max(v[2], v[3]))
    vb >= min(b, l) + 2 * speling_vak && vl >= max(b, l) + 2 * speling_vak
    && H - v[4] >= h;

module check(n, i, wat, b, l, h) {
    v = vak(n, i);
    echo(str(ok(past(n, i, b, l, h)), n, " / ", v[7], ": vak ", r1(v[2]), " x ", r1(v[3]),
             " x ", r1(H - v[4]), " mm voor ", wat, " ", r1(b), " x ", r1(l), " x ", r1(h), " mm"));
}

module controle() {
    echo(str("        Bakjes ", r1(H), " mm hoog; doos ", BB, " x ", DD, " mm bruikbaar"));
    echo(str(ok(breedte_b > kolom_boek + 40), "Breedte bakje B: ", r1(breedte_b), " mm"));
    echo(str(ok(diepte_d > 2 * staaltegel), "Diepte staaltegelbak: ", r1(diepte_d), " mm"));

    check("kaarten_groot", 0, "31 kaarten", kaart_groot[0], kaart_groot[1], kaart_groot[2]);
    check("kaarten_klein", 0, "40 briefkaarten", kaart_brief[0], kaart_brief[1], kaart_brief[2]);
    check("kaarten_klein", 1, "36 boekkaarten", kaart_boek[0], kaart_boek[1], kaart_boek[2]);
    check("kaarten_klein", 2, "12 fiches op één stapel", buffonfiche[1], buffonfiche[0], 12 * tegel_dikte);
    check("kaarten_klein", 3, "15 starttegels", scoretegel, scoretegel, 15 * tegel_dikte);
    check("kaarten_klein", 4, "10 lenzen", lens, lens, 10 * lens_dikte);
    check("kaarten_klein", 5, "2 stapels van 9", merianfiche, 2 * merianfiche + 1, 9 * tegel_dikte);
    check("kaarten_klein", 6, "8 fiches + schip", baretfiche, baretfiche, 8 * tegel_dikte + 10);
    // Onder het roer: hoogte van de stapel + ruimte voor het roer
    check("kaarten_klein", 7, "9 markers op hun zijkant + roer", marker[1], 6 * marker[0],
          2 * marker[0] + H - roer_vloer);
    check("kaarten_klein", 8, "20 solokaarten + roer", kaart_solo[0], kaart_solo[1],
          kaart_solo[2] + H - roer_vloer);
    check("kaarten_klein", 9, "roer", roer, roer, roer_dikte);

    check("voorraad", 0, "27 lenzen, 2 stapels", lens, 2 * lens, 14 * lens_dikte);
    check("voorraad", 1, "24 fiches, 2 stapels", gereedschapsfiche, 2 * gereedschapsfiche, 12 * tegel_dikte);
    check("voorraad", 2, "24 fiches, 2 stapels", containerfiche, 2 * containerfiche, 12 * tegel_dikte);
    // Munten liggen los: het vak moet ongeveer 1,7 keer hun volume hebben
    for (m = [[3, 40, munt_1], [4, 25, munt_2]]) {
        v = vak("voorraad", m[0]);
        echo(str(ok(v[2] * v[3] * (H - bodem) >= 1.7 * m[1] * PI * pow(m[2] / 2, 2) * munt_dikte),
                 "voorraad / ", v[7], ": vak ", r1(v[2]), " x ", r1(v[3]), " mm, losse munten"));
    }

    check("stalen", 3, "15 tegels", staaltegel, staaltegel, 15 * tegel_dikte);
    check("stalen", 2, "12 tegels", staaltegel, staaltegel, 12 * tegel_dikte);

    check("tegels", 0, "13 tegels", schetstegel, schetstegel, 13 * tegel_dikte);
    check("tegels", 3, "16 tegels", scoretegel, scoretegel, 16 * tegel_dikte);
    check("tegels", 4, "11 tegels", beurtvolgorde[0], tuinbeloning[1], 11 * tegel_dikte);

    check("speler", 0, "4 bloemtegels", bloemtegel[0], bloemtegel[0], 4 * bloemtegel[1]);
    check("speler", 4, "ontdekker", ontdekker[0], ontdekker[1], ontdekker[2]);
    // Markers: 30 stuks los, ongeveer 60 % van de ruimte gevuld
    vm = vak("speler", 3);
    echo(str(ok(vm[2] * vm[3] * (H - bodem) * 0.6 >= 30 * 0.83 * marker[0] * marker[0] * marker[1]),
             "speler / markers: ruimte voor 30 markers (losse stapeling)"));

    for (n = ["kaarten_groot", "kaarten_klein", "voorraad", "stalen", "tegels", "speler"])
        echo(str(ok(max(bak(n)[0], bak(n)[1]) <= printbed - 10), "Printbed: ", n, " ",
                 r1(bak(n)[0]), " x ", r1(bak(n)[1]), " x ", r1(H), " mm, ",
                 bak(n)[4], "x printen (", bak(n)[5], ")"));
}

// ---------------------------------------------------------------------

controle();

if (onderdeel == "overzicht") overzicht(met_doos = true);
else if (onderdeel == "uiteen") overzicht(uiteen_afstand);
else if (onderdeel == "plattegrond") plattegrond();
else bak_vorm(onderdeel);
