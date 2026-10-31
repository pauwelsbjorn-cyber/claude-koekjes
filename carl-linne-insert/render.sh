#!/usr/bin/env bash
# Exporteert alle bakjes als STL en maakt de overzichtsafbeeldingen.
# Vereist OpenSCAD (op het PATH, of zet OPENSCAD=pad/naar/openscad);
# op een server zonder scherm ook xvfb-run.
set -euo pipefail
cd "$(dirname "$0")"

SCAD=carl-linne-insert.scad
OPENSCAD="${OPENSCAD:-openscad}"
RUN=""
if [ -z "${DISPLAY:-}" ] && command -v xvfb-run >/dev/null; then
  RUN="xvfb-run -a"
fi

mkdir -p stl
"$OPENSCAD" -o controle.echo "$SCAD" 2>/dev/null
cat controle.echo

for p in kaarten_groot kaarten_klein voorraad stalen tegels speler; do
  echo "STL: $p"
  "$OPENSCAD" -q -o "stl/$p.stl" -D "onderdeel=\"$p\"" "$SCAD" || echo "  overgeslagen: $p"
done

# Per spelersymbool: deksel, vulling (tweede kleur) en inplakstuk
for s in cirkel vierkant ruit ster; do
  for p in deksel_speler deksel_icoon icoon_plak; do
    echo "STL: $p $s"
    "$OPENSCAD" -q -o "stl/${p}_$s.stl" -D "onderdeel=\"$p\"" -D "symbool=\"$s\"" "$SCAD" \
      || echo "  overgeslagen: $p $s"
  done
done

echo "Afbeeldingen"
$RUN "$OPENSCAD" -q -o overzicht.png --imgsize=1600,1200 --colorscheme=Tomorrow \
  --camera=0,0,0,68,0,25,0 --viewall --autocenter -D 'onderdeel="overzicht"' "$SCAD"
$RUN "$OPENSCAD" -q -o uiteen.png --imgsize=1600,1200 --colorscheme=Tomorrow \
  --camera=0,0,0,50,0,25,0 --viewall --autocenter -D 'onderdeel="uiteen"' "$SCAD"
$RUN "$OPENSCAD" -q -o plattegrond.png --imgsize=1200,1200 --colorscheme=Tomorrow \
  --projection=o --camera=0,0,0,0,0,0,0 --viewall --autocenter -D 'onderdeel="plattegrond"' "$SCAD"
