# Carl von Linné – eigen insert (3D-print)

**Versie 1 – concept op geschatte maten.** Nog niet printen voor de echte maten zijn ingevuld (zie *Meetlijst* onderaan).

![Overzicht in de doos](overzicht.png)

## Idee

- **Alles op één hoogte onder de borden.** Speelbord, spelersborden, karakterborden en regelboek liggen er plat bovenop. Daardoor kan de doos ook rechtop staan zonder dat er iets door elkaar valt.
- **Bakjes die je op tafel zet.** Elk soort materiaal heeft een eigen bakje, zodat opzetten en opruimen snel gaat. Elke speler krijgt een eigen spelersbakje.
- **Kaarten en tegels in vakken met een vingergleuf**, zodat je ook de onderste kaart of tegel er makkelijk uit haalt.
- **Losse fiches in vakken met een afgeronde bodem**, zodat je ze er zo uitschuift.
- **Alles past zich aan de maten aan.** Je vult bovenaan in het bestand de maten in, en alle bakjes worden opnieuw berekend.

| Bakje | Aantal | Maat (mm) | Inhoud |
|---|---|---|---|
| kaarten | 2 | 143,5 × 95,5 × 17 | 4 kaartstapels (brieven, boeken, reizen, overige) |
| munten | 1 | 143,5 × 95,5 × 22 | munten – ligt bovenop een kaartbakje |
| lenzen | 1 | 143,5 × 95,5 × 22 | lenzen, grondstoffen, gevorderde fiches – ligt bovenop het andere kaartbakje |
| monsters | 1 | 143,5 × 95,5 × 39 | 69 monstertegels (4 vakken) |
| tegels | 1 | 143,5 × 95,5 × 39 | schets-, start- en overige tegels (6 vakken) |
| speler | 4 | 71,5 × 95,5 × 19,5 | per speler: houten markers en startlenzen (per twee op elkaar) |
| hout | 1 | 143,5 × 95,5 × 39 | 98 houten fiches (4 vakken) |

![Bovenaanzicht](plattegrond.png)
![Uit elkaar](uiteen.png)

Het grootste bakje is 143,5 mm, dus het past op elke gangbare printer (ook een Bambu A1 mini). In totaal heb je ongeveer een halve kilo PLA nodig.

## Printen

- PLA, nozzle 0,4 mm, laaghoogte 0,2 mm.
- Zet het aantal wanden op 4, zodat de 1,6 mm-wanden massief zijn.
- Infill 15 %. Steunmateriaal is niet nodig: alle bakjes printen met de opening naar boven.
- Print eerst **één spelersbakje** als test (35 g, kort) en controleer of het mooi in een hoek van de doos past.

## Bestanden

| Bestand | Wat |
|---|---|
| `carl-linne-insert.scad` | Het ontwerp. Open het in [OpenSCAD](https://openscad.org) (gratis). Onder *Window › Customizer* pas je de maten aan. |
| `stl/*.stl` | De bakjes, klaar voor de slicer (op geschatte maten!) |
| `render.sh` | Maakt alle STL's en afbeeldingen opnieuw |
| `controle.echo` | Controlelijst: past alles (OK / LET OP)? |

Zelf aanpassen hoeft niet: geef mij de maten door en ik maak de nieuwe STL's.

## Meetlijst

Meet in millimeter, met een schuifmaat als je er een hebt. Alles met *SCHATTING* in het ontwerp komt hiervan.

**Doos**
1. Binnenbreedte en binnendiepte van de bodemdoos. Meet onderaan aan de bodem; als de wanden iets schuin staan, noteer je de kleinste maat.
2. Binnenhoogte van de bodemdoos, van de bodem tot de bovenrand.
3. Leg speelbord, 4 spelersborden, 4 karakterborden, het regelboek en eventuele losse bladen op elkaar zoals ze in de doos moeten. Druk licht aan en meet de hoogte van de stapel.

**Kaarten**
4. Lengte en breedte van één kaart per soort: brieven, boeken, reizen en overige. Zijn ze allemaal even groot?
5. Hoogte van de stapel van 40 brievenkaarten. Daaruit volgt de dikte per kaart.
6. Gebruik je hoesjes, of ga je dat doen? Zo ja, welke maat?

**Tegels**
7. Monstertegels: lengte, breedte en de hoogte van een stapel van 10. Zijn ze vierkant, rechthoekig of zeshoekig? Zijn er verschillende soorten die je apart wilt houden?
8. Hetzelfde voor schetstegels, starttegels en de overige tegels.

**Fiches en hout**
9. Diameter van een lensfiche en een munt.
10. Hoeveel houten markers zijn er per spelerskleur, en wat is het grootste houten stuk?
11. Welke soorten houten fiches en kartonnen fiches wil je apart houden?

**Printer en wensen**
12. Welke printer heb je (grootte van het printbed)?
13. Wat stoort jou het meest aan de meegeleverde insert? Dan zorgen we dat de definitieve versie dat zeker oplost.
