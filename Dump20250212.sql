-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: pdf
-- ------------------------------------------------------
-- Server version	8.0.33

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
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add mp3',7,'add_mp3'),(26,'Can change mp3',7,'change_mp3'),(27,'Can delete mp3',7,'delete_mp3'),(28,'Can view mp3',7,'view_mp3'),(29,'Can add pdf',8,'add_pdf'),(30,'Can change pdf',8,'change_pdf'),(31,'Can delete pdf',8,'delete_pdf'),(32,'Can view pdf',8,'view_pdf'),(33,'Can add profile',9,'add_profile'),(34,'Can change profile',9,'change_profile'),(35,'Can delete profile',9,'delete_profile'),(36,'Can view profile',9,'view_profile'),(37,'Can add m p3 file',7,'add_mp3file'),(38,'Can change m p3 file',7,'change_mp3file'),(39,'Can delete m p3 file',7,'delete_mp3file'),(40,'Can view m p3 file',7,'view_mp3file'),(41,'Can add pdf file',8,'add_pdffile'),(42,'Can change pdf file',8,'change_pdffile'),(43,'Can delete pdf file',8,'delete_pdffile'),(44,'Can view pdf file',8,'view_pdffile'),(45,'Can add user activity',10,'add_useractivity'),(46,'Can change user activity',10,'change_useractivity'),(47,'Can delete user activity',10,'delete_useractivity'),(48,'Can view user activity',10,'view_useractivity');
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$870000$2bg63o2O6GkZLHinLd5mFw$IPBavDOnEYfHHAccUMcJ0SSrtQSiCRRxPwZB/tLXSR8=','2025-01-05 08:46:05.597081',1,'suderson','','','suderson@gmail.com',1,1,'2025-01-03 05:45:18.422151'),(2,'pbkdf2_sha256$870000$8H3aEnETIDG09ZcbqbcDe0$ZpRdON2LpxnsJAan6fYK7+m0J9hIIb5oYCUMAK6WRCE=',NULL,0,'vikram','','','',0,1,'2025-01-03 07:37:47.529637'),(3,'pbkdf2_sha256$870000$yeF7joStyncxfGSJTmdR0G$pd3BU7C6tLb79GAsM7av1XrXAZu5JI8tjX5mImnlgdk=',NULL,0,'dhonikoli','dhoni','kholi','pomaro2945@hapied.com',0,1,'2025-01-03 07:57:45.288404'),(4,'pbkdf2_sha256$870000$Z7wm0tJLIqElQDVmgBpkIO$OLbq+0iLnVFd5IiI7LKtQmR9UsWiq5uLcIoCTJdy3nI=','2025-01-03 08:05:45.856646',0,'rs12','raina','suresh','rs12@gmail.com',0,1,'2025-01-03 08:05:29.808842'),(5,'pbkdf2_sha256$870000$1Gl4wm2CLmYitdXbyevU9e$ViK9OnyA2Nj5JTpalkwcoGwnGr0Dcp9sotcDM09XDdU=','2025-01-04 02:30:26.283262',0,'bharghaviravi','bharghavi','ravi shankar','pomaro2945@hapied.com',0,1,'2025-01-04 02:29:42.933264'),(6,'pbkdf2_sha256$870000$2dQY8L5A9H9pegA7m2iTft$RpZUg/BBoLqEKPGVckw2khcTy7XPgnmmH8v9PJDQthY=','2025-01-04 03:20:33.102099',0,'abinaya','abinaya','V','haridossabinaya@gmail.com',0,1,'2025-01-04 03:20:00.713211'),(7,'pbkdf2_sha256$870000$HHFQwasaKW2im25w89MKW5$mZ+UbeBFhFHoA0CnyyUIT4M4/ZgsvNaCU8sBZiWgt+Q=',NULL,0,'ragav','harish','ragav','harishragav963@gmail.com',0,1,'2025-01-04 06:34:23.502495'),(8,'pbkdf2_sha256$870000$3kslM9J23QPdAq9KU7Sxo0$mO+wjWUQePxKUch4bxDnA5vT7ua1GVrTWceC/uafcAk=',NULL,0,'mk','mohan','s','mohankarthiksundarrajan@gmail.com',0,1,'2025-01-04 07:27:21.861616'),(9,'pbkdf2_sha256$870000$YaxTopx5pGvSib35SZwAMM$ioAxL/xqoVXWmxeROntcOYU+n8o5r4tU4bEDfAA4xik=','2025-02-04 09:12:14.087539',0,'issac_netwon','issac','newton','m.vishnusuderson@gmail.com',0,1,'2025-01-05 14:26:33.708454'),(10,'pbkdf2_sha256$870000$fdM4IU6uHMTWZkP6zqx8Ef$gGad+8QOkmgWYIpuC/qaaIuCfJhIhgkvlXPUylYkyVY=','2025-01-06 06:06:15.151745',0,'siu','Merwin','S','merwins2004@gmail.com',0,1,'2025-01-06 02:33:30.240317'),(11,'pbkdf2_sha256$870000$TKBvzaumDYKnwRLHCWXsQh$ONToVREZWBzS2AtJsPGtb+hL10C2ZPU0XnnZtgxTTf4=','2025-02-12 03:42:01.639583',0,'hari','bharghavi','kholi','bharghaviprabhu2005@gmail.com',0,1,'2025-01-06 08:18:54.441926'),(12,'pbkdf2_sha256$870000$mT4w1VFq56MaoeX4UTshRV$kM3KpReR6KN3jaYGh9RW+9f1jYqUE3LeKPldwIcGPUM=',NULL,0,'bh','prasant','newton','m.vishnusuderson2004@gmail.com',0,1,'2025-01-09 08:58:33.324763'),(13,'pbkdf2_sha256$870000$22FFbIHU1vCtYXtUciioOd$fJHCnSxWat7Xr/m3l//Vh77wF1QAust4yqkaPcGp4Tc=','2025-02-01 03:54:53.075411',0,'ashwin05','agathiyan','as','agathiyanvelu005@gmail.com',0,1,'2025-01-21 05:35:37.334928'),(14,'pbkdf2_sha256$870000$MIpU2zj1KiZ9J5UjYZMU4Z$d1beS2Ynx5xVt7dVSmoLPFdcgFgIerVEzWk8iBpp5ak=',NULL,0,'siddhu','siddhu','sedde','t8x53@pirolsnet.com',0,1,'2025-01-24 12:54:01.898922'),(15,'pbkdf2_sha256$870000$Ku2HWZIcKrEeksc9j1cpuk$4SuOCkNcJNymAcWjjKMT0QUtG98UZNusfy5yd6Wbyfw=',NULL,0,'sabari','sabari','kholi','pomaro2945@hapied.com',0,1,'2025-01-24 12:56:56.482367'),(16,'pbkdf2_sha256$870000$hzAzhX250n9cEC20ChgKhK$NQXvfIeb926XQHzX+i17HQ0k/oCkVDhzfdJKy15oN3Y=','2025-01-27 05:39:54.233449',0,'bharghavi05','chandru','newton','wTTNOW91@rizzy.tv',0,1,'2025-01-27 04:28:31.983814'),(17,'pbkdf2_sha256$870000$YhpcDpkVVCvHmNnB3VitHZ$GMJS9+bQH5FL7jDqIL8oYeIV7coVjpvC+ZOM8kFreT4=','2025-02-06 08:19:33.072045',0,'mk09','mohan','karthiok','mohankarthiksundarrajan@gmail.com',0,1,'2025-01-30 08:06:06.184118'),(18,'pbkdf2_sha256$870000$ZFOXAZKEsiwBdMVvxKoaHv$fav2YYIir/JrneSCIcRBxIZNcSORW74TX0dOM++3ifU=','2025-02-04 03:28:09.372635',0,'vishnu','mohan','s','mk2004op@gmail.com',0,1,'2025-02-01 03:54:44.425190'),(19,'pbkdf2_sha256$870000$kYLHdioQDevey5rdYNhbwP$8N+ZIonLUJqopXx6ZUEqeZcvL0k9inz61hgy/Qq9smY=','2025-02-07 13:26:00.540760',0,'Chandru','chandru','ganesh','chandrug1063.sse@saveetha.com',0,1,'2025-02-07 10:44:28.116780'),(20,'pbkdf2_sha256$870000$gzr3jWJzIOTESRQVx5fGHv$+Gs98iWOqSJPlXfkBuXGMd3qig2FrLaU9xoeBaUB/Kk=','2025-02-11 05:49:29.970975',0,'Priya12','Har','Parad','prasadhari03604@gmail.com',0,1,'2025-02-11 05:47:56.669954');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-01-03 07:37:48.054944','2','vikram',1,'[{\"added\": {}}]',4,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'pdftomp3','mp3file'),(8,'pdftomp3','pdffile'),(9,'pdftomp3','profile'),(10,'pdftomp3','useractivity'),(6,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-01-03 03:15:40.048658'),(2,'auth','0001_initial','2025-01-03 03:15:40.913448'),(3,'admin','0001_initial','2025-01-03 03:15:41.136203'),(4,'admin','0002_logentry_remove_auto_add','2025-01-03 03:15:41.151123'),(5,'admin','0003_logentry_add_action_flag_choices','2025-01-03 03:15:41.176158'),(6,'contenttypes','0002_remove_content_type_name','2025-01-03 03:15:41.336374'),(7,'auth','0002_alter_permission_name_max_length','2025-01-03 03:15:41.449998'),(8,'auth','0003_alter_user_email_max_length','2025-01-03 03:15:41.498992'),(9,'auth','0004_alter_user_username_opts','2025-01-03 03:15:41.514806'),(10,'auth','0005_alter_user_last_login_null','2025-01-03 03:15:41.639558'),(11,'auth','0006_require_contenttypes_0002','2025-01-03 03:15:41.644063'),(12,'auth','0007_alter_validators_add_error_messages','2025-01-03 03:15:41.659407'),(13,'auth','0008_alter_user_username_max_length','2025-01-03 03:15:41.777085'),(14,'auth','0009_alter_user_last_name_max_length','2025-01-03 03:15:41.911106'),(15,'auth','0010_alter_group_name_max_length','2025-01-03 03:15:41.947967'),(16,'auth','0011_update_proxy_permissions','2025-01-03 03:15:41.965935'),(17,'auth','0012_alter_user_first_name_max_length','2025-01-03 03:15:42.064222'),(18,'sessions','0001_initial','2025-01-03 03:15:42.125503'),(19,'pdftomp3','0001_initial','2025-01-08 07:55:10.443843'),(20,'pdftomp3','0002_remove_pdf_user_remove_profile_user_delete_mp3_and_more','2025-01-08 08:03:14.835899'),(21,'pdftomp3','0003_initial','2025-01-08 08:07:54.298983'),(22,'pdftomp3','0004_rename_mp3_mp3file_rename_pdf_pdffile','2025-01-08 08:28:16.355371'),(23,'pdftomp3','0005_useractivity','2025-01-31 08:42:23.584120');
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
INSERT INTO `django_session` VALUES ('1wxta3m87qt187v5hxikf19r2yb1n17g','.eJxVjDEOwjAMAP-SGUVx2kQtIztviOzYJgWUSk07If6OijrAene6l0m4rSVtTZY0sTkbAHP6hYT5IXU3fMd6m22e67pMZPfEHrbZ68zyvBzt36BgK9-vMkfBHrxjYKRRVYfoCENAkswae0KJogKAAj66znmkAaTDMIp5fwBFGDmO:1tXElR:9b2Fsbmw21g_46OOfbpm-GaPLzmSILJ25zfU50Fi_Gc','2025-01-27 07:21:33.238634'),('1xc3jigkkr7a10yzv052j8idydgl7cfa','.eJxVjDsOwjAUBO_iGlkh_sSmpM8ZrGe_NQ4gR4qTCnF3iJQC2p2ZfYlA21rC1rCEicVF9J04_Y6R0gN1J3yneptlmuu6TFHuijxok-PMeF4P9--gUCvf-gw9wDtYytpaYyMyKUTrskOGckDSqtOMlEGsHLPyRsMqR4NPphfvDzgROU4:1thjHQ:apVqBIqQ1L7l_sBXmZG4Fu8_GhITPkkffjzg9Ih-gGY','2025-02-25 05:57:56.298522'),('2a54rlq23i22w07m9guqgfrx9naiiwsl','.eJxVjDsOwjAQBe_iGlnrrI0XSnrOED1_ggMoluKkQtwdIqWA9s3Me6ke61L6teW5H5M6KyPq8DsGxEeeNpLumG5Vxzot8xj0puidNn2tKT8vu_t3UNDKt_bZGDgBIMRBKAo5b9k67wlEwjYZ9mQthYzIwJBYOuHkcDz5blDvD-QKNy8:1tf9hF:ZcNuixJReJ1_FJqzMFrTLczHvEA63fsexxZIJbKpXzg','2025-02-18 03:33:57.199570'),('35pyb9gzh6t9n0eqzarq3l7658lnp8ni','.eJxVjDEOwjAMAP-SGUVx2kQtIztviOzYJgWUSk07If6OijrAene6l0m4rSVtTZY0sTkbAHP6hYT5IXU3fMd6m22e67pMZPfEHrbZ68zyvBzt36BgK9-vMkfBHrxjYKRRVYfoCENAkswae0KJogKAAj66znmkAaTDMIp5fwBFGDmO:1thj0m:mkWUocIidjCKSY2nIxlu9HG4w2Yr7LG0Wpqs5m1iwKA','2025-02-25 05:40:44.967669'),('37jhmtm87gufb2cgnixy456flwo2c2yj','.eJxVjDEOwjAMAP-SGUVx2kQtIztviOzYJgWUSk07If6OijrAene6l0m4rSVtTZY0sTkbAHP6hYT5IXU3fMd6m22e67pMZPfEHrbZ68zyvBzt36BgK9-vMkfBHrxjYKRRVYfoCENAkswae0KJogKAAj66znmkAaTDMIp5fwBFGDmO:1ti3Bn:QJO7mPPOudSkLlGSILdjkZxPOP-O-SfG8zMbhwDK2BA','2025-02-26 03:13:27.420751'),('5m1ey1h1ca3g1jne3pjpgzpfsha57egk','.eJxVjDEOwjAMAP-SGUVx2kQtIztviOzYJgWUSk07If6OijrAene6l0m4rSVtTZY0sTkbAHP6hYT5IXU3fMd6m22e67pMZPfEHrbZ68zyvBzt36BgK9-vMkfBHrxjYKRRVYfoCENAkswae0KJogKAAj66znmkAaTDMIp5fwBFGDmO:1ti3dR:T7feRLWiAQpTQBTzSAjYD8__jJKL5lxFedUX2RB2d1Q','2025-02-26 03:42:01.651030'),('7hq957otl6s6euznlpwjd6u5x310khxo','.eJxVjDEOwjAMAP-SGUVx2kQtIztviOzYJgWUSk07If6OijrAene6l0m4rSVtTZY0sTkbAHP6hYT5IXU3fMd6m22e67pMZPfEHrbZ68zyvBzt36BgK9-vMkfBHrxjYKRRVYfoCENAkswae0KJogKAAj66znmkAaTDMIp5fwBFGDmO:1tUiKr:dmG7pJ99fjaUgRqupsEDBrlIAWwQqR8KJszdZghVfGg','2025-01-20 08:19:41.848296'),('7zgg0454tawisf3amapuvunei0ohx9t5','.eJxVjEEOwiAQRe_C2hCgAh2X7nuGZpgZpGpoUtqV8e7apAvd_vfef6kRt7WMW5NlnFhdlO3U6XdMSA-pO-E71tusaa7rMiW9K_qgTQ8zy_N6uH8HBVv51lko5pCMBbHuHKn3ZCBlcga67DkSogOCHhizCSzWZggpRI7eAztR7w8inzix:1taSFH:uV8XGppt5XYb28TyJA4wb8s8D1IYOsnQitqY4CBkhqk','2025-02-05 04:21:39.157674'),('9brjxii67z3e1zuzyn0pyalw6ivuoqcp','.eJxVjDEOwjAMAP-SGUVx2kQtIztviOzYJgWUSk07If6OijrAene6l0m4rSVtTZY0sTkbAHP6hYT5IXU3fMd6m22e67pMZPfEHrbZ68zyvBzt36BgK9-vMkfBHrxjYKRRVYfoCENAkswae0KJogKAAj66znmkAaTDMIp5fwBFGDmO:1tVTMZ:eWylXVCpTFb6hvL_S9U9dBRCtXeAjDfDww0HLTszTb4','2025-01-22 10:32:35.063868'),('9kbowr923g3zmiv71qkkunygrt0oidi6','.eJxFy00KwjAUReG93HGRpvEHMnLo0B2Ui0k10JjwEhEp3btPBzr9OGfBlCWNno1wC6YotY13pgCHEyWiw8w_nYWVXvFRg_wsvmgGxZAYZ5XyrW6693bfb4_Xj28uOWlTWOszi9fMDBZrh9wK3MHuzPoGKb8tyg:1thj4f:CNtH4FFgeDNZpi9m_sVMWfYIEby7dGhM8lT-dlIB4Ww','2025-02-25 05:44:45.036345'),('dh9y99n07x4i10w1g6vfie3foiup11jn','.eJxVjDEOwjAMAP-SGUVx2kQtIztviOzYJgWUSk07If6OijrAene6l0m4rSVtTZY0sTkbAHP6hYT5IXU3fMd6m22e67pMZPfEHrbZ68zyvBzt36BgK9-vMkfBHrxjYKRRVYfoCENAkswae0KJogKAAj66znmkAaTDMIp5fwBFGDmO:1thrCX:trsflgVsnuOkPWFrq4CZPRtVlvPS371bWjTD-qq9dwY','2025-02-25 14:25:25.081593'),('lfxtg206s3mimniirh25aqmfuy5r5xh3','.eJxVjDsOwjAQBe_iGlnrrI0XSnrOED1_ggMoluKkQtwdIqWA9s3Me6ke61L6teW5H5M6KyPq8DsGxEeeNpLumG5Vxzot8xj0puidNn2tKT8vu_t3UNDKt_bZGDgBIMRBKAo5b9k67wlEwjYZ9mQthYzIwJBYOuHkcDz5blDvD-QKNy8:1tf9bc:hZXhljC8HcJkGwkG_-4hGVe9Cf7Ox3pFjh0eCX-F7Kw','2025-02-18 03:28:08.502327'),('mzxo6xm05jx2043hi1pt93uo72r0xcb5','.eJxVjDsOgzAQBe-yNbL4GLOmitLnDGhtL-CETwQGKYpy9xiJhvbNzPvCHN5Qy6pQCSxs2e-8NDySH6AG6ij0_kPTzsOWpuWtO4Cw8wgJNLSFvtnW6HsX5ay4jobsi6eDuCdN3RyzKSzeiEMRJ13FY3Y83E_3ctDT2sfapESKJJat1Ig5YiURFRZSkjKZYmcpN1hWqI1mW6AzsrWOUSuypc4U_P4NcUs-:1te4ar:TgpKKF-v8oedhR3IJOTSpaL8ii_p0_9GQJhuvZBNTi4','2025-02-15 03:54:53.086976'),('periuzm3nsij1o4xiz0n2py6qemh9e71','.eJxVjDsOwjAUBO_iGlkh_sSmpM8ZrGe_NQ4gR4qTCnF3iJQC2p2ZfYlA21rC1rCEicVF9J04_Y6R0gN1J3yneptlmuu6TFHuijxok-PMeF4P9--gUCvf-gw9wDtYytpaYyMyKUTrskOGckDSqtOMlEGsHLPyRsMqR4NPphfvDzgROU4:1thj9F:YjA1vRPasU6oIzat0JEcXcgdpsKwcHLdTJ5kpCnzQXw','2025-02-25 05:49:29.175545'),('xurofb5c38dicdf7syqb5rouf17wo7d6','.eJxVjDsOwjAQBe_iGlnrrI0XSnrOED1_ggMoluKkQtwdIqWA9s3Me6ke61L6teW5H5M6KyPq8DsGxEeeNpLumG5Vxzot8xj0puidNn2tKT8vu_t3UNDKt_bZGDgBIMRBKAo5b9k67wlEwjYZ9mQthYzIwJBYOuHkcDz5blDvD-QKNy8:1te4ao:4r_VhmomTFtuTdD6UxAzG21JqG7gNxeUo0eOa7lmhHE','2025-02-15 03:54:50.503069'),('yzu4o6a3rgxg5glixzrmawermz6skk2p','.eJxVjDEOwjAMAP-SGUVx2kQtIztviOzYJgWUSk07If6OijrAene6l0m4rSVtTZY0sTkbAHP6hYT5IXU3fMd6m22e67pMZPfEHrbZ68zyvBzt36BgK9-vMkfBHrxjYKRRVYfoCENAkswae0KJogKAAj66znmkAaTDMIp5fwBFGDmO:1thqat:R4sKZxKhpCJcxHIxmG4gl32tlWp3cf_FbkVz1xo9lw0','2025-02-25 13:46:31.985735'),('zkptjqphrilf6nl2m2zzg03egrjtm08p','e30:1tbJF3:-DS5D0hPLbo8ADuo25HTjYNrC-PGRfqdLSIoT9nJVHc','2025-02-07 12:56:57.827841');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pdftomp3_mp3file`
--

DROP TABLE IF EXISTS `pdftomp3_mp3file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pdftomp3_mp3file` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `mp3_file` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL,
  `date` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pdftomp3_mp3_user_id_b7bb43d0_fk_pdftomp3_profile_id` (`user_id`),
  CONSTRAINT `pdftomp3_mp3_user_id_b7bb43d0_fk_pdftomp3_profile_id` FOREIGN KEY (`user_id`) REFERENCES `pdftomp3_profile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pdftomp3_mp3file`
