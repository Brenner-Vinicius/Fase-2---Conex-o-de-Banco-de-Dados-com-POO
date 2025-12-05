CREATE OR REPLACE VIEW vw_locacoes_detalhadas AS
SELECT
    l.pk_locacao AS id_locacao,
    l.nome_cliente,
    l.cpf_cnpj_cliente,
    l.data_locacao,
    l.data_prevista_devolucao,
    l.data_devolucao_real,
    l.status_locacao,
    p.valor_previsto,
    p.valor_multa,
    p.valor_total AS valor_total_pago,
    COALESCE(SUM(CASE WHEN il.fk_equipamento_id IS NOT NULL THEN 1 END), 0) AS total_itens,
    STRING_AGG(DISTINCT e.nome_equipamento, ', ') AS equipamentos_alugados,
    STRING_AGG(DISTINCT c.nome_categoria, ', ') AS categorias_envolvidas
FROM locacao l
LEFT JOIN item_locacao il ON il.fk_locacao_id = l.pk_locacao
LEFT JOIN equipamento e ON e.pk_equipamento = il.fk_equipamento_id
LEFT JOIN categoria c ON c.pk_categoria = e.fk_categoria_id
LEFT JOIN pagamento p ON p.fk_locacao_id = l.pk_locacao
GROUP BY
    l.pk_locacao,
    l.nome_cliente,
    l.cpf_cnpj_cliente,
    l.data_locacao,
    l.data_prevista_devolucao,
    l.data_devolucao_real,
    l.status_locacao,
    p.valor_previsto,
    p.valor_multa,
    p.valor_total;

CREATE OR REPLACE VIEW vw_extrato_cliente AS
SELECT
    c.nome_cliente,
    c.cpf_cnpj_cliente,
    l.pk_locacao,
    l.data_locacao,
    l.data_prevista_devolucao,
    l.data_devolucao_real,
    l.status_locacao,
    l.valor_total_estimado,
    p.valor_multa,
    p.valor_total AS valor_pago
FROM cliente c
JOIN locacao l ON c.cpf_cnpj_cliente = l.cpf_cnpj_cliente
LEFT JOIN pagamento p ON l.pk_locacao = p.fk_locacao_id;
