CREATE VIEW vw_Produto_Detalhes AS
SELECT
  p.prod_id          AS ProdutoID,
  p.prod_nome        AS NomeProduto,
  p.prod_preco       AS PrecoUnitario,
  p.prod_qtd_estoque AS QtdEstoque,
  c.catp_nome        AS Categoria
FROM Produto p
JOIN Categoria_Produto c ON p.catp_id = c.catp_id;

--View de Fornecedores por Produto

CREATE VIEW vw_Produto_Fornecedor AS
SELECT
  pf.prod_id    AS ProdutoID,
  p.prod_nome   AS NomeProduto,
  pf.forn_id    AS FornecedorID,
  f.forn_nome   AS NomeFornecedor
FROM Produto_Fornecedor pf
JOIN Produto p ON pf.prod_id = p.prod_id
JOIN Fornecedor f ON pf.forn_id = f.forn_id;

--View de Clientes com Endereço

CREATE VIEW vw_Cliente_Com_Endereco AS
SELECT
  cli.cli_id          AS ClienteID,
  cli.cli_nome        AS NomeCliente,
  cli.cli_cpf         AS CPF,
  cli.cli_telefone    AS Telefone,
  e.endc_rua          AS Rua,
  e.endc_numero       AS Numero,
  e.endc_bairro       AS Bairro,
  e.endc_cidade       AS Cidade,
  e.endc_estado       AS Estado
FROM Cliente cli
LEFT JOIN Endereco_Cliente e ON cli.cli_id = e.cli_id;

--View de Funcionários e Setores (Histórico)

CREATE VIEW vw_Funcionario_Setor_Historico AS
SELECT
  f.func_id            AS FuncionarioID,
  f.func_nome          AS NomeFuncionario,
  f.func_cargo         AS Cargo,
  f.func_salario       AS Salario,
  f.func_data_admissao AS DataAdmissao,
  s.setor_id           AS SetorID,
  s.setor_nome         AS NomeSetor,
  fs.fs_data_inicio    AS DataInicioSetor,
  fs.fs_data_fim       AS DataFimSetor
FROM Funcionario f
JOIN Funcionario_Setor fs ON f.func_id = fs.func_id
JOIN Setor s ON fs.setor_id = s.setor_id;

--View de Total de Itens por Venda

CREATE VIEW vw_Total_Itens_Por_Venda AS
SELECT
  iv.venda_id                             AS VendaID,
  SUM(iv.itemv_qtd * iv.itemv_preco_unit) AS ValorItens
FROM Item_Venda iv
GROUP BY iv.venda_id;

--View Principal de Vendas com Cliente e Funcionário

CREATE VIEW vw_Venda_Detalhada AS
SELECT
  v.venda_id                       AS VendaID,
  v.venda_data                     AS DataVenda,
  COALESCE(t.ValorItens, 0.00)     AS ValorItens,
  v.venda_valor_total              AS ValorTotalInformado,
  (COALESCE(t.ValorItens, 0.00) - v.venda_valor_total) AS DiferencaItensXTotal,
  cli.cli_id                       AS ClienteID,
  cli.cli_nome                     AS NomeCliente,
  f.func_id                        AS FuncionarioID,
  f.func_nome                      AS NomeFuncionario
FROM Venda v
LEFT JOIN vw_Total_Itens_Por_Venda t ON v.venda_id = t.VendaID
JOIN Cliente cli ON v.cli_id = cli.cli_id
JOIN Funcionario f ON v.func_id = f.func_id;

--View de Itens de Venda com Nome do Produto

CREATE VIEW vw_Item_Venda_Detalhado AS
SELECT
  iv.itemv_id         AS ItemVendaID,
  iv.venda_id         AS VendaID,
  p.prod_id           AS ProdutoID,
  p.prod_nome         AS NomeProduto,
  iv.itemv_qtd        AS Quantidade,
  iv.itemv_preco_unit AS PrecoUnitario,
  (iv.itemv_qtd * iv.itemv_preco_unit) AS "Total",
  v.venda_data AS "Data_Venda"