--

LOCK TABLES `pdftomp3_mp3file` WRITE;
/*!40000 ALTER TABLE `pdftomp3_mp3file` DISABLE KEYS */;
INSERT INTO `pdftomp3_mp3file` VALUES (3,'mp3s/output_.mp3','savered','2025-01-12 04:44:24.809422',11),(4,'mp3s/{title}.mp3','Varshini_T-_192221006_1.pdf','2025-01-12 04:51:01.166485',11),(5,'mp3s/1.mp3','1','2025-01-12 04:59:20.852266',11),(6,'mp3s/PD_Slides.mp3','PD_Slides','2025-01-12 06:24:08.205351',11),(7,'mp3s/PD_Slides.mp3','PD_Slides','2025-01-12 06:27:13.656260',11),(8,'mp3s/PD_Slides.mp3','PD_Slides','2025-01-12 06:28:43.606510',11),(9,'mp3s/PD_Slides.mp3','PD_Slides','2025-01-12 06:38:21.685075',11),(11,'mp3s/PD_Slides.mp3','PD_Slides','2025-01-12 06:39:45.875048',11),(12,'mp3s/Varshini_T-_192221006_1.mp3','Varshini_T-_192221006_1','2025-01-12 06:40:32.806831',11),(13,'mp3s/Varshini_T-_192221006_1.mp3','Varshini_T-_192221006_1','2025-01-12 08:24:39.249584',11),(14,'mp3s/Varshini_T-_192221006_1_male.mp3','Varshini_T-_192221006_1','2025-01-12 14:26:37.944982',11),(15,'mp3s/1_en-US-GuyNeural.mp3','1','2025-01-12 14:43:48.091315',11),(16,'mp3s/Varshini_T-_192221006_1_en-US-GuyNeural.mp3','Varshini_T-_192221006_1','2025-01-12 14:44:05.871463',11),(17,'mp3s/Varshini_T-_192221006_1_en-US-GuyNeural.mp3','Varshini_T-_192221006_1','2025-01-12 14:46:14.947771',11),(18,'mp3s/Varshini_T-_192221006_1_en-US-GuyNeural.mp3','Varshini_T-_192221006_1','2025-01-12 14:47:19.876413',11),(19,'mp3s/PD_Slides_en-US-GuyNeural.mp3','PD_Slides','2025-01-12 14:52:57.566469',11),(31,'mp3s/_en-US-JennyNeural.mp3','','2025-01-21 03:07:04.642649',11),(32,'mp3s/_en-US-GuyNeural.mp3','','2025-01-21 03:07:28.514319',11),(33,'mp3s/PD_Slides_en-US-GuyNeural.mp3','PD_Slides','2025-01-21 03:18:20.830947',11),(34,'mp3s/_en-US-JennyNeural.mp3','','2025-01-21 05:35:11.947305',11),(35,'mp3s/_en-US-JennyNeural.mp3','','2025-01-21 05:39:49.041599',12),(36,'mp3s/_en-US-JennyNeural.mp3','','2025-01-21 05:48:03.118567',12),(37,'mp3s/VISHNU_SUDERSON_M[1]_en-US-GuyNeural.mp3','VISHNU_SUDERSON_M[1]','2025-01-21 05:51:26.732934',12),(38,'mp3s/Optimizing for Distributed Systems_en-US-GuyNeural.mp3','Optimizing for Distributed Systems','2025-01-22 04:03:44.357689',12),(39,'mp3s/Optimizing for Distributed Systems_en-US-GuyNeural.mp3','Optimizing for Distributed Systems','2025-01-23 03:49:07.476496',12),(40,'mp3s/VISHNU_en-US-JennyNeural.mp3','VISHNU','2025-01-23 03:49:34.383317',12),(41,'mp3s/PD_Slides_en-US-GuyNeural.mp3','PD_Slides','2025-01-24 03:07:59.496212',12),(42,'mp3s/PD_Slides_en-US-GuyNeural.mp3','PD_Slides','2025-01-24 03:11:20.178069',12),(44,'mp3s/VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter_en-US-GuyNeural.mp3','VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter','2025-01-25 11:19:52.292305',11),(45,'mp3s/VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter_en-US-GuyNeural.mp3','VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter','2025-01-25 11:21:38.241139',11),(46,'mp3s/VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter_en-US-GuyNeural.mp3','VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter','2025-01-25 11:22:43.631471',11),(47,'mp3s/VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter_en-US-GuyNeural.mp3','VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter','2025-01-25 11:23:33.583187',11),(48,'mp3s/VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter_en-US-JennyNeural.mp3','VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter','2025-01-27 05:43:43.322540',15),(49,'mp3s/VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter_en-US-JennyNeural.mp3','VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter','2025-01-27 05:44:11.774757',15),(50,'mp3s/VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter_en-US-JennyNeural.mp3','VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter','2025-01-27 05:44:51.593282',15),(51,'mp3s/VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter_en-US-GuyNeural.mp3','VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter','2025-01-30 03:39:19.863506',12),(60,'mp3s/42_[male].mp3','42','2025-02-04 03:33:53.376708',17),(61,'mp3s/Varshini_T-_192221006_1_NlNSkMj_female.mp3','Varshini_T-_192221006_1_NlNSkMj','2025-02-11 05:51:24.365357',11),(62,'mp3s/1_male.mp3','1','2025-02-11 05:51:48.291321',11),(63,'mp3s/EC-council-10_female.mp3','EC-council-10','2025-02-11 05:52:47.144403',19),(64,'mp3s/EC-council-10_female.mp3','EC-council-10','2025-02-11 05:54:01.975124',19),(65,'mp3s/EC-council-10_female.mp3','EC-council-10','2025-02-11 05:55:22.194724',19),(66,'mp3s/EC-council-10_male.mp3','EC-council-10','2025-02-11 05:55:34.788875',19),(67,'mp3s/PU ABC ID creation-5_male.mp3','PU ABC ID creation-5','2025-02-11 05:57:51.730003',19),(68,'mp3s/Toughest_Interview_Questions_[female].mp3','Toughest Interview Questions','2025-02-12 03:13:23.338397',11);
/*!40000 ALTER TABLE `pdftomp3_mp3file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pdftomp3_pdffile`
--

DROP TABLE IF EXISTS `pdftomp3_pdffile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pdftomp3_pdffile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pdf_file` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL,
  `date` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pdftomp3_pdf_user_id_546a66a6_fk_pdftomp3_profile_id` (`user_id`),
  CONSTRAINT `pdftomp3_pdf_user_id_546a66a6_fk_pdftomp3_profile_id` FOREIGN KEY (`user_id`) REFERENCES `pdftomp3_profile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pdftomp3_pdffile`
--

LOCK TABLES `pdftomp3_pdffile` WRITE;
/*!40000 ALTER TABLE `pdftomp3_pdffile` DISABLE KEYS */;
INSERT INTO `pdftomp3_pdffile` VALUES (1,'pdfs/PD_Slides.pdf','PD_Slides.pdf','2025-01-08 08:42:35.363297',11),(2,'pdfs/1.pdf','1.pdf','2025-01-08 08:42:49.377099',11),(3,'pdfs/Varshini_T-_192221006_1.pdf','Varshini_T-_192221006_1.pdf','2025-01-08 09:16:08.203946',11),(4,'pdfs/Varshini_T-_192221006_1_NlNSkMj.pdf','Varshini_T-_192221006_1_NlNSkMj.pdf','2025-01-08 09:16:30.322689',11),(11,'pdfs/Department_of_Information_Technology_Vision_Mission_and_PSO_UjSOCY9.pdf','department of information','2025-01-13 06:10:25.231480',11),(12,'pdfs/VISHNU_ozAyDru.pdf','vishnu ','2025-01-14 12:41:24.164048',11),(13,'pdfs/ITA0480PRACTICALQUESTION_4_COPIES.pdf','','2025-01-21 03:02:34.650433',11),(14,'pdfs/VISHNU_iE9AdQr.pdf','','2025-01-21 03:06:09.904611',11),(15,'pdfs/Optimizing_for_Distributed_Systems.pdf','','2025-01-21 05:38:23.301359',12),(16,'pdfs/Vishnu_Suderson_MRESUME.pdf','','2025-01-21 05:47:13.965643',12),(17,'pdfs/VISHNU_SUDERSON_M1.pdf','VISHNU_SUDERSON_M[1].pdf','2025-01-21 05:50:25.320729',12),(18,'pdfs/Optimizing_for_Distributed_Systems_s7H4r07.pdf','Optimizing for Distributed Systems.pdf','2025-01-22 04:02:04.660794',12),(19,'pdfs/Optimizing_for_Distributed_Systems_yO93Oua.pdf','Optimizing for Distributed Systems.pdf','2025-01-23 03:44:41.310460',12),(20,'pdfs/VISHNU_xTjYRt3.pdf','VISHNU.pdf','2025-01-23 03:48:51.080532',12),(21,'pdfs/PD_Slides_grNnn4x.pdf','PD_Slides.pdf','2025-01-24 03:06:58.144708',12),(22,'pdfs/VISHNU_SUDERSON_M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter.pdf','VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter.pdf','2025-01-25 11:17:17.196361',11),(23,'pdfs/VISHNU_SUDERSON_M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter_PnWSAJe.pdf','VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter.pdf','2025-01-27 05:41:36.105326',15),(24,'pdfs/VISHNU_SUDERSON_M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter_MsiVcE9.pdf','VISHNU SUDERSON M_INTERNSHIP_1733138870674d99b64cb4b_offer_letter.pdf','2025-01-30 03:38:12.966352',12),(30,'pdfs/42.pdf','42.pdf','2025-02-04 03:28:49.631520',17),(31,'pdfs/VISHNU_Ns6FL4N.pdf','VISHNU.pdf','2025-02-06 10:30:47.836084',11),(32,'pdfs/EC-council-10.pdf','EC-council-10.pdf','2025-02-11 05:52:02.318177',19),(33,'pdfs/PU_ABC_ID_creation-5.pdf','PU ABC ID creation-5.pdf','2025-02-11 05:57:35.082960',19),(34,'pdfs/EC-council-10_JaACQpr.pdf','EC-council-10.pdf','2025-02-11 06:02:38.545908',19),(35,'pdfs/Toughest_Interview_Questions.pdf','Toughest Interview Questions.pdf','2025-02-12 03:10:44.374458',11);
/*!40000 ALTER TABLE `pdftomp3_pdffile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pdftomp3_profile`
--

DROP TABLE IF EXISTS `pdftomp3_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pdftomp3_profile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `profile_pic` varchar(100) NOT NULL,
  `name` varchar(225) NOT NULL,
  `username` varchar(225) NOT NULL,
  `passwords` varchar(225) NOT NULL,
  `mobile_phone` varchar(225) NOT NULL,
  `email` varchar(225) NOT NULL,
  `POSITION` varchar(100) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `pdftomp3_profile_user_id_1a4570b9_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pdftomp3_profile`
--

LOCK TABLES `pdftomp3_profile` WRITE;
/*!40000 ALTER TABLE `pdftomp3_profile` DISABLE KEYS */;
INSERT INTO `pdftomp3_profile` VALUES (1,'profile_pics/default.jpg','','suderson','pbkdf2_sha256$870000$2bg63o2O6GkZLHinLd5mFw$IPBavDOnEYfHHAccUMcJ0SSrtQSiCRRxPwZB/tLXSR8=','xxxx','suderson@gmail.com','xxxx',1),(2,'profile_pics/default.jpg','','vikram','pbkdf2_sha256$870000$8H3aEnETIDG09ZcbqbcDe0$ZpRdON2LpxnsJAan6fYK7+m0J9hIIb5oYCUMAK6WRCE=','xxxx','','xxxx',2),(3,'profile_pics/default.jpg','dhoni','dhonikoli','pbkdf2_sha256$870000$yeF7joStyncxfGSJTmdR0G$pd3BU7C6tLb79GAsM7av1XrXAZu5JI8tjX5mImnlgdk=','xxxx','pomaro2945@hapied.com','xxxx',3),(4,'profile_pics/default.jpg','raina','rs12','pbkdf2_sha256$870000$Z7wm0tJLIqElQDVmgBpkIO$OLbq+0iLnVFd5IiI7LKtQmR9UsWiq5uLcIoCTJdy3nI=','xxxx','rs12@gmail.com','xxxx',4),(5,'profile_pics/default.jpg','bharghavi','bharghaviravi','pbkdf2_sha256$870000$1Gl4wm2CLmYitdXbyevU9e$ViK9OnyA2Nj5JTpalkwcoGwnGr0Dcp9sotcDM09XDdU=','xxxx','pomaro2945@hapied.com','xxxx',5),(6,'profile_pics/default.jpg','abinaya','abinaya','pbkdf2_sha256$870000$2dQY8L5A9H9pegA7m2iTft$RpZUg/BBoLqEKPGVckw2khcTy7XPgnmmH8v9PJDQthY=','xxxx','haridossabinaya@gmail.com','xxxx',6),(7,'profile_pics/default.jpg','harish','ragav','pbkdf2_sha256$870000$HHFQwasaKW2im25w89MKW5$mZ+UbeBFhFHoA0CnyyUIT4M4/ZgsvNaCU8sBZiWgt+Q=','xxxx','harishragav963@gmail.com','xxxx',7),(8,'profile_pics/default.jpg','mohan','mk','pbkdf2_sha256$870000$3kslM9J23QPdAq9KU7Sxo0$mO+wjWUQePxKUch4bxDnA5vT7ua1GVrTWceC/uafcAk=','xxxx','mohankarthiksundarrajan@gmail.com','xxxx',8),(9,'profile_pics/default.jpg','issac','issac_netwon','pbkdf2_sha256$870000$YaxTopx5pGvSib35SZwAMM$ioAxL/xqoVXWmxeROntcOYU+n8o5r4tU4bEDfAA4xik=','xxxx','m.vishnusuderson@gmail.com','xxxx',9),(10,'profile_pics/default.jpg','Merwin','siu','pbkdf2_sha256$870000$fdM4IU6uHMTWZkP6zqx8Ef$gGad+8QOkmgWYIpuC/qaaIuCfJhIhgkvlXPUylYkyVY=','xxxx','merwins2004@gmail.com','xxxx',10),(11,'profile_pics/WhatsApp_Image_2023-12-27_at_10.35.09_PM.jpeg','bharghavi','hari','pbkdf2_sha256$870000$TKBvzaumDYKnwRLHCWXsQh$ONToVREZWBzS2AtJsPGtb+hL10C2ZPU0XnnZtgxTTf4=','6633686154','bharghaviprabhu2005@gmail.com','manager',11),(12,'profile_pics/marraiageemoji_uOslFjW.jpg','agathiyan','ashwin05','','9895266','agathiyanvelu005@gmail.com','Student',13),(13,'profile_pics/default.jpg','siddhu sedde','siddhu','suderson14@','xxxx','t8x53@pirolsnet.com','xxxx',14),(14,'profile_pics/default.jpg','sabari kholi','sabari','12345678','xxxx','pomaro2945@hapied.com','xxxx',15),(15,'profile_pics/default.jpg','chandru newton','bharghavi05','12345678','xxxx','wTTNOW91@rizzy.tv','xxxx',16),(17,'profile_pics/default.jpg','mohan s','vishnu','mk09','xxxx','mk2004op@gmail.com','xxxx',18),(18,'profile_pics/default.jpg','chandru ganesh','Chandru','12345','xxxx','chandrug1063.sse@saveetha.com','xxxx',19),(19,'profile_pics/default.jpg','Har Parad','Priya12','123','xxxx','prasadhari03604@gmail.com','xxxx',20);
/*!40000 ALTER TABLE `pdftomp3_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pdftomp3_useractivity`
--

DROP TABLE IF EXISTS `pdftomp3_useractivity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pdftomp3_useractivity` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pdftomp3_useractivity_user_id_3c872a45_fk_auth_user_id` (`user_id`),
  CONSTRAINT `pdftomp3_useractivity_user_id_3c872a45_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pdftomp3_useractivity`
--

LOCK TABLES `pdftomp3_useractivity` WRITE;
/*!40000 ALTER TABLE `pdftomp3_useractivity` DISABLE KEYS */;
INSERT INTO `pdftomp3_useractivity` VALUES (3,'2025-01-31 09:09:32.775832','2025-01-31 09:09:32.775832',17),(4,'2025-01-31 09:11:51.480975',NULL,17),(5,'2025-01-31 10:17:43.630147','2025-01-31 10:17:43.624132',17),(6,'2025-01-31 10:17:48.526198',NULL,17),(7,'2025-02-01 03:54:50.483319',NULL,18),(8,'2025-02-01 03:54:53.081748',NULL,13),(9,'2025-02-04 02:46:33.700749','2025-02-04 02:46:33.699747',17),(10,'2025-02-04 02:46:40.072247',NULL,17),(11,'2025-02-04 03:28:08.496883',NULL,18),(12,'2025-02-04 03:28:09.376300',NULL,18),(13,'2025-02-04 05:32:44.090077',NULL,11),(14,'2025-02-04 09:11:11.368848','2025-02-04 09:11:11.367482',11),(15,'2025-02-04 09:11:50.879493',NULL,11),(16,'2025-02-04 09:12:03.596877','2025-02-04 09:12:03.596877',11),(17,'2025-02-04 09:12:14.090178',NULL,9),(18,'2025-02-04 09:21:23.736878','2025-02-04 09:21:23.736878',9),(19,'2025-02-04 09:22:02.330979',NULL,17),(20,'2025-02-04 09:29:18.468952','2025-02-04 09:29:18.468952',17),(21,'2025-02-04 09:29:28.414818',NULL,11),(22,'2025-02-06 03:26:28.026694','2025-02-06 03:26:28.026694',11),(23,'2025-02-06 04:07:28.100167',NULL,11),(24,'2025-02-06 07:58:04.117827','2025-02-06 07:58:04.116831',11),(25,'2025-02-06 07:58:23.290869',NULL,17),(26,'2025-02-06 08:19:21.103701',NULL,17),(27,'2025-02-06 08:19:33.077762',NULL,17),(28,'2025-02-06 08:21:42.716377',NULL,11),(29,'2025-02-06 08:29:45.646263','2025-02-06 08:29:45.646263',11),(30,'2025-02-06 08:30:57.654657',NULL,11),(31,'2025-02-06 10:36:46.089901','2025-02-06 10:36:46.089901',11),(32,'2025-02-06 10:37:05.716317',NULL,11),(33,'2025-02-07 10:44:37.176703',NULL,19),(34,'2025-02-07 12:43:53.478459','2025-02-07 12:43:53.477535',19),(35,'2025-02-07 13:26:00.550470',NULL,19),(36,'2025-02-07 13:26:08.773802','2025-02-07 13:26:08.773802',19),(37,'2025-02-07 13:26:19.433253',NULL,11),(38,'2025-02-10 08:27:52.603949','2025-02-10 08:27:52.603949',11),(39,'2025-02-10 09:55:08.265929',NULL,11),(40,'2025-02-11 03:09:58.504587','2025-02-11 03:09:58.503430',11),(41,'2025-02-11 03:11:19.881950',NULL,11),(42,'2025-02-11 05:40:18.910537','2025-02-11 05:40:18.910043',11),(43,'2025-02-11 05:40:44.964254',NULL,11),(44,'2025-02-11 05:49:29.172548',NULL,20),(45,'2025-02-11 05:49:29.975195',NULL,20),(46,'2025-02-11 13:06:40.529510',NULL,11),(47,'2025-02-11 13:38:41.781904','2025-02-11 13:38:41.780823',11),(48,'2025-02-11 13:39:36.225424',NULL,11),(49,'2025-02-11 13:46:31.981915',NULL,11),(50,'2025-02-11 13:49:14.683964',NULL,11),(51,'2025-02-11 14:12:58.163727','2025-02-11 14:12:58.162714',11),(52,'2025-02-11 14:25:25.076550',NULL,11),(53,'2025-02-12 03:08:05.796100',NULL,11),(54,'2025-02-12 03:42:01.646575',NULL,11);
/*!40000 ALTER TABLE `pdftomp3_useractivity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'pdf'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-12 13:53:13
