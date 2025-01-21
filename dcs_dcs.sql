-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: dcs_enroll
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin_dashboard_checklist`
--

DROP TABLE IF EXISTS `admin_dashboard_checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_dashboard_checklist` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `program_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_id` (`student_id`),
  KEY `admin_dashboard_chec_program_id_a521970f_fk_admin_das` (`program_id`),
  CONSTRAINT `admin_dashboard_chec_program_id_a521970f_fk_admin_das` FOREIGN KEY (`program_id`) REFERENCES `admin_dashboard_program` (`id`),
  CONSTRAINT `admin_dashboard_checklist_student_id_499dd439_fk_auth_user_id` FOREIGN KEY (`student_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_dashboard_checklist`
--

LOCK TABLES `admin_dashboard_checklist` WRITE;
/*!40000 ALTER TABLE `admin_dashboard_checklist` DISABLE KEYS */;
INSERT INTO `admin_dashboard_checklist` VALUES (1,2,2),(2,3,1);
/*!40000 ALTER TABLE `admin_dashboard_checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_dashboard_checklistitem`
--

DROP TABLE IF EXISTS `admin_dashboard_checklistitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_dashboard_checklistitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `grade` double DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `semester` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  `checklist_id` bigint NOT NULL,
  `instructor_id` bigint DEFAULT NULL,
  `subject_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_dashboard_chec_checklist_id_5834ee8c_fk_admin_das` (`checklist_id`),
  KEY `admin_dashboard_chec_instructor_id_6485d0ff_fk_admin_das` (`instructor_id`),
  KEY `admin_dashboard_chec_subject_id_b5763318_fk_admin_das` (`subject_id`),
  CONSTRAINT `admin_dashboard_chec_checklist_id_5834ee8c_fk_admin_das` FOREIGN KEY (`checklist_id`) REFERENCES `admin_dashboard_checklist` (`id`),
  CONSTRAINT `admin_dashboard_chec_instructor_id_6485d0ff_fk_admin_das` FOREIGN KEY (`instructor_id`) REFERENCES `admin_dashboard_instructor` (`id`),
  CONSTRAINT `admin_dashboard_chec_subject_id_b5763318_fk_admin_das` FOREIGN KEY (`subject_id`) REFERENCES `admin_dashboard_subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_dashboard_checklistitem`
--

