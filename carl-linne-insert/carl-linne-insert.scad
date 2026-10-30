// =====================================================================
//  Carl von Linné - eigen insert om te 3D-printen
//
//  Versie 1 (concept): alle maten met "SCHATTING" zijn nog niet gemeten.
//  Vul na het meten sectie 1 en 2 in en exporteer opnieuw; de bakjes
//  passen zich vanzelf aan de doos aan.
//
//  Gebruik: open in OpenSCAD (2021.01 of nieuwer), kies onder
//  Window > Customizer het onderdeel, druk F6 (render) en F7 (STL).
//  De console toont na elke render een controlelijst (OK / LET OP).
//
//  Indeling (bovenaanzicht, voorkant onderaan):
//
//    achter  +-----------+-----------+-----------------------+
//            | speler    | speler    |  houten fiches        |
//            | 1 + 2     | 3 + 4     |  (4 vakken)           |
//            +-----------+-----------+-----------------------+
//            | monstertegels         |  schets-, start- en   |
//            | (4 vakken)            |  overige tegels (6)   |
//            +-----------------------+-----------------------+
//            | kaarten 2 vakken      |  kaarten 2 vakken     |
//            | + munten erbovenop    |  + lenzen erbovenop   |
//    voor    +-----------------------+-----------------------+
//
//  Daarboven liggen de borden en het regelboek plat.
// =====================================================================

/* [Wat tonen of exporteren] */
// Kies "overzicht" om alles in de doos te zien, of één bakje om als STL te exporteren
onderdeel = "overzicht"; // [overzicht, uiteen, plattegrond, kaarten, munten, lenzen, monsters, tegels, speler, hout]

/* [1. Doos - METEN] */
// Binnenmaat links-rechts (mm) - SCHATTING
doos_breedte = 290;
// Binnenmaat voor-achter (mm) - SCHATTING
doos_diepte = 290;
// Binnenhoogte van de bodemdoos, tot de rand (mm) - SCHATTING
doos_hoogte = 70;
// Stapel speelbord + spelersborden + karakterborden + regelboek, licht aangedrukt (mm) - SCHATTING
borden_hoogte = 30;

/* [2. Onderdelen - METEN] */
// Kaartbreedte (mm), met hoesje als je hoesjes gebruikt - SCHATTING
kaart_breedte = 63.5;
// Kaartlengte (mm), met hoesje als je hoesjes gebruikt - SCHATTING
kaart_lengte = 88;
// Dikte per kaart (mm): ongeveer 0.32 zonder hoesje, 0.6 met hoesje - SCHATTING
kaart_dikte = 0.32;
// Grootste stapel kaarten in één vak (brieven: 40)
max_kaarten_per_vak = 40;
// Monstertegels, 69 stuks (mm) - SCHATTING
monster_breedte = 40;
monster_lengte = 40;
// Schets-, start- en overige tegels (mm) - SCHATTING
tegel_breedte = 40;
tegel_lengte = 40;
// Dikte van één kartonnen tegel (mm) - SCHATTING
tegel_dikte = 2.0;

/* [3. Printinstellingen] */
// Wanddikte (mm): 1.6 = 4 lijnen met een 0.4 mm-nozzle
wand = 1.6;
// Bodemdikte (mm)
bodem = 1.2;
// Vrije ruimte rondom tussen bakjes en doos, per zijde (mm)
speling_doos = 1.0;
// Vrije ruimte tussen bakjes en borden (mm)
speling_boven = 1.0;
// Ruimte tussen twee bakjes naast elkaar (mm)
tussenruimte = 0.5;
// Minimale speling rond kaarten en tegels in hun vak, per zijde (mm)
speling_vak = 1.0;
// Afronding van de buitenhoeken (mm)
hoek_r = 2;
// Breedte van de vingergleuf in kaart- en tegelbakjes (mm)
vinger_breedte = 24;
// Straal van de afgeronde bodem in bakjes voor losse fiches (mm)
schep_r = 12;
// Grootste afmeting die je printer aankan (mm)
printbed = 220;
// Afstand tussen de bakjes in de "uiteen"-weergave (mm)
uiteen_afstand = 30;

/* [Hidden] */
$fn = 64;

// ---------------------------------------------------------------------
//  Afgeleide maten
// ---------------------------------------------------------------------

B = doos_breedte - 2 * speling_doos;   // bruikbare breedte
D = doos_diepte - 2 * speling_doos;    // bruikbare diepte
H = doos_hoogte - borden_hoogte - speling_boven;   // hoogte onder de borden

CB = B / 4;   // celbreedte: de doos is verdeeld in 4 kolommen
CD = D / 3;   // celdiepte: en in 3 rijen

