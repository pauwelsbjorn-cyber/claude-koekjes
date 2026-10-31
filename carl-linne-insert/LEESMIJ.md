# Carl von Linné – eigen insert (3D-print)

**Versie 2 – op gemeten maten, alle kaarten in hoesjes.** Print eerst één spelersbakje als test.

![Overzicht in de doos](overzicht.png)

## Idee

- **Alles op één hoogte (40 mm) onder de borden.** Speelbord, spelersborden, personageborden, overzichtskaarten en regelboek liggen er plat bovenop. Daardoor kan de doos ook rechtop staan zonder dat er iets door elkaar valt.
- **Elke kaartsoort in hoesje heeft een eigen vak**, met speling rondom en een vingergleuf.
- **Bakjes die je op tafel zet.** Elke speler krijgt een eigen bakje, de staaltegelbak is ook de trekbak.
- **Geen zakjes en geen verstopte laag.**
- **Alles past zich aan de maten aan.** Bovenaan in het bestand staan alle maten; de console toont na elke render een controle (OK / LET OP).

| Bakje | Aantal | Maat (mm) | Inhoud |
|---|---|---|---|
| A `kaarten_groot` | 1 | 77 × 129 × 40 | 31 reis-, start-, promo- en opzetkaarten |
| B `kaarten_klein` | 1 | 152 × 129 × 40 | boek, brief, solo; gevorderd spel (Buffon, Merian, Baret, Linné, Humboldt, sololenzen, starttegels); het roer ligt bovenop het solodeel |
| C `voorraad` | 1 | 58 × 129 × 40 | metalen munten 1 en 2, containers, gereedschap, 27 verbeterde lenzen |
| D `stalen` | 1 | 171 × 116 × 40 | 75 staaltegels in 6 vakken (trekbak) |
| E `tegels` | 1 | 171 × 42 × 40 | schets-, score-, vijver-, tuinbeloning- en beurtvolgordetegels |
| F–I `speler` | 4 | 58 × 79 × 40 | per speler: 3 stapels bloemtegels, markers, 6 lenzen en de rest van het hout; met klikdeksel |

De kartonnen munten gaan niet in de doos: je speelt met de 65 metalen munten.

![Bovenaanzicht](plattegrond.png)
![Uit elkaar](uiteen.png)

Het grootste bakje is 171 mm: het past op de Bambu Lab A1 (256 mm).

## Spelersbakjes en deksels

Getest met een volledige print: alles van één speler past, en het deksel klikt vast.

- De bloemvakken zijn krap (0,5 mm speling) en hebben een verhoogde vloer: de stapel van 4 komt tot net onder het deksel.
- Het deksel valt in een randje en ligt gelijk met de bovenkant. Twee richeltjes aan voor- en achterkant klikken in een groef in het deksel; je tilt het op via de vingergleuven van de bloemvakken.
- Op elk deksel staat een pion met het spelersymbool van de lenzen: cirkel, vierkant, ruit of ster. Print elk deksel in de kleur van de speler met dat symbool.

![Deksels](deksels.png)

Per symbool zijn er drie bestanden:

| Bestand | Wat |
|---|---|
| `deksel_speler_<symbool>.stl` | het deksel; pion en symbool zitten er 0,6 mm diep in |
| `deksel_icoon_<symbool>.stl` | de vulling voor een tweede kleur: laad hem samen met het deksel als één object in Bambu Studio en geef hem een ander filament (AMS) |
| `icoon_plak_<symbool>.stl` | pion en symbool als losse stukjes, 0,15 mm kleiner, om achteraf in te lijmen |

## Printen

- PLA, nozzle 0,4 mm, laaghoogte 0,2 mm.
- Zet het aantal wanden op 4, zodat de buitenwanden van 1,6 mm massief zijn.
- Infill 15 %. Steunmateriaal is niet nodig: alle bakjes printen met de opening naar boven.
- Print eerst **één spelersbakje** als test en controleer of de bloemtegels, markers en de ontdekker erin passen.

## Bestanden

| Bestand | Wat |
|---|---|
| `carl-linne-insert.scad` | Het ontwerp. Open het in [OpenSCAD](https://openscad.org) (gratis). Onder *Window › Customizer* pas je de maten aan. |
| `stl/*.stl` | De bakjes, klaar voor de slicer |
| `render.sh` | Maakt alle STL's en afbeeldingen opnieuw (`OPENSCAD=pad/naar/openscad.com bash render.sh` op Windows) |
| `controle.echo` | Controlelijst: past alles (OK / LET OP)? |
| `fotos/` | Meetfoto's en het regelboek |
