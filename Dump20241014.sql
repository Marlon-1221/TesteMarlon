CREATE DATABASE  IF NOT EXISTS `marlon` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `marlon`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: marlon
-- ------------------------------------------------------
-- Server version	8.0.39

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
  `CodCli` int NOT NULL AUTO_INCREMENT,
  `DesCli` varchar(100) NOT NULL,
  `CodCid` varchar(100) DEFAULT NULL,
  `DsUf` char(2) DEFAULT NULL,
  PRIMARY KEY (`CodCli`),
  KEY `DesCli` (`DesCli`),
  KEY `CodCid` (`CodCid`),
  KEY `DsUf` (`DsUf`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Maria Silva','São Paulo','SP'),(2,'João Pereira','Rio de Janeiro','RJ'),(3,'Ana Souza','Belo Horizonte','MG'),(4,'Carlos Oliveira','Porto Alegre','RS'),(5,'Fernanda Costa','Curitiba','PR'),(6,'Lucas Lima','Salvador','BA'),(7,'Bruno Santos','Fortaleza','CE'),(8,'Juliana Ferreira','Recife','PE'),(9,'Paulo Alves','Brasília','DF'),(10,'Amanda Rocha','Goiânia','GO'),(11,'Gabriel Martins','Florianópolis','SC'),(12,'Rafaela Nascimento','Manaus','AM'),(13,'Marcos Teixeira','Belém','PA'),(14,'Camila Ribeiro','Vitória','ES'),(15,'Rodrigo Batista','São Luís','MA'),(16,'Isabela Melo','Maceió','AL'),(17,'Pedro Araújo','Natal','RN'),(18,'Larissa Dias','Aracaju','SE'),(19,'Felipe Barbosa','Campo Grande','MS'),(20,'Julio Castro','Cuiabá','MT');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itempedido`
--

DROP TABLE IF EXISTS `itempedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itempedido` (
  `CdItem` int NOT NULL,
  `CodPed` int NOT NULL,
  `CodPro` int NOT NULL,
  `VlrPro` decimal(10,2) NOT NULL,
  `VlrUni` decimal(10,2) NOT NULL,
  `QtdPed` decimal(10,2) NOT NULL,
  PRIMARY KEY (`CodPed`,`CdItem`),
  CONSTRAINT `itempedido_ibfk_1` FOREIGN KEY (`CodPed`) REFERENCES `pedidos` (`CodPed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itempedido`
--

LOCK TABLES `itempedido` WRITE;
/*!40000 ALTER TABLE `itempedido` DISABLE KEYS */;
INSERT INTO `itempedido` VALUES (1,3,10,1799.00,1799.00,1.00),(1,4,10,1799.00,1799.00,1.00),(1,5,11,79.90,7.99,10.00);
/*!40000 ALTER TABLE `itempedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `CodPed` int NOT NULL AUTO_INCREMENT,
  `CodCli` int NOT NULL,
  `VlrTot` decimal(10,2) DEFAULT NULL,
  `DtEmi` date NOT NULL,
  PRIMARY KEY (`CodPed`),
  KEY `CodCli` (`CodCli`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`CodCli`) REFERENCES `clientes` (`CodCli`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,15,NULL,'2024-10-14'),(2,17,NULL,'2024-10-14'),(3,15,NULL,'2024-10-14'),(4,15,1799.00,'2024-10-14'),(5,18,79.90,'2024-10-14');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `CodPro` int NOT NULL AUTO_INCREMENT,
  `DesPro` varchar(255) NOT NULL,
  `PreVen` decimal(10,2) NOT NULL,
  PRIMARY KEY (`CodPro`),
  KEY `DesPro` (`DesPro`),
  KEY `PreVen` (`PreVen`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'Apple iPhone 14 Pro Max',1099.00),(2,'Samsung Galaxy S23 Ultra',999.00),(3,'Notebook Dell XPS 13',1299.00),(4,'Smart TV LG OLED 55\"',1399.00),(5,'Câmera GoPro HERO10',499.99),(6,'PlayStation 5',499.00),(7,'Xbox Series X',499.00),(8,'Fone de Ouvido Bluetooth Sony WH-1000XM5',349.00),(9,'Monitor Gamer Samsung Odyssey G7',699.00),(10,'Notebook Lenovo ThinkPad X1 Carbon',1799.00),(11,'Detergente Líquido OMO Lavagem Perfeita 3L',7.99),(12,'Sabonete Líquido Dove 250ml',3.50),(13,'Shampoo Pantene 400ml',5.50),(14,'Café em Pó Pilão Tradicional 500g',4.99),(15,'Água Mineral Bonafont 1,5L',1.00),(16,'Arroz Tio João Tipo 1 5kg',12.50),(17,'Leite Longa Vida Parmalat Integral 1L',1.99),(18,'Refrigerante Coca-Cola 2L',2.99),(19,'Creme Dental Colgate Total 90g',2.50),(20,'Chocolate Nestlé KitKat 45g',1.25);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-14 21:51:54
