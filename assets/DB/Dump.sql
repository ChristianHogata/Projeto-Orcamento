-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: projetowk
-- ------------------------------------------------------
-- Server version	5.7.29-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Ana Silva'),(2,'Bruno Oliveira'),(3,'Carlos Souza'),(4,'Daniela Pereira'),(5,'Eduardo Lima'),(6,'Fernanda Costa'),(7,'Gabriel Almeida'),(8,'Helena Martins'),(9,'Igor Fernandes'),(10,'Juliana Rocha'),(11,'Kleber Santos'),(12,'Larissa Mendes'),(13,'Marcos Ribeiro'),(14,'Natália Carvalho'),(15,'Otávio Gomes'),(16,'Patrícia Araújo'),(17,'Rafael Barbosa'),(18,'Sabrina Ferreira'),(19,'Thiago Monteiro'),(20,'Vanessa Teixeira');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enderecos`
--

DROP TABLE IF EXISTS `enderecos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enderecos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `endereco` varchar(255) NOT NULL,
  `numero` varchar(11) DEFAULT NULL,
  `bairro` varchar(50) NOT NULL,
  `uf` varchar(2) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `cep` varchar(14) DEFAULT NULL,
  `referencia` varchar(255) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `enderecos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enderecos`
--

LOCK TABLES `enderecos` WRITE;
/*!40000 ALTER TABLE `enderecos` DISABLE KEYS */;
INSERT INTO `enderecos` VALUES (1,'Rua das Flores, 123','123','Centro','SP','São Paulo','01001-000','Próximo ao mercado',1),(2,'Avenida Paulista, 1000','1000','Bela Vista','SP','São Paulo','01310-100','Em frente ao parque',2),(3,'Rua XV de Novembro, 45','45','Centro','RJ','Rio de Janeiro','20010-000','Ao lado do banco',3),(4,'Avenida Atlântica, 500','500','Copacabana','RJ','Rio de Janeiro','22010-000','Perto da praia',4),(5,'Rua das Palmeiras, 200','200','Jardim','MG','Belo Horizonte','30110-000','Próximo ao shopping',5),(6,'Avenida Brasil, 1500','1500','Centro','RS','Porto Alegre','90010-000','Em frente ao hospital',6),(7,'Rua das Acácias, 300','300','Vila Nova','PR','Curitiba','80010-000','Perto da escola',7),(8,'Avenida Independência, 400','400','Centro','BA','Salvador','40010-000','Ao lado da praça',8),(9,'Rua das Laranjeiras, 250','250','Centro','PE','Recife','50010-000','Próximo ao museu',9),(10,'Avenida das Nações, 600','600','Centro','DF','Brasília','70010-000','Em frente ao teatro',10),(11,'Rua dos Pinheiros, 700','700','Centro','SC','Florianópolis','88010-000','Perto do parque',11),(12,'Avenida das Américas, 800','800','Centro','CE','Fortaleza','60010-000','Ao lado do estádio',12),(13,'Rua das Hortênsias, 900','900','Centro','GO','Goiânia','74010-000','Próximo ao aeroporto',13),(14,'Avenida das Palmeiras, 1000','1000','Centro','MT','Cuiabá','78010-000','Em frente ao hotel',14),(15,'Rua das Rosas, 1100','1100','Centro','MS','Campo Grande','79010-000','Perto da universidade',15),(16,'Avenida das Flores, 1200','1200','Centro','PA','Belém','66010-000','Ao lado do mercado',16),(17,'Rua das Margaridas, 1300','1300','Centro','AM','Manaus','69010-000','Próximo ao porto',17),(18,'Avenida das Orquídeas, 1400','1400','Centro','MA','São Luís','65010-000','Em frente ao shopping',18),(19,'Rua das Tulipas, 1500','1500','Centro','PB','João Pessoa','58010-000','Perto da rodoviária',19),(20,'Avenida das Violetas, 1600','1600','Centro','RN','Natal','59010-000','Ao lado do parque',20);
/*!40000 ALTER TABLE `enderecos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `valor_total` float DEFAULT NULL,
  `valor_pago` float DEFAULT NULL,
  `valor_troco` float DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `data_pedido` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`codigo`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (180,0,0,0,NULL,'2024-09-30 12:13:36'),(181,1999.99,2000,0.01,5,'2024-09-30 12:15:47');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos_itens`
--

DROP TABLE IF EXISTS `pedidos_itens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos_itens` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `id_produto` int(11) DEFAULT NULL,
  `id_pedido` int(11) DEFAULT NULL,
  `quantidade` float DEFAULT NULL,
  `valor_total_item` float DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `id_produto` (`id_produto`),
  KEY `id_pedido` (`id_pedido`),
  CONSTRAINT `pedidos_itens_ibfk_1` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`codigo`),
  CONSTRAINT `pedidos_itens_ibfk_2` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`codigo`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos_itens`
--

LOCK TABLES `pedidos_itens` WRITE;
/*!40000 ALTER TABLE `pedidos_itens` DISABLE KEYS */;
INSERT INTO `pedidos_itens` VALUES (97,4,180,1,1999.99),(98,4,181,1,1999.99);
/*!40000 ALTER TABLE `pedidos_itens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) DEFAULT NULL,
  `preco_venda` float DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `descricao` (`descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'Cadeira de Escritório',299.99),(2,'Mesa de Jantar',499.99),(3,'Sofá 3 Lugares',899.99),(4,'Geladeira Frost Free',1999.99),(5,'Fogão 4 Bocas',799.99),(6,'Micro-ondas',399.99),(7,'Máquina de Lavar',1499.99),(8,'Televisão 50 Polegadas',2499.99),(9,'Notebook',3499.99),(10,'Smartphone',1999.99),(11,'Ventilador de Mesa',149.99),(12,'Ar Condicionado',2299.99),(13,'Liquidificador',199.99),(14,'Cafeteira Elétrica',299.99),(15,'Aspirador de Pó',499.99),(16,'Ferro de Passar',129.99),(17,'Bicicleta',799.99),(18,'Cama Box Casal',999.99),(19,'Guarda-Roupa',1299.99),(20,'Estante para Livros',399.99);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'projetowk'
--

--
-- Dumping routines for database 'projetowk'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-30  9:31:41
