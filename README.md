# 📄 RAG File Scrapper API 
_> made out of Ker SDB parts <_

A powerful and intelligent Flask-based API that automatically extracts and processes content from various file formats. Built for scalability and ease of use with comprehensive document processing capabilities.

## ✨ Features

- 🔄 **Dynamic Processing**: Automatically detects file type and uses the appropriate scrapper
- 📝 **Multiple Formats**: Support for Markdown (`.md`), PDF (`.pdf`) and PowerPoint (`.pptx`)
- 🌐 **Full UTF-8**: Perfect handling of special characters and accents
- ⚙️ **External Configuration**: Easy modification of extensions and server settings
- 🛡️ **Robust Error Handling**: Complete validations and clear error messages
- 📊 **Additional Endpoints**: Health check and supported extensions query
- 🧪 **Testing Framework**: Built-in testing suite with sample files
- 🚀 **Automated Setup**: One-command installation and execution

## 📁 Project Structure

```
rag_file_scrapper/
├── 📄 api.py                      # Main Flask API
├── ⚙️ config.json                 # System configurations
├── 📋 requirements.txt            # Python dependencies
├── 🔧 setup.sh                    # Automated setup script
├── 🚀 run.sh                      # API execution script (auto-generated)
├── 📖 README.md                   # This documentation
├── 🚫 .gitignore                  # Git ignore rules
├── 📁 scrappers/                  # Document processing modules
│   ├── __pycache__/              # Python cache (auto-generated)
│   ├── 🔍 get_md.py              # Markdown processor
│   ├── 📋 get_pdf.py             # PDF processor
│   └── 🎯 get_pptx.py            # PowerPoint processor
├── 📁 tests/                      # Testing framework
│   ├── 📁 samples/               # Test documents
│   │   ├── 📄 documentacion.pdf  # Sample PDF file
│   │   ├── 📝 ensayo.docx        # Sample Word document
│   │   └── 🎯 press_peste.pptx   # Sample PowerPoint
│   ├── 📁 results/               # Test output files
│   │   ├── 📊 md.json            # Markdown test results
│   │   ├── 📊 pdf.json           # PDF test results
│   │   └── 📊 pptx.json          # PowerPoint test results
│   └── 🧪 test.sh                # Automated testing script
└── 📁 venv/                       # Virtual environment (auto-generated)
```

## 🚀 Quick Start

### Automated Setup (Recommended):
```bash
# Clone the repository
git clone https://github.com/OmarSaldanna/file_scrapper_api.git
cd rag_file_scrapper

# One-command setup
chmod +x setup.sh && ./setup.sh

# Start the API
./run.sh

# Run tests (optional)
chmod +x tests/test.sh && ./tests/test.sh
```

### Manual Setup:
```bash
# Clone and setup
git clone https://github.com/OmarSaldanna/file_scrapper_api.git
cd rag_file_scrapper
python3 -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt

# Start API
python api.py

# Test the API
curl http://localhost:5670/health
```

## 📦 Installation

### Option 1: Automated Setup (Recommended) 🚀

**Complete setup with one command:**

```bash
chmod +x setup.sh
./setup.sh
```

The `setup.sh` script automatically:
- ✅ Detects Python installation (python3/python)
- ✅ Creates virtual environment in `./venv/`
- ✅ Installs all dependencies from `requirements.txt`
- ✅ Creates executable `run.sh` script with absolute paths
- ✅ Generates `requirements.txt` template if missing
- ✅ Provides colored output and error handling

### Option 2: Manual Installation

**Step-by-step manual setup:**

1. **Clone and navigate:**
```bash
git clone https://github.com/OmarSaldanna/file_scrapper_api.git
cd rag_file_scrapper
```

2. **Create virtual environment:**
```bash
# Linux/macOS
python3 -m venv venv
source venv/bin/activate

# Windows
python -m venv venv
venv\Scripts\activate
```

3. **Install dependencies:**
```bash
pip install --upgrade pip
pip install -r requirements.txt
```

4. **Configure system:**
Edit `config.json` as needed (optional)

5. **Start API:**
```bash
python api.py
```

## 🎯 API Usage

### Core Endpoints

#### 📤 Process File
**Endpoint:** `POST /process-file`

Processes a file and extracts its content using the appropriate scrapper.

**Request:**
```bash
curl -X POST http://localhost:5670/process-file \
  -H "Content-Type: application/json; charset=utf-8" \
  -d '{"file": "/absolute/path/to/document.pdf"}' \
  -o result.json
```

**Request Body:**
```json
{
  "file": "/absolute/path/to/your/file.pdf"
}
```

**Success Response (200):**
```json
{
  "content": {
    "title": "Document Title",
    "text": "Extracted content...",
    "metadata": {
      "pages": 10,
      "author": "Author Name"
    }
  }
}
```

