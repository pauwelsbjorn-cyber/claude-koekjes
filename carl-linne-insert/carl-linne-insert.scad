// =====================================================================
//  Carl von Linné - eigen insert om te 3D-printen
//
//  Versie 2: maten gemeten (oktober 2026), alle kaarten in hoesjes.
//  Alleen de dikte van munten en lenzen is
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
// Deksel, vulling en inplakstuk gebruiken het symbool uit "6. Printinstellingen"
onderdeel = "overzicht"; // [overzicht, uiteen, plattegrond, kaarten_groot, kaarten_klein, voorraad, stalen, tegels, speler, deksel_speler, deksel_icoon, icoon_plak]

/* [1. Doos - gemeten] */
// Binnenmaat links-rechts (mm)
doos_breedte = 290;
// Binnenmaat voor-achter (mm)
doos_diepte = 290;
// Binnenhoogte van de bodemdoos, tot de rand (mm)
doos_hoogte = 71;
// Vrije hoogte boven alle borden en het regelboek in de doos (mm)
vrije_hoogte = 41;
// Grootste bord bovenop (speelbord dichtgevouwen ±22 x 27, regelboek ±21 x 28): breedte x diepte (mm).
// De borden liggen links; bakje C rechtsachter steekt ernaast uit tot onder het deksel.
borden = [220, 280];

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
// Munten: 2 Daler en 1 Daler (metaal en karton even groot), dikte metaal - SCHATTING
munt_2 = 25;
munt_1 = 20;
munt_dikte = 2.5;
// Aantal munten van 1 en van 2: metaal (uitbreiding) en karton (basisspel), dikte karton
munten_metaal = [40, 25];
munten_karton = [45, 40];
munt_karton_dikte = 2.3;
// Roer (hout): breedte met handvatten (3 handvatten, rand Ø 45), dikte
roer = 54;
roer_dikte = 11;

/* [4. Hout per speler - gemeten] */
// Bloemtegel: zijde en dikte (stapels van 4)
bloemtegel = [19.5, 4.4];
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
// Dikte van het deksel; het valt in een randje en ligt gelijk met de bovenkant (mm)
deksel_dikte = 1.6;
// Buitenwand die naast het deksel blijft staan (mm)
deksel_rand = 0.8;
// Speling rond het deksel, per zijde (mm)
deksel_speling = 0.25;
// Hoogte van het pion-icoon op het deksel, en hoe diep het erin zit (mm)
icoon_hoogte = 32;
icoon_diepte = 0.6;
// Spelersymbool (achterkant van de lenzen) onder de pion: welk, grootte en lijndikte (mm)
symbool = "cirkel"; // [cirkel, vierkant, ruit, ster, geen]
symbool_maat = 18;
symbool_lijn = 2;
// Losse pion om in te plakken: zoveel kleiner rondom, voor de lijm (mm)
icoon_plak_speling = 0.15;
// Klikrichel aan voor- en achterkant: lengte, en hoever ze uit de rand steekt (mm).
// Ze grijpt klik_diepte - deksel_speling in het deksel: groter = vaster.
klik_lengte = 16;
klik_diepte = 0.5;
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
H = vrije_hoogte - speling_boven;       // hoogte van alle bakjes onder de borden
H_C = doos_hoogte - speling_boven;      // bakje C: naast de borden, tot onder het deksel
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
// C steekt naast de borden uit tot net onder het deksel van de doos; elk vak
// krijgt een verhoogde vloer, zodat je alles bovenaan kunt pakken.
c_d = [lens + 2, gereedschapsfiche + 2, containerfiche + 2, 26];
c_l = concat(c_d, [rest(rij_achter, c_d)]);
c_vb = breedte_c - 2 * w;
// Losse munten vragen ±1,7 keer hun volume; de grootste van metaal en karton telt
function munt_ruimte(i) = 1.7 * PI * pow((i == 0 ? munt_1 : munt_2) / 2, 2)
    * max(munten_metaal[i] * munt_dikte, munten_karton[i] * munt_karton_dikte);
c_diepte = [14 * lens_dikte + 3, 12 * tegel_dikte + 3, 12 * tegel_dikte + 3,
            munt_ruimte(0) / (c_vb * c_l[3]) + 2, munt_ruimte(1) / (c_vb * c_l[4]) + 2];
