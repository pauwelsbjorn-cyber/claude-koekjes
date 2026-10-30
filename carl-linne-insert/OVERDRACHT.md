# Overdracht: eigen 3D-print-insert voor Carl von Linné

Plak dit als eerste bericht in een nieuwe sessie. Antwoord in het Nederlands. Werkwijze die de gebruiker wil: eerst op schatting ontwerpen, daarna met echte maten afwerken. Blijf bij de insert, geen zijsporen.

## Opdracht

Ontwerp een eigen, 3D-printbare insert voor het bordspel **Carl von Linné** (ook "Carl v. Linné"; Pink Troubadour, 2026, BGG-id **462012**) die de meegeleverde insert vervangt.

Eerste taken in deze sessie:
1. **BGG lezen:** forum van Carl von Linné (id 462012): klachten over de insert, opslag en kaarthoesjes. Kijk ook of er al inserts bestaan (BGG-files, Printables, MakerWorld, Thingiverse); alleen als referentie, we ontwerpen zelf.
2. **Versie 2 maken** van het OpenSCAD-ontwerp met de indeling hieronder en de maten die de gebruiker aanlevert.

## Bestanden

- Repository `pauwelsbjorn-cyber/claude-koekjes`, branch **`claude/carl-linne-insert`**, map `carl-linne-insert/`. Let op: die repository is **openbaar** en hoort eigenlijk bij een wafelverkoop. Overweeg een eigen (privé)repository voor de insert.
- `carl-linne-insert.scad`: parametrisch OpenSCAD-ontwerp (getest met 2021.01): maten bovenaan in Customizer-secties, generieke bakjes ("plat" met vingergleuf voor kaarten en tegels, "schep" met afgeronde bodem voor fiches), een controle in de console (OK / LET OP), export per onderdeel met `-D onderdeel="..."`.
- `render.sh`: exporteert alle STL's en de overzichtsbeelden (gebruikt `xvfb-run` als er geen scherm is).
- `LEESMIJ.md`, `stl/`, `overzicht.png`, `uiteen.png`, `plattegrond.png`, `controle.echo`.
- **Versie 1 is verouderd:** gemaakt op geschatte maten, vóór we de spelonderdelen kenden. De code (modules, controles, render.sh) is herbruikbaar; de indeling moet opnieuw.
- Draft-PR #3 op die repository bevat versie 1.

## De doos

| | Buiten (gemeten op foto) | Binnen (afgeleid) |
|---|---|---|
| Breedte × diepte | ±29,5 × 29,5 cm | ±29,0 × 29,0 cm |
| Hoogte | ±7,4 cm | **7,1–7,2 cm** (gemeten in de lege doos; ontwerp met 71 mm) |

## De meegeleverde insert (waarom we dit doen)

Eén zwarte vacuümgevormde bak: links een grote, diepe bak waarin al het hout in zakjes door elkaar ligt, rechts een smal vak (daar zaten de hoesjes), vooraan drie ondiepe kaartvakken (reis, boek, brief) die **precies rond kaarten zonder hoesje** passen: de reiskaart raakt nu al de randen. Kaarten met hoesje passen er niet in, ook niet met de hoesjes die in de doos zitten. Vermoedelijk is dat de frustratie online (nog bevestigen op BGG).

## Onderdelen (uit de onderdelenlijst en spelvoorbereiding van het regelboek)

**Per speler** (4 kleuren: rood, blauw, geel, donkerblauw/paars):
30 houten markers (achthoekig), 12 houten bloemtegels (dikke blokjes; 3 stapels van 4: 1, 2 en 3 bloemen, omdraaibaar), 5 schepen, 3 spraakwolkjes, 1 beurtvolgordefiche, 1 scorefiche, 1 ontdekker, 1 onderzoeker, 6 basislenzen (waaronder de jokerlens).

**Gemeenschappelijke voorraad:** 83 munten (twee waarden), 24 containers, 24 gereedschappen. Daarnaast ±20 **metalen munten** "2 Daler", Ø ±25 mm (onduidelijk of ze de kartonnen munten van 2 vervangen).

**Lenzen:** 25 verbeterde lenzen + 2 reserve (display onder het speelbord).

**Monstertegels:** 45 gewone, 18 exotische, 6 start, + 6 promotegels = 75. **Vierkant, ±50 × 50 mm** (gemeten op foto). Gewone en exotische liggen als aparte trekstapels naast het bord.

**Overige tegels:** 36 schetstegels (+3 reserve), 15 starttegels (alleen voor de variant met ongelijke startvoorraad), 5 beurtvolgorde, 6 tuinbeloning, 9 vijver, 7 score.

**Kaarten** (de gebruiker wil **alle** kaarten in hoesjes):
| Soort | Aantal | Formaat |
|---|---|---|
| Reiskaarten | 24 + 3 promo (Jane Colden, Charles De Geer, Tadeáš Haenke) = 27 | 70 × 120-formaat, al in hoesje |
| Solokaarten | 20 | idem, al in hoesje |
| Opzetkaarten | 4 | idem, al in hoesje |
| Boekkaarten | 36 | ±70 × 70 (schatting) |
| Briefkaarten | 40 | ±45 × 65 (schatting) |

