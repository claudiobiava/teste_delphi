Alguns conceitos usados no projeto:

Padrão de Projeto DAO (Data Access Object) para separação das regras de negócio das regras de acesso a banco de dados.
Classes: TClienteDAO, TProdutoDAO, TPedidosDeVendaDAO.

Model do MVC
Classes: TClienteModel, TProdutoModel, TPedidosDeVendaModel, TItemPedidoModel.

Acesso ao BD: usuário=root senha=root


Criar o BD:

-- wk.cliente definition

CREATE TABLE `cliente` (
  `codigo_cliente` int unsigned NOT NULL AUTO_INCREMENT,
  `nome_cliente` varchar(100) NOT NULL,
  `uf_cliente` varchar(2) DEFAULT NULL,
  `cidade_cliente` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`codigo_cliente`),
  KEY `cliente_nome_cliente_IDX` (`nome_cliente`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 COMMENT='Tabela de cadastro de clientes';


-- wk.produto definition

CREATE TABLE `produto` (
  `codigo_produto` int unsigned NOT NULL AUTO_INCREMENT,
  `descricao_produto` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `preco_venda_produto` double DEFAULT '0',
  PRIMARY KEY (`codigo_produto`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;


-- wk.pedido definition

CREATE TABLE `pedido` (
  `numero_pedido` int unsigned NOT NULL AUTO_INCREMENT,
  `data_emissao` datetime NOT NULL,
  `codigo_cliente` int unsigned NOT NULL,
  `valor_total` float DEFAULT '0',
  PRIMARY KEY (`numero_pedido`),
  KEY `pedido_FK` (`codigo_cliente`),
  CONSTRAINT `pedido_FK` FOREIGN KEY (`codigo_cliente`) REFERENCES `cliente` (`codigo_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;


-- wk.pedido_item definition

CREATE TABLE `pedido_item` (
  `numero_pedido_item` int unsigned NOT NULL AUTO_INCREMENT,
  `numero_pedido` int unsigned NOT NULL,
  `codigo_produto` int unsigned NOT NULL,
  `quantidade` int unsigned DEFAULT '0',
  `valor_unitario` float DEFAULT '0',
  `valor_total` float DEFAULT '0',
  PRIMARY KEY (`numero_pedido_item`,`numero_pedido`),
  KEY `pedido_item_FK` (`codigo_produto`),
  KEY `pedido_item_numero_pedido_IDX` (`numero_pedido`) USING BTREE,
  CONSTRAINT `pedido_item_FK` FOREIGN KEY (`codigo_produto`) REFERENCES `produto` (`codigo_produto`),
  CONSTRAINT `pedido_item_FK_1` FOREIGN KEY (`numero_pedido`) REFERENCES `pedido` (`numero_pedido`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Elon Musk','SC','Florianópolis');
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Jeff Bezos','SC','Lages');
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Bernard Arnault',NULL,NULL);
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Bill Gates',NULL,NULL);
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Warren Buffett',NULL,NULL);
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Larry Page',NULL,NULL);
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Sergey Brin',NULL,NULL);
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Larry Ellison',NULL,NULL);
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Steve Ballmer',NULL,NULL);
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Mukesh Ambani',NULL,NULL);
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Jorge Paulo Lemann',NULL,NULL);
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Eduardo Saverin',NULL,NULL);
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Marcel Herrmann Telles',NULL,NULL);
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Jorge Moll Filho',NULL,NULL);
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Lucia Maggi',NULL,NULL);
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Andre Esteves',NULL,NULL);
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Alexandre Behring',NULL,NULL);
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Luciano Hang',NULL,NULL);
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Claudio Ulisses Nunes Biava',NULL,NULL);
INSERT INTO wk.cliente (nome_cliente,uf_cliente,cidade_cliente) VALUES ('Maria',NULL,NULL);

INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 1',10.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 2',20.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 3',30.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 4',40.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 5',50.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 6',60.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 7',70.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 8',80.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 9',90.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 10',100.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 11',110.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 12',120.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 13',130.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 14',140.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 15',150.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 16',160.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 17',170.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 18',180.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 19',190.0);
INSERT INTO wk.produto (descricao_produto,preco_venda_produto) VALUES ('Produto 20',200.0);
