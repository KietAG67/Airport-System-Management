CREATE DATABASE  IF NOT EXISTS `ap` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ap`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: ap
-- ------------------------------------------------------
-- Server version	8.4.8

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
-- Table structure for table `aircraft`
--

DROP TABLE IF EXISTS `aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircraft` (
  `Aircraft_ID` varchar(50) NOT NULL,
  `Aircraft_Type` varchar(100) DEFAULT NULL,
  `Manufacture` varchar(100) DEFAULT NULL,
  `Capacity` int DEFAULT NULL,
  `Year_Made` year DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Aircraft_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft`
--

LOCK TABLES `aircraft` WRITE;
/*!40000 ALTER TABLE `aircraft` DISABLE KEYS */;
INSERT INTO `aircraft` VALUES ('AC001','Airbus A321','Airbus',220,2018,'Active'),('AC002','Airbus A321','Airbus',220,2019,'Active'),('AC003','Airbus A320','Airbus',180,2017,'Active'),('AC004','Airbus A320','Airbus',180,2020,'Active'),('AC005','Boeing 737-800','Boeing',189,2016,'Active'),('AC006','Boeing 737-800','Boeing',189,2018,'Active'),('AC007','Boeing 787-9','Boeing',296,2019,'Active'),('AC008','Boeing 787-9','Boeing',296,2021,'Active'),('AC009','Airbus A350-900','Airbus',305,2020,'Active'),('AC010','ATR 72-600','ATR',70,2017,'Active'),('AC011','Airbus A321','Airbus',220,2015,'Maintenance'),('AC012','Boeing 737-800','Boeing',189,2014,'Maintenance'),('AC013','Airbus A320','Airbus',180,2013,'Inactive'),('AC014','Boeing 787-9','Boeing',296,2022,'Active'),('AC015','Airbus A321neo','Airbus',232,2023,'Active'),('AC016','Airbus A321neo','Airbus',232,2022,'Active'),('AC017','Boeing 737 MAX 8','Boeing',178,2021,'Active'),('AC018','Boeing 737 MAX 8','Boeing',178,2022,'Active'),('AC019','Airbus A320neo','Airbus',165,2021,'Active'),('AC020','Airbus A320neo','Airbus',165,2022,'Active'),('AC021','Boeing 787-10','Boeing',330,2020,'Active'),('AC022','Boeing 787-10','Boeing',330,2021,'Active'),('AC023','Airbus A350-900','Airbus',305,2021,'Active'),('AC024','Airbus A350-900','Airbus',305,2022,'Active'),('AC025','ATR 72-600','ATR',70,2019,'Active'),('AC026','ATR 72-600','ATR',70,2020,'Active'),('AC027','Airbus A321','Airbus',220,2016,'Active'),('AC028','Airbus A321','Airbus',220,2017,'Active'),('AC029','Boeing 737-800','Boeing',189,2015,'Active'),('AC030','Boeing 737-800','Boeing',189,2016,'Active'),('AC031','Airbus A320','Airbus',180,2018,'Active'),('AC032','Airbus A320','Airbus',180,2019,'Active'),('AC033','Boeing 787-9','Boeing',296,2020,'Active'),('AC034','Boeing 787-9','Boeing',296,2022,'Active'),('AC035','Airbus A321neo','Airbus',232,2023,'Active'),('AC036','Airbus A321neo','Airbus',232,2024,'Active'),('AC037','Boeing 737 MAX 8','Boeing',178,2023,'Active'),('AC038','Boeing 737 MAX 8','Boeing',178,2024,'Active'),('AC039','Airbus A320neo','Airbus',165,2023,'Active'),('AC040','Airbus A320neo','Airbus',165,2024,'Active'),('AC041','Boeing 787-10','Boeing',330,2022,'Active'),('AC042','Boeing 787-10','Boeing',330,2023,'Active'),('AC043','Airbus A350-900','Airbus',305,2023,'Active'),('AC044','Airbus A350-900','Airbus',305,2024,'Active'),('AC045','ATR 72-600','ATR',70,2021,'Active'),('AC046','ATR 72-600','ATR',70,2022,'Active'),('AC047','Airbus A321','Airbus',220,2014,'Maintenance'),('AC048','Boeing 737-800','Boeing',189,2013,'Maintenance'),('AC049','Airbus A320','Airbus',180,2012,'Inactive'),('AC050','Boeing 787-9','Boeing',296,2011,'Inactive'),('AC051','Airbus A321neo','Airbus',232,2024,'Active'),('AC052','Boeing 737 MAX 8','Boeing',178,2024,'Active'),('AC053','Airbus A320neo','Airbus',165,2024,'Active'),('AC054','Boeing 787-10','Boeing',330,2024,'Active'),('AC055','Airbus A350-900','Airbus',305,2024,'Active'),('AC056','ATR 72-600','ATR',70,2023,'Active'),('AC057','Airbus A321','Airbus',220,2023,'Active'),('AC058','Boeing 737-800','Boeing',189,2023,'Active'),('AC059','Airbus A320','Airbus',180,2024,'Active'),('AC060','Boeing 787-9','Boeing',296,2024,'Active');
/*!40000 ALTER TABLE `aircraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boarding_pass`
--

DROP TABLE IF EXISTS `boarding_pass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boarding_pass` (
  `Boarding_Pass_ID` varchar(50) NOT NULL,
  `Ticket_ID` varchar(50) DEFAULT NULL,
  `Boarding_Time` datetime DEFAULT NULL,
  `Gate_Number` varchar(20) NOT NULL,
  PRIMARY KEY (`Boarding_Pass_ID`),
  UNIQUE KEY `Ticket_ID` (`Ticket_ID`),
  CONSTRAINT `boarding_pass_ibfk_1` FOREIGN KEY (`Ticket_ID`) REFERENCES `ticket` (`Ticket_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boarding_pass`
--

LOCK TABLES `boarding_pass` WRITE;
/*!40000 ALTER TABLE `boarding_pass` DISABLE KEYS */;
INSERT INTO `boarding_pass` VALUES ('BP001','TK001','2025-06-01 05:20:00','G12'),('BP002','TK002','2025-06-01 05:25:00','G12'),('BP003','TK003','2025-06-01 05:30:00','G12'),('BP004','TK004','2025-06-01 06:50:00','G08'),('BP005','TK005','2025-06-01 06:55:00','G08'),('BP006','TK006','2025-06-01 08:15:00','G05'),('BP007','TK007','2025-06-01 08:20:00','G05'),('BP008','TK008','2025-06-01 07:00:00','A01'),('BP009','TK009','2025-06-01 07:05:00','A01'),('BP010','TK010','2025-06-01 07:10:00','A01'),('BP011','TK011','2025-06-01 09:30:00','A03'),('BP012','TK012','2025-06-01 09:35:00','A03'),('BP013','TK013','2025-06-01 12:00:00','A07'),('BP014','TK014','2025-06-01 12:05:00','A07'),('BP015','TK015','2025-06-01 14:45:00','A05'),('BP016','TK016','2025-06-01 05:30:00','C02'),('BP017','TK017','2025-06-01 05:35:00','C02'),('BP018','TK018','2025-06-01 07:00:00','C04'),('BP019','TK019','2025-06-01 07:05:00','C04'),('BP020','TK020','2025-06-01 11:30:00','C06'),('BP021','TK021','2025-06-02 05:20:00','G14'),('BP022','TK022','2025-06-02 05:25:00','G14'),('BP023','TK023','2025-06-02 06:50:00','G09'),('BP024','TK024','2025-06-02 06:55:00','G09'),('BP025','TK025','2025-06-02 08:15:00','G06'),('BP026','TK026','2025-06-02 07:00:00','A02'),('BP027','TK027','2025-06-02 07:05:00','A02'),('BP028','TK028','2025-06-02 07:10:00','A02'),('BP029','TK029','2025-06-02 09:30:00','A04'),('BP030','TK030','2025-06-02 09:35:00','A04'),('BP031','TK031','2025-06-02 00:10:00','A08'),('BP032','TK032','2025-06-02 00:15:00','A08'),('BP033','TK033','2025-06-02 11:45:00','A06'),('BP034','TK034','2025-06-02 11:50:00','A06'),('BP035','TK035','2025-06-02 15:15:00','A09'),('BP036','TK036','2025-06-02 05:30:00','C03'),('BP037','TK037','2025-06-02 05:35:00','C03'),('BP038','TK038','2025-06-02 07:15:00','C05'),('BP039','TK039','2025-06-02 07:20:00','C05'),('BP040','TK040','2025-06-02 09:15:00','C07'),('BP041','TK041','2025-06-03 05:20:00','G10'),('BP042','TK042','2025-06-03 05:25:00','G10'),('BP043','TK043','2025-06-03 06:45:00','G07'),('BP044','TK044','2025-06-03 06:50:00','G07'),('BP045','TK045','2025-06-03 08:15:00','G04'),('BP046','TK046','2025-06-03 07:00:00','A10'),('BP047','TK047','2025-06-03 07:05:00','A10'),('BP048','TK048','2025-06-03 07:10:00','A10'),('BP049','TK049','2025-06-03 09:30:00','A11'),('BP050','TK050','2025-06-03 09:35:00','A11'),('BP051','TK051','2025-06-03 08:45:00','A12'),('BP052','TK052','2025-06-03 08:50:00','A12'),('BP053','TK053','2025-06-03 19:15:00','A13'),('BP054','TK054','2025-06-03 19:20:00','A13'),('BP055','TK055','2025-06-03 05:30:00','C08'),('BP056','TK056','2025-06-03 05:35:00','C08'),('BP057','TK057','2025-06-03 07:15:00','C09'),('BP058','TK058','2025-06-03 07:20:00','C09'),('BP059','TK059','2025-06-03 09:15:00','C10'),('BP060','TK060','2025-06-04 05:20:00','G11'),('BP061','TK061','2025-06-04 05:25:00','G11'),('BP062','TK062','2025-06-04 07:15:00','G13'),('BP063','TK063','2025-06-04 08:15:00','A14'),('BP064','TK064','2025-06-04 08:20:00','A14'),('BP065','TK065','2025-06-04 08:25:00','A14'),('BP066','TK066','2025-06-04 13:15:00','A15'),('BP067','TK067','2025-06-04 05:30:00','C11'),('BP068','TK068','2025-06-04 05:35:00','C11'),('BP069','TK069','2025-06-05 05:20:00','G15'),('BP070','TK070','2025-06-05 05:25:00','G15'),('BP071','TK071','2025-06-05 10:15:00','A16'),('BP072','TK072','2025-06-05 10:20:00','A16'),('BP073','TK073','2025-06-05 15:45:00','A17'),('BP074','TK074','2025-06-05 06:15:00','C12'),('BP075','TK075','2025-06-01 13:15:00','G01'),('BP076','TK076','2025-06-01 13:20:00','G01'),('BP077','TK077','2025-06-03 11:30:00','C13'),('BP078','TK079','2025-06-02 10:15:00','G03');
/*!40000 ALTER TABLE `boarding_pass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_flight`
--

DROP TABLE IF EXISTS `crew_flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crew_flight` (
  `Flight_ID` varchar(50) NOT NULL,
  `Employee_ID` varchar(50) NOT NULL,
  `Role_on_flight` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Flight_ID`,`Employee_ID`),
  KEY `Employee_ID` (`Employee_ID`),
  CONSTRAINT `crew_flight_ibfk_1` FOREIGN KEY (`Flight_ID`) REFERENCES `flight` (`Flight_ID`),
  CONSTRAINT `crew_flight_ibfk_2` FOREIGN KEY (`Employee_ID`) REFERENCES `employee` (`Employee_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_flight`
--

LOCK TABLES `crew_flight` WRITE;
/*!40000 ALTER TABLE `crew_flight` DISABLE KEYS */;
INSERT INTO `crew_flight` VALUES ('FL001','EMP001','Captain'),('FL001','EMP005','First Officer'),('FL001','EMP008','Lead Flight Attendant'),('FL001','EMP009','Flight Attendant'),('FL002','EMP002','Captain'),('FL002','EMP006','First Officer'),('FL002','EMP010','Lead Flight Attendant'),('FL003','EMP003','Captain'),('FL003','EMP007','First Officer'),('FL003','EMP011','Flight Attendant'),('FL004','EMP004','Captain'),('FL004','EMP012','Flight Attendant'),('FL004','EMP025','First Officer'),('FL005','EMP013','Flight Attendant'),('FL005','EMP021','Captain'),('FL005','EMP026','First Officer'),('FL006','EMP022','Captain'),('FL006','EMP027','First Officer'),('FL006','EMP029','Lead Flight Attendant'),('FL006','EMP030','Flight Attendant'),('FL006','EMP031','Flight Attendant'),('FL007','EMP023','Captain'),('FL007','EMP028','First Officer'),('FL007','EMP032','Lead Flight Attendant'),('FL007','EMP033','Flight Attendant'),('FL008','EMP024','Captain'),('FL008','EMP054','First Officer'),('FL008','EMP057','Lead Flight Attendant'),('FL008','EMP058','Flight Attendant'),('FL008','EMP059','Flight Attendant'),('FL009','EMP034','Lead Flight Attendant'),('FL009','EMP035','Flight Attendant'),('FL009','EMP051','Captain'),('FL009','EMP055','First Officer'),('FL010','EMP036','Flight Attendant'),('FL010','EMP052','Captain'),('FL010','EMP056','First Officer'),('FL011','EMP053','Captain'),('FL011','EMP077','First Officer'),('FL011','EMP078','Lead Flight Attendant'),('FL011','EMP079','Flight Attendant'),('FL012','EMP025','First Officer'),('FL012','EMP075','Captain'),('FL012','EMP080','Flight Attendant'),('FL013','EMP026','First Officer'),('FL013','EMP076','Captain'),('FL014','EMP001','Captain'),('FL014','EMP027','First Officer'),('FL014','EMP060','Flight Attendant'),('FL015','EMP002','Captain'),('FL015','EMP008','Flight Attendant'),('FL015','EMP028','First Officer'),('FL016','EMP003','Captain'),('FL016','EMP005','First Officer'),('FL016','EMP009','Lead Flight Attendant'),('FL016','EMP010','Flight Attendant'),('FL017','EMP004','Captain'),('FL017','EMP006','First Officer'),('FL017','EMP011','Flight Attendant'),('FL018','EMP007','First Officer'),('FL018','EMP012','Flight Attendant'),('FL018','EMP021','Captain'),('FL019','EMP013','Flight Attendant'),('FL019','EMP022','Captain'),('FL019','EMP025','First Officer'),('FL020','EMP023','Captain'),('FL020','EMP026','First Officer'),('FL020','EMP029','Flight Attendant'),('FL021','EMP024','Captain'),('FL021','EMP027','First Officer'),('FL021','EMP030','Lead Flight Attendant'),('FL021','EMP031','Flight Attendant'),('FL021','EMP032','Flight Attendant'),('FL022','EMP028','First Officer'),('FL022','EMP033','Lead Flight Attendant'),('FL022','EMP034','Flight Attendant'),('FL022','EMP051','Captain'),('FL023','EMP052','Captain'),('FL023','EMP054','First Officer'),('FL023','EMP057','Lead Flight Attendant'),('FL023','EMP058','Flight Attendant'),('FL023','EMP059','Flight Attendant'),('FL024','EMP035','Flight Attendant'),('FL024','EMP053','Captain'),('FL024','EMP055','First Officer'),('FL025','EMP036','Flight Attendant'),('FL025','EMP056','First Officer'),('FL025','EMP075','Captain'),('FL026','EMP060','Lead Flight Attendant'),('FL026','EMP076','Captain'),('FL026','EMP077','First Officer'),('FL026','EMP078','Flight Attendant'),('FL027','EMP001','Captain'),('FL027','EMP005','First Officer'),('FL027','EMP079','Flight Attendant'),('FL028','EMP002','Captain'),('FL028','EMP006','First Officer'),('FL028','EMP080','Flight Attendant'),('FL029','EMP003','Captain'),('FL029','EMP007','First Officer'),('FL029','EMP008','Flight Attendant'),('FL030','EMP004','Captain'),('FL030','EMP025','First Officer'),('FL031','EMP009','Lead Flight Attendant'),('FL031','EMP010','Flight Attendant'),('FL031','EMP021','Captain'),('FL031','EMP026','First Officer'),('FL032','EMP011','Flight Attendant'),('FL032','EMP022','Captain'),('FL032','EMP027','First Officer'),('FL033','EMP012','Flight Attendant'),('FL033','EMP023','Captain'),('FL033','EMP028','First Officer'),('FL034','EMP013','Flight Attendant'),('FL034','EMP024','Captain'),('FL034','EMP054','First Officer'),('FL035','EMP029','Flight Attendant'),('FL035','EMP051','Captain'),('FL035','EMP055','First Officer'),('FL036','EMP030','Lead Flight Attendant'),('FL036','EMP031','Flight Attendant'),('FL036','EMP032','Flight Attendant'),('FL036','EMP052','Captain'),('FL036','EMP056','First Officer'),('FL037','EMP033','Lead Flight Attendant'),('FL037','EMP034','Flight Attendant'),('FL037','EMP053','Captain'),('FL037','EMP077','First Officer'),('FL038','EMP025','First Officer'),('FL038','EMP035','Lead Flight Attendant'),('FL038','EMP036','Flight Attendant'),('FL038','EMP075','Captain'),('FL039','EMP026','First Officer'),('FL039','EMP057','Lead Flight Attendant'),('FL039','EMP058','Flight Attendant'),('FL039','EMP059','Flight Attendant'),('FL039','EMP076','Captain'),('FL040','EMP001','Captain'),('FL040','EMP027','First Officer'),('FL040','EMP060','Lead Flight Attendant'),('FL040','EMP078','Flight Attendant'),('FL041','EMP002','Captain'),('FL041','EMP028','First Officer'),('FL041','EMP079','Lead Flight Attendant'),('FL041','EMP080','Flight Attendant'),('FL042','EMP003','Captain'),('FL042','EMP005','First Officer'),('FL042','EMP008','Flight Attendant'),('FL043','EMP004','Captain'),('FL043','EMP006','First Officer'),('FL043','EMP009','Flight Attendant'),('FL044','EMP007','First Officer'),('FL044','EMP010','Flight Attendant'),('FL044','EMP021','Captain'),('FL045','EMP011','Flight Attendant'),('FL045','EMP022','Captain'),('FL045','EMP025','First Officer'),('FL046','EMP012','Lead Flight Attendant'),('FL046','EMP013','Flight Attendant'),('FL046','EMP023','Captain'),('FL046','EMP026','First Officer'),('FL047','EMP024','Captain'),('FL047','EMP027','First Officer'),('FL047','EMP029','Flight Attendant'),('FL048','EMP028','First Officer'),('FL048','EMP030','Flight Attendant'),('FL048','EMP051','Captain'),('FL049','EMP031','Lead Flight Attendant'),('FL049','EMP032','Flight Attendant'),('FL049','EMP033','Flight Attendant'),('FL049','EMP052','Captain'),('FL049','EMP054','First Officer'),('FL050','EMP034','Flight Attendant'),('FL050','EMP053','Captain'),('FL050','EMP055','First Officer'),('FL051','EMP035','Lead Flight Attendant'),('FL051','EMP036','Flight Attendant'),('FL051','EMP056','First Officer'),('FL051','EMP075','Captain'),('FL052','EMP060','Flight Attendant'),('FL052','EMP076','Captain'),('FL052','EMP077','First Officer'),('FL053','EMP001','Captain'),('FL053','EMP005','First Officer'),('FL053','EMP057','Flight Attendant'),('FL054','EMP002','Captain'),('FL054','EMP006','First Officer'),('FL054','EMP058','Lead Flight Attendant'),('FL054','EMP059','Flight Attendant'),('FL055','EMP003','Captain'),('FL055','EMP007','First Officer'),('FL055','EMP078','Flight Attendant'),('FL056','EMP004','Captain'),('FL056','EMP008','Flight Attendant'),('FL056','EMP025','First Officer'),('FL056','EMP079','Lead Flight Attendant'),('FL056','EMP080','Flight Attendant'),('FL057','EMP009','Lead Flight Attendant'),('FL057','EMP010','Flight Attendant'),('FL057','EMP021','Captain'),('FL057','EMP026','First Officer'),('FL058','EMP011','Lead Flight Attendant'),('FL058','EMP013','Flight Attendant'),('FL058','EMP022','Captain'),('FL058','EMP027','First Officer'),('FL059','EMP012','Flight Attendant'),('FL059','EMP023','Captain'),('FL059','EMP028','First Officer'),('FL060','EMP024','Captain'),('FL060','EMP054','First Officer');
/*!40000 ALTER TABLE `crew_flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `Employee_ID` varchar(50) NOT NULL,
  `Full_Name` varchar(100) DEFAULT NULL,
  `Role` varchar(50) NOT NULL,
  `Department` varchar(50) DEFAULT NULL,
  `Start_Date` date DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Employee_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('EMP001','Nguyễn Văn Hùng','Pilot','Flight Operations','2015-03-10','Active'),('EMP002','Trần Minh Khoa','Pilot','Flight Operations','2016-07-15','Active'),('EMP003','Lê Thị Thu Hà','Pilot','Flight Operations','2018-01-20','Active'),('EMP004','Phạm Quốc Bảo','Pilot','Flight Operations','2017-05-01','Active'),('EMP005','Hoàng Đức Long','Co-Pilot','Flight Operations','2019-08-12','Active'),('EMP006','Vũ Thị Lan Anh','Co-Pilot','Flight Operations','2020-02-28','Active'),('EMP007','Đinh Văn Nam','Co-Pilot','Flight Operations','2021-06-01','Active'),('EMP008','Ngô Thị Hương','Flight Attendant','Cabin Services','2018-04-10','Active'),('EMP009','Bùi Thanh Tùng','Flight Attendant','Cabin Services','2019-09-15','Active'),('EMP010','Đỗ Thị Mai Ly','Flight Attendant','Cabin Services','2020-03-01','Active'),('EMP011','Trịnh Hoàng Phúc','Flight Attendant','Cabin Services','2019-11-20','Active'),('EMP012','Lý Thị Ngọc Hân','Flight Attendant','Cabin Services','2021-07-05','Active'),('EMP013','Cao Minh Trí','Flight Attendant','Cabin Services','2022-01-15','Active'),('EMP014','Phan Thị Cẩm Tú','Ground Staff','Ground Operations','2017-06-20','Active'),('EMP015','Huỳnh Văn Tài','Ground Staff','Ground Operations','2018-09-10','Active'),('EMP016','Mai Thị Thu Thảo','Check-in Agent','Passenger Services','2019-04-01','Active'),('EMP017','Nguyễn Thanh Sơn','Check-in Agent','Passenger Services','2020-08-15','Active'),('EMP018','Trần Văn Dũng','Security Officer','Security','2016-02-01','Active'),('EMP019','Lê Quốc Tuấn','Security Officer','Security','2017-10-10','Active'),('EMP020','Phạm Thị Bích Ngọc','Security Officer','Security','2019-05-20','Active'),('EMP021','Võ Minh Tuấn','Pilot','Flight Operations','2014-11-15','Active'),('EMP022','Đặng Thị Lan','Pilot','Flight Operations','2015-08-20','Active'),('EMP023','Nguyễn Hoàng Phát','Pilot','Flight Operations','2016-03-05','Active'),('EMP024','Trần Đức Thịnh','Pilot','Flight Operations','2017-09-18','Active'),('EMP025','Lê Văn Toàn','Co-Pilot','Flight Operations','2018-12-01','Active'),('EMP026','Phạm Thị Yến','Co-Pilot','Flight Operations','2019-06-15','Active'),('EMP027','Hoàng Văn Khánh','Co-Pilot','Flight Operations','2020-10-20','Active'),('EMP028','Vũ Quốc Thắng','Co-Pilot','Flight Operations','2021-04-10','Active'),('EMP029','Đinh Thị Thu Nga','Flight Attendant','Cabin Services','2018-07-01','Active'),('EMP030','Ngô Văn Hải','Flight Attendant','Cabin Services','2019-02-14','Active'),('EMP031','Bùi Thị Phương','Flight Attendant','Cabin Services','2020-05-20','Active'),('EMP032','Đỗ Minh Quân','Flight Attendant','Cabin Services','2021-08-15','Active'),('EMP033','Trịnh Thị Như Ý','Flight Attendant','Cabin Services','2022-03-01','Active'),('EMP034','Lý Văn Đạt','Flight Attendant','Cabin Services','2022-09-10','Active'),('EMP035','Cao Thị Mỹ Duyên','Flight Attendant','Cabin Services','2023-01-05','Active'),('EMP036','Phan Văn Nghĩa','Flight Attendant','Cabin Services','2023-06-20','Active'),('EMP037','Huỳnh Thị Kim Loan','Ground Staff','Ground Operations','2016-04-15','Active'),('EMP038','Mai Văn Linh','Ground Staff','Ground Operations','2017-11-30','Active'),('EMP039','Nguyễn Thị Thanh Hằng','Ground Staff','Ground Operations','2018-06-25','Active'),('EMP040','Trần Văn Phúc','Ground Staff','Ground Operations','2019-09-01','Active'),('EMP041','Lê Thị Mỹ Hạnh','Check-in Agent','Passenger Services','2017-03-10','Active'),('EMP042','Phạm Văn Lộc','Check-in Agent','Passenger Services','2018-07-22','Active'),('EMP043','Hoàng Thị Diệu Linh','Check-in Agent','Passenger Services','2019-12-15','Active'),('EMP044','Vũ Văn Cảnh','Check-in Agent','Passenger Services','2020-06-01','Active'),('EMP045','Đinh Thị Thanh Thúy','Security Officer','Security','2015-05-10','Active'),('EMP046','Ngô Văn Hậu','Security Officer','Security','2016-09-20','Active'),('EMP047','Bùi Thị Ngọc Lan','Security Officer','Security','2017-12-05','Active'),('EMP048','Đỗ Văn Khải','Security Officer','Security','2018-04-18','Active'),('EMP049','Trịnh Văn Sỹ','Security Officer','Security','2019-08-30','Active'),('EMP050','Lý Thị Thu Huyền','Security Officer','Security','2020-11-15','Active'),('EMP051','Cao Văn Lâm','Pilot','Flight Operations','2013-07-20','Active'),('EMP052','Phan Thị Hoa','Pilot','Flight Operations','2014-02-14','Active'),('EMP053','Huỳnh Văn Sáng','Pilot','Flight Operations','2015-10-01','Active'),('EMP054','Mai Thị Kiều Oanh','Co-Pilot','Flight Operations','2016-05-25','Active'),('EMP055','Nguyễn Đức Huy','Co-Pilot','Flight Operations','2017-08-10','Active'),('EMP056','Trần Thị Bảo Châu','Co-Pilot','Flight Operations','2018-11-20','Active'),('EMP057','Lê Văn Dương','Flight Attendant','Cabin Services','2019-04-05','Active'),('EMP058','Phạm Thị Hồng Nhung','Flight Attendant','Cabin Services','2020-07-18','Active'),('EMP059','Hoàng Văn Bình','Flight Attendant','Cabin Services','2021-01-10','Active'),('EMP060','Vũ Thị Xuân Mai','Flight Attendant','Cabin Services','2021-09-25','Active'),('EMP061','Đinh Văn Thiện','Ground Staff','Ground Operations','2015-06-15','Active'),('EMP062','Ngô Thị Hoa Đào','Ground Staff','Ground Operations','2016-12-01','Active'),('EMP063','Bùi Văn Quý','Baggage Handler','Ground Operations','2017-04-20','Active'),('EMP064','Đỗ Thị Thu Trang','Baggage Handler','Ground Operations','2018-08-05','Active'),('EMP065','Trịnh Văn Lực','Baggage Handler','Ground Operations','2019-01-15','Active'),('EMP066','Lý Thị Cẩm Nhung','Baggage Handler','Ground Operations','2019-10-30','Active'),('EMP067','Cao Văn Dũng','Baggage Handler','Ground Operations','2020-04-15','Active'),('EMP068','Phan Thị Thanh Tâm','Check-in Agent','Passenger Services','2021-02-01','Active'),('EMP069','Huỳnh Văn Thành','Check-in Agent','Passenger Services','2021-08-20','Active'),('EMP070','Mai Thị Bích Trâm','Check-in Agent','Passenger Services','2022-03-10','Active'),('EMP071','Nguyễn Văn Tâm','Security Officer','Security','2014-09-05','Active'),('EMP072','Trần Thị Mỹ Linh','Security Officer','Security','2015-04-18','Active'),('EMP073','Lê Văn Đông','Security Officer','Security','2016-07-30','Active'),('EMP074','Phạm Thị Hồng Hạnh','Security Officer','Security','2017-11-12','Inactive'),('EMP075','Hoàng Văn Tùng','Pilot','Flight Operations','2012-05-01','Active'),('EMP076','Vũ Thị Phương Linh','Pilot','Flight Operations','2013-09-15','Active'),('EMP077','Đinh Văn Mạnh','Co-Pilot','Flight Operations','2015-02-28','Active'),('EMP078','Ngô Thị Diễm Quỳnh','Flight Attendant','Cabin Services','2018-06-10','Active'),('EMP079','Bùi Văn Hiếu','Flight Attendant','Cabin Services','2019-12-01','Active'),('EMP080','Đỗ Thị Khánh Linh','Flight Attendant','Cabin Services','2020-09-15','Active');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `Flight_ID` varchar(50) NOT NULL,
  `Flight_Number` varchar(20) DEFAULT NULL,
  `Origin` varchar(100) DEFAULT NULL,
  `Destination` varchar(100) DEFAULT NULL,
  `Scheduled_Departure` datetime DEFAULT NULL,
  `Actual_Departure` datetime DEFAULT NULL,
  `Scheduled_Arrival` datetime DEFAULT NULL,
  `Actual_Arrival` datetime DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `Aircraft_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Flight_ID`),
  KEY `Aircraft_ID` (`Aircraft_ID`),
  CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`Aircraft_ID`) REFERENCES `aircraft` (`Aircraft_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES ('FL001','VN123','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-01 06:00:00','2025-06-01 06:05:00','2025-06-01 08:10:00','2025-06-01 08:15:00','Completed','AC001'),('FL002','VJ234','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-01 07:30:00','2025-06-01 07:35:00','2025-06-01 09:00:00','2025-06-01 09:05:00','Completed','AC003'),('FL003','QH345','Tan Son Nhat (SGN)','Phu Quoc (PQC)','2025-06-01 09:00:00','2025-06-01 09:10:00','2025-06-01 10:05:00','2025-06-01 10:20:00','Completed','AC010'),('FL004','VN456','Tan Son Nhat (SGN)','Cam Ranh (CXR)','2025-06-01 11:00:00','2025-06-01 11:00:00','2025-06-01 12:10:00','2025-06-01 12:10:00','Completed','AC004'),('FL005','VJ567','Noi Bai (HAN)','Tan Son Nhat (SGN)','2025-06-01 14:00:00','2025-06-01 14:15:00','2025-06-01 16:10:00','2025-06-01 16:30:00','Completed','AC002'),('FL006','VN001','Tan Son Nhat (SGN)','Narita (NRT)','2025-06-01 08:00:00','2025-06-01 08:05:00','2025-06-01 15:30:00','2025-06-01 15:35:00','Completed','AC007'),('FL007','VN011','Tan Son Nhat (SGN)','Incheon (ICN)','2025-06-01 10:30:00','2025-06-01 10:30:00','2025-06-01 17:45:00','2025-06-01 17:45:00','Completed','AC009'),('FL008','QR560','Tan Son Nhat (SGN)','Doha (DOH)','2025-06-01 23:55:00',NULL,'2025-06-02 05:30:00',NULL,'Scheduled','AC014'),('FL009','SQ185','Tan Son Nhat (SGN)','Changi (SIN)','2025-06-01 13:00:00','2025-06-01 13:05:00','2025-06-01 16:25:00','2025-06-01 16:30:00','Completed','AC008'),('FL010','CX761','Tan Son Nhat (SGN)','Hong Kong (HKG)','2025-06-01 15:45:00','2025-06-01 15:50:00','2025-06-01 19:30:00','2025-06-01 19:35:00','Completed','AC005'),('FL011','VN789','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-01 06:30:00','2025-06-01 06:30:00','2025-06-01 08:40:00','2025-06-01 08:40:00','Completed','AC015'),('FL012','VJ890','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-01 08:00:00','2025-06-01 08:10:00','2025-06-01 09:30:00','2025-06-01 09:45:00','Completed','AC006'),('FL013','VN321','Tan Son Nhat (SGN)','Hue (HUI)','2025-06-01 10:00:00',NULL,'2025-06-01 11:20:00',NULL,'Cancelled','AC011'),('FL014','VJ432','Tan Son Nhat (SGN)','Phu Quoc (PQC)','2025-06-01 12:30:00','2025-06-01 12:45:00','2025-06-01 13:35:00','2025-06-01 13:50:00','Completed','AC003'),('FL015','QH543','Tan Son Nhat (SGN)','Can Tho (VCA)','2025-06-01 16:00:00','2025-06-01 16:00:00','2025-06-01 16:50:00','2025-06-01 16:50:00','Completed','AC010'),('FL016','VN124','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-02 06:00:00','2025-06-02 06:08:00','2025-06-02 08:10:00','2025-06-02 08:20:00','Completed','AC027'),('FL017','VJ235','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-02 07:30:00','2025-06-02 07:30:00','2025-06-02 09:00:00','2025-06-02 09:00:00','Completed','AC028'),('FL018','QH346','Tan Son Nhat (SGN)','Phu Quoc (PQC)','2025-06-02 09:00:00','2025-06-02 09:05:00','2025-06-02 10:05:00','2025-06-02 10:10:00','Completed','AC025'),('FL019','VN457','Tan Son Nhat (SGN)','Buon Ma Thuot (BMV)','2025-06-02 11:00:00','2025-06-02 11:15:00','2025-06-02 12:10:00','2025-06-02 12:25:00','Completed','AC031'),('FL020','VJ568','Da Nang (DAD)','Tan Son Nhat (SGN)','2025-06-02 14:00:00','2025-06-02 14:00:00','2025-06-02 15:30:00','2025-06-02 15:30:00','Completed','AC029'),('FL021','VN002','Tan Son Nhat (SGN)','Narita (NRT)','2025-06-02 08:00:00','2025-06-02 08:00:00','2025-06-02 15:30:00','2025-06-02 15:30:00','Completed','AC021'),('FL022','KE684','Tan Son Nhat (SGN)','Incheon (ICN)','2025-06-02 10:30:00','2025-06-02 10:45:00','2025-06-02 17:45:00','2025-06-02 18:00:00','Completed','AC023'),('FL023','EK393','Tan Son Nhat (SGN)','Dubai (DXB)','2025-06-02 01:00:00','2025-06-02 01:00:00','2025-06-02 07:00:00','2025-06-02 07:00:00','Completed','AC033'),('FL024','TG556','Tan Son Nhat (SGN)','Bangkok (BKK)','2025-06-02 12:30:00','2025-06-02 12:35:00','2025-06-02 14:00:00','2025-06-02 14:05:00','Completed','AC008'),('FL025','MH751','Tan Son Nhat (SGN)','Kuala Lumpur (KUL)','2025-06-02 16:00:00','2025-06-02 16:00:00','2025-06-02 18:30:00','2025-06-02 18:30:00','Completed','AC005'),('FL026','VN790','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-02 06:30:00','2025-06-02 06:40:00','2025-06-02 08:40:00','2025-06-02 08:50:00','Completed','AC035'),('FL027','VJ891','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-02 08:00:00','2025-06-02 08:00:00','2025-06-02 09:30:00','2025-06-02 09:30:00','Completed','AC036'),('FL028','VN322','Tan Son Nhat (SGN)','Hue (HUI)','2025-06-02 10:00:00','2025-06-02 10:00:00','2025-06-02 11:20:00','2025-06-02 11:20:00','Completed','AC039'),('FL029','VJ433','Tan Son Nhat (SGN)','Phu Quoc (PQC)','2025-06-02 12:30:00','2025-06-02 12:30:00','2025-06-02 13:35:00','2025-06-02 13:35:00','Completed','AC032'),('FL030','QH544','Tan Son Nhat (SGN)','Can Tho (VCA)','2025-06-02 17:00:00',NULL,'2025-06-02 17:50:00',NULL,'Cancelled','AC047'),('FL031','VN125','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-03 06:00:00','2025-06-03 06:00:00','2025-06-03 08:10:00','2025-06-03 08:10:00','Completed','AC057'),('FL032','VJ236','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-03 07:30:00','2025-06-03 07:45:00','2025-06-03 09:00:00','2025-06-03 09:15:00','Completed','AC058'),('FL033','QH347','Tan Son Nhat (SGN)','Phu Quoc (PQC)','2025-06-03 09:00:00','2025-06-03 09:00:00','2025-06-03 10:05:00','2025-06-03 10:05:00','Completed','AC056'),('FL034','VN458','Tan Son Nhat (SGN)','Cam Ranh (CXR)','2025-06-03 11:00:00','2025-06-03 11:20:00','2025-06-03 12:10:00','2025-06-03 12:30:00','Completed','AC031'),('FL035','VJ569','Noi Bai (HAN)','Tan Son Nhat (SGN)','2025-06-03 15:00:00','2025-06-03 15:00:00','2025-06-03 17:10:00','2025-06-03 17:10:00','Completed','AC030'),('FL036','VN003','Tan Son Nhat (SGN)','Narita (NRT)','2025-06-03 08:00:00','2025-06-03 08:10:00','2025-06-03 15:30:00','2025-06-03 15:40:00','Completed','AC041'),('FL037','OZ733','Tan Son Nhat (SGN)','Incheon (ICN)','2025-06-03 10:30:00','2025-06-03 10:30:00','2025-06-03 17:45:00','2025-06-03 17:45:00','Completed','AC043'),('FL038','GA867','Tan Son Nhat (SGN)','Bali (DPS)','2025-06-03 09:30:00','2025-06-03 09:45:00','2025-06-03 13:00:00','2025-06-03 13:15:00','Completed','AC009'),('FL039','AF257','Tan Son Nhat (SGN)','Paris (CDG)','2025-06-03 22:30:00',NULL,'2025-06-04 06:30:00',NULL,'Scheduled','AC044'),('FL040','LH770','Tan Son Nhat (SGN)','Frankfurt (FRA)','2025-06-03 20:00:00','2025-06-03 20:00:00','2025-06-04 03:00:00','2025-06-04 03:00:00','Completed','AC054'),('FL041','VN791','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-03 06:30:00','2025-06-03 06:30:00','2025-06-03 08:40:00','2025-06-03 08:40:00','Completed','AC059'),('FL042','VJ892','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-03 08:00:00','2025-06-03 08:05:00','2025-06-03 09:30:00','2025-06-03 09:35:00','Completed','AC060'),('FL043','VN323','Tan Son Nhat (SGN)','Hue (HUI)','2025-06-03 10:00:00','2025-06-03 10:15:00','2025-06-03 11:20:00','2025-06-03 11:35:00','Completed','AC051'),('FL044','VJ434','Tan Son Nhat (SGN)','Phu Quoc (PQC)','2025-06-03 12:30:00','2025-06-03 12:30:00','2025-06-03 13:35:00','2025-06-03 13:35:00','Completed','AC052'),('FL045','QH545','Tan Son Nhat (SGN)','Can Tho (VCA)','2025-06-03 16:00:00','2025-06-03 16:10:00','2025-06-03 16:50:00','2025-06-03 17:00:00','Completed','AC053'),('FL046','VN126','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-04 06:00:00','2025-06-04 06:00:00','2025-06-04 08:10:00','2025-06-04 08:10:00','Completed','AC001'),('FL047','VJ237','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-04 08:00:00','2025-06-04 08:00:00','2025-06-04 09:30:00','2025-06-04 09:30:00','Completed','AC004'),('FL048','QH348','Tan Son Nhat (SGN)','Buon Ma Thuot (BMV)','2025-06-04 10:00:00','2025-06-04 10:05:00','2025-06-04 11:10:00','2025-06-04 11:15:00','Completed','AC025'),('FL049','VN012','Tan Son Nhat (SGN)','Beijing (PEK)','2025-06-04 09:00:00','2025-06-04 09:00:00','2025-06-04 14:30:00','2025-06-04 14:30:00','Completed','AC022'),('FL050','TG557','Tan Son Nhat (SGN)','Bangkok (BKK)','2025-06-04 14:00:00','2025-06-04 14:20:00','2025-06-04 15:30:00','2025-06-04 15:50:00','Completed','AC006'),('FL051','VN792','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-04 06:30:00','2025-06-04 06:30:00','2025-06-04 08:40:00','2025-06-04 08:40:00','Completed','AC035'),('FL052','VJ893','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-04 09:00:00','2025-06-04 09:10:00','2025-06-04 10:30:00','2025-06-04 10:45:00','Completed','AC053'),('FL053','VN324','Tan Son Nhat (SGN)','Can Tho (VCA)','2025-06-04 13:00:00','2025-06-04 13:00:00','2025-06-04 13:50:00','2025-06-04 13:50:00','Completed','AC045'),('FL054','VN127','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-05 06:00:00','2025-06-05 06:10:00','2025-06-05 08:10:00','2025-06-05 08:25:00','Completed','AC002'),('FL055','VJ238','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-05 08:00:00','2025-06-05 08:00:00','2025-06-05 09:30:00','2025-06-05 09:30:00','Completed','AC003'),('FL056','VN013','Tan Son Nhat (SGN)','Incheon (ICN)','2025-06-05 11:00:00','2025-06-05 11:00:00','2025-06-05 18:15:00','2025-06-05 18:15:00','Completed','AC024'),('FL057','MH752','Tan Son Nhat (SGN)','Kuala Lumpur (KUL)','2025-06-05 16:30:00','2025-06-05 16:30:00','2025-06-05 19:00:00','2025-06-05 19:00:00','Completed','AC007'),('FL058','VN793','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-05 07:00:00','2025-06-05 07:00:00','2025-06-05 09:10:00','2025-06-05 09:10:00','Completed','AC051'),('FL059','VJ894','Tan Son Nhat (SGN)','Phu Quoc (PQC)','2025-06-05 10:00:00','2025-06-05 10:10:00','2025-06-05 11:05:00','2025-06-05 11:20:00','Completed','AC052'),('FL060','QH549','Tan Son Nhat (SGN)','Can Tho (VCA)','2025-06-05 15:00:00',NULL,'2025-06-05 15:50:00',NULL,'Cancelled','AC048');
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `luggage`
--

DROP TABLE IF EXISTS `luggage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `luggage` (
  `Luggage_ID` varchar(50) NOT NULL,
  `Weight` decimal(5,2) DEFAULT NULL,
  `Checked_Time` datetime DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `Ticket_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Luggage_ID`),
  KEY `Ticket_ID` (`Ticket_ID`),
  CONSTRAINT `luggage_ibfk_1` FOREIGN KEY (`Ticket_ID`) REFERENCES `ticket` (`Ticket_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `luggage`
--

LOCK TABLES `luggage` WRITE;
/*!40000 ALTER TABLE `luggage` DISABLE KEYS */;
INSERT INTO `luggage` VALUES ('LG001',22.50,'2025-06-01 05:00:00','Delivered','TK001'),('LG002',18.00,'2025-06-01 05:05:00','Delivered','TK002'),('LG003',15.30,'2025-06-01 05:08:00','Delivered','TK003'),('LG004',20.00,'2025-06-01 06:30:00','Delivered','TK004'),('LG005',12.50,'2025-06-01 06:35:00','Delivered','TK005'),('LG006',25.00,'2025-06-01 08:00:00','Delivered','TK006'),('LG007',10.00,'2025-06-01 08:05:00','Delivered','TK007'),('LG008',30.00,'2025-06-01 06:45:00','Delivered','TK008'),('LG009',28.00,'2025-06-01 06:50:00','Delivered','TK009'),('LG010',19.50,'2025-06-01 06:55:00','Delivered','TK010'),('LG011',23.00,'2025-06-01 09:20:00','Delivered','TK011'),('LG012',17.00,'2025-06-01 09:25:00','Delayed','TK012'),('LG013',21.00,'2025-06-01 11:50:00','Delivered','TK013'),('LG014',14.50,'2025-06-01 11:55:00','Delivered','TK014'),('LG015',32.00,'2025-06-01 14:30:00','Delivered','TK015'),('LG016',16.00,'2025-06-01 05:10:00','Delivered','TK016'),('LG017',11.00,'2025-06-01 05:15:00','Delivered','TK017'),('LG018',24.00,'2025-06-01 06:50:00','Delivered','TK018'),('LG019',9.50,'2025-06-01 06:55:00','Delivered','TK019'),('LG020',13.00,'2025-06-01 11:15:00','Delivered','TK020'),('LG021',18.50,'2025-06-01 06:58:00','Lost','TK003'),('LG022',26.00,'2025-06-01 09:22:00','Delayed','TK012'),('LG023',20.00,'2025-06-02 05:00:00','Delivered','TK021'),('LG024',15.00,'2025-06-02 05:05:00','Delivered','TK022'),('LG025',22.00,'2025-06-02 06:30:00','Delivered','TK023'),('LG026',18.00,'2025-06-02 06:35:00','Delivered','TK024'),('LG027',11.50,'2025-06-02 08:00:00','Delivered','TK025'),('LG028',31.00,'2025-06-02 06:45:00','Delivered','TK026'),('LG029',29.00,'2025-06-02 06:50:00','Delivered','TK027'),('LG030',20.50,'2025-06-02 06:55:00','Delivered','TK028'),('LG031',24.00,'2025-06-02 09:20:00','Delivered','TK029'),('LG032',16.50,'2025-06-02 09:25:00','Delivered','TK030'),('LG033',33.00,'2025-06-02 00:05:00','Delivered','TK031'),('LG034',27.00,'2025-06-02 00:07:00','Delivered','TK032'),('LG035',14.00,'2025-06-02 11:40:00','Delivered','TK033'),('LG036',19.00,'2025-06-02 11:45:00','Lost','TK034'),('LG037',22.50,'2025-06-02 15:10:00','Delivered','TK035'),('LG038',17.00,'2025-06-02 05:10:00','Delivered','TK036'),('LG039',12.00,'2025-06-02 05:15:00','Delivered','TK037'),('LG040',25.00,'2025-06-02 07:05:00','Delivered','TK038'),('LG041',10.50,'2025-06-02 07:10:00','Delivered','TK039'),('LG042',16.00,'2025-06-02 09:10:00','Delivered','TK040'),('LG043',21.00,'2025-06-03 05:00:00','Delivered','TK041'),('LG044',16.00,'2025-06-03 05:05:00','Delivered','TK042'),('LG045',23.00,'2025-06-03 06:30:00','Delayed','TK043'),('LG046',19.00,'2025-06-03 06:35:00','Delivered','TK044'),('LG047',12.00,'2025-06-03 08:00:00','Delivered','TK045'),('LG048',32.00,'2025-06-03 06:45:00','Delivered','TK046'),('LG049',30.00,'2025-06-03 06:50:00','Delivered','TK047'),('LG050',21.50,'2025-06-03 06:55:00','Delivered','TK048'),('LG051',25.00,'2025-06-03 09:20:00','Delivered','TK049'),('LG052',17.50,'2025-06-03 09:25:00','Delivered','TK050'),('LG053',14.00,'2025-06-03 08:45:00','Delivered','TK051'),('LG054',20.00,'2025-06-03 08:50:00','Delivered','TK052'),('LG055',35.00,'2025-06-03 19:10:00','Delivered','TK053'),('LG056',28.50,'2025-06-03 19:12:00','Delivered','TK054'),('LG057',17.00,'2025-06-03 05:10:00','Delivered','TK055'),('LG058',13.00,'2025-06-03 05:15:00','Delivered','TK056'),('LG059',26.00,'2025-06-03 07:05:00','Delivered','TK057'),('LG060',11.50,'2025-06-03 07:10:00','Lost','TK058'),('LG061',17.00,'2025-06-03 09:10:00','Delivered','TK059'),('LG062',22.00,'2025-06-04 05:00:00','Delivered','TK060'),('LG063',15.00,'2025-06-04 05:05:00','Delivered','TK061'),('LG064',20.50,'2025-06-04 07:10:00','Delivered','TK062'),('LG065',34.00,'2025-06-04 08:10:00','Delivered','TK063'),('LG066',29.00,'2025-06-04 08:12:00','Delivered','TK064'),('LG067',23.00,'2025-06-04 08:15:00','Delivered','TK065'),('LG068',16.00,'2025-06-04 13:10:00','Delivered','TK066'),('LG069',18.00,'2025-06-04 05:10:00','Delivered','TK067'),('LG070',14.00,'2025-06-04 05:12:00','Delivered','TK068'),('LG071',23.50,'2025-06-05 05:00:00','Delivered','TK069'),('LG072',17.00,'2025-06-05 05:05:00','Delivered','TK070'),('LG073',36.00,'2025-06-05 10:10:00','Delivered','TK071'),('LG074',20.00,'2025-06-05 10:12:00','Delivered','TK072'),('LG075',22.00,'2025-06-05 15:40:00','Delivered','TK073'),('LG076',15.50,'2025-06-05 06:10:00','Delivered','TK074'),('LG077',19.00,'2025-06-01 13:10:00','Delivered','TK075'),('LG078',14.00,'2025-06-01 13:12:00','Delivered','TK076'),('LG079',21.00,'2025-06-03 11:25:00','Delayed','TK077'),('LG080',27.00,'2025-06-02 10:10:00','Delivered','TK079'),('LG081',8.50,'2025-06-02 07:08:00','Delivered','TK039'),('LG082',30.50,'2025-06-03 06:48:00','Lost','TK043'),('LG083',13.50,'2025-06-04 08:18:00','Delayed','TK065'),('LG084',11.00,'2025-06-05 05:08:00','Delivered','TK074'),('LG085',19.50,'2025-06-01 11:52:00','Delivered','TK013'),('LG086',24.00,'2025-06-02 06:52:00','Delivered','TK028'),('LG087',16.50,'2025-06-03 06:52:00','Delivered','TK048'),('LG088',22.00,'2025-06-04 13:12:00','Delivered','TK066'),('LG089',18.00,'2025-06-05 10:14:00','Delivered','TK072'),('LG090',14.50,'2025-06-03 09:12:00','Delivered','TK059');
/*!40000 ALTER TABLE `luggage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passenger`
--

DROP TABLE IF EXISTS `passenger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passenger` (
  `Passenger_ID` varchar(50) NOT NULL,
  `First_Name` varchar(50) DEFAULT NULL,
  `Middle_Name` varchar(50) DEFAULT NULL,
  `Last_Name` varchar(50) DEFAULT NULL,
  `Date_of_Birth` date DEFAULT NULL,
  `Nationality` varchar(100) DEFAULT NULL,
  `Gender` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Passenger_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger`
--

LOCK TABLES `passenger` WRITE;
/*!40000 ALTER TABLE `passenger` DISABLE KEYS */;
INSERT INTO `passenger` VALUES ('PAX001','Nguyễn','Văn','An','1990-05-15','Vietnamese','Male'),('PAX002','Trần','Thị','Bình','1985-08-22','Vietnamese','Female'),('PAX003','Lê',NULL,'Cường','1992-12-01','Vietnamese','Male'),('PAX004','Phạm','Thị','Dung','1995-03-18','Vietnamese','Female'),('PAX005','John',NULL,'Smith','1988-07-30','American','Male'),('PAX006','Emily','Rose','Johnson','1993-11-25','British','Female'),('PAX007','Tanaka',NULL,'Hiroshi','1980-02-14','Japanese','Male'),('PAX008','Kim',NULL,'Ji-yeon','1997-06-09','Korean','Female'),('PAX009','Hoàng','Minh','Đức','1975-09-03','Vietnamese','Male'),('PAX010','Vũ','Thị','Hoa','1999-01-27','Vietnamese','Female'),('PAX011','Wang',NULL,'Wei','1986-04-16','Chinese','Male'),('PAX012','Sophie',NULL,'Dubois','1991-10-08','French','Female'),('PAX013','Đinh','Quốc','Hùng','1983-12-31','Vietnamese','Male'),('PAX014','Ngô','Thị','Lan','2000-07-20','Vietnamese','Female'),('PAX015','Bùi','Văn','Minh','1978-03-05','Vietnamese','Male'),('PAX016','Ahmad',NULL,'Reza','1989-09-12','Malaysian','Male'),('PAX017','Đỗ','Thị','Nhung','1996-05-28','Vietnamese','Female'),('PAX018','Trịnh','Văn','Phong','1987-11-17','Vietnamese','Male'),('PAX019','Lucas',NULL,'Müller','1994-08-04','German','Male'),('PAX020','Cao','Thị','Quỳnh','2001-02-22','Vietnamese','Female'),('PAX021','Võ','Văn','Tân','1982-06-10','Vietnamese','Male'),('PAX022','Đặng','Thị','Uyên','1990-09-30','Vietnamese','Female'),('PAX023','Nguyễn','Hoàng','Việt','1977-04-20','Vietnamese','Male'),('PAX024','Trần','Thị','Xuân','1993-07-15','Vietnamese','Female'),('PAX025','Michael',NULL,'Brown','1985-01-12','American','Male'),('PAX026','Sarah','Jane','Wilson','1990-03-28','Australian','Female'),('PAX027','Park',NULL,'Sung-jin','1988-11-05','Korean','Male'),('PAX028','Yamamoto',NULL,'Yuki','1995-08-17','Japanese','Female'),('PAX029','Li',NULL,'Jing','1983-05-22','Chinese','Female'),('PAX030','Marco',NULL,'Rossi','1979-10-14','Italian','Male'),('PAX031','Lê','Thị','Yến','1998-02-08','Vietnamese','Female'),('PAX032','Phạm','Đức','Anh','1986-06-25','Vietnamese','Male'),('PAX033','Hoàng','Thị','Bảo','1991-12-12','Vietnamese','Female'),('PAX034','Vũ','Minh','Châu','1984-07-07','Vietnamese','Male'),('PAX035','James',NULL,'Taylor','1987-04-03','British','Male'),('PAX036','Anna','Marie','Schmidt','1992-09-19','German','Female'),('PAX037','Chen',NULL,'Xiao','1981-01-30','Chinese','Male'),('PAX038','Nguyen','Thi','Dao','1996-05-05','Vietnamese','Female'),('PAX039','Đinh','Văn','Em','1973-11-28','Vietnamese','Male'),('PAX040','Ngô','Thị','Phượng','2002-03-16','Vietnamese','Female'),('PAX041','Ali',NULL,'Hassan','1988-08-08','Singaporean','Male'),('PAX042','Maria','Clara','Santos','1994-06-14','Filipino','Female'),('PAX043','Raj',NULL,'Patel','1980-10-25','Indian','Male'),('PAX044','Nadia',NULL,'Ivanova','1992-02-18','Russian','Female'),('PAX045','Bùi','Thị','Giang','1987-07-22','Vietnamese','Female'),('PAX046','Đỗ','Văn','Hiếu','1995-04-11','Vietnamese','Male'),('PAX047','Trịnh','Thị','Ích','1983-09-03','Vietnamese','Female'),('PAX048','Lý','Văn','Kiên','1990-12-27','Vietnamese','Male'),('PAX049','Cao','Thị','Liễu','1997-06-06','Vietnamese','Female'),('PAX050','Phan','Văn','Mạnh','1985-01-19','Vietnamese','Male'),('PAX051','David',NULL,'Lee','1979-05-31','American','Male'),('PAX052','Yuna',NULL,'Cho','1998-08-14','Korean','Female'),('PAX053','Sato',NULL,'Kenji','1975-12-09','Japanese','Male'),('PAX054','Fatima',NULL,'Al-Rashid','1989-03-23','Emirati','Female'),('PAX055','Huỳnh','Thị','Ngân','1993-10-17','Vietnamese','Female'),('PAX056','Mai','Văn','Oanh','1988-04-04','Vietnamese','Male'),('PAX057','Nguyễn','Thị','Phúc','2001-07-29','Vietnamese','Female'),('PAX058','Trần','Đức','Quang','1980-02-13','Vietnamese','Male'),('PAX059','Oliver',NULL,'Williams','1991-06-06','British','Male'),('PAX060','Isabelle',NULL,'Laurent','1986-11-21','French','Female'),('PAX061','Lê','Thị','Rạng','1994-08-08','Vietnamese','Female'),('PAX062','Phạm','Văn','Sơn','1977-03-15','Vietnamese','Male'),('PAX063','Zhang',NULL,'Fang','1984-01-01','Chinese','Female'),('PAX064','Aarav',NULL,'Sharma','1999-09-09','Indian','Male'),('PAX065','Vũ','Thị','Triều','1996-05-20','Vietnamese','Female'),('PAX066','Đinh','Văn','Uy','1982-12-12','Vietnamese','Male'),('PAX067','Thomas',NULL,'Nguyen','1990-07-04','American','Male'),('PAX068','Yui',NULL,'Tanaka','1995-02-28','Japanese','Female'),('PAX069','Ngô','Thị','Vân','1978-10-10','Vietnamese','Female'),('PAX070','Bùi','Văn','Xuyên','1987-06-16','Vietnamese','Male'),('PAX071','Carlos',NULL,'Mendez','1983-04-07','Mexican','Male'),('PAX072','Hyun',NULL,'Ji-ho','1993-11-30','Korean','Male'),('PAX073','Đỗ','Thị','Ý','1989-08-25','Vietnamese','Female'),('PAX074','Trịnh','Minh','Tuấn','1984-03-18','Vietnamese','Male'),('PAX075','Natasha',NULL,'Petrova','1991-07-07','Russian','Female'),('PAX076','Lý','Văn','Phát','1986-09-22','Vietnamese','Male'),('PAX077','Mohamed',NULL,'Al-Farsi','1978-05-15','Omani','Male'),('PAX078','Cao','Thị','Diệu','1997-01-14','Vietnamese','Female'),('PAX079','Phan','Văn','Quyết','1974-11-08','Vietnamese','Male'),('PAX080','Huỳnh','Thị','Thiên','2002-06-30','Vietnamese','Female');
/*!40000 ALTER TABLE `passenger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passenger_email`
--

DROP TABLE IF EXISTS `passenger_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passenger_email` (
  `Email_ID` int NOT NULL AUTO_INCREMENT,
  `Passenger_ID` varchar(50) DEFAULT NULL,
  `Email` varchar(100) NOT NULL,
  PRIMARY KEY (`Email_ID`),
  KEY `Passenger_ID` (`Passenger_ID`),
  CONSTRAINT `passenger_email_ibfk_1` FOREIGN KEY (`Passenger_ID`) REFERENCES `passenger` (`Passenger_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger_email`
--

LOCK TABLES `passenger_email` WRITE;
/*!40000 ALTER TABLE `passenger_email` DISABLE KEYS */;
INSERT INTO `passenger_email` VALUES (1,'PAX001','nguyenvanan@gmail.com'),(2,'PAX002','tranthibinh@gmail.com'),(3,'PAX002','binh.tran@company.vn'),(4,'PAX003','lecuong92@gmail.com'),(5,'PAX004','phamthidung@yahoo.com'),(6,'PAX005','john.smith@gmail.com'),(7,'PAX005','jsmith@corp.us'),(8,'PAX006','emily.johnson@outlook.com'),(9,'PAX007','tanaka.h@jp.co'),(10,'PAX008','kimjiyeon97@naver.com'),(11,'PAX009','hoangminhduc@gmail.com'),(12,'PAX010','vuthihoa99@gmail.com'),(13,'PAX011','wangwei@163.com'),(14,'PAX012','sophie.dubois@gmail.com'),(15,'PAX013','dinhquochung@gmail.com'),(16,'PAX013','hung.dinh@biz.vn'),(17,'PAX014','ngothilan@gmail.com'),(18,'PAX015','buivanminh@gmail.com'),(19,'PAX016','ahmad.reza@gmail.com'),(20,'PAX017','dothinhung@gmail.com'),(21,'PAX018','trinhvanphong@gmail.com'),(22,'PAX019','lucas.muller@gmail.de'),(23,'PAX020','caothiquynh@gmail.com'),(24,'PAX021','vovatran@gmail.com'),(25,'PAX022','dangthiuyen@gmail.com'),(26,'PAX023','nguyenhoangviet@gmail.com'),(27,'PAX023','viet.nguyen@work.vn'),(28,'PAX024','tranthixuan@gmail.com'),(29,'PAX025','michael.brown@gmail.com'),(30,'PAX026','sarah.wilson@gmail.com'),(31,'PAX026','swilson@au.net'),(32,'PAX027','park.sungjin@daum.net'),(33,'PAX028','yamamoto.yuki@yahoo.co.jp'),(34,'PAX029','lijing83@qq.com'),(35,'PAX030','marco.rossi@gmail.it'),(36,'PAX031','lethiyen98@gmail.com'),(37,'PAX032','phamducanh@gmail.com'),(38,'PAX033','hoangbao@gmail.com'),(39,'PAX034','vuminhchau@gmail.com'),(40,'PAX035','james.taylor@gmail.co.uk'),(41,'PAX036','anna.schmidt@gmail.de'),(42,'PAX037','chenxiao81@163.com'),(43,'PAX038','nguyenthidao@gmail.com'),(44,'PAX039','dinhvanem@gmail.com'),(45,'PAX040','ngothiphuong@gmail.com'),(46,'PAX041','ali.hassan@gmail.sg'),(47,'PAX042','maria.santos@gmail.ph'),(48,'PAX043','raj.patel@gmail.in'),(49,'PAX044','nadia.ivanova@mail.ru'),(50,'PAX045','buithigiang@gmail.com'),(51,'PAX046','dovanhieu@gmail.com'),(52,'PAX047','trinhthi-ich@gmail.com'),(53,'PAX048','lyvankien@gmail.com'),(54,'PAX049','caothilieu@gmail.com'),(55,'PAX050','phanvanmanh@gmail.com'),(56,'PAX051','david.lee@gmail.com'),(57,'PAX051','dlee@corp.us'),(58,'PAX052','yunach@naver.com'),(59,'PAX053','sato.kenji@yahoo.co.jp'),(60,'PAX054','fatima.alrashid@gmail.ae'),(61,'PAX055','huynhthingan@gmail.com'),(62,'PAX056','maivanoanh@gmail.com'),(63,'PAX057','nguyenthiphuc@gmail.com'),(64,'PAX058','tranducquang@gmail.com'),(65,'PAX059','oliver.williams@gmail.co.uk'),(66,'PAX060','isabelle.laurent@gmail.fr'),(67,'PAX061','lethirang@gmail.com'),(68,'PAX062','phamvanson@gmail.com'),(69,'PAX063','zhangfang@163.com'),(70,'PAX064','aarav.sharma@gmail.in'),(71,'PAX065','vuthitrieu@gmail.com'),(72,'PAX066','dinhvanuy@gmail.com'),(73,'PAX067','thomas.nguyen@gmail.com'),(74,'PAX068','yui.tanaka@yahoo.co.jp'),(75,'PAX069','ngothivan@gmail.com'),(76,'PAX070','buivanxuyen@gmail.com'),(77,'PAX071','carlos.mendez@gmail.mx'),(78,'PAX072','hyun.jiho@daum.net'),(79,'PAX073','dothiy@gmail.com'),(80,'PAX074','trinhminhtuan@gmail.com'),(81,'PAX075','natasha.petrova@mail.ru'),(82,'PAX076','lyvanphat@gmail.com'),(83,'PAX077','mohamed.alfarsi@gmail.om'),(84,'PAX078','caothidieu@gmail.com'),(85,'PAX079','phanvanquyet@gmail.com'),(86,'PAX080','huynhthithien@gmail.com');
/*!40000 ALTER TABLE `passenger_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passenger_phone`
--

DROP TABLE IF EXISTS `passenger_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passenger_phone` (
  `Phone_ID` int NOT NULL AUTO_INCREMENT,
  `Passenger_ID` varchar(50) DEFAULT NULL,
  `Phone_Number` varchar(20) NOT NULL,
  PRIMARY KEY (`Phone_ID`),
  KEY `Passenger_ID` (`Passenger_ID`),
  CONSTRAINT `passenger_phone_ibfk_1` FOREIGN KEY (`Passenger_ID`) REFERENCES `passenger` (`Passenger_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger_phone`
--

LOCK TABLES `passenger_phone` WRITE;
/*!40000 ALTER TABLE `passenger_phone` DISABLE KEYS */;
INSERT INTO `passenger_phone` VALUES (1,'PAX001','0901234567'),(2,'PAX002','0912345678'),(3,'PAX002','0287654321'),(4,'PAX003','0923456789'),(5,'PAX004','0934567890'),(6,'PAX005','+14155550101'),(7,'PAX006','+447911123456'),(8,'PAX007','+819012345678'),(9,'PAX008','+821012345678'),(10,'PAX009','0945678901'),(11,'PAX010','0956789012'),(12,'PAX011','+8613812345678'),(13,'PAX012','+33612345678'),(14,'PAX013','0967890123'),(15,'PAX014','0978901234'),(16,'PAX015','0989012345'),(17,'PAX016','+60123456789'),(18,'PAX017','0990123456'),(19,'PAX018','0901234568'),(20,'PAX019','+4915123456789'),(21,'PAX020','0912345679'),(22,'PAX021','0913456780'),(23,'PAX022','0924567891'),(24,'PAX023','0935678902'),(25,'PAX023','0286543210'),(26,'PAX024','0946789013'),(27,'PAX025','+12125550102'),(28,'PAX026','+61412345678'),(29,'PAX027','+821198765432'),(30,'PAX028','+819087654321'),(31,'PAX029','+8613987654321'),(32,'PAX030','+393331234567'),(33,'PAX031','0957890124'),(34,'PAX032','0968901235'),(35,'PAX033','0979012346'),(36,'PAX034','0980123457'),(37,'PAX035','+447700900001'),(38,'PAX036','+4915209876543'),(39,'PAX037','+8613700000001'),(40,'PAX038','0901111222'),(41,'PAX039','0912222333'),(42,'PAX040','0923333444'),(43,'PAX041','+6591234567'),(44,'PAX042','+639171234567'),(45,'PAX043','+919876543210'),(46,'PAX044','+79161234567'),(47,'PAX045','0934444555'),(48,'PAX046','0945555666'),(49,'PAX047','0956666777'),(50,'PAX048','0967777888'),(51,'PAX049','0978888999'),(52,'PAX050','0989999000'),(53,'PAX051','+13235550103'),(54,'PAX052','+82109876543'),(55,'PAX053','+819011111111'),(56,'PAX054','+971501234567'),(57,'PAX055','0901122334'),(58,'PAX056','0912233445'),(59,'PAX057','0923344556'),(60,'PAX058','0934455667'),(61,'PAX059','+447911000001'),(62,'PAX060','+33698765432'),(63,'PAX061','0945566778'),(64,'PAX062','0956677889'),(65,'PAX063','+8618800000001'),(66,'PAX064','+919000000001'),(67,'PAX065','0967788990'),(68,'PAX066','0978899001'),(69,'PAX067','+14085550104'),(70,'PAX068','+819022222222'),(71,'PAX069','0989900112'),(72,'PAX070','0900011223'),(73,'PAX071','+5215512345678'),(74,'PAX072','+821034567890'),(75,'PAX073','0911122334'),(76,'PAX074','0922233445'),(77,'PAX075','+79261234567'),(78,'PAX076','0933344556'),(79,'PAX077','+96891234567'),(80,'PAX078','0944455667'),(81,'PAX079','0955566778'),(82,'PAX080','0966677889');
/*!40000 ALTER TABLE `passenger_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_log`
--

DROP TABLE IF EXISTS `security_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `security_log` (
  `Log_ID` int NOT NULL AUTO_INCREMENT,
  `Passenger_ID` varchar(50) DEFAULT NULL,
  `Screen_DateTime` datetime DEFAULT NULL,
  `Result` varchar(50) DEFAULT NULL,
  `Note` text,
  PRIMARY KEY (`Log_ID`),
  KEY `Passenger_ID` (`Passenger_ID`),
  CONSTRAINT `security_log_ibfk_1` FOREIGN KEY (`Passenger_ID`) REFERENCES `passenger` (`Passenger_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_log`
--

LOCK TABLES `security_log` WRITE;
/*!40000 ALTER TABLE `security_log` DISABLE KEYS */;
INSERT INTO `security_log` VALUES (1,'PAX001','2025-06-01 04:45:00','Clear',NULL),(2,'PAX002','2025-06-01 04:50:00','Clear',NULL),(3,'PAX003','2025-06-01 04:52:00','Alert','Flagged – secondary screening required'),(4,'PAX004','2025-06-01 06:20:00','Clear',NULL),(5,'PAX005','2025-06-01 06:30:00','Clear',NULL),(6,'PAX006','2025-06-01 11:00:00','Clear',NULL),(7,'PAX007','2025-06-01 06:35:00','Clear',NULL),(8,'PAX008','2025-06-01 09:00:00','Clear',NULL),(9,'PAX009','2025-06-01 06:25:00','Clear',NULL),(10,'PAX010','2025-06-01 08:00:00','Clear',NULL),(11,'PAX011','2025-06-01 06:40:00','Alert','Prohibited item detected'),(12,'PAX012','2025-06-01 09:05:00','Clear',NULL),(13,'PAX013','2025-06-01 08:05:00','Clear',NULL),(14,'PAX014','2025-06-01 05:05:00','Clear',NULL),(15,'PAX015','2025-06-01 11:40:00','Clear',NULL),(16,'PAX016','2025-06-01 11:45:00','Clear',NULL),(17,'PAX017','2025-06-01 05:10:00','Clear',NULL),(18,'PAX018','2025-06-01 06:40:00','Clear',NULL),(19,'PAX019','2025-06-01 14:30:00','Clear',NULL),(20,'PAX020','2025-06-01 06:45:00','Alert','Oversized carry-on'),(21,'PAX021','2025-06-02 04:45:00','Clear',NULL),(22,'PAX022','2025-06-02 04:50:00','Clear',NULL),(23,'PAX023','2025-06-02 06:20:00','Clear',NULL),(24,'PAX024','2025-06-02 06:25:00','Clear',NULL),(25,'PAX025','2025-06-02 06:30:00','Clear',NULL),(26,'PAX026','2025-06-02 13:00:00','Clear',NULL),(27,'PAX027','2025-06-02 06:35:00','Clear',NULL),(28,'PAX028','2025-06-02 09:00:00','Clear',NULL),(29,'PAX029','2025-06-02 06:40:00','Clear',NULL),(30,'PAX030','2025-06-02 13:05:00','Alert','Liquid over 100ml detected'),(31,'PAX031','2025-06-02 08:00:00','Clear',NULL),(32,'PAX032','2025-06-02 09:10:00','Clear',NULL),(33,'PAX033','2025-06-02 05:05:00','Clear',NULL),(34,'PAX034','2025-06-02 05:10:00','Clear',NULL),(35,'PAX035','2025-06-02 23:45:00','Clear',NULL),(36,'PAX036','2025-06-02 23:50:00','Clear',NULL),(37,'PAX037','2025-06-02 11:45:00','Clear',NULL),(38,'PAX038','2025-06-02 07:05:00','Clear',NULL),(39,'PAX039','2025-06-02 07:10:00','Clear',NULL),(40,'PAX040','2025-06-02 11:50:00','Alert','Metal object in bag – cleared after secondary check'),(41,'PAX041','2025-06-02 15:10:00','Clear',NULL),(42,'PAX042','2025-06-03 11:20:00','Clear',NULL),(43,'PAX043','2025-06-02 09:05:00','Clear',NULL),(44,'PAX044','2025-06-03 04:45:00','Clear',NULL),(45,'PAX045','2025-06-03 04:50:00','Clear',NULL),(46,'PAX046','2025-06-03 06:20:00','Clear',NULL),(47,'PAX047','2025-06-03 06:25:00','Clear',NULL),(48,'PAX048','2025-06-03 08:00:00','Clear',NULL),(49,'PAX049','2025-06-03 06:30:00','Clear',NULL),(50,'PAX050','2025-06-02 10:00:00','Clear',NULL),(51,'PAX051','2025-06-03 06:35:00','Alert','Passport irregularity – referred to immigration'),(52,'PAX052','2025-06-03 09:05:00','Clear',NULL),(53,'PAX053','2025-06-03 06:40:00','Clear',NULL),(54,'PAX054','2025-06-03 09:10:00','Clear',NULL),(55,'PAX055','2025-06-03 08:25:00','Clear',NULL),(56,'PAX056','2025-06-03 08:30:00','Clear',NULL),(57,'PAX057','2025-06-03 05:10:00','Clear',NULL),(58,'PAX058','2025-06-05 06:05:00','Clear',NULL),(59,'PAX059','2025-06-03 19:05:00','Clear',NULL),(60,'PAX060','2025-06-03 19:10:00','Clear',NULL),(61,'PAX061','2025-06-03 05:05:00','Clear',NULL),(62,'PAX062','2025-06-03 05:08:00','Clear',NULL),(63,'PAX063','2025-06-03 07:00:00','Clear',NULL),(64,'PAX064','2025-06-03 07:05:00','Clear',NULL),(65,'PAX065','2025-06-03 09:05:00','Clear',NULL),(66,'PAX066','2025-06-04 04:45:00','Clear',NULL),(67,'PAX067','2025-06-04 04:50:00','Alert','Random selection – secondary screening'),(68,'PAX068','2025-06-04 07:00:00','Clear',NULL),(69,'PAX069','2025-06-04 08:05:00','Clear',NULL),(70,'PAX070','2025-06-04 08:08:00','Clear',NULL),(71,'PAX071','2025-06-04 08:10:00','Clear',NULL),(72,'PAX072','2025-06-04 13:05:00','Clear',NULL),(73,'PAX073','2025-06-04 05:05:00','Clear',NULL),(74,'PAX074','2025-06-04 05:08:00','Clear',NULL),(75,'PAX075','2025-06-05 04:45:00','Clear',NULL),(76,'PAX076','2025-06-05 04:50:00','Clear',NULL),(77,'PAX077','2025-06-05 10:05:00','Clear',NULL),(78,'PAX078','2025-06-05 10:08:00','Alert','Restricted item – confiscated'),(79,'PAX079','2025-06-05 15:30:00','Clear',NULL),(80,'PAX080','2025-06-05 06:00:00','Clear',NULL);
/*!40000 ALTER TABLE `security_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_restricted_items`
--

DROP TABLE IF EXISTS `security_restricted_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `security_restricted_items` (
  `Item_ID` int NOT NULL AUTO_INCREMENT,
  `Log_ID` int DEFAULT NULL,
  `Item_Name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Item_ID`),
  KEY `Log_ID` (`Log_ID`),
  CONSTRAINT `security_restricted_items_ibfk_1` FOREIGN KEY (`Log_ID`) REFERENCES `security_log` (`Log_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_restricted_items`
--

LOCK TABLES `security_restricted_items` WRITE;
/*!40000 ALTER TABLE `security_restricted_items` DISABLE KEYS */;
INSERT INTO `security_restricted_items` VALUES (1,3,'Metal object (belt buckle)'),(2,11,'Lighter fluid'),(3,11,'Pocket knife > 6cm'),(4,20,'Oversized carry-on bag (62L)'),(5,30,'Water bottle 500ml (liquid > 100ml)'),(6,30,'Sunscreen tube 200ml'),(7,40,'Stainless steel thermos'),(8,51,'Expired visa document'),(9,67,'Electronic device without declaration'),(10,78,'Swiss army knife'),(11,78,'Gas lighter');
/*!40000 ALTER TABLE `security_restricted_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `Ticket_ID` varchar(50) NOT NULL,
  `Terminal` varchar(50) DEFAULT NULL,
  `Seat_Number` varchar(20) DEFAULT NULL,
  `Class` varchar(50) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Purchase_Date` datetime DEFAULT NULL,
  `Passenger_ID` varchar(50) DEFAULT NULL,
  `Flight_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Ticket_ID`),
  KEY `Passenger_ID` (`Passenger_ID`),
  KEY `Flight_ID` (`Flight_ID`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`Passenger_ID`) REFERENCES `passenger` (`Passenger_ID`),
  CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`Flight_ID`) REFERENCES `flight` (`Flight_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES ('TK001','T1','12A','Business',2500000.00,'2025-05-20 10:00:00','PAX001','FL001'),('TK002','T1','23B','Economy',1200000.00,'2025-05-21 14:00:00','PAX002','FL001'),('TK003','T1','24C','Economy',1200000.00,'2025-05-22 09:00:00','PAX003','FL001'),('TK004','T1','10D','Economy',900000.00,'2025-05-18 08:00:00','PAX004','FL002'),('TK005','T1','11E','Economy',900000.00,'2025-05-19 11:00:00','PAX009','FL002'),('TK006','T1','5A','Economy',1100000.00,'2025-05-25 07:30:00','PAX010','FL003'),('TK007','T1','5B','Economy',1100000.00,'2025-05-26 10:00:00','PAX013','FL003'),('TK008','T2','8A','Business',12000000.00,'2025-05-10 09:00:00','PAX005','FL006'),('TK009','T2','9B','Business',12000000.00,'2025-05-12 13:00:00','PAX007','FL006'),('TK010','T2','25C','Economy',5500000.00,'2025-05-15 16:00:00','PAX011','FL006'),('TK011','T2','7A','Business',11000000.00,'2025-05-14 10:00:00','PAX008','FL007'),('TK012','T2','28D','Economy',4800000.00,'2025-05-16 08:00:00','PAX012','FL007'),('TK013','T2','15C','Economy',3200000.00,'2025-05-22 11:00:00','PAX015','FL009'),('TK014','T2','16D','Economy',3200000.00,'2025-05-23 09:30:00','PAX016','FL009'),('TK015','T2','6B','Business',9500000.00,'2025-05-11 14:00:00','PAX019','FL010'),('TK016','T3','14A','Economy',1300000.00,'2025-05-23 10:00:00','PAX014','FL011'),('TK017','T3','15B','Economy',1300000.00,'2025-05-24 12:00:00','PAX017','FL011'),('TK018','T3','20C','Economy',850000.00,'2025-05-25 15:00:00','PAX018','FL012'),('TK019','T3','21D','Economy',850000.00,'2025-05-26 09:00:00','PAX020','FL012'),('TK020','T3','9C','Economy',1050000.00,'2025-05-27 08:00:00','PAX006','FL014'),('TK021','T1','13A','Business',2500000.00,'2025-05-25 10:00:00','PAX021','FL016'),('TK022','T1','25B','Economy',1200000.00,'2025-05-26 14:00:00','PAX022','FL016'),('TK023','T1','10A','Economy',900000.00,'2025-05-23 08:00:00','PAX023','FL017'),('TK024','T1','11B','Economy',900000.00,'2025-05-24 11:00:00','PAX024','FL017'),('TK025','T1','6A','Economy',1100000.00,'2025-05-28 07:30:00','PAX031','FL018'),('TK026','T2','8A','Business',12000000.00,'2025-05-15 09:00:00','PAX025','FL021'),('TK027','T2','9B','Business',12000000.00,'2025-05-17 13:00:00','PAX027','FL021'),('TK028','T2','26C','Economy',5500000.00,'2025-05-20 16:00:00','PAX029','FL021'),('TK029','T2','7A','Business',11000000.00,'2025-05-18 10:00:00','PAX028','FL022'),('TK030','T2','29D','Economy',4800000.00,'2025-05-20 08:00:00','PAX032','FL022'),('TK031','T2','5C','Business',15000000.00,'2025-05-10 10:00:00','PAX035','FL023'),('TK032','T2','30E','Economy',7000000.00,'2025-05-12 15:00:00','PAX036','FL023'),('TK033','T2','12A','Economy',2500000.00,'2025-05-24 09:00:00','PAX037','FL024'),('TK034','T2','13B','Economy',2500000.00,'2025-05-25 11:00:00','PAX040','FL024'),('TK035','T2','14C','Economy',3000000.00,'2025-05-26 14:00:00','PAX041','FL025'),('TK036','T3','15A','Economy',1300000.00,'2025-05-27 10:00:00','PAX033','FL026'),('TK037','T3','16B','Economy',1300000.00,'2025-05-28 12:00:00','PAX034','FL026'),('TK038','T3','22C','Economy',850000.00,'2025-05-29 15:00:00','PAX038','FL027'),('TK039','T3','23D','Economy',850000.00,'2025-05-30 09:00:00','PAX039','FL027'),('TK040','T3','10A','Economy',950000.00,'2025-05-29 08:00:00','PAX043','FL028'),('TK041','T1','14A','Business',2600000.00,'2025-05-28 10:00:00','PAX044','FL031'),('TK042','T1','26B','Economy',1250000.00,'2025-05-29 14:00:00','PAX045','FL031'),('TK043','T1','11A','Economy',920000.00,'2025-05-27 08:00:00','PAX046','FL032'),('TK044','T1','12B','Economy',920000.00,'2025-05-28 11:00:00','PAX047','FL032'),('TK045','T1','7A','Economy',1100000.00,'2025-05-30 07:30:00','PAX048','FL033'),('TK046','T2','9A','Business',12000000.00,'2025-05-18 09:00:00','PAX049','FL036'),('TK047','T2','10B','Business',12000000.00,'2025-05-20 13:00:00','PAX051','FL036'),('TK048','T2','27C','Economy',5500000.00,'2025-05-22 16:00:00','PAX053','FL036'),('TK049','T2','8A','Business',11000000.00,'2025-05-20 10:00:00','PAX052','FL037'),('TK050','T2','30D','Economy',4800000.00,'2025-05-22 08:00:00','PAX054','FL037'),('TK051','T2','15A','Economy',4000000.00,'2025-05-25 09:00:00','PAX055','FL038'),('TK052','T2','16B','Economy',4000000.00,'2025-05-26 11:00:00','PAX056','FL038'),('TK053','T2','6C','Business',18000000.00,'2025-05-12 14:00:00','PAX059','FL040'),('TK054','T2','31D','Economy',8500000.00,'2025-05-14 16:00:00','PAX060','FL040'),('TK055','T3','16A','Economy',1300000.00,'2025-05-29 10:00:00','PAX061','FL041'),('TK056','T3','17B','Economy',1300000.00,'2025-05-30 12:00:00','PAX062','FL041'),('TK057','T3','24C','Economy',870000.00,'2025-05-31 15:00:00','PAX063','FL042'),('TK058','T3','25D','Economy',870000.00,'2025-06-01 09:00:00','PAX064','FL042'),('TK059','T3','11A','Economy',960000.00,'2025-05-31 08:00:00','PAX065','FL043'),('TK060','T1','15A','Business',2500000.00,'2025-06-01 10:00:00','PAX066','FL046'),('TK061','T1','27B','Economy',1200000.00,'2025-06-02 14:00:00','PAX067','FL046'),('TK062','T1','12A','Economy',900000.00,'2025-06-02 08:00:00','PAX068','FL047'),('TK063','T2','10A','Business',13000000.00,'2025-05-20 09:00:00','PAX069','FL049'),('TK064','T2','11B','Business',13000000.00,'2025-05-22 13:00:00','PAX070','FL049'),('TK065','T2','28C','Economy',6000000.00,'2025-05-25 16:00:00','PAX071','FL049'),('TK066','T2','13A','Economy',2600000.00,'2025-06-01 09:00:00','PAX072','FL050'),('TK067','T3','17A','Economy',1300000.00,'2025-06-02 10:00:00','PAX073','FL051'),('TK068','T3','18B','Economy',1300000.00,'2025-06-03 12:00:00','PAX074','FL051'),('TK069','T1','16A','Business',2550000.00,'2025-06-03 10:00:00','PAX075','FL054'),('TK070','T1','28B','Economy',1220000.00,'2025-06-04 14:00:00','PAX076','FL054'),('TK071','T2','11A','Business',11500000.00,'2025-05-22 10:00:00','PAX077','FL056'),('TK072','T2','31D','Economy',5000000.00,'2025-05-24 08:00:00','PAX078','FL056'),('TK073','T2','15B','Economy',3000000.00,'2025-06-04 09:00:00','PAX079','FL057'),('TK074','T3','18A','Economy',1300000.00,'2025-06-04 10:00:00','PAX080','FL058'),('TK075','T1','30A','Economy',880000.00,'2025-05-22 08:00:00','PAX026','FL005'),('TK076','T1','31B','Economy',880000.00,'2025-05-23 11:00:00','PAX030','FL005'),('TK077','T3','26C','Economy',870000.00,'2025-05-31 09:00:00','PAX042','FL044'),('TK078','T2','32D','Economy',4200000.00,'2025-05-28 08:00:00','PAX043','FL038'),('TK079','T1','14C','Economy',1150000.00,'2025-06-02 08:00:00','PAX050','FL019'),('TK080','T3','19A','Economy',1280000.00,'2025-06-03 10:00:00','PAX058','FL058');
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-26 20:30:06
