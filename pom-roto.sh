#!/usr/bin/env bash
# MP-5 Cazar errores. Rompe tu pom.xml a propósito, como lo dejaría un compañero con prisa.
set -u
bueno=.pom-bueno.xml

nucleo() {
python3 - "$@" << 'FIN_PY'
import re, sys, difflib

BUENO = '.pom-bueno.xml'

def leer(p):
    return open(p, encoding='utf-8').read().replace('\r\n', '\n')

def norm(s):
    s = re.sub(r'<!--.*?-->', '', s, flags=re.S)
    s = re.sub(r'(<version>\$\{jackson\.version\}</version>)\s*<scope>\s*compile\s*</scope>', r'\1', s)
    s = re.sub(r'\s+', ' ', s)
    return re.sub(r' ?(</?[^>]+>) ?', r'\1', s).strip()

ROMPER = {
    '1': (r'(<version>\$\{jackson\.version\}</version>\s*)</dependency>', r'\1</project>'),
    '2': (r'<maven\.compiler\.release>\s*17\s*</maven\.compiler\.release>', r'<maven.compiler.release>21</maven.compiler.release>'),
    '3': (r'<jackson\.version>\s*2\.22\.3\s*</jackson\.version>', r'<jackson.version>2.22.30</jackson.version>'),
    '4': (r'(\n([ \t]*)<version>\$\{jackson\.version\}</version>)', r'\1\n\2<scope>test</scope>'),
    '5': (r'<mainClass>\s*com\.academia\.banco\.App\s*</mainClass>', r'<mainClass>com.academia.banco.Aplicacion</mainClass>'),
}

if sys.argv[1] == 'romper':
    patron, reemplazo = ROMPER[sys.argv[2]]
    s, n = re.subn(patron, reemplazo, leer(BUENO), count=1)
    if n != 1:
        sys.exit(3)
    open('pom.xml', 'w', encoding='utf-8').write(s)
else:
    bueno, tuyo = leer(BUENO), leer('pom.xml')
    if norm(bueno) == norm(tuyo):
        print('✔ Tu pom.xml quedó igual al bueno.')
        sys.exit(0)
    b = [l.strip() for l in bueno.split('\n')]
    t = [l.strip() for l in tuyo.split('\n')]
    lineas = sorted({j1 + 1 for op, i1, i2, j1, j2 in difflib.SequenceMatcher(None, b, t, autojunk=False).get_opcodes() if op != 'equal' and any(x for x in b[i1:i2] + t[j1:j2])})
    donde = ' y '.join(str(min(l, len(t))) for l in lineas[:3]) or '?'
    print(f'✘ Todavía no: tu pom.xml es distinto del bueno cerca de la línea {donde}. Vuelve a leer lo que dijo Maven.')
    sys.exit(1)
FIN_PY
}

if [ "${1:-}" = "revisar" ]; then
  if [ ! -f "$bueno" ]; then echo "Todavía no rompes nada: corre ./pom-roto.sh 1"; exit 2; fi
  nucleo revisar; exit $?
fi

case "${1:-}" in 1|2|3|4|5) ;; * ) echo "Uso: ./pom-roto.sh <1 a 5> | ./pom-roto.sh revisar"; exit 2 ;; esac

nuevo=
if [ ! -f "$bueno" ]; then
  if ! grep -q '<jackson.version>2.22.3</jackson.version>' pom.xml \
     || ! grep -q '<version>${jackson.version}</version>' pom.xml \
     || [ "$(grep -c '<artifactId>jackson-databind</artifactId>' pom.xml)" -ne 1 ] \
     || ! grep -q '<mainClass>com.academia.banco.App</mainClass>' pom.xml; then
    echo "Tu pom.xml no está como lo dejó la MP-4: compáralo con el «así debe quedar» de la MP-4 y vuelve a intentar."; exit 2
  fi
  cp pom.xml "$bueno"; nuevo=1
fi

if ! nucleo romper "$1" || cmp -s "$bueno" pom.xml; then
  [ "$nuevo" = 1 ] && rm -f "$bueno"
  echo "No pude preparar la queja $1 con tu pom.xml (tu pom.xml sigue igual). Avísale al instructor."; exit 3
fi
echo "Queja $1: tu pom.xml tiene un error. Encuéntralo con lo que dice Maven (la guía te dice qué correr)."