c_naam = ["lenzen (27)", "gereedschap (24)", "containers (24)", "munten 1", "munten 2"];
c_stijl = ["schep", "plat", "plat", "schep", "schep"];
c_gleuf = ["", "rechts", "rechts", "", ""];
vakken_c = [for (i = [0 : 4])
    [w, rij(c_l, i), c_vb, c_l[i], max(bodem, H_C - c_diepte[i]), c_stijl[i], c_gleuf[i], c_naam[i]]];

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
s_bloem = bloemtegel[0] + 2 * speling_vak;   // krap: de stapel mag niet schuiven
s_x2 = w + s_bloem + bw;
s_b2 = speler_b - w - s_x2;
s_bd = (speler_d - 2 * w - 2 * bw) / 3;      // ruimte per stapel; het vak staat in het midden
s_markers = 44;
// verhoogde vloer: de bovenste bloemtegel komt 1 mm onder het deksel
s_bloem_vloer = H - deksel_dikte - 4 * bloemtegel[1] - 1;
vakken_speler = concat(
    [for (j = [0 : 2])
        [w, w + j * (s_bd + bw) + (s_bd - s_bloem) / 2, s_bloem, s_bloem, s_bloem_vloer, "plat", "links",
         str("bloemtegels ", j + 1)]],
    [[s_x2, w, s_b2, s_markers, bodem, "schep", "", "markers (30)"],
     [s_x2, w + s_markers + bw, s_b2, speler_d - 2 * w - s_markers - bw, bodem, "schep", "",
      "schepen, lenzen, wolkjes, fiches, ontdekker, onderzoeker"]]);

// Per bakje: [breedte, diepte, vakken, kleur, aantal te printen, inhoud, met deksel, hoogte]
function bak(n) =
    n == "kaarten_groot" ? [breedte_a, rij_achter, vakken_a, "SteelBlue", 1, "A: reis-, start-, promo- en opzetkaarten", false, H] :
    n == "kaarten_klein" ? [breedte_b, rij_achter, vakken_b, "LightSteelBlue", 1, "B: boek, brief, solo, gevorderd spel, roer", false, H] :
    n == "voorraad"      ? [breedte_c, rij_achter, vakken_c, "Goldenrod", 1, "C: munten, containers, gereedschap, lenzen", false, H_C] :
    n == "stalen"        ? [breedte_d, diepte_d, vakken_d, "OliveDrab", 1, "D: staaltegels (75)", false, H] :
    n == "tegels"        ? [breedte_d, diepte_e, vakken_e, "DarkSalmon", 1, "E: schets-, score-, vijver-, tuin- en beurtvolgordetegels", false, H] :
    n == "speler"        ? [speler_b, speler_d, vakken_speler, "IndianRed", 4, "F-I: alles van één speler", true, H] :
    undef;

// Bruikbare hoogte in een bakje: tot de bovenkant, of tot onder het deksel
function hoog(n) = bak(n)[7] - (bak(n)[6] ? deksel_dikte : 0);

// Plaats in de doos: [bakje, x, y, symbool op het deksel]
layout = [
    ["kaarten_groot", 0, rij_voor + t],
    ["kaarten_klein", breedte_a + t, rij_voor + t],
    ["voorraad", BB - breedte_c, rij_voor + t],
    ["stalen", 0, diepte_e + t],
    ["tegels", 0, 0],
    ["speler", breedte_d + t, speler_d + t, "cirkel"],
    ["speler", breedte_d + t + speler_b + t, speler_d + t, "vierkant"],
    ["speler", breedte_d + t, 0, "ruit"],
    ["speler", breedte_d + t + speler_b + t, 0, "ster"]];

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
module vingergleuf(v, bb, d, h = H) {
    r = min(vinger_breedte, v[2] - 2, v[3] - 2) / 2;
    z = v[4] + r + 1;
    // gleuf in de richting y (voor/achter) of x (links/rechts)
    if (v[6] == "voor" || v[6] == "achter")
        translate([v[0] + v[2] / 2, v[6] == "voor" ? -1 : v[1] + v[3] - 0.01, 0])
            hull() {
                translate([0, 0, z]) rotate([-90, 0, 0]) cylinder(r = r, h = w + 2);
                translate([-r, 0, h]) cube([2 * r, w + 2, 1]);
            }
    if (v[6] == "links" || v[6] == "rechts")
        translate([v[6] == "links" ? -1 : v[0] + v[2] - 0.01, v[1] + v[3] / 2, 0])
            hull() {
                translate([0, 0, z]) rotate([0, 90, 0]) cylinder(r = r, h = w + 2);
                translate([0, -r, h]) cube([w + 2, 2 * r, 1]);
            }
}

