# 🚀 RAG File Scrapper API

Una API poderosa y elegante construida con Flask que extrae y procesa contenido de diferentes tipos de archivos de manera inteligente.

## ✨ Características

- 🔄 **Procesamiento Dinámico**: Detecta automáticamente el tipo de archivo y usa el scrapper apropiado
- 📝 **Múltiples Formatos**: Soporte para Markdown (`.md`), PDF (`.pdf`) y PowerPoint (`.pptx`)
- 🌐 **UTF-8 Completo**: Manejo perfecto de caracteres especiales y acentos
- ⚙️ **Configuración Externa**: Fácil modificación de extensiones y configuraciones del servidor
- 🛡️ **Manejo Robusto de Errores**: Validaciones completas y mensajes de error claros
- 📊 **Endpoints Adicionales**: Health check y consulta de extensiones soportadas

## 📁 Estructura del Proyecto

```
rag_file_scrapper/
├── 📄 api.py              # API principal de Flask
├── ⚙️ config.json         # Configuraciones del sistema
├── 📁 scrappers/          # Módulos de procesamiento
│   ├── 🔍 get_md.py       # Procesador de Markdown
│   ├── 📋 get_pdf.py      # Procesador de PDF
│   └── 🎯 get_pptx.py     # Procesador de PowerPoint
├── 📖 README.md           # Este archivo
└── 🚫 .gitignore          # Archivos ignorados por Git
```

## 🚀 Instalación Rápida

### 1. Clona el repositorio
```bash
git clone <tu-repositorio>
cd rag_file_scrapper
```

### 2. Instala las dependencias
```bash
pip install flask
# Instala las dependencias específicas para cada scrapper según tus necesidades
```

### 3. Configura el sistema
Edita `config.json` para ajustar extensiones y configuraciones del servidor:

```json
{
  "extension_mappings": {
    ".md": "scrappers.get_md",
    ".pdf": "scrappers.get_pdf",
    ".pptx": "scrappers.get_pptx"
  },
  "server_config": {
    "debug": true,
    "host": "0.0.0.0",
    "port": 5000
  }
}
```

### 4. ¡Ejecuta la API!
```bash
python api.py
```

## 🎯 Uso de la API

### 📤 Procesar Archivo
**Endpoint:** `POST /process-file`

```bash
curl -X POST http://localhost:5000/process-file \
  -H "Content-Type: application/json; charset=utf-8" \
  -d '{"file": "/ruta/absoluta/archivo.pdf"}' \
  -o resultado.json
```

**Respuesta de éxito:**
```json
{
  "content": {
    "título": "Contenido extraído del archivo",
    "datos": ["información", "procesada", "correctamente"]
  }
}
```

**Respuesta de error:**
```json
{
  "error": "Descripción detallada del error"
}
```

### 🏥 Health Check
**Endpoint:** `GET /health`

```bash
curl http://localhost:5000/health
```

### 📋 Extensiones Soportadas
**Endpoint:** `GET /supported-extensions`

```bash
curl http://localhost:5000/supported-extensions
```

## 🔧 Configuración Avanzada

### Agregar Nuevos Tipos de Archivo

1. **Crea un nuevo scrapper** en la carpeta `scrappers/`:
```python
# scrappers/get_txt.py
def analyze(input_file):
    # Tu lógica de procesamiento aquí
    return {"content": "contenido procesado"}
```

2. **Actualiza config.json**:
```json
{
  "extension_mappings": {
    ".md": "scrappers.get_md",
    ".pdf": "scrappers.get_pdf",
    ".pptx": "scrappers.get_pptx",
    ".txt": "scrappers.get_txt"
  }
}
```

3. **¡Reinicia la API y listo!** 🎉

### Modificar Configuración del Servidor

Edita la sección `server_config` en `config.json`:

```json
{
  "server_config": {
    "debug": false,        # Producción
    "host": "127.0.0.1",   # Solo local
    "port": 5670           # Puerto personalizado
  }
}
```

## 🛠️ Desarrollo

### Requisitos de los Scrappers

Cada scrapper debe:
- Tener una función `analyze(input_file)`
- Recibir la ruta absoluta del archivo como parámetro
- Retornar un diccionario Python con el contenido procesado
- Manejar errores internamente o propagarlos apropiadamente

### Ejemplo de Scrapper

```python
def analyze(input_file):
    """
    Procesa un archivo y extrae su contenido
    
    Args:
        input_file (str): Ruta absoluta al archivo
        
    Returns:
        dict: Contenido procesado del archivo
    """
    try:
        # Tu lógica de procesamiento
        content = procesar_archivo(input_file)
        return {
            "titulo": content.titulo,
            "contenido": content.texto,
            "metadatos": content.info
        }
    except Exception as e:
        raise Exception(f"Error procesando archivo: {str(e)}")
```

## 🚨 Códigos de Estado HTTP

| Código | Significado | Descripción |
|--------|-------------|-------------|
| 200 | ✅ Éxito | Archivo procesado correctamente |
| 400 | ❌ Bad Request | Parámetros inválidos o extensión no soportada |
| 404 | 🔍 Not Found | Archivo no encontrado |
| 500 | 💥 Server Error | Error interno del servidor |

## 🤝 Contribuir

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Notas Importantes

- ⚠️ **Rutas Absolutas**: La API requiere rutas absolutas a los archivos
- 🔤 **UTF-8**: Soporte completo para caracteres especiales y acentos
- 🔧 **Configuración Externa**: Todas las configuraciones están en `config.json`
- 🛡️ **Validaciones**: La API valida existencia de archivos y parámetros

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para detalles.

---

<div align="center">

**¿Problemas o sugerencias?** 

[Abre un issue](../../issues) • [Contribuye](../../pulls) • [Documentación](../../wiki)

</div>