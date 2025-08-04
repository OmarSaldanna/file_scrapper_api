from flask import Flask, request, jsonify
import os
import json
from pathlib import Path

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False

# Cargar configuraciones desde archivo JSON
def load_config():
    """Carga las configuraciones desde config.json"""
    try:
        with open('config.json', 'r', encoding='utf-8') as f:
            return json.load(f)
    except FileNotFoundError:
        raise FileNotFoundError("Archivo config.json no encontrado")
    except json.JSONDecodeError:
        raise ValueError("Error al parsear config.json")

# Cargar configuraciones
config = load_config()
EXTENSION_MAPPINGS = config['extension_mappings']
SERVER_CONFIG = config['server_config']

def get_file_extension(file_path):
    """Obtiene la extensión del archivo en minúsculas"""
    return Path(file_path).suffix.lower()

def import_scrapper_function(extension):
    """Importa dinámicamente la función analyze del scrapper correspondiente"""
    if extension not in EXTENSION_MAPPINGS:
        raise ValueError(f"Extensión no soportada: {extension}")
    
    module_name = EXTENSION_MAPPINGS[extension]
    module = __import__(module_name, fromlist=['analyze'])
    return getattr(module, 'analyze')

@app.route('/process-file', methods=['POST'])
def process_file():
    try:
        # Verificar que el request tenga JSON
        if not request.is_json:
            return jsonify({'error': 'Content-Type debe ser application/json'}), 400
        
        data = request.get_json()
        
        # Verificar que el parámetro 'file' exista
        if 'file' not in data:
            return jsonify({'error': 'Parámetro "file" es requerido'}), 400
        
        file_path = data['file']
        
        # Verificar que el archivo exista
        if not os.path.exists(file_path):
            return jsonify({'error': f'Archivo no encontrado: {file_path}'}), 404
        
        # Obtener la extensión del archivo
        extension = get_file_extension(file_path)
        
        # Verificar que la extensión sea soportada
        if extension not in EXTENSION_MAPPINGS:
            supported_extensions = list(EXTENSION_MAPPINGS.keys())
            return jsonify({
                'error': f'Extensión no soportada: {extension}',
                'supported_extensions': supported_extensions
            }), 400
        
        # Importar y ejecutar la función analyze correspondiente
        analyze_function = import_scrapper_function(extension)
        content = analyze_function(file_path)
        
        # Retornar el resultado
        # response = jsonify({'content': content})
        # response.headers['Content-Type'] = 'application/json; charset=utf-8'
        # return response, 200
        ## Esto fue implementado para que no hubiera acentos no detectados en los resultados
        payload = {'content': content}
        response = app.response_class(
            response=json.dumps(payload, ensure_ascii=False, indent=2),
            status=200,
            mimetype='application/json; charset=utf-8'
        )
        return response
        
    except ValueError as e:
        response = jsonify({'error': str(e)})
        response.headers['Content-Type'] = 'application/json; charset=utf-8'
        return response, 400
    except ImportError as e:
        response = jsonify({'error': f'Error al importar scrapper: {str(e)}'})
        response.headers['Content-Type'] = 'application/json; charset=utf-8'
        return response, 500
    except AttributeError as e:
        response = jsonify({'error': f'Función analyze no encontrada en el scrapper: {str(e)}'})
        response.headers['Content-Type'] = 'application/json; charset=utf-8'
        return response, 500
    except Exception as e:
        response = jsonify({'error': f'Error interno del servidor: {str(e)}'})
        response.headers['Content-Type'] = 'application/json; charset=utf-8'
        return response, 500

@app.route('/health', methods=['GET'])
def health_check():
    """Endpoint para verificar que la API esté funcionando"""
    return jsonify({'status': 'OK', 'message': 'API funcionando correctamente'}), 200

@app.route('/supported-extensions', methods=['GET'])
def supported_extensions():
    """Endpoint para obtener las extensiones soportadas"""
    return jsonify({'supported_extensions': list(EXTENSION_MAPPINGS.keys())}), 200

if __name__ == '__main__':
    app.run(
        debug=SERVER_CONFIG['debug'],
        host=SERVER_CONFIG['host'],
        port=SERVER_CONFIG['port']
    )