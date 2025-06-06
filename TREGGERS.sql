CREATE TRIGGER DelCli 
AFTER DELETE ON Cliente
FOR EACH ROW
BEGIN
	DELETE FROM Endereco_Cliente WHERE cli_id = OLD.cli_id;
END;

CREATE TRIGGER DelFun 
AFTER DELETE ON Funcionario
FOR EACH ROW
BEGIN
	DELETE FROM Funcionario_Setor WHERE func_id = OLD.func_id;
END;

CREATE TRIGGER DelProd
AFTER DELETE ON Produto
FOR EACH ROW
BEGIN
	DELETE FROM Produto_Fornecedor WHERE prod_id = OLD.prod_id;
END;

CREATE TRIGGER UpdateEstoqueVenda
AFTER INSERT ON Item_Venda
FOR EACH ROW
BEGIN
	UPDATE Produto SET prod_qtd_estoque = (prod_qtd_estoque-NEW.itemv_qtd) WHERE prod_id = NEW.prod_id;
END;

CREATE TRIGGER UpdateEstoqueCompra
AFTER INSERT ON Item_Compra
FOR EACH ROW
BEGIN
	UPDATE Produto SET prod_qtd_estoque = (prod_qtd_estoque+NEW.itemc_qtd) WHERE prod_id = NEW.prod_id;
END;

CREATE TRIGGER UpdateValorVenda
AFTER INSERT ON Item_Venda
FOR EACH ROW
BEGIN
    UPDATE Venda
    SET venda_valor_total = (SELECT SUM(itemv_qtd * itemv_preco_unit) FROM Item_Venda WHERE venda_id = NEW.venda_id)
    WHERE venda_id = NEW.venda_id;
END;

CREATE TRIGGER UpdateValorCompra
AFTER INSERT ON Item_Compra
FOR EACH ROW
BEGIN
    UPDATE Compra
    SET comp_valor_total = (SELECT SUM(itemc_qtd * itemc_preco_unit) FROM Item_Compra WHERE comp_id = NEW.comp_id)
    WHERE comp_id = NEW.comp_id;
END;