# Wafelverkoop eindejaarsreis: installatie

De bestelpagina (`docs/index.html`) staat op GitHub Pages. Elke bestelling komt in een Google Sheet. Die Sheet beheer jij: je ziet alle bestellingen, vinkt aan wat betaald en geleverd is, en het tabblad **Overzicht** telt de dozen per product op.

Na het bestellen krijgt de koper:
- een bestelnummer (W0001, W0002, …)
- een **gestructureerde mededeling** (+++260/0000/00170+++), uniek per bestelling
- het rekeningnummer en een **QR-code** die bankapps herkennen
- dezelfde gegevens per e-mail

Reken op ongeveer 10 minuten.

## 1. Google Sheet aanmaken

1. Ga naar [sheets.new](https://sheets.new) en noem de Sheet bv. *Wafelverkoop eindejaarsreis*.
2. Kies **Extensies → Apps Script**.
3. Wis de inhoud van `Code.gs` en plak de volledige inhoud van [`apps-script/Code.gs`](apps-script/Code.gs).
4. Rekeningnummer (BE60 9731 7768 8270), naam (Pauwels Björn) en leerling (Annais Van Camp) staan al ingevuld. Wil je bij elke bestelling zelf een mail? Vul dan bij `MELDING_NAAR` je e-mailadres in.
5. Klik op **Opslaan** (diskette-icoon).

## 2. Tabbladen aanmaken

1. Kies bovenaan in de functielijst **setup** en klik op **Uitvoeren**.
2. Google vraagt toestemming. Kies je account, klik op **Geavanceerd → Ga naar … (onveilig)** en daarna op **Toestaan**. Die melding komt omdat het script van jou is en niet door Google is nagekeken.
3. In de Sheet staan nu de tabbladen **Bestellingen** en **Overzicht**.

## 3. Publiceren als webapp

1. Klik rechtsboven op **Implementeren → Nieuwe implementatie**.
2. Klik op het tandwiel naast "Type selecteren" en kies **Web-app**.
3. Stel in:
   - *Uitvoeren als*: **Ik**
   - *Wie heeft toegang*: **Iedereen**
4. Klik op **Implementeren** en kopieer de **URL van de web-app** (die eindigt op `/exec`).

## 4. URL in de bestelpagina zetten

Open `docs/index.html` en vul de URL in:

```js
const SCRIPT_URL = "https://script.google.com/macros/s/.../exec";
```

Je kunt de URL ook aan Claude geven, dan past Claude het bestand aan.

## 5. Pagina online zetten (GitHub Pages)

1. Zet de repo op publiek: **Settings → General → Danger Zone → Change visibility → Public**.
2. Ga naar **Settings → Pages**, kies bij *Source* **Deploy from a branch**, branch **main**, map **/docs**, en klik op **Save**.
3. Na een minuutje staat de pagina op **https://pauwelsbjorn-cyber.github.io/claude-koekjes/**. Die link zet je in de WhatsApp-groep.

Het rekeningnummer staat in `apps-script/Code.gs` en is dus zichtbaar in de publieke repo. Elke koper krijgt het sowieso te zien.

## Dagelijks beheer

- **Betaald**: vergelijk je rekeninguittreksels met de kolom *Mededeling* en vink **Betaald** aan.
- **Overzicht**: toont per product het aantal dozen (alle bestellingen en alleen betaalde), het totaal ontvangen bedrag en wat nog openstaat. Gebruik *Dozen (betaald)* voor de bestelling bij de leverancier.
- **Levering**: vink **Geleverd** aan als iemand zijn dozen heeft.
- Na **28/10/2026 23:59** weigert het script nieuwe bestellingen en toont de pagina dat de verkoop afgelopen is.

## Iets aanpassen in het script?

Wijzig je later iets in `Code.gs`, kies dan **Implementeren → Implementaties beheren → potloodje → Versie: Nieuwe versie → Implementeren**. De URL blijft dan dezelfde.