**Error Responses:**
```json
// Missing file parameter (400)
{
  "error": "Parameter 'file' is required"
}

// File not found (404)
{
  "error": "File not found: /path/to/file.pdf"
}

// Unsupported extension (400)
{
  "error": "Unsupported extension: .doc",
  "supported_extensions": [".md", ".pdf", ".pptx"]
}
```

#### 🏥 Health Check
**Endpoint:** `GET /health`

Verifies API status and availability.

```bash
curl http://localhost:5670/health
```

**Response:**
```json
{
  "status": "OK",
  "message": "API working correctly"
}
```

#### 📋 Supported Extensions
**Endpoint:** `GET /supported-extensions`

Returns list of supported file extensions.

```bash
curl http://localhost:5670/supported-extensions
```

**Response:**
```json
{
  "supported_extensions": [".md", ".pdf", ".pptx"]
}
```

## 🔧 Configuration

### config.json Structure

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

### Configuration Options

| Section | Key | Description | Default |
|---------|-----|-------------|---------|
| `extension_mappings` | `.pdf` | PDF processor module | `scrappers.get_pdf` |
| `extension_mappings` | `.pptx` | PowerPoint processor | `scrappers.get_pptx` |
| `extension_mappings` | `.md` | Markdown processor | `scrappers.get_md` |
| `server_config` | `debug` | Debug mode | `true` |
| `server_config` | `host` | Server host | `0.0.0.0` |
| `server_config` | `port` | Server port | `5670` |

### Adding New File Types

1. **Create scrapper module:**
```python
# scrappers/get_txt.py
def analyze(input_file):
    """
    Process text file and extract content
    
    Args:
        input_file (str): Absolute path to file
        
    Returns:
        dict: Processed content
    """
    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    return {
        "content": content,
        "word_count": len(content.split()),
        "line_count": len(content.splitlines())
    }
```

2. **Update config.json:**
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

3. **Restart API:**
```bash
./run.sh
```

## 🧪 Testing

### Automated Testing

The project includes a comprehensive testing framework:

```bash
# Make test script executable
chmod +x tests/test.sh

# Run all tests
./tests/test.sh
```

### Test Structure

- **`tests/samples/`**: Contains sample files for testing
  - `documentacion.pdf`: Sample PDF document
  - `ensayo.docx`: Sample Word document
  - `press_peste.pptx`: Sample PowerPoint presentation

- **`tests/results/`**: Stores test output
  - `pdf.json`: PDF processing results
  - `pptx.json`: PowerPoint processing results
  - `md.json`: Markdown processing results

- **`tests/test.sh`**: Automated testing script

### Manual Testing

**Test each endpoint individually:**

```bash
# Health check
curl http://localhost:5670/health

# Supported extensions
curl http://localhost:5670/supported-extensions

# Process PDF
curl -X POST http://localhost:5670/process-file \
  -H "Content-Type: application/json" \
  -d '{"file": "$(pwd)/tests/samples/documentacion.pdf"}' \
  -o test_result.json

# Process PowerPoint
curl -X POST http://localhost:5670/process-file \
  -H "Content-Type: application/json" \
  -d '{"file": "$(pwd)/tests/samples/press_peste.pptx"}' \
  -o test_pptx.json
```

## 🛠️ Development

### Scrapper Development Guidelines

Each scrapper module must implement:

```python
def analyze(input_file):
    """
    Process file and extract content
    
    Args:
        input_file (str): Absolute path to the file
        
    Returns:
        dict: Dictionary with processed content
        
    Raises:
        Exception: If processing fails
    """
    # Implementation here
    pass
```

### Scrapper Requirements

- **Function name**: Must be `analyze`
- **Parameter**: Single string parameter (absolute file path)
- **Return type**: Python dictionary
- **Error handling**: Raise exceptions for processing errors
- **Encoding**: Handle UTF-8 properly

### Example Scrapper Implementation

```python
# scrappers/get_example.py
import os
from pathlib import Path

def analyze(input_file):
    """Example scrapper implementation"""
    
    # Validate file exists
    if not os.path.exists(input_file):
        raise FileNotFoundError(f"File not found: {input_file}")
    
    # Get file info
    file_path = Path(input_file)
    file_stats = file_path.stat()
    
    try:
        # Process file (example implementation)
        with open(input_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Return structured data
        return {
            "filename": file_path.name,
            "size_bytes": file_stats.st_size,
            "content": content,
            "word_count": len(content.split()),
            "character_count": len(content),
            "processed_at": file_stats.st_mtime
        }
        
    except Exception as e:
        raise Exception(f"Error processing {input_file}: {str(e)}")
```

## 📚 Dependencies

### Core Framework
- **Flask**: Web framework and API foundation
- **Werkzeug**: WSGI utilities and development server
- **Jinja2**: Template engine (Flask dependency)
- **MarkupSafe**: Safe string handling
- **itsdangerous**: Cryptographic signing
- **click**: Command-line interface utilities
- **blinker**: Object signaling system

