curl -X POST http://localhost:5670/process-file \
  -H "Content-Type: application/json; charset=utf-8" \
  -H "Accept: application/json; charset=utf-8" \
  -d '{"file": "/Users/omarsaldanna/d/documentacion.pdf"}' \
  --output resultado.json