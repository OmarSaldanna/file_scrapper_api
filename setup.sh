#!/bin/bash

# 🚀 RAG File Scrapper API - Setup Script
# This script sets up the project environment and creates execution scripts

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get absolute path of the project directory
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="$PROJECT_DIR/venv"
RUN_SCRIPT="$PROJECT_DIR/run.sh"

echo -e "${BLUE}🚀 RAG File Scrapper API Setup${NC}"
echo -e "${BLUE}================================${NC}"
echo -e "Project directory: ${YELLOW}$PROJECT_DIR${NC}"
echo ""

# Function to print status messages
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if Python is installed
if ! command -v python3 &> /dev/null && ! command -v python &> /dev/null; then
    print_error "Python is not installed. Please install Python 3.7 or higher."
    exit 1
fi

# Determine Python command
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
else
    PYTHON_CMD="python"
fi

print_status "Using Python: $($PYTHON_CMD --version)"

# Create virtual environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
    echo -e "${BLUE}📦 Creating virtual environment...${NC}"
    $PYTHON_CMD -m venv "$VENV_DIR"
    print_status "Virtual environment created at: $VENV_DIR"
else
    print_warning "Virtual environment already exists at: $VENV_DIR"
fi

# Activate virtual environment and install dependencies
echo -e "${BLUE}📚 Installing dependencies...${NC}"
source "$VENV_DIR/bin/activate"

# Upgrade pip
pip install --upgrade pip

# Install dependencies if requirements.txt exists
if [ -f "$PROJECT_DIR/requirements.txt" ]; then
    pip install -r "$PROJECT_DIR/requirements.txt"
    print_status "Dependencies installed from requirements.txt"
else
    print_warning "requirements.txt not found. Installing Flask only..."
    pip install Flask
fi

# Create run.sh script
echo -e "${BLUE}📝 Creating run.sh script...${NC}"

cat > "$RUN_SCRIPT" << EOF
#!/bin/bash

# 🚀 RAG File Scrapper API - Run Script
# Auto-generated script to run the API with virtual environment

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Project paths
PROJECT_DIR="$PROJECT_DIR"
VENV_DIR="$VENV_DIR"
API_SCRIPT="\$PROJECT_DIR/api.py"

echo -e "\${BLUE}🚀 Starting RAG File Scrapper API...\${NC}"
echo -e "Project: \${PROJECT_DIR}"
echo -e "Virtual env: \${VENV_DIR}"
echo ""

# Check if virtual environment exists
if [ ! -d "\$VENV_DIR" ]; then
    echo -e "\${RED}❌ Virtual environment not found at: \$VENV_DIR\${NC}"
    echo -e "\${RED}Please run setup.sh first\${NC}"
    exit 1
fi

# Check if API script exists
if [ ! -f "\$API_SCRIPT" ]; then
    echo -e "\${RED}❌ API script not found at: \$API_SCRIPT\${NC}"
    exit 1
fi

# Activate virtual environment
echo -e "\${GREEN}✅ Activating virtual environment...\${NC}"
source "\$VENV_DIR/bin/activate"

# Change to project directory
cd "\$PROJECT_DIR"

# Run the API
echo -e "\${GREEN}✅ Starting Flask API...\${NC}"
echo -e "\${BLUE}Access the API at: http://localhost:5670\${NC}"
echo -e "\${BLUE}Press Ctrl+C to stop the server\${NC}"
echo ""

python api.py
EOF

# Make run.sh executable
chmod +x "$RUN_SCRIPT"
print_status "Created executable run.sh script at: $RUN_SCRIPT"

# Final instructions
echo ""
echo -e "${GREEN}🎉 Setup completed successfully!${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo -e "1. Edit requirements.txt to add your scrapper dependencies"
echo -e "2. Run: ${YELLOW}./run.sh${NC} to start the API"
echo -e "3. Or manually activate venv: ${YELLOW}source venv/bin/activate${NC}"
echo ""
echo -e "${BLUE}Quick commands:${NC}"
echo -e "• Start API: ${YELLOW}./run.sh${NC}"
echo -e "• Test API: ${YELLOW}curl http://localhost:5670/health${NC}"
echo -e "• Deactivate venv: ${YELLOW}deactivate${NC}"
echo ""
print_status "All done! Happy coding! 🚀"