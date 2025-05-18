# Projeto Banco de Dados 2

## Mercado
Nosso grupo ira desenvolver um Banco de Dados para um supermercado

## Tabelas e seus campos
<details>
	<details>
		<summary>Categoria_Produto</summary>
		- catp_id
		- catp_nome
	</details>
	<details>
		<summary>Produto</summary> 
		- prod_id
		- prod_nome	
		- prod_preco 
		- prod_qtd_estoque
		- catp_catp_id 
	</details>
	<details>
		<summary>Fornecedor</summary> 
		- forn_id 
		- forn_nome 
		- forn_cnpj 
		- forn_telefone
	</details>
	<details>
		<summary>Produto_Fornecedor</summary> 
		- pf_prod_id 
		- pf_forn_id 
	</details>
	<details>
		<summary>Cliente</summary> 
		- cli_id 
		- cli_nome 
		- cli_cpf 
		- cli_telefone 
	</details>
	<details>
		<summary>Funcionario</summary> 
		- func_id 
		- func_nome 
		- func_cargo 
		- func_salario 
		- func_data_admissao 
	</details>
	<details>
		<summary>Endereco_Cliente</summary> 
		- endc_id 
		- endc_rua 
		- endc_numero 
		- endc_bairro 
		- endc_cidade 
		- endc_estado 
		- endc_cli_id 
	</details>
	<details>
		<summary>Venda</summary> 
		- venda_id 
		- venda_data 
		- venda_valor_total 
		- venda_cli_id 
		- venda_func_id 
	</details>
	<details>
		<summary>Item_Venda</summary> 
		- itemv_id
		- itemv_qtd
		- itemv_preco_unit
		- itemv_venda_id
		- itemv_prod_id 
	</details>
	<details>
		<summary>Compra</summary> 
		- comp_id
		- comp_data
		- comp_valor_total
		- comp_forn_id
		- comp_func_id 
	</details>
	<details>
		<summary>Item_Compra</summary> 
		- itemc_id
		- itemc_qtd
		- itemc_preco_unit
		- itemc_comp_id
		- itemc_prod_id 
	</details>
	<details>
		<summary>Setor</summary> 
		- setor_id
		- setor_nome 
	</details>
	<details>
		<summary>Funcionario_Setor</summary> 
		- fs_func_id
		- fs_setor_id
		- fs_data_inicio
		- fs_data_fim 
	</details>
	<details>
		<summary>Pagamento</summary> 
		- pag_id
		- pag_metodo
		- pag_valor
		- pag_data
		- pag_venda_id 
	</details>
	<details>
		<summary>Promocao</summary> 
		- promo_id
		- promo_percentual
		- promo_inicio
		- promo_fim
		- promo_prod_id 
	</details>
</details>

## Views

## Triggers

## Procedures
