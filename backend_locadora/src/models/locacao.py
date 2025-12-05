from src.db.connection import execute_query

def get_all_locacoes():
    query = "SELECT * FROM vw_locacoes_detalhadas ORDER BY id_locacao DESC;"
    return execute_query(query)


def get_locacao_detalhes(locacao_id):
    query = "SELECT * FROM vw_locacoes_detalhadas WHERE id_locacao = %s;"
    result = execute_query(query, (locacao_id,))
    return result[0] if result else None

def call_prc_cancelar_locacao(locacao_id):
    query = "CALL prc_cancelar_locacao(%s);"
    return execute_query(query, (locacao_id,), fetch=False, commit=True)


def call_fn_calcular_valor_aluguel(locacao_id):
    query = "SELECT fn_calcular_valor_aluguel(%s) AS valor_estimado;"
    return execute_query(query, (locacao_id,))


def call_fn_dias_de_atraso(locacao_id, data_real):
    query = "SELECT fn_dias_de_atraso(%s, %s) AS dias_atraso;"
    return execute_query(query, (locacao_id, data_real))