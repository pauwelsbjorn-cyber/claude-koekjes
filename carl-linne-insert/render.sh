#!/usr/bin/env bash
# Exporteert alle bakjes als STL en maakt de overzichtsafbeeldingen.
# Vereist OpenSCAD; op een server zonder scherm ook xvfb-run.
set -euo pipefail
cd "$(dirname "$0")"

SCAD=carl-linne-insert.scad
RUN=""
if [ -z "${DISPLAY:-}" ] && command -v xvfb-run >/dev/null; then
  RUN="xvfb-run -a"
fi

mkdir -p stl
openscad -o controle.echo "$SCAD" 2>/dev/null
cat controle.echo

for p in kaarten munten lenzen monsters tegels speler hout; do
  echo "STL: $p"
  openscad -q -o "stl/$p.stl" -D "onderdeel=\"$p\"" "$SCAD" || echo "  overgeslagen: $p"
done

echo "Afbeeldingen"
$RUN openscad -q -o overzicht.png --imgsize=1600,1200 --colorscheme=Tomorrow \
  --camera=0,0,0,68,0,25,0 --viewall --autocenter -D 'onderdeel="overzicht"' "$SCAD"
$RUN openscad -q -o uiteen.png --imgsize=1600,1200 --colorscheme=Tomorrow \
  --camera=0,0,0,50,0,25,0 --viewall --autocenter -D 'onderdeel="uiteen"' "$SCAD"
$RUN openscad -q -o plattegrond.png --imgsize=1200,1200 --colorscheme=Tomorrow \
  --projection=o --camera=0,0,0,0,0,0,0 --viewall --autocenter -D 'onderdeel="plattegrond"' "$SCAD"
