from src.db.connection import execute_query

def get_all_clientes():
    query = """
    SELECT nome_cliente, cpf_cnpj_cliente, telefone_cliente, email_cliente
    FROM cliente
    ORDER BY nome_cliente;
    """
    return execute_query(query)


def get_cliente_by_id(cpf_cnpj):
    query = """
    SELECT nome_cliente, cpf_cnpj_cliente, telefone_cliente, email_cliente
    FROM cliente
    WHERE cpf_cnpj_cliente = %s;
    """
    result = execute_query(query, (cpf_cnpj,))
    return result[0] if result else None


def create_cliente(nome, cpf_cnpj, telefone, email):
    query = """
    INSERT INTO cliente (nome_cliente, cpf_cnpj_cliente, telefone_cliente, email_cliente)
    VALUES (%s, %s, %s, %s);
    """
    return execute_query(query, (nome, cpf_cnpj, telefone, email), fetch=False, commit=True)


def delete_cliente(cpf_cnpj):
    query = "DELETE FROM cliente WHERE cpf_cnpj_cliente = %s;"
    return execute_query(query, (cpf_cnpj,), fetch=False, commit=True)