// Twee liggende staafjes langs de voor- en achterrand, op hoogte z.
// Middelpunt op y = yc vanaf de rand: in het bakje steken ze klik_diepte
// voorbij de wand uit, in het deksel vormen ze de groef waar ze in klikken.
klik_r = 0.6;
module klikstaven(bb, d, z, yc, r, l = klik_lengte) {
    for (y = [yc, d - yc])
        translate([bb / 2 - l / 2, y, z]) rotate([0, 90, 0]) cylinder(r = r, h = l, $fn = 24);
}

module bakje(bb, d, vakken, deksel = false, h = H) {
    if (deksel)
        klikstaven(bb, d, h - deksel_dikte / 2, deksel_rand + klik_diepte - klik_r, klik_r);
    difference() {
        blok(bb, d, h, hoek_r);
        for (v = vakken) {
            translate([v[0], v[1], v[4]])
                if (v[5] == "schep") schepvak(v[2], v[3], h - v[4] + 1);
                else cube([v[2], v[3], h]);
            if (v[6] != "") vingergleuf(v, bb, d, h);
        }
        // randje waar het deksel in valt; het rust op de binnenwanden
        if (deksel)
            translate([deksel_rand, deksel_rand, h - deksel_dikte])
                blok(bb - 2 * deksel_rand, d - 2 * deksel_rand, deksel_dikte + 1, hoek_r - deksel_rand);
    }
}

// Pion: kop, hals en voet (2D, rond de oorsprong, ±30 mm hoog)
module pion_2d() {
    translate([0, 9.5]) circle(r = 5.5);
    translate([0, 3.5]) scale([1, 0.35]) circle(r = 7);
    hull() {
        translate([0, 3]) circle(r = 3.5);
        translate([-7.5, -10]) square([15, 1]);
    }
    offset(r = 1) translate([-9.5, -14]) square([19, 4]);
}

// Gevulde vorm van een spelersymbool, symbool_maat groot
module symbool_vorm(sym) {
    m = symbool_maat;
    if (sym == "cirkel") circle(d = m);
    if (sym == "vierkant") square(m * 0.85, center = true);
    if (sym == "ruit") rotate(45) square(m * 0.75, center = true);
    // vier punten met holle zijden
    if (sym == "ster") difference() {
        square(m, center = true);
        for (x = [-1, 1], y = [-1, 1]) translate([x, y] * m / 2) circle(r = m * 0.47);
    }
}

// Omtrek van het symbool, zoals op de achterkant van de lenzen
module symbool_2d(sym) {
    difference() {
        symbool_vorm(sym);
        offset(r = -symbool_lijn) symbool_vorm(sym);
    }
}

// Pion met het spelersymbool eronder
module icoon_2d(sym) {
    translate([0, sym == "geen" ? 0 : 12]) resize([0, icoon_hoogte], auto = true) pion_2d();
    if (sym != "geen") translate([0, -22]) symbool_2d(sym);
}

module deksel(n, sym = symbool) {
    p = bak(n);
    s = deksel_rand + deksel_speling;
    difference() {
        translate([s, s, 0])
            blok(p[0] - 2 * s, p[1] - 2 * s, deksel_dikte, max(hoek_r - s, 0.5));
        translate([p[0] / 2, p[1] / 2, deksel_dikte - icoon_diepte])
            linear_extrude(icoon_diepte + 1) icoon_2d(sym);
        // groef voor de klikrichel, iets ruimer en langer
        klikstaven(p[0], p[1], deksel_dikte / 2, deksel_rand + klik_diepte - klik_r, klik_r + 0.1,
                   klik_lengte + 1);
    }
}

// Vulling van het icoon, om in een andere kleur te printen (AMS)
module deksel_icoon(n, sym = symbool) {
    p = bak(n);
    translate([p[0] / 2, p[1] / 2, deksel_dikte - icoon_diepte])
        linear_extrude(icoon_diepte) icoon_2d(sym);
}

// Losse pion en symbool om achteraf in te plakken, plat op het printbed
module icoon_plak(sym = symbool) {
    linear_extrude(icoon_diepte) offset(delta = -icoon_plak_speling) icoon_2d(sym);
}

