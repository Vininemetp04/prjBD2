# Projeto Banco de Dados 2

## Mercado
Nosso grupo ira desenvolver um Banco de Dados para um supermercado

## Tabelas e seus campos

- <details>
	<summary>Categoria_Produto</summary>
	- catp_id
	- catp_nome
	</details>

- Produto: 
	- prod_id
	- prod_nome	
	- prod_preco 
	- prod_qtd_estoque
	- catp_catp_id 

- Fornecedor: 
	- forn_id 
	- forn_nome 
	- forn_cnpj 
	- forn_telefone

- Produto_Fornecedor: 
	- pf_prod_id 
	- pf_forn_id 

- Cliente: 
	- cli_id 
	- cli_nome 
	- cli_cpf 
	- cli_telefone 

- Funcionario: 
	- func_id 
	- func_nome 
	- func_cargo 
	- func_salario 
	- func_data_admissao 

- Endereco_Cliente: 
	- endc_id 
	- endc_rua 
	- endc_numero 
	- endc_bairro 
	- endc_cidade 
	- endc_estado 
	- endc_cli_id 

- Venda: 
	- venda_id 
	- venda_data 
	- venda_valor_total 
	- venda_cli_id 
	- venda_func_id 
	
- Item_Venda: 
	- itemv_id
	- itemv_qtd
	- itemv_preco_unit
	- itemv_venda_id
	- itemv_prod_id 

- Compra: 
	- comp_id
	- comp_data
	- comp_valor_total
	- comp_forn_id
	- comp_func_id 

- Item_Compra:
	- itemc_id
	- itemc_qtd
	- itemc_preco_unit
	- itemc_comp_id
	- itemc_prod_id 

- Setor:
	- setor_id
	- setor_nome 

- Funcionario_Setor:
	- fs_func_id
	- fs_setor_id
	- fs_data_inicio
	- fs_data_fim 

- Pagamento:
	- pag_id
	- pag_metodo
	- pag_valor
	- pag_data
	- pag_venda_id 

- Promocao:
	- promo_id
	- promo_percentual
	- promo_inicio
	- promo_fim
	- promo_prod_id 

## Views

## Triggers

## Procedures
