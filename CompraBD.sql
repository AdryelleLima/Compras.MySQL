-- create database dbcompra;

create table CLIENTE(
cliente_id int not null auto_increment primary key,
nome varchar(100) not null,
email varchar(150) not null,
cpf char(11) not null,
data_cadastro datetime not null,
constraint UQ_CLIENTE_EMAIL unique(email),
constraint UQ_CLIENTE_CPF unique(cpf)
);

create table PEDIDO(
pedido_id int not null auto_increment primary key,
cliente_id int not null,
data_pedido datetime not null,
status varchar(20) not null,
valor_total decimal(10,2) not null,
index IDX_PEDIDO_CLIENTE (cliente_id),
constraint FK_CLIENTE foreign key (cliente_id)
references CLIENTE(cliente_id),
constraint UQ_PEDIDO_NUMERO unique(cliente_id, data_pedido, status) 
);

create table PAGAMENTO(
pagamento_id int not null auto_increment primary key,
pedido_id int not null,
data_pagamento datetime not null ,
valor decimal(10,2) not null,
forma_pagamento varchar(30) not null,
status_pagamento ENUM('pago','aberto', 'cancelado') not null,
transacao_id varchar(100) null,
index IDX_PAGAMENTO_PEDIDO(pedido_id),
constraint UQ_PAGAMENTO_TRANSACAO unique (transacao_id),
constraint FK_PEDIDO foreign key(pedido_id)
references PEDIDO(pedido_id)
);

create table PRODUTO(
produto_id int not null auto_increment primary key,
codigo varchar(50) not null,
nome varchar(100) not null,
categoria varchar(50) not null,
preco decimal(10,2) not null,
ativo tinyint not null default 1,
constraint UQ_PRODUTO_CODIGO unique (codigo),
constraint UQ_PRODUTO_NOME_CATEGORIA unique (nome, categoria)
);

create table ITEM_PEDIDO(
pedido_id int not null,
produto_id int not null,
item_produto_id int not null auto_increment primary key,
quantidade int not null,
preco_unitario decimal(10,2) not null,
desconto decimal(10,2) not null default 0.00,
index IDX_ITEM_PEDIDO_PRODUTO (produto_id),
constraint UQ_ITEM_PEDIDO unique (pedido_id, produto_id),
constraint FK_PEDIDO_ITEM foreign key(pedido_id)
references PEDIDO(pedido_id),
constraint FK_PRODUTO foreign key(produto_id)
references PRODUTO(produto_id)
);