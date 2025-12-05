from flask import Blueprint, jsonify
from src.db.connection import get_db_connection

equipamentos_bp = Blueprint("equipamentos", __name__)

@equipamentos_bp.route("/equipamentos", methods=["GET"])
def listar_equipamentos():
    conn = get_db_connection()

    cur = conn.cursor()

    cur.execute("""
        SELECT 
            e.pk_equipamento,
            e.nome_equipamento,
            c.nome_categoria,
            e.status_equipamento,
            e.quantidade_disponivel
        FROM equipamento e
        JOIN categoria c ON c.pk_categoria = e.fk_categoria_id
        ORDER BY e.pk_equipamento;
    """)

    equipamentos = cur.fetchall()

    cur.close()
    conn.close()

    resultado = []
    for e in equipamentos:
        resultado.append({
            "id": e[0],
            "nome": e[1],
            "categoria": e[2],
            "status": e[3],
            "quantidade_disponivel": e[4]
        })

    return jsonify(resultado)
