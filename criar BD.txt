Alguns conceitos usados no projeto:

Padrão de Projeto DAO (Data Access Object) para separação das regras de negócio das regras de acesso a banco de dados.
Classes: TClienteDAO, TProdutoDAO, TPedidosDeVendaDAO.

Model do MVC
Classes: TClienteModel, TProdutoModel, TPedidosDeVendaModel, TItemPedidoModel.

Acesso ao BD: usuário=root senha=root


-- wk.cliente definition

CREATE TABLE `cliente` (
  `codigo_cliente` int unsigned NOT NULL AUTO_INCREMENT,
  `nome_cliente` varchar(100) NOT NULL,
  `uf_cliente` varchar(2) DEFAULT NULL,
  `cidade_cliente` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`codigo_cliente`),
  KEY `cliente_nome_cliente_IDX` (`nome_cliente`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=latin1 COMMENT='Tabela de cadastro de clientes';


-- wk.produto definition

CREATE TABLE `produto` (
  `codigo_produto` int unsigned NOT NULL AUTO_INCREMENT,
  `descricao_produto` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `preco_venda_produto` double DEFAULT '0',
  PRIMARY KEY (`codigo_produto`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=latin1;


-- wk.pedido definition

CREATE TABLE `pedido` (
  `numero_pedido` int unsigned NOT NULL AUTO_INCREMENT,
  `data_emissao` datetime NOT NULL,
  `codigo_cliente` int unsigned NOT NULL,
  `valor_total` float DEFAULT '0',
  PRIMARY KEY (`numero_pedido`),
  KEY `pedido_FK` (`codigo_cliente`),
  CONSTRAINT `pedido_FK` FOREIGN KEY (`codigo_cliente`) REFERENCES `cliente` (`codigo_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=latin1;


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
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (1,'Elon Musk','SC','Florianópolis');
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (2,'Jeff Bezos','SC','Lages');
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (3,'Bernard Arnault',NULL,NULL);
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (4,'Bill Gates',NULL,NULL);
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (5,'Warren Buffett',NULL,NULL);
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (6,'Larry Page',NULL,NULL);
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (7,'Sergey Brin',NULL,NULL);
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (8,'Larry Ellison',NULL,NULL);
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (9,'Steve Ballmer',NULL,NULL);
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (10,'Mukesh Ambani',NULL,NULL);
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (11,'Jorge Paulo Lemann',NULL,NULL);
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (12,'Eduardo Saverin',NULL,NULL);
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (13,'Marcel Herrmann Telles',NULL,NULL);
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (14,'Jorge Moll Filho',NULL,NULL);
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (15,'Lucia Maggi',NULL,NULL);
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (16,'Andre Esteves',NULL,NULL);
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (17,'Alexandre Behring',NULL,NULL);
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (18,'Luciano Hang',NULL,NULL);
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (19,'Claudio Ulisses Nunes Biava',NULL,NULL);
INSERT INTO wk.cliente (codigo_cliente,nome_cliente,uf_cliente,cidade_cliente) VALUES (20,'Maria',NULL,NULL);


INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (1,'Produto 1',10.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (2,'Produto 2',20.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (3,'Produto 3',30.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (4,'Produto 4',40.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (5,'Produto 5',50.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (6,'Produto 6',60.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (7,'Produto 7',70.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (8,'Produto 8',80.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (9,'Produto 9',90.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (10,'Produto 10',100.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (11,'Produto 11',110.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (12,'Produto 12',120.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (13,'Produto 13',130.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (14,'Produto 14',140.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (15,'Produto 15',150.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (16,'Produto 16',160.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (17,'Produto 17',170.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (18,'Produto 18',180.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (19,'Produto 19',190.0);
INSERT INTO wk.produto (codigo_produto,descricao_produto,preco_venda_produto) VALUES (20,'Produto 20',200.0);
