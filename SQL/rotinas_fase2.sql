-- ==========================================
-- FUNÇÃO: Retorna valor estimado da locação
-- ==========================================
CREATE OR REPLACE FUNCTION fn_calcular_valor_aluguel(p_locacao_id INT)
RETURNS NUMERIC(12,2) AS $$
DECLARE
    v_total NUMERIC(12,2);
BEGIN
    SELECT COALESCE(SUM(il.valor_diaria_negociada * il.dias_estimados), 0)
    INTO v_total
    FROM item_locacao il
    WHERE il.fk_locacao_id = p_locacao_id;

    RETURN v_total;
END;
$$ LANGUAGE plpgsql;


-- ==========================================
-- FUNÇÃO: Retorna dias de atraso
-- ==========================================
CREATE OR REPLACE FUNCTION fn_dias_de_atraso(
    p_locacao_id INT,
    p_data_retorno DATE
)
RETURNS INT AS $$
DECLARE
    v_data_prevista DATE;
    v_dias INT;
BEGIN
    SELECT data_prevista_devolucao
    INTO v_data_prevista
    FROM locacao
    WHERE pk_locacao = p_locacao_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Locação % não encontrada', p_locacao_id;
    END IF;

    IF p_data_retorno IS NULL THEN
        p_data_retorno := CURRENT_DATE;
    END IF;

    v_dias := p_data_retorno - v_data_prevista;

    IF v_dias < 0 THEN
        RETURN 0;
    END IF;

    RETURN v_dias;
END;
$$ LANGUAGE plpgsql;


-- ==========================================
-- PROCEDURE: Cancela uma locação
-- ==========================================
CREATE OR REPLACE PROCEDURE prc_cancelar_locacao(p_locacao_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE locacao
    SET status_locacao = 'cancelada'
    WHERE pk_locacao = p_locacao_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Locação % não encontrada', p_locacao_id;
    END IF;
END;
$$;
