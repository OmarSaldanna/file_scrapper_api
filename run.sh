#!/bin/bash

# 🚀 RAG File Scrapper API - Run Script
# Auto-generated script to run the API with virtual environment

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Project paths
PROJECT_DIR="/Users/omarsaldanna/Downloads/file_scrapper_api"
VENV_DIR="/Users/omarsaldanna/Downloads/file_scrapper_api/venv"
API_SCRIPT="$PROJECT_DIR/api.py"

echo -e "${BLUE}🚀 Starting RAG File Scrapper API...${NC}"
echo -e "Project: ${PROJECT_DIR}"
echo -e "Virtual env: ${VENV_DIR}"
echo ""

# Check if virtual environment exists
if [ ! -d "$VENV_DIR" ]; then
    echo -e "${RED}❌ Virtual environment not found at: $VENV_DIR${NC}"
    echo -e "${RED}Please run setup.sh first${NC}"
    exit 1
fi

# Check if API script exists
if [ ! -f "$API_SCRIPT" ]; then
    echo -e "${RED}❌ API script not found at: $API_SCRIPT${NC}"
    exit 1
fi

# Activate virtual environment
echo -e "${GREEN}✅ Activating virtual environment...${NC}"
source "$VENV_DIR/bin/activate"

# Change to project directory
cd "$PROJECT_DIR"

# Run the API
echo -e "${GREEN}✅ Starting Flask API...${NC}"
echo -e "${BLUE}Access the API at: http://localhost:5670${NC}"
echo -e "${BLUE}Press Ctrl+C to stop the server${NC}"
echo ""

python api.py
