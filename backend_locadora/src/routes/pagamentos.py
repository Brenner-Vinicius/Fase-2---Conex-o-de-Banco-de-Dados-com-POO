from flask import Blueprint, jsonify
from src.db.connection import get_db_connection

pagamentos_bp = Blueprint("pagamentos", __name__)

@pagamentos_bp.route("/pagamentos", methods=["GET"])
def listar_pagamentos():
    conn = get_db_connection()

    cur = conn.cursor()

    cur.execute("""
        SELECT 
            p.pk_pagamento,
            p.fk_locacao_id,
            p.valor_total_estimado,
            p.valor_multa,
            p.valor_total,
            p.status_pagamento,
            p.data_pagamento
        FROM pagamento p
        ORDER BY p.pk_pagamento;
    """)

    dados = cur.fetchall()

    cur.close()
    conn.close()

    pagamentos = []
    for p in dados:
        pagamentos.append({
            "id_pagamento": p[0],
            "locacao": p[1],
            "valor_estimado": float(p[2]),
            "multa": float(p[3]),
            "total": float(p[4]),
            "status": p[5],
            "data_pagamento": str(p[6])
        })

    return jsonify(pagamentos)