LOCK TABLES `admin_dashboard_checklistitem` WRITE;
/*!40000 ALTER TABLE `admin_dashboard_checklistitem` DISABLE KEYS */;
INSERT INTO `admin_dashboard_checklistitem` VALUES (1,NULL,'Pending',1,1,1,NULL,15),(2,NULL,'Pending',1,1,1,NULL,16),(3,NULL,'Pending',1,1,1,NULL,17),(4,NULL,'Pending',1,1,1,NULL,18),(5,NULL,'Pending',1,1,1,NULL,12),(6,NULL,'Pending',1,1,1,NULL,13),(7,NULL,'Pending',1,1,1,NULL,14),(8,NULL,'Pending',1,1,1,NULL,19),(9,NULL,'Pending',1,1,1,NULL,20),(10,NULL,'Pending',1,1,2,NULL,68),(11,NULL,'Pending',1,1,2,NULL,73),(12,NULL,'Pending',1,1,2,NULL,69),(13,NULL,'Pending',1,1,2,NULL,70),(14,NULL,'Pending',1,1,2,NULL,71),(15,NULL,'Pending',1,1,2,NULL,65),(16,NULL,'Pending',1,1,2,NULL,66),(17,NULL,'Pending',1,1,2,NULL,67),(18,NULL,'Pending',1,1,2,NULL,72);
/*!40000 ALTER TABLE `admin_dashboard_checklistitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_dashboard_instructor`
--

DROP TABLE IF EXISTS `admin_dashboard_instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_dashboard_instructor` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `contact` varchar(15) DEFAULT NULL,
  `address` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_dashboard_instructor`
--

LOCK TABLES `admin_dashboard_instructor` WRITE;
/*!40000 ALTER TABLE `admin_dashboard_instructor` DISABLE KEYS */;
INSERT INTO `admin_dashboard_instructor` VALUES (1,'Faculty A','F','facultya@gmail.com','',''),(2,'Faculty B','M','facultyb@gmail.com','','');
/*!40000 ALTER TABLE `admin_dashboard_instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_dashboard_program`
--

DROP TABLE IF EXISTS `admin_dashboard_program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_dashboard_program` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `full` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_dashboard_program`
--

LOCK TABLES `admin_dashboard_program` WRITE;
/*!40000 ALTER TABLE `admin_dashboard_program` DISABLE KEYS */;
INSERT INTO `admin_dashboard_program` VALUES (1,'BSCS','Bachelor of Science in Computer Science'),(2,'BSIT','Bachelor of Science in Information Technology');
/*!40000 ALTER TABLE `admin_dashboard_program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_dashboard_school_fees`
--

DROP TABLE IF EXISTS `admin_dashboard_school_fees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_dashboard_school_fees` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `school_fee_name` varchar(50) DEFAULT NULL,
  `school_fee_value` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_dashboard_school_fees`
--

LOCK TABLES `admin_dashboard_school_fees` WRITE;
/*!40000 ALTER TABLE `admin_dashboard_school_fees` DISABLE KEYS */;
INSERT INTO `admin_dashboard_school_fees` VALUES (1,'reg_fee',55.00),(2,'insurance',25.00),(3,'id',100.00),(4,'sfdf',1500.00),(5,'srf',2025.00),(6,'misc',435.00),(7,'athletics',100.00),(8,'scuaa',100.00),(9,'library_fee',50.00),(10,'lab_fees',800.00),(11,'other_fees',80.00),(12,'late_reg',80.00),(13,'tuition_fee',175.00),(14,'nstp_fee',300.00);
/*!40000 ALTER TABLE `admin_dashboard_school_fees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_dashboard_student`
--

DROP TABLE IF EXISTS `admin_dashboard_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_dashboard_student` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `studentnumber` varchar(100) DEFAULT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `middlename` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `suffix` varchar(100) DEFAULT NULL,
  `dateofbirth` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `year` varchar(50) DEFAULT NULL,
  `sectionyear` varchar(50) DEFAULT NULL,
  `section` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `new_or_old` varchar(50) DEFAULT NULL,
  `course_id` bigint DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `admin_dashboard_stud_course_id_7fd02908_fk_admin_das` (`course_id`),
  CONSTRAINT `admin_dashboard_stud_course_id_7fd02908_fk_admin_das` FOREIGN KEY (`course_id`) REFERENCES `admin_dashboard_program` (`id`),
  CONSTRAINT `admin_dashboard_student_user_id_b8276749_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_dashboard_student`
--

LOCK TABLES `admin_dashboard_student` WRITE;
/*!40000 ALTER TABLE `admin_dashboard_student` DISABLE KEYS */;
INSERT INTO `admin_dashboard_student` VALUES (1,'202500001','Marianne Shaine','','Canonoy','','2006-09-05','Female','bebotcans@gmail.com','09199999999','Blk 16 lot 44 lecaros st. woodsite 2 pasong buaya 2 imus cavite','1st Year','1','1','Regular','New',2,2),(2,'202211878','Luisha Gail','','Zaballero','','2002-03-22','Female','bc.luishagail.zaballero@cvsu.edu.ph','09623052769','Blk 16 lot 44 lecaros st. woodsite 2 pasong buaya 2 imus cavite','3rd Year','3','3','Regular','Old',1,3);
/*!40000 ALTER TABLE `admin_dashboard_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_dashboard_subject`
--

DROP TABLE IF EXISTS `admin_dashboard_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_dashboard_subject` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `course_code` varchar(10) DEFAULT NULL,
  `course_title` varchar(100) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `semester` int DEFAULT NULL,
  `subject_units_lec` int DEFAULT NULL,
  `subject_units_lab` int DEFAULT NULL,
  `program_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_dashboard_subj_program_id_d9bf0613_fk_admin_das` (`program_id`),
  CONSTRAINT `admin_dashboard_subj_program_id_d9bf0613_fk_admin_das` FOREIGN KEY (`program_id`) REFERENCES `admin_dashboard_program` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_dashboard_subject`
--

LOCK TABLES `admin_dashboard_subject` WRITE;
/*!40000 ALTER TABLE `admin_dashboard_subject` DISABLE KEYS */;
INSERT INTO `admin_dashboard_subject` VALUES (12,'GNED 02','Ethics',1,1,3,0,2),(13,'GNED 05','Purposive Communication',1,1,3,0,2),(14,'GNED 11','Kontekstwalisadong Komunikasyon sa Filipino',1,1,3,0,2),(15,'COSC 50','Discrete Structure',1,1,3,0,2),(16,'DCIT 21','Introduction to Computing',1,1,2,1,2),(17,'DCIT 22','Computer Programming 1',1,1,1,2,2),(18,'FITT 1','Movement Enhancement',1,1,2,0,2),(19,'NSTP 1','National Service Training Program 1',1,1,3,0,2),(20,'ORNT 1','Institutional Orientation',1,1,1,0,2),(21,'GNED 01','Arts Appreciation',1,2,3,0,2),(22,'GNED 06','Science, Technology and Society',1,2,3,0,2),(23,'GNED 12','Dalumat Ng/Sa Filipino',1,2,3,0,2),(24,'GNED 03','Mathematics in the Modern World',1,2,3,0,2),(25,'DCIT 23','Computer Programming 2',1,2,1,2,2),(26,'ITEC 50','Web System and Technologies 1',1,2,2,1,2),(27,'FITT 2','Fitness Exercise',1,2,2,0,2),(28,'NSTP 2','National Service Training Program 2',1,2,3,0,2),(29,'GNED 04','Mga Babasahin Hinggil sa Kasaysayan ng Pilipinas',2,1,3,0,2),(30,'GNED 07','The Contemporary World',2,1,3,0,2),(31,'GNED 10','Gender and Society',2,1,3,0,2),(32,'GNED 14','Panitikang Panlipunan',2,1,3,0,2),(33,'ITEC 55','Platform Technologies',2,1,2,1,2),(34,'DCIT 24','Information Management',2,1,2,1,2),(35,'DCIT 50','Object Oriented Programming',2,1,2,1,2),(36,'FITT 3','Physical Activities towards Health and Fitness I',2,1,2,0,2),(37,'GNED 08','Understanding the Self',2,2,3,0,2),(38,'DCIT 25','Data Structures and Algorithms',2,2,2,1,2),(39,'ITEC 60','Integrated Programming and Technologies 1',2,2,2,1,2),(40,'ITEC 65','Open Source Technology',2,2,2,1,2),(41,'DCIT 55','Advanced Database System',2,2,2,1,2),(42,'ITEC 70','Multimedia Systems',2,2,2,1,2),(43,'FITT 4','Physical Activities towards Health and Fitness  II',2,2,2,0,2),(44,'ITEC 80','Introduction to Human Computer Interaction',3,1,2,1,2),(45,'STAT 2','Applied Statistics',2,3,3,0,2),(46,'ITEC 75','System Integration and Architecture 1',2,3,2,1,2),(47,'ITEC 85','Information Assurance and Security 1',3,1,2,1,2),(48,'ITEC 90','Network Fundamentals',3,1,2,1,2),(49,'INSY 55','System Analysis and Design',3,1,2,1,2),(50,'DCIT 26','Application Development and Emerging Technologies',3,1,2,1,2),(51,'DCIT 60','Methods of Research',3,1,3,0,2),(52,'GNED 09','Rizal: Life, Works, and Writings',3,2,3,0,2),(53,'ITEC 95','Quantitative Methods (Modeling & Simulation)',3,2,3,0,2),(54,'ITEC 101','IT ELECTIVE 1 (Human Computer Interaction 2)',3,2,2,1,2),(55,'ITEC 106','IT ELECTIVE 2 (Web System and Technologies 2)',3,2,2,1,2),(56,'ITEC 100','Information Assurance and Security 2',3,2,2,1,2),(57,'ITEC 105','Network Management',3,2,2,1,2),(58,'ITEC 200A','Capstone Project and Research 1',3,2,3,0,2),(59,'DCIT 65','Social and Professional Issues',4,1,3,0,2),(60,'ITEC 111','IT ELECTIVE 3 (Integrated Programming and Technologies 2)',4,1,2,1,2),(61,'ITEC 116','IT ELECTIVE 4 (Systems Integration and Architecture 2)',4,1,2,1,2),(62,'ITEC 110','Systems Administration and Maintenance',4,1,2,1,2),(63,'ITEC 200B','Capstone Project and Research 2',4,1,3,0,2),(64,'ITEC 199','Practicum (minimum 486 hours)',4,2,6,0,2),(65,'GNED 02','Ethics',1,1,3,0,1),(66,'GNED 05','Purposive Communication',1,1,3,0,1),(67,'GNED 11','Kontekstwalisadong Komunikasyon sa Filipino',1,1,3,0,1),(68,'COSC 50','Discrete Structure I',1,1,3,0,1),(69,'DCIT 21','Introduction to Computing',1,1,2,1,1),(70,'DCIT 22','Computer Programming 1',1,1,1,2,1),(71,'FITT 1','Movement Enhancement',1,1,2,0,1),(72,'NSTP 1','National Service Training Program 1',1,1,3,0,1),(73,'CVSU 101','Institutional Orientation',1,1,1,0,1),(74,'GNED 01','Arts Appreciation',1,2,3,0,1),(75,'GNED 03','Mathematics in the Modern World',1,2,3,0,1),(76,'GNED 06','Science, Technology and Society',1,2,3,0,1),(77,'GNED 12','Dalumat Ng/Sa Filipino',1,2,3,0,1),(78,'DCIT 23','Computer Programming 2',1,2,1,2,1),(79,'ITEC 50','Web System and Technologies 1',1,2,2,1,1),(80,'FITT 2','Fitness Exercise',1,2,2,0,1),(81,'NSTP 2','National Service Training Program 2',1,2,3,0,1),(82,'GNED 04','Mga Babasahin Hinggil sa Kasaysayan ng Pilipinas',2,1,3,0,1),(83,'MATH 1','Analytic Geometry',2,1,3,0,1),(84,'COSC 55','Discrete Structure II',2,1,3,0,1),(85,'COSC 60','Digital Logic Design',2,1,2,1,1),(86,'DCIT 50','Object Oriented Programming',2,1,2,1,1),(87,'DCIT 24','Information Management',2,1,2,1,1),(88,'INSY 50','Fundamentals of Information Systems',2,1,3,0,1),(89,'FITT 3','Physical Activities towards Health and Fitness I',2,1,2,0,1),(90,'GNED 08','Understanding the Self',2,2,3,0,1),(91,'GNED 14','Panitikang Panlipunan',2,2,3,0,1),(92,'MATH 2','Calculus',2,2,3,0,1),(93,'COSC 65','Architecture and Organization',2,2,2,1,1),(94,'COSC 70','Software Engineering I',2,2,3,0,1),(95,'DCIT 25','Data Structures and Algorithms',2,2,2,1,1),(96,'DCIT 55','Advanced Database Management System',2,2,2,1,1),(97,'FITT 4','Physical Activities towards Health and Fitness  II',2,2,2,0,1),(98,'MATH 3','Linear Algebra',3,1,3,0,1),(99,'COSC 75','Software Engineering II',3,1,2,1,1),(100,'COSC 80','Operating Systems',3,1,2,1,1),(101,'COSC 85','Networks and Communications',3,1,2,1,1),(102,'COSC 101','CS Elective 1 (Computer Graphics and Visual Computing)',3,1,2,1,1),(103,'DCIT 26','Application Development and Emerging Technologies',3,1,2,1,1),(104,'DCIT 65','Social and Professional Issues',3,1,3,0,1),(105,'GNED 09','Life and Works of Rizal',3,2,3,0,1),(106,'MATH 4','Experimental Statistics',3,2,2,1,1),(107,'COSC 90','Design and Analysis of Algorithm',3,2,3,0,1),(108,'COSC 95','Programming Languages',3,2,3,0,1),(109,'COSC 106','CS Elective 2 (Introduction to Game Development)',3,2,2,1,1),(110,'DCIT 60','Methods of Research',3,2,2,1,1),(111,'ITEC 85','Information Assurance and Security',3,2,3,0,1),(112,'COSC 199','Practicum (minimum 240 hours)',3,3,3,0,1),(113,'ITEC 80','Human Computer Interaction',4,1,1,0,1),(114,'COSC 100','Automata Theory and Formal Languages',4,1,3,0,1),(115,'COSC 105','Intelligent Systems',4,1,2,1,1),(116,'COSC 111','CS Elective 3 (Internet Of Things)',4,1,2,1,1),(117,'COSC 200A','Undergraduate Thesis 1',4,1,3,0,1),(118,'GNED 07','The Contemporary World',4,2,3,0,1),(119,'GNED 10','Gender and Society',4,2,3,0,1),(120,'COSC 110','Numerical and Symbolic Computation',4,2,2,1,1),(121,'COSC 200B','Undergraduate Thesis 2',4,2,3,0,1);
/*!40000 ALTER TABLE `admin_dashboard_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_dashboard_subject_prerequisite`
--

DROP TABLE IF EXISTS `admin_dashboard_subject_prerequisite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_dashboard_subject_prerequisite` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `from_subject_id` bigint NOT NULL,
  `to_subject_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_dashboard_subject__from_subject_id_to_subje_f30b926b_uniq` (`from_subject_id`,`to_subject_id`),
  KEY `admin_dashboard_subj_to_subject_id_020cdc71_fk_admin_das` (`to_subject_id`),
  CONSTRAINT `admin_dashboard_subj_from_subject_id_766ba0c2_fk_admin_das` FOREIGN KEY (`from_subject_id`) REFERENCES `admin_dashboard_subject` (`id`),
  CONSTRAINT `admin_dashboard_subj_to_subject_id_020cdc71_fk_admin_das` FOREIGN KEY (`to_subject_id`) REFERENCES `admin_dashboard_subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_dashboard_subject_prerequisite`
--

LOCK TABLES `admin_dashboard_subject_prerequisite` WRITE;
/*!40000 ALTER TABLE `admin_dashboard_subject_prerequisite` DISABLE KEYS */;
INSERT INTO `admin_dashboard_subject_prerequisite` VALUES (1,25,17),(2,26,16),(3,27,18),(4,28,19),(5,33,25),(6,34,25),(7,35,25),(8,38,35),(9,39,26),(10,39,35),(11,41,34),(12,46,39),(13,47,46),(14,48,33),(15,50,41),(16,52,29),(18,53,15),(17,53,45),(19,54,44),(20,55,26),(21,56,47),(22,57,48),(25,58,47),(23,58,50),(24,58,51),(26,60,39),(27,61,46),(28,62,56),(29,63,58),(31,64,47),(30,64,50),(32,77,67),(33,78,70),(34,79,69),(35,80,71),(36,81,72),(37,83,75),(38,84,68),(39,85,68),(40,85,78),(41,86,78),(42,87,78),(43,88,69),(44,89,71),(45,92,83),(46,93,85),(47,94,86),(48,94,87),(49,95,78),(50,96,87),(51,97,71),(52,98,92),(53,99,94),(54,100,95),(55,101,79),(56,102,78),(57,103,79),(58,105,82),(59,106,92),(60,107,95),(61,108,95),(62,109,98),(63,109,102),(64,111,87),(65,113,111),(66,114,107),(68,115,84),(69,115,86),(67,115,106),(70,116,85),(71,120,85);
/*!40000 ALTER TABLE `admin_dashboard_subject_prerequisite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add school_fees',7,'add_school_fees'),(26,'Can change school_fees',7,'change_school_fees'),(27,'Can delete school_fees',7,'delete_school_fees'),(28,'Can view school_fees',7,'view_school_fees'),(29,'Can add subject',8,'add_subject'),(30,'Can change subject',8,'change_subject'),(31,'Can delete subject',8,'delete_subject'),(32,'Can view subject',8,'view_subject'),(33,'Can add checklist item',9,'add_checklistitem'),(34,'Can change checklist item',9,'change_checklistitem'),(35,'Can delete checklist item',9,'delete_checklistitem'),(36,'Can view checklist item',9,'view_checklistitem'),(37,'Can add program',10,'add_program'),(38,'Can change program',10,'change_program'),(39,'Can delete program',10,'delete_program'),(40,'Can view program',10,'view_program'),(41,'Can add checklist',11,'add_checklist'),(42,'Can change checklist',11,'change_checklist'),(43,'Can delete checklist',11,'delete_checklist'),(44,'Can view checklist',11,'view_checklist'),(45,'Can add instructor',12,'add_instructor'),(46,'Can change instructor',12,'change_instructor'),(47,'Can delete instructor',12,'delete_instructor'),(48,'Can view instructor',12,'view_instructor'),(49,'Can add student',13,'add_student'),(50,'Can change student',13,'change_student'),(51,'Can delete student',13,'delete_student'),(52,'Can view student',13,'view_student');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$870000$6mIHx3RTUJVSShaIDo5hEx$+AaLKlqKOQfuJ+PmUgQwUCglYH+ockfo9WbHK/6TVI0=','2025-01-20 07:09:10.395880',1,'admin','','','enrollmentdcsnoreply@gmail.com',1,1,'2025-01-20 02:18:33.969468'),(2,'pbkdf2_sha256$870000$pmyc1Ah7LlzVjIX1dcHaW3$KIBDyva+jmBlCC1bZkrCovNG8fq4HZbuEAc1wIJtAQs=',NULL,0,'canonoymarianneshaine','Marianne Shaine','Canonoy','bebotcans@gmail.com',0,1,'2025-01-20 02:41:15.289050'),(3,'pbkdf2_sha256$870000$0cAboe8yCmSroqOTfwrHUS$ELAIPQrJgUHfPIP9T/n9oX4L7Ami/Xfw9Qc8rQEZlEA=',NULL,0,'zaballeroluishagail','Luisha Gail','Zaballero','bc.luishagail.zaballero@cvsu.edu.ph',0,1,'2025-01-20 07:37:05.130816');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-01-20 02:19:58.896302','1','BSCS - Bachelor of Science in Computer Science',1,'[{\"added\": {}}]',10,1),(2,'2025-01-20 02:20:05.470901','2','BSIT - ',1,'[{\"added\": {}}]',10,1),(3,'2025-01-20 02:20:16.831613','2','BSIT - Bachelor of Science in Information Technology',2,'[{\"changed\": {\"fields\": [\"Full\"]}}]',10,1),(4,'2025-01-20 07:25:50.564651','1','school_fees object (1)',1,'[{\"added\": {}}]',7,1),(5,'2025-01-20 07:26:00.384825','2','school_fees object (2)',1,'[{\"added\": {}}]',7,1),(6,'2025-01-20 07:26:07.143372','3','school_fees object (3)',1,'[{\"added\": {}}]',7,1),(7,'2025-01-20 07:26:20.390205','4','school_fees object (4)',1,'[{\"added\": {}}]',7,1),(8,'2025-01-20 07:26:30.870468','5','school_fees object (5)',1,'[{\"added\": {}}]',7,1),(9,'2025-01-20 07:26:37.641936','6','school_fees object (6)',1,'[{\"added\": {}}]',7,1),(10,'2025-01-20 07:26:51.286325','7','school_fees object (7)',1,'[{\"added\": {}}]',7,1),(11,'2025-01-20 07:26:58.483531','8','school_fees object (8)',1,'[{\"added\": {}}]',7,1),(12,'2025-01-20 07:27:05.999311','9','school_fees object (9)',1,'[{\"added\": {}}]',7,1),(13,'2025-01-20 07:27:18.479698','10','school_fees object (10)',1,'[{\"added\": {}}]',7,1),(14,'2025-01-20 07:27:31.359598','11','school_fees object (11)',1,'[{\"added\": {}}]',7,1),(15,'2025-01-20 07:27:40.495345','12','school_fees object (12)',1,'[{\"added\": {}}]',7,1),(16,'2025-01-20 07:28:03.603384','13','school_fees object (13)',1,'[{\"added\": {}}]',7,1),(17,'2025-01-20 07:28:10.140684','14','school_fees object (14)',1,'[{\"added\": {}}]',7,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(11,'admin_dashboard','checklist'),(9,'admin_dashboard','checklistitem'),(12,'admin_dashboard','instructor'),(10,'admin_dashboard','program'),(7,'admin_dashboard','school_fees'),(13,'admin_dashboard','student'),(8,'admin_dashboard','subject'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-01-20 02:03:07.075598'),(2,'auth','0001_initial','2025-01-20 02:03:08.245038'),(3,'admin','0001_initial','2025-01-20 02:03:08.514349'),(4,'admin','0002_logentry_remove_auto_add','2025-01-20 02:03:08.529273'),(5,'admin','0003_logentry_add_action_flag_choices','2025-01-20 02:03:08.546629'),(6,'contenttypes','0002_remove_content_type_name','2025-01-20 02:03:08.706407'),(7,'auth','0002_alter_permission_name_max_length','2025-01-20 02:03:08.852468'),(8,'auth','0003_alter_user_email_max_length','2025-01-20 02:03:08.910973'),(9,'auth','0004_alter_user_username_opts','2025-01-20 02:03:08.926232'),(10,'auth','0005_alter_user_last_login_null','2025-01-20 02:03:09.079066'),(11,'auth','0006_require_contenttypes_0002','2025-01-20 02:03:09.083046'),(12,'auth','0007_alter_validators_add_error_messages','2025-01-20 02:03:09.096827'),(13,'auth','0008_alter_user_username_max_length','2025-01-20 02:03:09.278403'),(14,'auth','0009_alter_user_last_name_max_length','2025-01-20 02:03:09.429048'),(15,'auth','0010_alter_group_name_max_length','2025-01-20 02:03:09.481729'),(16,'auth','0011_update_proxy_permissions','2025-01-20 02:03:09.497512'),(17,'auth','0012_alter_user_first_name_max_length','2025-01-20 02:03:09.665413'),(18,'sessions','0001_initial','2025-01-20 02:03:09.737528'),(19,'admin_dashboard','0001_initial','2025-01-20 02:13:27.921235');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('d77ur2hk0t922wv00yln7vrkdtwc0o2g','.eJxVjMEOwiAQRP-FsyG7BQp49N5vIAtLpWpoUtqT8d9tkx70OPPezFsE2tYStpaXMLG4ChSX3y5SeuZ6AH5Qvc8yzXVdpigPRZ60yWHm_Lqd7t9BoVb2tel9BrDgFTtnCVGhHr33JlLWVivXpaTZgsI9c5fiiK43JgIwKSYnPl-1yDc9:1tZhd3:qwkGISHCteBFU1LtX730tfaSpvtw6e5XhfNst-2Ag0U','2025-02-03 02:35:05.253581'),('p12ijg05wwfqfwgc4wchjbxl8yk5u3qx','.eJxVjMEOwiAQRP-FsyG7BQp49N5vIAtLpWpoUtqT8d9tkx70OPPezFsE2tYStpaXMLG4ChSX3y5SeuZ6AH5Qvc8yzXVdpigPRZ60yWHm_Lqd7t9BoVb2tel9BrDgFTtnCVGhHr33JlLWVivXpaTZgsI9c5fiiK43JgIwKSYnPl-1yDc9:1tZluI:1a49uKhlDRF7dc4r8leb2qrfJuMPYM9rQfq3TVEDEm8','2025-02-03 07:09:10.409321');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-20 17:25:15
