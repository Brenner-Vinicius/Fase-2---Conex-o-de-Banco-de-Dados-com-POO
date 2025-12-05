from flask import Blueprint, jsonify, request
from src.db.connection import get_db_connection

locacoes_bp = Blueprint("locacoes", __name__)

@locacoes_bp.route("/locacoes", methods=["GET"])
def listar_locacoes():
    conn = get_db_connection()

    cur = conn.cursor()

    cur.execute("SELECT * FROM vw_locacoes_detalhadas ORDER BY id_locacao")
    dados = cur.fetchall()

    colunas = [desc[0] for desc in cur.description]

    cur.close()
    conn.close()

    resultado = []
    for row in dados:
        item = dict(zip(colunas, row))
        resultado.append(item)

    return jsonify(resultado)


@locacoes_bp.route("/locacoes/<int:id_locacao>/valor_estimado", methods=["GET"])
def valor_estimado(id_locacao):
    conn = get_db_connection()

    cur = conn.cursor()

    cur.execute("SELECT fn_calcular_valor_aluguel(%s);", (id_locacao,))
    valor = cur.fetchone()[0]

    cur.close()
    conn.close()

    return jsonify({"id_locacao": id_locacao, "valor_estimado": float(valor)})


@locacoes_bp.route("/locacoes/<int:id_locacao>/dias_atraso", methods=["GET"])
def dias_atraso(id_locacao):
    data_devolucao = request.args.get("data_devolucao")

    conn = get_db_connection()

    cur = conn.cursor()

    cur.execute("SELECT fn_dias_de_atraso(%s, %s);", (id_locacao, data_devolucao))
    dias = cur.fetchone()[0]

    cur.close()
    conn.close()

    return jsonify({"id_locacao": id_locacao, "dias_atraso": dias})


@locacoes_bp.route("/locacoes/<int:id_locacao>/cancelar", methods=["PUT"])
def cancelar_locacao(id_locacao):

    conn = get_db_connection()

    cur = conn.cursor()

    cur.execute("CALL prc_cancelar_locacao(%s);", (id_locacao,))
    conn.commit()

    cur.close()
    conn.close()

    return jsonify({"mensagem": f"Locação {id_locacao} cancelada com sucesso"})
