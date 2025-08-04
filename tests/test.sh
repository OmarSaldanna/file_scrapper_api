#!/bin/bash

# colores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
RESET='\033[0m'
SEP="\n${YELLOW}----------------------------------------${RESET}\n"

# dirs y endpoint
BASE_DIR="/Users/omarsaldanna/Downloads/file_scrapper_api/tests"
RESULTS_DIR="$BASE_DIR/results"
SAMPLES_DIR="$BASE_DIR/samples"
ENDPOINT="http://localhost:5670/process-file"
CT="application/json; charset=utf-8"

mkdir -p "$RESULTS_DIR"

post() {
  local input="$1"
  local out="$2"

  if [[ ! -f "$input" ]]; then
    echo -e "${RED}ERROR:${RESET} no existe el archivo de entrada: $input"
    return 1
  fi

  echo -e "${YELLOW}Enviando:${RESET} $input -> $out"
  http_code=$(curl -s -w "%{http_code}" -o "$out" \
    -X POST "$ENDPOINT" \
    -H "Content-Type: $CT" \
    -H "Accept: $CT" \
    -d "{\"file\": \"${input}\"}")

  if [[ "$http_code" =~ ^2[0-9]{2}$ ]]; then
    echo -e "${GREEN}OK:${RESET} respuesta guardada en $out (HTTP $http_code)"
  else
    echo -e "${RED}FALLÓ:${RESET} HTTP $http_code para $input"
    echo -e "${RED}Cuerpo de respuesta:${RESET}"
    cat "$out"
    return 1
  fi

  echo -e "$SEP"
}

post "$BASE_DIR/../README.md" "$RESULTS_DIR/md.json"
post "$SAMPLES_DIR/documentacion.pdf" "$RESULTS_DIR/pdf.json"
post "$SAMPLES_DIR/press_peste.pptx" "$RESULTS_DIR/pptx.json"
