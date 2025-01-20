-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: dcs_enrolled_students
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add student',7,'add_student'),(26,'Can change student',7,'change_student'),(27,'Can delete student',7,'delete_student'),(28,'Can view student',7,'view_student'),(29,'Can add subjects',8,'add_subjects'),(30,'Can change subjects',8,'change_subjects'),(31,'Can delete subjects',8,'delete_subjects'),(32,'Can view subjects',8,'view_subjects'),(33,'Can add subject',8,'add_subject'),(34,'Can change subject',8,'change_subject'),(35,'Can delete subject',8,'delete_subject'),(36,'Can view subject',8,'view_subject');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$870000$ZpVFvOMKaT4hCcilBT3aeG$tG+kr6JI6cQu6Y/wny4fzYVRrjKg+Ztxm5SLMMDUGJw=','2025-01-06 18:58:03.511971',1,'admin','','','',1,1,'2024-12-04 16:36:48.584264'),(2,'pbkdf2_sha256$870000$LXmmHSAYnyeGXMa8jEP72M$N2nTWkLTcYzpAxr79Y+4nkYnL1IDLdURgSigxkZXSZ8=','2024-12-28 10:51:29.440524',0,'baerted','Ted','Baer','luishagailcanonoy@gmail.com',0,1,'2024-12-28 10:43:20.569086'),(4,'pbkdf2_sha256$870000$0cyHSliOIDxJCX51x59465$M0bVIF98JAe4j5l1Dwn8gtD51M1hw02GLxyOmSK/HQs=','2025-01-06 18:55:27.525634',0,'kumaalii','Alii','Kuma','bebotcans@gmail.com',0,1,'2025-01-06 15:26:16.423905'),(5,'pbkdf2_sha256$870000$Ism3QETy41yaDijh9l1RD0$RmmmG7xxZ8TCG7JUcjAu/IT8IRavwheiKAdyR/C3r7Y=',NULL,0,'testzam','Zam','test','bebotcans@gmail.com',0,1,'2025-01-06 18:52:00.867163');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(7,'admin_dashboard','student'),(8,'admin_dashboard','subject'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-12-04 16:36:00.495115'),(2,'auth','0001_initial','2024-12-04 16:36:00.966091'),(3,'admin','0001_initial','2024-12-04 16:36:01.086860'),(4,'admin','0002_logentry_remove_auto_add','2024-12-04 16:36:01.098188'),(5,'admin','0003_logentry_add_action_flag_choices','2024-12-04 16:36:01.108504'),(6,'contenttypes','0002_remove_content_type_name','2024-12-04 16:36:01.178417'),(7,'auth','0002_alter_permission_name_max_length','2024-12-04 16:36:01.232669'),(8,'auth','0003_alter_user_email_max_length','2024-12-04 16:36:01.263688'),(9,'auth','0004_alter_user_username_opts','2024-12-04 16:36:01.271531'),(10,'auth','0005_alter_user_last_login_null','2024-12-04 16:36:01.316355'),(11,'auth','0006_require_contenttypes_0002','2024-12-04 16:36:01.319149'),(12,'auth','0007_alter_validators_add_error_messages','2024-12-04 16:36:01.329716'),(13,'auth','0008_alter_user_username_max_length','2024-12-04 16:36:01.386985'),(14,'auth','0009_alter_user_last_name_max_length','2024-12-04 16:36:01.440669'),(15,'auth','0010_alter_group_name_max_length','2024-12-04 16:36:01.461788'),(16,'auth','0011_update_proxy_permissions','2024-12-04 16:36:01.469317'),(17,'auth','0012_alter_user_first_name_max_length','2024-12-04 16:36:01.527373'),(18,'sessions','0001_initial','2024-12-04 16:36:01.565721'),(19,'admin_dashboard','0001_initial','2024-12-04 17:10:51.263633'),(20,'admin_dashboard','0002_student_user_alter_student_lastname_and_more','2024-12-28 10:39:56.970482'),(21,'admin_dashboard','0003_rename_subjects_subject','2024-12-30 05:31:51.304806'),(22,'admin_dashboard','0004_student_new_or_old','2024-12-30 06:33:24.365208');
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
INSERT INTO `django_session` VALUES ('k70z080mb1pg8ksba5trqrenxjzmyxss','.eJxVjEEOwiAQRe_C2hAY6lBcuvcMBJhBqoYmpV0Z7y5NutDte-__t_BhW4vfGi9-InERWpx-WQzpyXUX9Aj1Pss013WZotwTedgmbzPx63q0fwcltNLXAw-QozIaDTs00WgHOVmyxp6dSoq6JxxHRpUxcQAMGgxbyIzQufh8AcyHN04:1tJ0X3:XMcPmxl-MQHuxToyRMemLhLsY3sLOLYyzbJw7MCpkcY','2024-12-19 01:19:53.421490'),('qhvuoohofgtfibcmo96ty7wertfhw2pn','.eJxVjEEOwiAQRe_C2hAY6lBcuvcMBJhBqoYmpV0Z7y5NutDte-__t_BhW4vfGi9-InERWpx-WQzpyXUX9Aj1Pss013WZotwTedgmbzPx63q0fwcltNLXAw-QozIaDTs00WgHOVmyxp6dSoq6JxxHRpUxcQAMGgxbyIzQufh8AcyHN04:1tJ0Q7:lKv3-xIBlOkG-NC4XJKQfs7-YmTtOrrCQhFIz87NuK8','2024-12-19 01:12:43.002894'),('surmxxlk60qb90lspsqbdj7xvh4doy4j','.eJxVjEEOwiAQRe_C2hAY6lBcuvcMBJhBqoYmpV0Z7y5NutDte-__t_BhW4vfGi9-InERWpx-WQzpyXUX9Aj1Pss013WZotwTedgmbzPx63q0fwcltNLXAw-QozIaDTs00WgHOVmyxp6dSoq6JxxHRpUxcQAMGgxbyIzQufh8AcyHN04:1tSA0B:if7-v_YWWsts8Uo9CnF7Rl0EcqardSt-5BEBhT9HMPA','2025-01-13 07:15:47.886114'),('utx450l1lmm7yg68l3hbl5zxse25z0q8','.eJxVjEEOwiAQRe_C2hAY6lBcuvcMBJhBqoYmpV0Z7y5NutDte-__t_BhW4vfGi9-InERWpx-WQzpyXUX9Aj1Pss013WZotwTedgmbzPx63q0fwcltNLXAw-QozIaDTs00WgHOVmyxp6dSoq6JxxHRpUxcQAMGgxbyIzQufh8AcyHN04:1tLVd5:oB9OpKqwCcQE7Xho3Fs_bS9GaMOsH_5Rln1B2N07AuM','2024-12-25 22:56:27.236309'),('zjtw8xs5ncduv7cpzki84giwizjl07wo','.eJxVjEEOwiAQRe_C2hAY6lBcuvcMBJhBqoYmpV0Z7y5NutDte-__t_BhW4vfGi9-InERWpx-WQzpyXUX9Aj1Pss013WZotwTedgmbzPx63q0fwcltNLXAw-QozIaDTs00WgHOVmyxp6dSoq6JxxHRpUxcQAMGgxbyIzQufh8AcyHN04:1tUsId:bOxthBHzwFvUyoBSoMsoG-5mWVdrlmrcGtzPiDyUcO0','2025-01-20 18:58:03.517759');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
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
  `course` varchar(50) DEFAULT NULL,
  `sectionyear` int DEFAULT NULL,
  `section` int DEFAULT NULL,
  `major` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `new_or_old` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `students_studentnumber_65e99131_uniq` (`studentnumber`),
  CONSTRAINT `students_user_id_42864fc9_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'202400000','Luisha Gail','Canonoy','Zaballero','','2002-03-22','Female','luishagailcanonoy@gmail.com','09156561632','Blk 16 lot 44 lecaros st. woodsite 2 pasong buaya 2 imus cavite','3rd Year','BSCS',3,3,'Subject','regular',NULL,NULL),(2,'202400001','Ali','Canonoy','Zaballero','','2024-12-25','Male','ali@gmai.com','09132555123','Blk 16 lot 44 lecaros st. woodsite 2 pasong buaya 2 imus cavite','1st Year','BSCS',1,3,'','irregular',NULL,NULL),(3,'202400002','Ted','E','Baer','','2024-12-20','Female','luishagailcanonoy@gmail.com','09156561632','Blk 16 lot 44 lecaros st. woodsite 2 pasong buaya 2 imus cavite','3rd Year','BSCS',3,3,'','regular',2,NULL),(4,'202500003','Alii','Sainunb','Kuma','','2006-09-05','Female','bebotcans@gmail.com','09132555123','Blk 16 lot 44 lecaros st. woodsite 2 pasong buaya 2 imus cavite','1st Year','BSCS',1,1,NULL,'regular',4,'new'),(5,'202500004','Zam','Lesley','test','','2025-01-06','Male','bebotcans@gmail.com','09132555123','asd','2nd Year','BSCS',1,2,NULL,'regular',5,'new');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `course_code` varchar(50) DEFAULT NULL,
  `course_description` varchar(50) DEFAULT NULL,
  `subject_units_lec` int DEFAULT NULL,
  `subject_units_lab` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-07 19:08:22
