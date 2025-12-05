from flask import Blueprint, jsonify
from src.db.connection import get_db_connection

clientes_bp = Blueprint("clientes", __name__)

@clientes_bp.route("/clientes", methods=["GET"])
def listar_clientes():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("SELECT cpf_cnpj_cliente, nome_cliente, telefone_cliente, email_cliente FROM cliente")
    clientes = cur.fetchall()

    cur.close()
    conn.close()

    resultado = []
    for c in clientes:
        resultado.append({
            "cpf_cnpj": c[0],
            "nome": c[1],
            "telefone": c[2],
            "email": c[3]
        })

    return jsonify(resultado)