FROM Item_Venda iv
JOIN Produto p ON iv.prod_id = p.prod_id
JOIN Venda v ON iv.venda_id = v.venda_id;

--View de Total de Itens por Compra

CREATE VIEW vw_Total_Itens_Por_Compra AS
SELECT
  ic.comp_id                               AS CompraID,
  SUM(ic.itemc_qtd * ic.itemc_preco_unit)  AS ValorItens
FROM Item_Compra ic
GROUP BY ic.comp_id;

--View Principal de Compras com Fornecedor e Funcionário

CREATE VIEW vw_Compra_Detalhada AS
SELECT
  c.comp_id                        AS CompraID,
  c.comp_data                      AS DataCompra,
  COALESCE(t.ValorItens, 0.00)     AS ValorItens,
  c.comp_valor_total               AS ValorTotalInformado,
  (COALESCE(t.ValorItens, 0.00) - c.comp_valor_total) AS DiferencaItensXTotal,
  f.forn_id                        AS FornecedorID,
  f.forn_nome                      AS NomeFornecedor,
  fn.func_id                       AS FuncionarioID,
  fn.func_nome                     AS NomeFuncionario
FROM Compra c
LEFT JOIN vw_Total_Itens_Por_Compra t ON c.comp_id = t.CompraID
JOIN Fornecedor f ON c.forn_id = f.forn_id
JOIN Funcionario fn ON c.func_id = fn.func_id;

--View de Promoções Ativas

CREATE VIEW vw_Promocao_Ativa AS
SELECT
  pr.promo_id         AS PromocaoID,
  pr.promo_percentual AS PercentualDesconto,
  pr.promo_inicio     AS DataInicio,
  pr.promo_fim        AS DataFim,
  p.prod_id           AS ProdutoID,
  p.prod_nome         AS NomeProduto,
  p.prod_preco        AS PrecoOriginal,
  ROUND((p.prod_preco * (1 - pr.promo_percentual / 100.0)), 2) AS PrecoPromocional
FROM Promocao pr
JOIN Produto p ON pr.prod_id = p.prod_id
WHERE DATE('now') BETWEEN pr.promo_inicio AND pr.promo_fim;

CREATE VIEW TempoEmEstoque AS
SELECT 
	p.prod_id AS "ID_Produto",
	p.prod_nome AS "Nome_Produto",
	p.prod_qtd_estoque AS "Quantidade_em_Estoque",
	c.comp_data AS "Ultima_Compra",
	JULIANDAY(CURRENT_DATE) - JULIANDAY(c.comp_data) AS "Dias_em_Estoque"
FROM Produto p 
JOIN Item_Compra ic ON ic.prod_id = p.prod_id
JOIN Compra c ON c.comp_id = ic.comp_id
ORDER BY Dias_em_Estoque DESC
LIMIT 10;

CREATE VIEW MetodoPag AS
SELECT 
	p.pag_metodo AS "Metodo",
	COUNT(p.pag_id) AS "Vezes_Usado"
FROM Pagamento p 
GROUP BY p.pag_metodo;

CREATE VIEW vw_Funcionarios_Ativos_Por_Setor AS
SELECT 
	fs.NomeSetor,
	COUNT(fs.FuncionarioID) AS "TotalFuncionarios"
FROM vw_Funcionario_Setor_Historico fs
GROUP BY fs.NomeSetor; 

CREATE VIEW vw_Produtos_Mais_Vendidos_Por_Periodo AS
SELECT
    p.prod_id AS ProdutoID,
    p.prod_nome AS NomeProduto,
    cp.catp_nome AS CategoriaProduto,
    v.venda_data AS DataVenda,
    SUM(iv.itemv_qtd) AS QuantidadeTotalVendida,
    SUM(iv.itemv_qtd * iv.itemv_preco_unit) AS ValorTotalVendido
FROM Item_Venda iv
JOIN Produto p ON iv.prod_id = p.prod_id
JOIN Categoria_Produto cp ON p.catp_id = cp.catp_id
JOIN Venda v ON iv.venda_id = v.venda_id
GROUP BY
    p.prod_id
ORDER BY
    v.venda_data ASC, QuantidadeTotalVendida DESC;