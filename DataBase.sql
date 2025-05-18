CREATE TABLE Categoria_Produto(
	catp_id 	INTEGER 		PRIMARY KEY AUTOINCREMENT,
	catp_nome 	VARCHAR(30)		NOT NULL
);

CREATE TABLE Fornecedor(
	forn_id 		INTEGER			PRIMARY KEY AUTOINCREMENT,
	forn_nome 		VARCHAR(30)		NOT NULL,
	forn_cnpj 		VARCHAR(14)		NOT NULL,
	forn_telefone	VARCHAR(11)		NOT NULL
);

CREATE TABLE Cliente(
	cli_id 			INTEGER			PRIMARY KEY AUTOINCREMENT,
	cli_nome 		VARCHAR(30)		NOT NULL,
	cli_cpf 		VARCHAR(11)		NOT NULL,
	cli_telefone	VARCHAR(11)		NOT NULL
);

CREATE TABLE Funcionario(
    func_id 				INTEGER			PRIMARY KEY AUTOINCREMENT,
    func_nome				VARCHAR(30)		NOT NULL,
    func_cargo				VARCHAR(20)		NOT NULL,
    func_salario			DECIMAL(9,2) 	NOT NULL,
    func_data_admissao		DATE 			NOT NULL
);

CREATE TABLE Setor(
	setor_id 	INTEGER 		PRIMARY KEY AUTOINCREMENT,
	setor_nome 	VARCHAR(30)		NOT NULL
);

-- 1:N

CREATE TABLE Produto(
	prod_id 			INTEGER			PRIMARY KEY AUTOINCREMENT,
	prod_nome 			VARCHAR(30)		NOT NULL,
	prod_preco 			DECIMAL(4,2)	NOT NULL,
	prod_qtd_estoque 	INT				NOT NULL,
	catp_id 			INTEGER			NOT NULL,
	FOREIGN KEY (catp_id) REFERENCES Categoria_Produto(catp_id)
);

CREATE TABLE Endereco_Cliente(
    endc_id 			INTEGER			PRIMARY KEY AUTOINCREMENT,
    endc_rua			VARCHAR(30)		NOT NULL,
    endc_numero			INT 			NOT NULL,
    endc_bairro			VARCHAR(30)		NOT NULL,
    endc_cidade			VARCHAR(30)		NOT NULL,
    endc_estado			VARCHAR(2)		NOT NULL,
    cli_id				INTEGER			NOT NULL,
	FOREIGN KEY (cli_id) REFERENCES Cliente(cli_id)
);

CREATE TABLE Venda(
    venda_id				INTEGER			PRIMARY KEY AUTOINCREMENT,
    venda_data				DATE			NOT NULL,
    venda_valor_total		DECIMAL(5,2) 	NOT NULL,
    cli_id					INTEGER			NOT NULL,
    func_id					INTEGER			NOT NULL,
	FOREIGN KEY (cli_id) REFERENCES Cliente(cli_id),
	FOREIGN KEY (func_id) REFERENCES Funcionario(func_id)
);

CREATE TABLE Item_Venda(
    itemv_id 			INTEGER			PRIMARY KEY AUTOINCREMENT,
    itemv_qtd			INT 			NOT NULL,
    itemv_preco_unit	DECIMAL(4,2)	NOT NULL,
    venda_id			INTEGER			NOT NULL,
	prod_id				INTEGER			NOT NULL,
	FOREIGN KEY (venda_id) REFERENCES Venda(venda_id),
	FOREIGN KEY (prod_id) REFERENCES Produto(prod_id)
);

CREATE TABLE Compra(
    comp_id 			INTEGER			PRIMARY KEY AUTOINCREMENT,
    comp_data			DATE 			NOT NULL,
    comp_valor_total	DECIMAL(10,2)	NOT NULL,
    forn_id				INTEGER			NOT NULL,
    func_id				INTEGER			NOT NULL,
	FOREIGN KEY (forn_id) REFERENCES Fornecedor(forn_id),
	FOREIGN KEY (func_id) REFERENCES Funcionario(func_id)
);

CREATE TABLE Item_Compra(
    itemc_id 			INTEGER			PRIMARY KEY AUTOINCREMENT,
    itemc_qtd			INT				NOT NULL,
    itemc_preco_unit    DECIMAL(10,2)	NOT NULL,
    comp_id				INTEGER			NOT NULL,
    prod_id				INTEGER			NOT NULL,
	FOREIGN KEY (comp_id) REFERENCES Compra(comp_id),
	FOREIGN KEY (prod_id) REFERENCES Produto(prod_id)
);

CREATE TABLE Pagamento( 
    pag_id 			INTEGER			PRIMARY KEY AUTOINCREMENT,
    pag_metodo		VARCHAR(30)		NOT NULL,
    pag_valor		DECIMAL(5,2)	NOT NULL,
    pag_data		DATE			NOT NULL,
    venda_id		INTEGER			NOT NULL,
	FOREIGN KEY (venda_id) REFERENCES Venda(venda_id)
);

CREATE TABLE Promocao( 
    promo_id 			INTEGER		PRIMARY KEY AUTOINCREMENT,
    promo_percentual	INT			NOT NULL,
    promo_inicio		DATE		NOT NULL,
    promo_fim			DATE 		NOT NULL,
    prod_id				INTEGER 	NOT NULL,
	FOREIGN KEY (prod_id) REFERENCES Produto(prod_id)
);

-- N:M ou 1*:1*

CREATE TABLE Produto_Fornecedor(
	prod_id 	INTEGER,
	forn_id 	INTEGER,
	PRIMARY KEY(prod_id, forn_id),
	FOREIGN KEY (prod_id) REFERENCES Produto(prod_id),
	FOREIGN KEY (forn_id) REFERENCES Fornecedor(forn_id)
);

CREATE TABLE Funcionario_Setor(
	func_id 			INTEGER,
	setor_id 			INTEGER,
	fs_data_inicio 		DATE		NOT NULL,
	fs_data_fim			DATE		NOT NULL,
	PRIMARY KEY(func_id, setor_id),
	FOREIGN KEY (func_id) REFERENCES Funcionario(func_id),
	FOREIGN KEY (setor_id) REFERENCES Setor(setor_id)
);