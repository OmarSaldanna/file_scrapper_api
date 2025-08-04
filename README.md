# 🚀 File Scrapper API _For RAG_
--> Made out of Ker SDB parts <--

A powerful and elegant Flask-based API that intelligently extracts and processes content from different file types.

## ✨ Features

- 🔄 **Dynamic Processing**: Automatically detects file type and uses the appropriate scrapper
- 📝 **Multiple Formats**: Support for Markdown (`.md`), PDF (`.pdf`) and PowerPoint (`.pptx`)
- 🌐 **Full UTF-8**: Perfect handling of special characters and accents
- ⚙️ **External Configuration**: Easy modification of extensions and server settings
- 🛡️ **Robust Error Handling**: Complete validations and clear error messages
- 📊 **Additional Endpoints**: Health check and supported extensions query

## 📁 Project Structure

```
rag_file_scrapper/
├── 📄 api.py              # Main Flask API
├── ⚙️ config.json         # System configurations
├── 📋 requirements.txt    # Python dependencies
├── 📁 scrappers/          # Processing modules
│   ├── 🔍 get_md.py       # Markdown processor
│   ├── 📋 get_pdf.py      # PDF processor
│   └── 🎯 get_pptx.py     # PowerPoint processor
├── 📖 README.md           # This file
└── 🚫 .gitignore          # Files ignored by Git
```

## 📦 Installation

### 1. Clone the repository
```bash
git clone <your-repository>
cd rag_file_scrapper
```

### 2. Create and activate virtual environment

**On Windows:**
```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
venv\Scripts\activate
```

**On macOS/Linux:**
```bash
# Create virtual environment
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate
```

### 3. Install dependencies
```bash
pip install -r requirements.txt
```

### 4. Configure the system
Edit `config.json` to adjust extensions and server configurations:

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
    "port": 5670
  }
}
```

### 5. Run the API! 🎉
```bash
python api.py
```

The API will be available at `http://localhost:5670`

## 🎯 API Usage

### 📤 Process File
**Endpoint:** `POST /process-file`

```bash
curl -X POST http://localhost:5670/process-file \
  -H "Content-Type: application/json; charset=utf-8" \
  -d '{"file": "/absolute/path/to/file.pdf"}' \
  -o result.json
```

**Success Response:**
```json
{
  "content": {
    "title": "Content extracted from file",
    "data": ["information", "processed", "correctly"]
  }
}
```

**Error Response:**
```json
{
  "error": "Detailed error description"
}
```

### 🏥 Health Check
**Endpoint:** `GET /health`

```bash
curl http://localhost:5670/health
```

### 📋 Supported Extensions
**Endpoint:** `GET /supported-extensions`

```bash
curl http://localhost:5670/supported-extensions
```

## 🔧 Advanced Configuration

### Adding New File Types

1. **Create a new scrapper** in the `scrappers/` folder:
```python
# scrappers/get_txt.py
def analyze(input_file):
    # Your processing logic here
    return {"content": "processed content"}
```

2. **Update config.json**:
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

3. **Restart the API and you're done!** 🎉

### Modify Server Configuration

Edit the `server_config` section in `config.json`:

```json
{
  "server_config": {
    "debug": false,        # Production
    "host": "127.0.0.1",   # Local or 0.0.0.0 for public
    "port": 5670           # Custom port
  }
}
```

## 🛠️ Development

### Scrapper Requirements

Each scrapper must:
- Have an `analyze(input_file)` function
- Receive the absolute file path as parameter
- Return a Python dictionary with processed content
- Handle errors internally or propagate them appropriately

### Scrapper Example

```python
def analyze(input_file):
    """
    Processes a file and extracts its content
    
    Args:
        input_file (str): Absolute path to the file
        
    Returns:
        dict: Processed file content
    """
    try:
        # Your processing logic
        content = process_file(input_file)
        return {
            "title": content.title,
            "content": content.text,
            "metadata": content.info
        }
    except Exception as e:
        raise Exception(f"Error processing file: {str(e)}")
```

## 🚨 HTTP Status Codes

| Code | Meaning | Description |
|------|---------|-------------|
| 200 | ✅ Success | File processed successfully |
| 400 | ❌ Bad Request | Invalid parameters or unsupported extension |
| 404 | 🔍 Not Found | File not found |
| 500 | 💥 Server Error | Internal server error |

## 📚 Dependencies

The main dependencies include:
- **Flask**: Web framework for the API
- **Additional libraries**: Specific to each scrapper (PDF processing, Office documents, etc.)

Check `requirements.txt` for the complete list of dependencies.

## 🤝 Contributing

1. Fork the project
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 Important Notes

- ⚠️ **Absolute Paths**: The API requires absolute paths to files
- 🔤 **UTF-8**: Full support for special characters and accents
- 🔧 **External Configuration**: All settings are in `config.json`
- 🛡️ **Validations**: The API validates file existence and parameters
- 🐍 **Virtual Environment**: Always use a virtual environment for isolation

## 🚀 Quick Start

```bash
# Clone and setup
git clone https://github.com/OmarSaldanna/file_scrapper_api.git
cd file_scrapper_api
python -m venv venv
source venv/bin/activate  # or venv\Scripts\activate on Windows
pip install -r requirements.txt

# Run
python api.py

# sh tests/pdf.sh
```