module bak_vorm(n) {
    p = bak(n);
    if (p == undef) echo(str("LET OP  onbekend onderdeel: ", n));
    else bakje(p[0], p[1], p[2], p[6], p[7]);
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

module overzicht(uiteen = 0, met_doos = false, met_deksel = true) {
    if (met_doos) {
        translate([-speling_doos, -speling_doos, 0]) doos_doorsnede();
        color("Wheat")
            translate([0, (DD - borden[1]) / 2, H + speling_boven])
                cube([borden[0], borden[1], doos_hoogte - vrije_hoogte]);
    }
    for (e = layout) {
        p = bak(e[0]);
        translate([e[1] * (1 + uiteen / 100), e[2] * (1 + uiteen / 100), 0]) {
            color(p[3]) bak_vorm(e[0]);
            // deksel erop, of erboven in de "uiteen"-weergave
            if (p[6] && met_deksel)
                translate([0, 0, H - deksel_dikte + (uiteen > 0 ? 25 : 0)]) {
                    color(p[3]) deksel(e[0], e[3]);
                    color("Ivory") deksel_icoon(e[0], e[3]);
                }
        }
    }
}

module plattegrond() {
    overzicht(met_deksel = false);
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
    && hoog(n) - v[4] >= h;

module check(n, i, wat, b, l, h) {
    v = vak(n, i);
    echo(str(ok(past(n, i, b, l, h)), n, " / ", v[7], ": vak ", r1(v[2]), " x ", r1(v[3]),
             " x ", r1(hoog(n) - v[4]), " mm voor ", wat, " ", r1(b), " x ", r1(l), " x ", r1(h), " mm"));
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
    for (i = [0 : 1]) {
        v = vak("voorraad", 3 + i);
        echo(str(ok(v[2] * v[3] * (hoog("voorraad") - v[4]) >= munt_ruimte(i)),
                 "voorraad / ", v[7], ": vak ", r1(v[2]), " x ", r1(v[3]), " x ", r1(hoog("voorraad") - v[4]),
                 " mm voor ", munten_metaal[i], " metalen of ", munten_karton[i], " kartonnen munten, los"));
    }
    echo(str(ok(borden[0] <= BB - breedte_c - t), "Borden bovenop ", borden[0], " mm breed: naast bakje C (",
             r1(H_C), " mm hoog)"));

    check("stalen", 3, "15 tegels", staaltegel, staaltegel, 15 * tegel_dikte);
    check("stalen", 2, "12 tegels", staaltegel, staaltegel, 12 * tegel_dikte);

    check("tegels", 0, "13 tegels", schetstegel, schetstegel, 13 * tegel_dikte);
    check("tegels", 3, "16 tegels", scoretegel, scoretegel, 16 * tegel_dikte);
    check("tegels", 4, "11 tegels", beurtvolgorde[0], tuinbeloning[1], 11 * tegel_dikte);

    check("speler", 0, "4 bloemtegels", bloemtegel[0], bloemtegel[0], 4 * bloemtegel[1]);
    check("speler", 4, "ontdekker", ontdekker[0], ontdekker[1], ontdekker[2]);
    // Markers: 30 stuks los, ongeveer 60 % van de ruimte gevuld
    vm = vak("speler", 3);
    echo(str(ok(vm[2] * vm[3] * (hoog("speler") - bodem) * 0.6 >= 30 * 0.83 * marker[0] * marker[0] * marker[1]),
             "speler / markers: ruimte voor 30 markers (losse stapeling)"));
    echo(str("        Deksel speler: ", r1(speler_b - 2 * (deksel_rand + deksel_speling)), " x ",
             r1(speler_d - 2 * (deksel_rand + deksel_speling)), " x ", deksel_dikte,
             " mm, icoon ", icoon_diepte, " mm diep, klikt ", klik_diepte - deksel_speling,
             " mm vast, 4x printen"));

    for (n = ["kaarten_groot", "kaarten_klein", "voorraad", "stalen", "tegels", "speler"])
        echo(str(ok(max(bak(n)[0], bak(n)[1]) <= printbed - 10), "Printbed: ", n, " ",
                 r1(bak(n)[0]), " x ", r1(bak(n)[1]), " x ", r1(bak(n)[7]), " mm, ",
                 bak(n)[4], "x printen (", bak(n)[5], ")"));
}

// ---------------------------------------------------------------------

controle();

if (onderdeel == "overzicht") overzicht(met_doos = true);
else if (onderdeel == "uiteen") overzicht(uiteen_afstand);
else if (onderdeel == "plattegrond") plattegrond();
else if (onderdeel == "deksel_speler") deksel("speler");
else if (onderdeel == "deksel_icoon") deksel_icoon("speler");
else if (onderdeel == "icoon_plak") icoon_plak();
else bak_vorm(onderdeel);
