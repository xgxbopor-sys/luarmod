from flask import Flask, request, jsonify
import firebase_admin
from firebase_admin import db

# 1. Configura Firebase con tu archivo .json (la clave privada que bajaste)
cred = firebase_admin.credentials.Certificate("tu-archivo-de-firebase.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://tu-proyecto-id.firebaseio.com/'
})

app = Flask(__name__)

@app.route('/verificar', methods=['GET'])
def verificar():
    key_recibida = request.args.get('key')
    
    # 2. Buscamos en la base de datos "Keys"
    ref = db.reference('Keys')
    keys_en_db = ref.get()
    
    # 3. Verificamos si la key existe
    if keys_en_db and key_recibida in keys_en_db:
        return jsonify({"status": "success", "script": "TU_LINK_RAW_DE_GITHUB"})
    
    return jsonify({"status": "error", "message": "Key no valida, mae"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=10000)