// Kaartbakjes zijn net hoog genoeg voor de grootste stapel; in de
// ruimte erboven past dan nog een voorraadbakje (munten, lenzen).
hk_nodig = ceil(bodem + max_kaarten_per_vak * kaart_dikte + 3);
boven_kaarten = H - hk_nodig >= 12;
HK = boven_kaarten ? hk_nodig : H;
HV = H - HK;
HS = H / 2;   // spelersbakjes staan per twee op elkaar

// Per bakje: [cellen breed, hoogte, vakken naast elkaar, vakken achter elkaar,
//             stijl, kleur, aantal te printen, inhoud]
// Stijl "plat": vlakke bodem en vingergleuf (kaarten, tegels).
// Stijl "schep": afgeronde bodem, fiches schuif je er makkelijk uit.
function bak(n) =
    n == "kaarten"  ? [2, HK, 2, 1, "plat",  "SteelBlue",    2, "kaarten: brieven, boeken, reizen, overige"] :
    n == "munten"   ? [2, HV, 2, 1, "schep", "Goldenrod",    1, "munten (89)"] :
    n == "lenzen"   ? [2, HV, 2, 2, "schep", "LightSkyBlue", 1, "lenzen, grondstoffen, gevorderde fiches"] :
    n == "monsters" ? [2, H,  2, 2, "plat",  "OliveDrab",    1, "monstertegels (69)"] :
    n == "tegels"   ? [2, H,  3, 2, "plat",  "DarkSeaGreen", 1, "schets- (36), overige (27) en starttegels (15)"] :
    n == "speler"   ? [1, HS, 1, 2, "schep", "IndianRed",    4, "per speler: houten markers en startlenzen"] :
    n == "hout"     ? [2, H,  2, 2, "schep", "BurlyWood",    1, "houten fiches (98)"] :
    undef;

function bak_b(n) = bak(n)[0] * CB - tussenruimte;
function bak_d(n) = CD - tussenruimte;
// Binnenmaat van één vak: [breedte, diepte, hoogte]
function vak(n) = let(p = bak(n))
    [(bak_b(n) - (p[2] + 1) * wand) / p[2],
     (bak_d(n) - (p[3] + 1) * wand) / p[3],
     p[1] - bodem];

// Plaats in de doos: [bakje, kolom, rij (0 = voor), hoogte]
layout = concat(
    [["kaarten", 0, 0, 0], ["kaarten", 2, 0, 0]],
    boven_kaarten ? [["munten", 0, 0, HK], ["lenzen", 2, 0, HK]] : [],
    [["monsters", 0, 1, 0], ["tegels", 2, 1, 0],
     ["speler", 0, 2, 0], ["speler", 0, 2, HS],
     ["speler", 1, 2, 0], ["speler", 1, 2, HS],
     ["hout", 2, 2, 0]]);

// ---------------------------------------------------------------------
//  Vormen
// ---------------------------------------------------------------------

module blok(w, d, h, r) {
    hull() for (x = [r, w - r], y = [r, d - r])
        translate([x, y, 0]) cylinder(r = r, h = h);
}

// Vak met afgeronde voor- en achterkant onderaan
module schepvak(vw, vd, hh) {
    r = min(schep_r, vd / 2, hh - 1);
    hull() {
        for (y = [r, vd - r])
            translate([0, y, r]) rotate([0, 90, 0]) cylinder(r = r, h = vw);
        translate([0, 0, hh - 0.01]) cube([vw, vd, 0.01]);
    }
}

// U-vormige gleuf door alle wanden van voor naar achter; de onderkant
// raakt net de vloer, zodat je ook de onderste kaart of tegel pakt.
module vingergleuf(d, h) {
    r = vinger_breedte / 2;
    hull() {
        translate([0, -1, bodem + r]) rotate([-90, 0, 0]) cylinder(r = r, h = d + 2);
        translate([-r, -1, max(h, bodem + r)]) cube([vinger_breedte, d + 2, 1]);
    }
}

module bakje(w, d, h, kol, rij, stijl) {
    vw = (w - (kol + 1) * wand) / kol;
    vd = (d - (rij + 1) * wand) / rij;
    difference() {
        blok(w, d, h, hoek_r);
        for (i = [0 : kol - 1], j = [0 : rij - 1])
            translate([wand + i * (vw + wand), wand + j * (vd + wand), bodem])
                if (stijl == "schep") schepvak(vw, vd, h - bodem + 1);
                else cube([vw, vd, h]);
        if (stijl == "plat")
            for (i = [0 : kol - 1])
                translate([wand + i * (vw + wand) + vw / 2, 0, 0]) vingergleuf(d, h);
    }
}

