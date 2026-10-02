#!/usr/bin/env bash
# MP-5 Cazar errores. Rompe tu pom.xml a propósito, como lo dejaría un compañero con prisa.
set -u
bueno=.pom-bueno.xml
nucleo() { python3 -c "$(echo 'IyDDumNsZW8gZGVsIHBvbS1yb3RvLnNoIChzZSBpbmNydXN0YSBlbiBiYXNlNjQgcGFyYSBxdWUgZWwgYWx1bW5vIG5vIHZlYSBsYXMgcmVzcH1lc3RhcyBhbCBwZWdhciBjcmVhci1wcm95ZWN0by5zaCkuCiMgVXNvOiBweXRob24zIC0gcXVlamFzLnB5IDxyb21wZXIgTjxyZXZpc2FyPiAgICAodHJhYmFqYSBzb2JyZSBwb20ueG1sIHkgLnBvbS1idWVuby54bWwgZW4gbGEgY2FycGV0YSBhY3R1YWwpCmltcG9ydCByZSwgc3lzLCBkaWZmbGliCkJVRU5PID0gJy5wb20tYnVlbm8ueG1sJw==; echo 'ZGVmIGxlZXIocCk6IHJldHVybiBvcGVuKHAsIGVuY29kaW5nPSd1dGYtOCcpLnJlYWQoKS5yZXBsYWNlKCdcciAgbicsICdcbicpCmRlZiBub3JtKHMpOgogICAgcyA9IHJlLnN1YihyJzwhLS0uKj8tLT4nLCAnJywgcywgZmxhZ3M9cmUuUykKICAgICMgRW4gSmFja3NvbiwgPHNjb3BlPmNvbXBpbGU8L3Njb3BlPiA9IG5vIHBvbmVyIHNjb3BlLiBUYW1iacOpbiBlcyB1biBhcnJlZ2xvIHbDoWxpZG8gZGUgbGEgcXVlamEgNAogICAgcyA9IHJlLnN1YihyJyg8dmVyc2lvbj5cJFx7amFja3NvblwudmVyc2lvbnx9PC92ZXJzaW9uPilccyo8c2NvcGU+XHMqY29tcGlsZVxzKjwvc2NvcGU+Jywgcic8dmVyc2lvbj5cJFx7amFja3NvblwudmVyc2lvbnx9PC92ZXJzaW9uPicsIHMpCiAgICAjIFNlIGNvbGFwc2FuIGxvcyBlc3BhY2lvcyAobm8gc2UgYm9ycmFuOiDCqTIuMjIuIDPCuyBubyBlcyDCqTIuMjIuM8K7KSB5IHNlIHF1aXRhbiBzb2xvIGxvcyBxdWUgcm9kZWFuIGV0aXF1ZXRhcy4KICAgIHMgPSByZS5zdWIocidccysnLCAnICcsIHMpCiAgICByZXR1cm4gcmUuc3ViKHInID8oPDw/W14+XSo+KSA/Jywgcic8XDFyLCBzKS5zdHJpcCgpCkRPTl9TID0gewogICAgJzEnOiAocic8dmVyc2lvbj5cJFx7amFja3NvblwudmVyc2lvbnx9PC92ZXJzaW9uPlxzKik8L2RlcGVuZGVuY3k+Jywgcic8dmVyc2lvbj5cJFx7amFja3NvblwudmVyc2lvbnx9PC92ZXJzaW9uPlxzKjwvcHJvamVjdD4nKSwKICAgICcyJzogKHInPG1hdmVuXC5jb21waWxlclwucmVsZWFzZT5ccyoxN1xzKjwvbWF2ZW5cLmNvbXBpbGVyXC5yZWxlYXNlPicsICc8bWF2ZW4uY29tcGlsZXIucmVsZWFzZT4yMTwvbWF2ZW4uY29tcGlsZXIucmVsZWFzZT4nKSwKICAgICczJzogKHInPGphY2tzb25cLnZlcnNpb24+XHMqMi4yMi4zXHMqPC9qYWNrc29uXC52ZXJzaW9uPicsICc8amFja3Nvbi52ZXJzaW9uPjIuMjIuMzA8L2phY2tzb24udmVyc2lvbj4nKSwKICAgICc0JzogKHInKFxuKFsgXHRdKik8dmVyc2lvbj5cJFx7amFja3NvblwudmVyc2lvbnx9PC92ZXJzaW9uPiknLCByJ1wxXG5cMjxzY29wZT50ZXN0PC9zY29wZT4nKSwKICAgICc1JzogKHInPG1haW5DbGFzcz5ccypjb21cLmFjYWRlbWlhXC5iYW5jb1wuQXBwXHMqPC9tYWluQ2xhc3M+JywgJzxtYWluQ2xhc3M+Y29tLmFjYWRlbWlhLmJhbmNvLkFwbGljYWNpb248L21haW5DbGFzcz4nKSwKfQ==; echo 'aWYgc3lzLmFyZ3ZVsMV0gPT0gJ3JvbXBlcic6CiAgICBwYXRyb24sIHJlZW1wbGF6byA9IFJPTVAuU1RzeXMuYXJndlsyXV0KICAgIHMsIG4gPSByZS5zdWJuKHBhdHJvbiwgcmVlbXBsYXpvLCBsZWVyKEJVRU5PKSwgY291bnQ9MSkKICAgIGlmIG4gIT0gMTogc3lzLmV4aXQoMykKICAgIG9wZW4oJ3BvbS54bWwnLCAndycsIGVuY29kaW5nPSd1dGYtOCcpLndyaXRlKHMpCmVsc2U6CiAgICBidWVubywgdHV5byA9IGxlZXIoQlVFTk8pLCBsZWVyKCdwb20ueG1sJykKICAgIGlmIG5vcm0oYnVlbm8pID09IG5vcm0odHV5byk6IHByaW50KCfinIUgVHUgcG9tLnhtbCBxdWVkw7MgaWd1YWwgYWwgYnVlbm8uJyk7IHN5cy5leGl0KDApCiAgICBiID0gW2wuc3RyaXAoKSBmb3IgbCBpbiBidWVuby5zcGxpdCgnXG4nKV0KICAgIHQgPSBbbC5zdHJpcCgpIGZvciBsIGluIHR1eW8uc3BsaXQoJ1xuJyldCiAgICBsaW5lYXMgPSBzb3J0ZWQoe2oxICsgMSBmb3Igb3AsIGkxLCBpMiwgajEsIGoyIGluIGRpZmZsaWIuU2VxdWVuY2VNYXRjaGVyKE5vbmUsIGIsIHQsIGF1dG9qdW5rPUZhbHNlKS5nZXRfb3Bjb2RlcygpIGlmIG9wICE9ICdlcXVhbCcgYW5kIGFueSh4IGZvciB4IGluIGJbaTE6aTJdICsgdFtqMTpqMl0pfSkKICAgIGRvbmRlID0gJyB5ICcuam9pbihzdHIobWluKGwsIGxlbih0KSkpIGZvciBsIGluIGxpbmVhc1s6M10pIG9yICc/JwogICAgcHJpbnQoZifinVggVG9kYXbDrWEgbm86IHR1IHBvbS54bWwgZXMgZGlzdGludG8gZGVsIGJ1ZW5vIGNlcmNhIGRlIGxhIGzDrW5lYSB7ZG9uZGV9LiBWdWVsdmUgYSBsZWVyIGxvIHF1ZSBkaWpvIE1hdmVuLicpCiAgICBzeXMuZXhpdCgxKQ==' | base64 -d)" "$@"; }

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
