-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: computer_hw_inventory
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('Braun-Mohr','Šimanovci',4232552566,1195533592,0),('Brown LLC','Tieremu',2859305420,694959198,0),('Glover-Denesik','Houzhai',2897512166,94555191,0),('Heaney Inc','Vejprnice',1283988532,2811231287,0),('Homenick LLC','Hepang',1948186811,447208895,0),('Lubowitz Group','San Mateo',3942390516,2691207885,0),('Luettgen Group','Walce',3589865562,1342152588,0),('Mante, Kirlin and Carroll','Villa Mercedes',2569967228,810353606,0),('O\'Reilly Inc','Baisha',3399546270,861465229,0),('Orn Inc','Shūsh',2953403148,858087124,1);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `customerfees`
--

LOCK TABLES `customerfees` WRITE;
/*!40000 ALTER TABLE `customerfees` DISABLE KEYS */;
INSERT INTO `customerfees` VALUES ('Braun-Mohr',147058.00,174141.00),('Brown LLC',165935.00,165935.00),('Heaney Inc',5726.00,174141.00),('Orn Inc',56998.00,18374.00);
/*!40000 ALTER TABLE `customerfees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'repairman','Celestyn','Spurier',45649.65),(13,'repairman','Jeremiah','Minchinton',19913.12),(16,'repairman','Kayne','Kulas',30273.39),(17,'staff','Rica','Eccleston',21756.12),(27,'staff','Fayette','Tranfield',18818.58),(32,'manager','Ali','Spalton',93622.69),(33,'repairman','Xenos','Nolan',52460.19),(34,'manager','Chandra','Cattle',80424.42),(37,'staff','Lion','Wickett',826.52),(41,'manager','Hedwiga','Samms',70100.22),(49,'repairman','Flint','Kinsley',33503.64),(50,'manager','Cecily','Filov',62375.16),(54,'staff','Welsh','Prendergrass',8039.65),(59,'repairman','Cobb','Matt',54217.54),(60,'repairman','Kirbee','le Keux',45185.76),(64,'manager','Renault','Plackstone',88306.16),(72,'repairman','Danny','Tolworthy',32329.08),(74,'staff','Guthrey','Clarson',26384.30),(84,'staff','Marcia','Verdie',15529.21),(90,'repairman','Brennen','Allington',44794.22);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `fees_fines`
--

LOCK TABLES `fees_fines` WRITE;
/*!40000 ALTER TABLE `fees_fines` DISABLE KEYS */;
INSERT INTO `fees_fines` VALUES (1,26577.00,120481.00),(2,5726.00,0.00),(3,10063.00,158575.00),(4,0.00,38624.00),(5,12893.00,0.00),(7,5268.00,213.00);
/*!40000 ALTER TABLE `fees_fines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `hardware`
--

LOCK TABLES `hardware` WRITE;
/*!40000 ALTER TABLE `hardware` DISABLE KEYS */;
INSERT INTO `hardware` VALUES (3,'laptop',0,1973.34,0,1,2),(4,'router',2,9224.63,0,1,2),(5,'printer',1,4965.77,0,1,2),(6,'phone',2,1634.06,0,1,2),(8,'router',0,2656.60,0,1,2),(9,'printer',0,2557.66,1,2,1),(10,'phone',1,7145.07,1,2,1),(11,'laptop',0,3539.27,1,2,1),(12,'router',0,959.58,1,2,1),(13,'printer',0,7606.18,1,2,3),(14,'phone',3,1302.48,1,2,3),(15,'laptop',0,8462.40,1,2,3),(16,'router',2,1879.92,1,3,3),(17,'printer',1,6654.45,1,3,3),(18,'phone',1,3906.47,1,3,1),(19,'laptop',3,1701.93,1,3,1),(20,'router',0,4686.20,1,3,2),(21,'printer',0,6538.14,1,3,2),(22,'phone',2,3239.00,0,1,NULL),(23,'laptop',2,9545.27,1,1,NULL),(24,'router',0,2309.85,1,4,NULL),(25,'printer',0,9135.52,1,4,NULL),(26,'phone',2,3406.52,1,5,NULL),(27,'laptop',3,6157.44,1,5,NULL),(28,'router',3,3412.28,1,7,NULL),(29,'printer',0,1800.68,1,2,NULL),(30,'phone',0,2734.17,1,NULL,NULL),(31,'laptop',0,5743.28,1,NULL,NULL),(32,'router',0,9345.66,1,NULL,NULL),(33,'printer',0,5797.85,1,NULL,NULL),(34,'phone',0,4405.35,1,NULL,NULL),(35,'laptop',0,3329.45,1,NULL,NULL),(36,'router',0,2027.01,1,NULL,NULL),(37,'printer',0,433.86,1,NULL,NULL),(38,'phone',0,1170.26,1,NULL,NULL),(39,'laptop',0,6460.36,1,NULL,NULL),(40,'router',0,4295.68,1,NULL,NULL),(41,'printer',0,6874.61,1,NULL,NULL),(42,'phone',0,9075.51,1,NULL,NULL),(43,'laptop',0,6836.91,1,NULL,NULL),(44,'router',0,2875.20,1,NULL,NULL),(45,'printer',0,3081.16,1,NULL,NULL),(46,'phone',0,1470.89,1,NULL,NULL),(47,'laptop',0,6150.38,1,NULL,NULL),(48,'router',0,7147.99,1,NULL,NULL),(49,'printer',0,7005.83,1,NULL,NULL),(50,'phone',0,4142.63,1,NULL,NULL),(51,'laptop',0,3791.87,1,NULL,NULL),(52,'router',0,130.25,1,NULL,NULL),(53,'printer',0,2939.47,1,NULL,NULL),(54,'phone',0,3540.19,1,NULL,NULL),(55,'laptop',0,5829.48,1,NULL,NULL),(56,'router',0,3497.41,1,NULL,NULL),(57,'printer',0,5699.61,1,NULL,NULL),(58,'phone',0,9341.28,1,NULL,NULL),(59,'laptop',0,5457.67,1,NULL,NULL),(60,'router',0,8850.36,1,NULL,NULL),(61,'printer',0,8031.69,1,NULL,NULL),(62,'phone',0,4932.81,1,NULL,NULL),(63,'laptop',0,2954.17,1,NULL,NULL),(64,'router',0,7054.90,1,NULL,NULL),(65,'printer',0,3446.15,1,NULL,NULL),(66,'phone',0,3653.63,1,NULL,NULL),(67,'laptop',0,7296.92,1,NULL,NULL),(68,'router',0,585.30,1,NULL,NULL),(69,'printer',0,3156.18,1,NULL,NULL),(70,'phone',0,9506.58,1,NULL,NULL),(71,'laptop',0,8402.84,1,NULL,NULL),(72,'router',0,4793.18,1,NULL,NULL),(73,'printer',0,7359.52,1,NULL,NULL),(74,'phone',0,7463.27,1,NULL,NULL),(75,'laptop',0,130.78,1,NULL,NULL),(76,'router',0,8837.10,1,NULL,NULL),(77,'printer',0,508.12,1,NULL,NULL),(78,'phone',0,245.00,1,NULL,NULL),(79,'laptop',0,4174.37,1,NULL,NULL),(80,'router',0,1459.04,1,NULL,NULL),(81,'printer',0,4752.37,1,NULL,NULL),(82,'phone',0,6002.23,1,NULL,NULL),(83,'laptop',0,3028.49,1,NULL,NULL),(84,'router',0,7743.99,1,NULL,NULL),(85,'printer',0,4556.34,1,NULL,NULL),(86,'phone',0,9390.51,1,NULL,NULL),(87,'laptop',0,8928.54,1,NULL,NULL),(88,'router',0,1823.50,1,NULL,NULL),(89,'printer',0,9901.30,1,NULL,NULL),(90,'phone',0,5501.66,1,NULL,NULL),(91,'laptop',0,3520.40,1,NULL,NULL),(92,'router',0,7219.68,1,NULL,NULL),(93,'printer',0,2739.60,1,NULL,NULL),(94,'phone',0,7067.77,1,NULL,NULL),(95,'laptop',0,6743.41,1,NULL,NULL),(96,'router',0,9226.05,1,NULL,NULL),(97,'printer',0,4455.62,1,NULL,NULL),(98,'phone',0,9604.96,1,NULL,NULL),(99,'laptop',0,7194.30,1,NULL,NULL),(100,'router',0,7368.68,1,NULL,NULL),(101,'printer',0,2544.61,1,NULL,NULL),(102,'phone',0,419.92,1,NULL,NULL),(103,'router',0,500.00,1,NULL,NULL),(104,'router',0,505.00,1,NULL,NULL),(105,'laptop',0,501.00,1,2,NULL);
/*!40000 ALTER TABLE `hardware` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,19810.00,6,20170416,74,2),(2,31679.00,7,20170322,27,2),(3,25905.00,5,20170333,27,3);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `repairservices`
--

LOCK TABLES `repairservices` WRITE;
/*!40000 ALTER TABLE `repairservices` DISABLE KEYS */;
INSERT INTO `repairservices` VALUES (1,26127.00,5,'Braun-Mohr',1,13),(2,5526.00,2,'Heaney Inc',2,49);
/*!40000 ALTER TABLE `repairservices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'Dare, Bailey and Hyatt','Kalahang',4069534833,4),(2,'Kassulke, Schowalter and West','Lupak',8071314911,3),(3,'MacGyver, Nienow and Thiel','Bābol',8627048480,2),(4,'Bogisich, Ernser and Morissette','Kousséri',4863963860,3),(5,'Bogan, Hansen and Olson','Idalolong',300847631,4),(6,'Brakus, Murray and Conn','Emnambithi-Ladysmith',2167937779,2),(7,'Wilkinson, Lubowitz and Marquardt','Bamenda',2284322158,1),(8,'McKenzie and Sons','Rawa',5460566677,1),(9,'Schowalter, O\'Kon and Stiedemann','Jianba',4902066972,5),(10,'Dickens, Renner and Hyatt','Espanola',8732597160,5);
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,20170423,20170522,20170524,240961.00,'Braun-Mohr',17),(2,20170424,20170524,20170524,254070.00,'Heaney Inc',37),(3,20170425,20170525,20170526,634300.00,'Brown LLC',54),(4,20170416,20170609,20170610,154494.00,'Orn Inc',13),(5,20170506,20170507,20170507,2391.00,'Orn Inc',54),(7,20170506,20170507,20170508,853.00,'Orn Inc',54);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `unit_price`
--

LOCK TABLES `unit_price` WRITE;
/*!40000 ALTER TABLE `unit_price` DISABLE KEYS */;
INSERT INTO `unit_price` (`itemPrice`) VALUES (2.00),(130.25),(130.78),(245.00),(350.00),(419.92),(433.86),(500.00),(501.00),(505.00),(508.12),(585.30),(959.58),(1093.88),(1170.26),(1302.48),(1459.04),(1470.89),(1634.06),(1701.93),(1800.68),(1823.50),(1879.92),(1973.34),(2027.01),(2309.85),(2544.61),(2557.66),(2656.60),(2734.17),(2739.60),(2875.20),(2939.47),(2954.17),(3028.49),(3081.16),(3156.18),(3239.00),(3329.45),(3406.52),(3412.28),(3446.15),(3497.41),(3520.40),(3539.27),(3540.19),(3653.63),(3791.87),(3906.47),(4142.63),(4174.37),(4295.68),(4405.35),(4455.62),(4556.34),(4686.20),(4752.37),(4793.18),(4932.81),(4965.77),(5457.67),(5501.66),(5699.61),(5743.28),(5797.85),(5829.48),(6002.23),(6150.38),(6157.44),(6460.36),(6538.14),(6654.45),(6743.41),(6836.91),(6874.61),(7005.83),(7054.90),(7067.77),(7145.07),(7147.99),(7194.30),(7219.68),(7296.92),(7359.52),(7368.68),(7463.27),(7606.18),(7743.99),(8031.69),(8402.84),(8462.40),(8837.10),(8850.36),(8928.54),(9075.51),(9135.52),(9224.63),(9226.05),(9341.28),(9345.66),(9390.51),(9506.58),(9545.27),(9604.96),(9901.30);
/*!40000 ALTER TABLE `unit_price` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-08 21:20:03
