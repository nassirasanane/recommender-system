from flask import Flask, jsonify
import sys
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def hello():
    return '''<h1>🐳 Docker Test OK!</h1><p>Flask fonctionne!</p>'''

@app.route('/health')
def health():
    return jsonify({'status': 'healthy'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