### Document Processing
- **python-pptx**: PowerPoint document processing
  - Used for: `from pptx import Presentation`
- **PyMuPDF**: PDF processing and text extraction
  - Alternative name: `fitz`
- **tiktoken**: Text tokenization for AI/ML applications

### Standard Library (No Installation Required)
- **collections**: Counter, defaultdict utilities
- **json**: JSON parsing and generation
- **os**: Operating system interface
- **pathlib**: Object-oriented filesystem paths

### Development & Testing
- **requests**: HTTP library (for testing)
- **pytest**: Testing framework (optional)

## 🚨 HTTP Status Codes

| Code | Status | Description | Example |
|------|--------|-------------|---------|
| 200 | ✅ Success | File processed successfully | Valid file processed |
| 400 | ❌ Bad Request | Invalid request parameters | Missing 'file' parameter |
| 404 | 🔍 Not Found | File not found | Invalid file path |
| 500 | 💥 Server Error | Internal processing error | Scrapper module error |

## 🏃‍♂️ Running the API

### Using Automated Scripts

**Start API (after setup.sh):**
```bash
./run.sh
```

**Features of run.sh:**
- ✅ Automatically activates virtual environment
- ✅ Changes to correct project directory
- ✅ Validates environment setup
- ✅ Provides colored status output
- ✅ Uses absolute paths (works from anywhere)

### Manual Execution

**Activate environment and run:**
```bash
# Activate virtual environment
source venv/bin/activate  # Windows: venv\Scripts\activate

# Start API
python api.py

# Access API at: http://localhost:5670
```

### Production Deployment

**For production environments:**

1. **Update config.json:**
```json
{
  "server_config": {
    "debug": false,
    "host": "127.0.0.1",
    "port": 8080
  }
}
```

2. **Use production WSGI server:**
```bash
pip install gunicorn
gunicorn -w 4 -b 0.0.0.0:8080 api:app
```

## 🤝 Contributing

### Development Workflow

1. **Fork the repository**
2. **Create feature branch:**
```bash
git checkout -b feature/amazing-feature
```

3. **Make changes and test:**
```bash
./tests/test.sh
```

4. **Commit changes:**
```bash
git commit -m 'Add amazing feature'
```

5. **Push and create Pull Request:**
```bash
git push origin feature/amazing-feature
```

### Code Standards

- **Python Style**: Follow PEP 8
- **Documentation**: Document all functions
- **Testing**: Add tests for new features
- **Error Handling**: Proper exception handling
- **UTF-8**: Support international characters

### Adding New Scrappers

1. Create scrapper in `scrappers/` directory
2. Implement `analyze(input_file)` function
3. Update `config.json` extension mappings
4. Add test samples to `tests/samples/`
5. Update documentation

## 🔒 Security Considerations

- **File Path Validation**: API validates file existence
- **Input Sanitization**: JSON input validation
- **Error Information**: Limited error details in responses
- **File Access**: Only processes files with absolute paths
- **Virtual Environment**: Isolated dependency management

## 📝 Important Notes

- ⚠️ **Absolute Paths**: API requires absolute file paths
- 🔤 **UTF-8 Support**: Full international character support
- 🔧 **External Configuration**: All settings in `config.json`
- 🛡️ **Robust Validation**: File existence and parameter validation
- 🐍 **Virtual Environment**: Always use isolated environments
- 🚀 **Automated Tools**: Use `setup.sh` and `run.sh` for efficiency
- 🧪 **Built-in Testing**: Comprehensive testing framework included
- 📊 **Sample Data**: Test files provided in `tests/samples/`

## 🐛 Troubleshooting

### Common Issues

**API won't start:**
```bash
# Check virtual environment
source venv/bin/activate
python --version

# Reinstall dependencies
pip install -r requirements.txt
```

**File not found errors:**
```bash
# Use absolute paths
curl -X POST http://localhost:5670/process-file \
  -d '{"file": "'$(pwd)'/tests/samples/documentacion.pdf"}'
```

**UTF-8 encoding issues:**
```bash
# Use proper headers
curl -H "Content-Type: application/json; charset=utf-8" \
  -X POST http://localhost:5670/process-file \
  -d '{"file": "/path/to/file.pdf"}'
```

**Permission errors:**
```bash
# Make scripts executable
chmod +x setup.sh run.sh tests/test.sh
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- 📖 **Documentation**: This README
- 🐛 **Issues**: [GitHub Issues](../../issues)
- 💡 **Feature Requests**: [GitHub Discussions](../../discussions)
- 🤝 **Contributions**: [Pull Requests](../../pulls)

---

<div align="center">

**RAG File Scrapper API** - Intelligent Document Processing Made Simple

[🚀 Get Started](#-quick-start) • [📖 Documentation](#-rag-file-scrapper-api) • [🧪 Testing](#-testing) • [🤝 Contribute](#-contributing)

*Built with ❤️ using Flask and Python*

</div>