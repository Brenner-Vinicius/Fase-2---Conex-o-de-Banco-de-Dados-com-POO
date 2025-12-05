INSERT INTO categoria (nome_categoria, valor_diaria_padrao, multa_diaria_atraso) VALUES
('Ferramentas Eletricas', 25.00, 10.00),
('Equipamentos de Construcao', 80.00, 30.00),
('Maquinas Pesadas', 350.00, 150.00),
('Equipamentos de Jardinagem', 15.00, 5.00);

INSERT INTO equipamento (nome_equipamento, descricao_equipamento, fk_categoria_id, status_equipamento, data_aquisicao, valor_custo, quantidade_disponivel) VALUES
('Furadeira de Impacto', 'Furadeira 1/2 Pol. 110V', 1, 'disponivel', '2023-01-15', 350.00, 5),
('Serra Circular', 'Serra elétrica para madeira e MDF', 1, 'disponivel', '2023-02-20', 520.00, 3),
('Betoneira 400L', 'Betoneira de grande capacidade', 2, 'disponivel', '2022-11-01', 4500.00, 2),
('Compactador de Solo', 'Compactador tipo sapo', 2, 'disponivel', '2023-03-10', 3200.00, 2),
('Escavadeira Hidraulica', 'Mini escavadeira hidráulica', 3, 'disponivel', '2022-05-01', 85000.00, 1),
('Rocadeira a Gasolina', 'Roçadeira profissional 52cc', 4, 'disponivel', '2023-06-05', 980.00, 4),
('Andaime Tubular', 'Estrutura modular de andaime', 2, 'disponivel', '2023-01-25', 1200.00, 6),
('Gerador 6kVA', 'Gerador portátil trifásico', 3, 'disponivel', '2023-08-12', 4500.00, 2),
('Cortador de Grama', 'Cortador elétrico 220V', 4, 'disponivel', '2024-04-01', 1200.00, 5),
('Vibrador de Concreto', 'Vibrador portátil', 2, 'disponivel', '2023-09-01', 800.00, 3),
('Plaina Elétrica', 'Plaina 650W', 1, 'disponivel', '2023-07-10', 400.00, 2),
('Compactador Manual', 'Compactador leve manual', 2, 'disponivel', '2024-03-01', 900.00, 2);

INSERT INTO cliente (nome_cliente, cpf_cnpj_cliente, telefone_cliente, email_cliente) VALUES
('Construtora Alfa', '11.111.111/0001-11', '(11) 98765-4321', 'contato@alfa.com'),
('Joao da Silva', '222.222.222-22', '(21) 99888-7777', 'joao.silva@email.com'),
('Engenharia Beta', '33.333.333/0001-33', '(31) 99666-5555', 'projetos@beta.com'),
('Maria Oliveira', '444.444.444-44', '(81) 98555-4444', 'maria.ol@email.com'),
('Pedro Santos', '555.555.555-55', '(41) 99333-2222', 'pedro.santos@email.com'),
('Construtora Delta', '66.666.666/0001-66', '(11) 91234-5678', 'delta@construtora.com'),
('Loja Central', '77.777.777/0001-77', '(21) 91111-2222', 'lojacentral@contato.com'),
('Ana Pereira', '888.888.888-88', '(31) 99999-0000', 'ana.pereira@email.com'),
('Office Solucoes', '99.999.999/0001-99', '(41) 98888-1111', 'contato@office.com'),
('Carlos Lima', '101.101.101-10', '(71) 98877-6655', 'carlos.lima@email.com'),
('Empresa X', '202.202.202/0001-20', '(11) 94444-5555', 'contato@empresax.com'),
('Felipe Costa', '303.303.303-30', '(51) 97777-3333', 'felipe.costa@email.com');

INSERT INTO locacao (cpf_cnpj_cliente, data_prevista_devolucao, status_locacao) VALUES
('11.111.111/0001-11', '2025-01-20', 'emcurso'),
('222.222.222-22', '2025-01-05', 'emcurso'),
('33.333.333/0001-33', '2025-02-15', 'aberta'),
('444.444.444-44', '2025-01-18', 'emcurso'),
('555.555.555-55', '2025-11-15', 'aberta'),
('66.666.666/0001-66', '2025-11-30', 'aberta'),
('77.777.777/0001-77', '2025-11-10', 'emcurso'),
('888.888.888-88', '2025-11-05', 'emcurso'),
('99.999.999/0001-99', '2025-11-22', 'aberta'),
('101.101.101-10', '2025-11-02', 'emcurso'),
('202.202.202/0001-20', '2025-11-18', 'aberta'),
('303.303.303-30', '2025-11-25', 'aberta');

INSERT INTO item_locacao (fk_locacao_id, fk_equipamento_id, valor_diaria_negociada, dias_estimados) VALUES
(1, 3, 80.00, 9),
(1, 7, 80.00, 9),
(2, 1, 20.00, 5),
(3, 5, 350.00, 5),
(4, 2, 25.00, 8),
(5, 8, 70.00, 2),
(6, 12, 30.00, 7),
(7, 11, 200.00, 5),
(8, 9, 40.00, 4),
(9, 4, 80.00, 2),
(10, 10, 40.00, 6),
(11, 6, 12.00, 10),
(12, 2, 25.00, 2);

INSERT INTO devolucao (fk_locacao_id, data_devolucao, observacoes) VALUES
(1, '2025-01-20 10:00:00', 'Devolvido no prazo'),
(2, '2025-01-08 09:30:00', 'Devolução com 3 dias de atraso'),
(4, '2025-01-22 15:00:00', 'Equipamento devolvido com leve desgaste');

INSERT INTO item_devolucao (fk_devolucao_id, fk_equipamento_id, estado_devolucao)
SELECT d.pk_devolucao, i.fk_equipamento_id, 'Perfeito'
FROM devolucao d
JOIN item_locacao i ON i.fk_locacao_id = d.fk_locacao_id;

INSERT INTO pagamento (fk_locacao_id, data_devolucao_real)
VALUES (1, '2025-01-20');

INSERT INTO pagamento (fk_locacao_id, data_devolucao_real)
VALUES (2, '2025-01-08');

INSERT INTO pagamento (fk_locacao_id, data_devolucao_real)
VALUES (4, '2025-01-22');