module bak_vorm(n) {
    p = bak(n);
    if (p == undef) echo(str("LET OP  onbekend onderdeel: ", n));
    else if (p[1] <= bodem + 2) echo(str("LET OP  geen ruimte voor bakje '", n, "' in deze doos"));
    else bakje(bak_b(n), bak_d(n), p[1], p[2], p[3], p[4]);
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
            translate([0, 0, H + speling_boven]) cube([B, D, borden_hoogte]);
    }
    for (e = layout) {
        p = bak(e[0]);
        color(p[5])
            translate([e[1] * (CB + uiteen) + tussenruimte / 2,
                       e[2] * (CD + uiteen) + tussenruimte / 2,
                       e[3] + (e[3] > 0 ? uiteen : 0)])
                bak_vorm(e[0]);
    }
}

// Bovenaanzicht met namen: [kolom-midden, rij, regel 1, regel 2]
labels = [
    [1, 0, "MUNTEN", "kaarten eronder"],
    [3, 0, "LENZEN e.a.", "kaarten eronder"],
    [1, 1, "MONSTERTEGELS", ""],
    [3, 1, "OVERIGE TEGELS", ""],
    [0.5, 2, "SPELER", "1 + 2"],
    [1.5, 2, "SPELER", "3 + 4"],
    [3, 2, "HOUTEN FICHES", ""]];

module plattegrond() {
    overzicht();
    for (l = labels)
        color("Black") translate([l[0] * CB, (l[1] + 0.5) * CD, H + 2]) {
            translate([0, 2, 0]) text(l[2], size = CB / 9, halign = "center", valign = "bottom");
            translate([0, -2, 0]) text(l[3], size = CB / 12, halign = "center", valign = "top");
        }
}

// ---------------------------------------------------------------------
//  Controle (verschijnt in de console)
// ---------------------------------------------------------------------

function r1(x) = round(x * 10) / 10;
function ok(test) = test ? "OK      " : "LET OP  ";
function per_vak(n) = floor((vak(n)[2] - 0.5) / tegel_dikte);
function past(n, b, l) =
    let(v = vak(n)) min(v[0], v[1]) >= min(b, l) + 2 * speling_vak
                 && max(v[0], v[1]) >= max(b, l) + 2 * speling_vak;

module controle() {
    vk = vak("kaarten");
    vm = vak("monsters");
    vt = vak("tegels");
    pm = per_vak("monsters");
    pt = per_vak("tegels");
    tegelvakken = ceil(36 / max(pt, 1)) + ceil(27 / max(pt, 1)) + ceil(15 / max(pt, 1));

    echo(str("        Hoogte onder de borden: ", r1(H), " mm; kaartbakjes ", HK,
             " mm, voorraad erboven ", r1(HV), " mm, spelersbakjes 2 x ", r1(HS), " mm"));
    echo(str(ok(H >= 25), "Hoogte onder de borden (minstens 25 mm)"));
    echo(str(ok(boven_kaarten), "Ruimte voor munten- en lenzenbakje boven de kaarten"));
    echo(str(ok(past("kaarten", kaart_breedte, kaart_lengte)),
             "Kaartvak ", r1(vk[0]), " x ", r1(vk[1]), " mm voor kaart ",
             kaart_breedte, " x ", kaart_lengte, " mm"));
    echo(str(ok(past("monsters", monster_breedte, monster_lengte)),
             "Monstervak ", r1(vm[0]), " x ", r1(vm[1]), " mm voor tegel ",
             monster_breedte, " x ", monster_lengte, " mm"));
    echo(str(ok(4 * pm >= 69),
             "Monstertegels: 4 vakken x ", pm, " = ", 4 * pm, " plaatsen voor 69 tegels"));
    echo(str(ok(past("tegels", tegel_breedte, tegel_lengte)),
             "Tegelvak ", r1(vt[0]), " x ", r1(vt[1]), " mm voor tegel ",
             tegel_breedte, " x ", tegel_lengte, " mm"));
    echo(str(ok(tegelvakken <= 6),
             "Overige tegels: ", tegelvakken, " van de 6 vakken nodig (", pt, " tegels per vak)"));
    for (n = ["kaarten", "munten", "lenzen", "monsters", "tegels", "speler", "hout"])
        echo(str(ok(max(bak_b(n), bak_d(n)) <= printbed), "Printbed: ", n, " ",
                 r1(bak_b(n)), " x ", r1(bak_d(n)), " x ", r1(bak(n)[1]),
                 " mm, ", bak(n)[6], "x printen (", bak(n)[7], ")"));
}

// ---------------------------------------------------------------------

controle();

if (onderdeel == "overzicht") overzicht(met_doos = true);
else if (onderdeel == "uiteen") overzicht(uiteen_afstand);
else if (onderdeel == "plattegrond") plattegrond();
else bak_vorm(onderdeel);