Het meegeleverde pakje had 54 hoesjes van 70 × 120: 51 gebruikt, 3 over. Buitenmaat kaart met hoesje ±72 × 122 mm (foto). Voor de boek- en briefkaarten heeft de gebruiker net hoesjes gekocht: maat nog door te geven. Reken voorlopig met ±0,6 mm per kaart met hoesje.

**Solo:** 20 solokaarten, groene sololenzen (9 volgens de lijst, niet nageteld), 1 solovoorraadfiche. Geen apart solobord: een spelersbord heeft een soloachterkant.

**Gevorderd spel, per personage:** Linné: 9 groene monstermarkers. Baret: 8 bestemmingsfiches + een schip. Merian: 12 canvasfiches + 6 metamorfosefiches. Buffon: 12 *Histoire Naturelle*-fiches. **Humboldt (promo):** personagebord ±8,5 × 19,5 cm + paarse jokerlens.

**Plat bovenop:** speelbord, 4 spelersborden (twee lagen die de gebruiker zelf lijmt, met stickers; daardoor dikker), 5 personageborden (±8,5 × 19,5 cm), 4 overzichtskaarten, regelboek. Verder: een roer (houten of kartonnen stuk? nog na te vragen) en een stoffen zakje ±10 × 15,5 cm (doel nog onbekend).

## Wat het spelverloop betekent voor het ontwerp

- Monstertegels liggen als trekstapels naast het bord: hun bakje is ook trekbak, met aparte vakken voor gewone, exotische en start/promo.
- Markers gaan constant heen en weer: groot vak met afgeronde bodem in het spelersbakje.
- Bloemtegels in 3 stapels van 4 per speler: drie gleufjes.
- Verbeterde lenzen: eigen bakje.
- Solo, gevorderd en starttegels zijn zelden nodig: één apart bakje met een vak per personage (Linné, Baret, Merian, Buffon, Humboldt) en een vak voor solo.

## Ontwerpkeuzes tot nu toe

- Alle bakjes op **één hoogte** onder de bordenstapel; de borden liggen er plat op, zodat de doos rechtop kan staan zonder dat iets verschuift.
- **Elk kaartvak voor kaarten met hoesje**, plat gestapeld, met vingergleuf.
- Elk bakje kan los op tafel.
- Geplande indeling (bovenaanzicht, voorkant onderaan):

```
achter ┌──────────┬──────────┬──────────┬──────────┐
       │ speler 1 │ speler 2 │ speler 3 │ speler 4 │
       ├──────────┴──────────┼──────────┴──────────┤
       │ monstertegels       │ voorraad: munten,   │
       │ gewoon·exotisch·start│ containers, gereedsch.│
       ├──────────┬──────────┼──────────┬──────────┤
       │ kaarten  │ lenzen   │ tegels   │ solo +   │
       │ reis·boek│ (27)     │ schets e.a.│ gevorderd│
voor   └──────────┴──────────┴──────────┴──────────┘
```

- Hoogtebudget: kartonstapel **gemeten ±28 mm** (foto, ±2 mm), mét de 4 gelijmde spelersborden (plat, niet geplooid). Op de foto ±18 lagen karton en geen regelboek, dus reken ±3 mm extra voor het regelboek. Ontwerp met **32 mm** stapel + 1 mm speling, dus bakjes **±38 mm** hoog (binnenhoogte 71 mm). Kaartstapels met hoesje: reis 27 kaarten ±16 mm, solo + opzet 24 ±14 mm, boeken ±22 mm, brieven ±24 mm: plat in één laag mogelijk.
- Printinstellingen: PLA, nozzle 0,4, wand 1,6 mm, bodem 1,2 mm, 1,0 mm speling rond de doos, 0,5 mm tussen bakjes, 1,0 mm rond onderdelen. In versie 1 was het grootste bakje 143,5 mm, zodat het op elke printer past; de printer van de gebruiker is nog onbekend.

## Nog te meten of te vragen

1. Bordenstapel: ±28 mm gemeten mét de 4 gelijmde spelersborden; het regelboek zat er vermoedelijk niet bij (+±3 mm). Eventueel nameten met het regelboek erop.
2. Kaart met hoesje: exacte buitenmaat, en de hoogte van de stapel van 27 reiskaarten met hoesje.
3. Boek- en briefkaart: maat met de nieuwe hoesjes, en stapelhoogte.
4. Dikte van 10 monstertegels; maten van schets-, vijver-, score-, tuinbeloning-, beurtvolgorde- en starttegels.
5. Diameter van een lens en een kartonnen munt; maat van een bloemtegel, marker en schip; het roer.
6. Printer en grootte van het printbed.
7. Metalen munten: vervangen of erbij? Doel van het stoffen zakje?
