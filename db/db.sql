-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: items
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add items',1,'add_items'),(2,'Can change items',1,'change_items'),(3,'Can delete items',1,'delete_items'),(4,'Can view items',1,'view_items'),(5,'Can add items audit log',2,'add_itemsauditlog'),(6,'Can change items audit log',2,'change_itemsauditlog'),(7,'Can delete items audit log',2,'delete_itemsauditlog'),(8,'Can view items audit log',2,'view_itemsauditlog'),(9,'Can add log entry',3,'add_logentry'),(10,'Can change log entry',3,'change_logentry'),(11,'Can delete log entry',3,'delete_logentry'),(12,'Can view log entry',3,'view_logentry'),(13,'Can add permission',4,'add_permission'),(14,'Can change permission',4,'change_permission'),(15,'Can delete permission',4,'delete_permission'),(16,'Can view permission',4,'view_permission'),(17,'Can add group',5,'add_group'),(18,'Can change group',5,'change_group'),(19,'Can delete group',5,'delete_group'),(20,'Can view group',5,'view_group'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add content type',7,'add_contenttype'),(26,'Can change content type',7,'change_contenttype'),(27,'Can delete content type',7,'delete_contenttype'),(28,'Can view content type',7,'view_contenttype'),(29,'Can add session',8,'add_session'),(30,'Can change session',8,'change_session'),(31,'Can delete session',8,'delete_session'),(32,'Can view session',8,'view_session');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$720000$4tvCBAQcaMg5m8JX62sJn4$ofYbjQPfd/Wfgj5lZkcly+wWzoD55gEgol7tySxAlT8=','2024-09-19 13:03:57.659975',1,'lucas','','','',1,1,'2024-09-09 12:57:16.016844');
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
INSERT INTO `django_content_type` VALUES (3,'admin','logentry'),(5,'auth','group'),(4,'auth','permission'),(6,'auth','user'),(7,'contenttypes','contenttype'),(1,'items','items'),(2,'items','itemsauditlog'),(8,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-09-09 12:56:53.910824'),(2,'auth','0001_initial','2024-09-09 12:56:54.383088'),(3,'admin','0001_initial','2024-09-09 12:56:54.527357'),(4,'admin','0002_logentry_remove_auto_add','2024-09-09 12:56:54.542981'),(5,'admin','0003_logentry_add_action_flag_choices','2024-09-09 12:56:54.556837'),(6,'contenttypes','0002_remove_content_type_name','2024-09-09 12:56:54.710983'),(7,'auth','0002_alter_permission_name_max_length','2024-09-09 12:56:54.853517'),(8,'auth','0003_alter_user_email_max_length','2024-09-09 12:56:54.924122'),(9,'auth','0004_alter_user_username_opts','2024-09-09 12:56:54.953332'),(10,'auth','0005_alter_user_last_login_null','2024-09-09 12:56:55.063644'),(11,'auth','0006_require_contenttypes_0002','2024-09-09 12:56:55.063644'),(12,'auth','0007_alter_validators_add_error_messages','2024-09-09 12:56:55.063644'),(13,'auth','0008_alter_user_username_max_length','2024-09-09 12:56:55.139396'),(14,'auth','0009_alter_user_last_name_max_length','2024-09-09 12:56:55.206673'),(15,'auth','0010_alter_group_name_max_length','2024-09-09 12:56:55.228304'),(16,'auth','0011_update_proxy_permissions','2024-09-09 12:56:55.243700'),(17,'auth','0012_alter_user_first_name_max_length','2024-09-09 12:56:55.311583'),(18,'items','0001_initial','2024-09-09 12:56:55.327770'),(19,'items','0002_remove_items_title_items_brand_items_location_and_more','2024-09-09 12:56:55.507754'),(20,'items','0003_alter_items_observation','2024-09-09 12:56:55.507754'),(21,'items','0004_items_locality','2024-09-09 12:56:55.574364'),(22,'items','0005_alter_items_quantity','2024-09-09 12:56:55.711264'),(23,'items','0006_itemsauditlog','2024-09-09 12:56:55.790926'),(24,'items','0007_remove_itemsauditlog_changes_and_more','2024-09-09 12:56:56.189370'),(25,'items','0008_itemsauditlog_changes_itemsauditlog_model_name_and_more','2024-09-09 12:56:56.452608'),(26,'items','0009_remove_itemsauditlog_model_name_and_more','2024-09-09 12:56:56.506891'),(27,'items','0010_alter_itemsauditlog_item','2024-09-09 12:56:56.659656'),(28,'items','0011_itemsauditlog_item_deletado','2024-09-09 12:56:56.708855'),(29,'sessions','0001_initial','2024-09-09 12:56:56.756326'),(30,'items','0012_remove_items_finished_at','2024-09-10 13:54:41.963272'),(31,'items','0013_alter_items_id','2024-09-10 13:59:50.911828'),(32,'items','0014_alter_items_id','2024-09-10 14:13:03.328770'),(33,'items','0015_remove_items_locality','2024-09-11 14:01:50.133353'),(34,'items','0016_items_nmr_tombo','2024-09-13 13:22:07.132994'),(35,'items','0017_alter_items_nmr_tombo','2024-09-13 13:24:03.664904'),(36,'items','0018_alter_items_nmr_tombo','2024-09-13 14:08:36.144562'),(37,'items','0019_alter_items_observation','2024-09-13 14:11:41.892496'),(38,'items','0020_alter_items_nmr_tombo_alter_items_observation','2024-09-13 14:13:31.679102');
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
INSERT INTO `django_session` VALUES ('37va43mr0w0ikweyllx4wufzmk93yp1p','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1so19W:F1yFC4A9LIMn9ZufjswRC9d_shzDytMu9wL4CCPCnuM','2024-09-10 14:13:30.460462'),('46ugeu6zbt6u51oh20mfumpw2biwr1x3','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sqck3:P0Y-l-FWjLdIJQIUtPuQ2YEDKjPPSaoTF_jnvOkBUsA','2024-09-17 18:45:59.507001'),('4ocpi24w7py1ejp7htfap6bxyp34481i','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sqHYM:QwhxykppCobu197ZWmKevcTgOk7-zGHSrHZJaLg6LFg','2024-09-16 20:08:30.467393'),('4td995k1apldcwcujlavd8fdaxrpxyiw','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sr0UL:OP3ea3mfig7qCSWRbr_jZtsfwcDSMI4GNcXfk9rjo0o','2024-09-18 20:07:21.366035'),('4u1md0y1204ca81408mxfb7f0s98lqlr','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sqfCy:gLr10oUCWrhoiWlMvBJaDX5cHr3Rn2UcCzLqNwToGyc','2024-09-17 21:24:00.468314'),('6xihl9srvarqflrjzrv837mxuscbn8pp','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1so1cy:PRz1kv6Ifyj4VV8rfgJXhkStPQ9vxsjBBV7KwTWpid8','2024-09-10 14:43:56.821239'),('99cj2syu5dsf9jlamd4s8a1f8vkjzpok','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sp6l0:0PGPb8PQQHdimBDAKdSTy5uSqU1eeHVFX7sO61ej2UM','2024-09-13 14:24:42.310518'),('9rdd3e1eutmb1f9trcc2okvpc1tvnzwh','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sqFNP:pF4MAd6WEDJ-O9qeZ2V0cHIzp_Sqj3ZQ-6BFrb99nX0','2024-09-16 17:49:03.247441'),('a1mxgc1v6wobct8531s9852rh3e4o2hp','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sqzzT:vrX92SyC42-Xs2pqU12RYcIhbwLwqZjNa5Eil5URRSA','2024-09-18 19:35:27.179323'),('adp7ka88szxcmp02ow0082t285vayjig','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sqb7C:JwewD27kOa8e9yBlFusJYnopnzFzakZMgC1uM90aLhc','2024-09-17 17:01:46.063246'),('bx6psn4s7p4cfsaxb4d7x6lnkt3x5qqy','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sp6Gi:RwqB0ceiOqkVfUmIVvrLSnRR2Qmf4WoPp1VKwIV3qxc','2024-09-13 13:53:24.613512'),('gvb09ofj21vabnqyj14h3izogn9uhmo6','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1snfJN:SJRSZFT-F6lxqav4JS8xwNCb65ukuPOnqmaPy7zF-w4','2024-09-09 14:54:13.705690'),('h54rxw5zuvfdvrwlthf5iyrfsg2yze5f','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sqFtP:gKwj1iTy5-NGmtzdqoaUbXGVb4P95UoO3iO2RxxTi5w','2024-09-16 18:22:07.533749'),('jdduiab2naml21m4gqrrmgnwr009p96a','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1soMBW:RiGzDQFnXWE-tX81NGHxA5Df-61BE9AK7U5cUlp-KYE','2024-09-11 12:40:58.416366'),('kwgzrqrdbtk7uusw4wu87bgqu3zhkg98','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sneQv:0pbg-HGhwnWVtElOdOExc3-KNJczDm2XGbAywCRs9Gw','2024-09-09 13:57:57.619207'),('lj5q5c5tbnaxgtrwjqau6jkrl4h6ykwd','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sndxZ:3yBD3IY41uGfGWoxofFZqjgdhCdtb6ZoVkTKdvm7jKc','2024-09-09 13:27:37.685786'),('nrpau0lspzme280hb7xuuvu2v638gqn6','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1srGpB:tyY_aq5op8VCNCzkUj66SpcQcOZdvqOW-6kqS4WA9Js','2024-09-19 13:33:57.659975'),('ntukj2ypmwlrc3w7aw5phiq33wdnwm8e','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sqjfH:VOsCKJhBoGxknive_qCujNmm5tyRqfqRd0GtCwWtvpc','2024-09-18 02:09:31.721567'),('oi4jmg4rel6ztxi35feis39qx0luhfag','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sqcDd:jZUD8caKK5BwP5W1-YZWP00QKuN1y6K_18DAA5V-YsU','2024-09-17 18:12:29.995862'),('orouomkmomck9bamsxurfh32urpxjn16','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sp7jM:Qi6zOLUuAiAiLNnojg9KW2lfFGDss24DIt9wCv77NNI','2024-09-13 15:27:04.915625'),('oup5p36381zflt7bq644cnvxrjcwt8cf','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sqbgj:AcQs1LXetuPOBzsk8bZd-CRtqjvwnG68NpdojGZf5J4','2024-09-17 17:38:29.311857'),('oxqxa3jaleceutnt7en16d3cplo9jbd9','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1snytr:MtOJxSnwAP7uZgyVnhl0gwpsdd2ENLH3bJfrrIotJ68','2024-09-10 11:49:11.381099'),('q7cd5o0nkjpulxyzkv77i13fuuz0a4l3','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sqdIj:nmjTDEDNZsJS1x3W3wooLU0NL4rbeFXkJGSLRwEC8mU','2024-09-17 19:21:49.778713'),('q9icra6yl920yfvn411ie59qzpfozi7l','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sqGOY:B1j6YI64CZpu8B9tpYIZffSjjjDSDKESU9EJjiHBbo4','2024-09-16 18:54:18.388416'),('qsessugf7w0tlmu2yd9zcrm5i2vvqxal','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sqg7Z:Wqjl2DpuWhODRpQ7CcIOFPfv3BlgW9Rp5HLgt44ELLc','2024-09-17 22:22:29.231722'),('swm18q1mhlcm24754s0au2o07ihljqql','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sqdn8:-i0CvyaIzyE8SM6to99XhsrgQdBcdB_p8jiIYCY6HSo','2024-09-17 19:53:14.713998'),('tt6cpfux4kgeqns1msngkm7usc7yksu4','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sqeaa:OaHHm6rlQu9nGhTl8L2KrLRgjXzI_xjAfTDNuqUiv_U','2024-09-17 20:44:20.341574'),('ucsooa4k777ozhqjxdhf4taolklcoad3','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1soNpl:Fs3Ic7lBylTk4mv6s8krsNVo5YqMamP1Qbc4dWauhtA','2024-09-11 14:26:37.668280'),('vj7negi3gb0nsj61tn3z5mje2mvsao9f','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1snzxk:RJyieWf51S-2woetck2V9mEc9zNQnXtRkzZ6cYSKzRo','2024-09-10 12:57:16.456713'),('w9t7lpr7w42fommi7qbtukhivxqdivya','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1soOOG:tVMoVRKsco1kAG31MeEt7vM8Ngvp0rJ8LTPkDua0YsM','2024-09-11 15:02:16.600544'),('zv97bdendvfbat7od2vp2oblucyd6397','.eJxVjMsOwiAQRf-FtSEdYKB16d5vIDxmpGogKe3K-O_apAvd3nPOfQkftrX4rdPi5yzOAsTpd4shPajuIN9DvTWZWl2XOcpdkQft8toyPS-H-3dQQi_fWqkpJ6eQLToCBzmCVpYYDY-sp4EpatQ2miECoVNgEpqsiW0yo0Ur3h_QoDdO:1sp7FV:zCdC44Se0SwZqTxmdGRcxuf5-8tarUInDHsDkBe1t1g','2024-09-13 14:56:13.756194');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_items`
--

DROP TABLE IF EXISTS `items_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_items` (
  `id` varchar(36) NOT NULL,
  `create_at` date NOT NULL,
  `category` varchar(100) NOT NULL,
  `quantity` int unsigned NOT NULL,
  `brand` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `observation` varchar(300) NOT NULL,
  `sub_category` varchar(100) NOT NULL,
  `modified_by_id` int DEFAULT NULL,
  `nmr_tombo` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `items_items_modified_by_id_3b626255_fk_auth_user_id` (`modified_by_id`),
  CONSTRAINT `items_items_modified_by_id_3b626255_fk_auth_user_id` FOREIGN KEY (`modified_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `items_items_chk_1` CHECK ((`nmr_tombo` >= 0)),
  CONSTRAINT `items_items_quantity_ca5b0272_check` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_items`
--

LOCK TABLES `items_items` WRITE;
/*!40000 ALTER TABLE `items_items` DISABLE KEYS */;
INSERT INTO `items_items` VALUES ('0435bf3b-818e-4642-902f-67bf992a4d1c','2024-09-13','DESCARTE',1,'EPSON','Almoxarifado 014 - Arm. 1| P1','H368A','PROJETOR','Funcionando','NÃO A SUB CATEGORIAS',NULL,135623),('0ace6436-7212-468c-bb47-6a1c7978c231','2024-09-18','FERRAMENTA',1,'MOTOROLA','Almoxarifado 014 - Arm. 1| P2','T5720','TALK ABOUT','Não há bateria','NÃO SUB CATEGORIAS',NULL,85410),('0dafb06d-3139-4d5b-a32c-158123f1cc3d','2024-09-13','DESCARTE',1,'SHARP NOTEVISION','Almoxarifado 014 - Arm. 1| P1','PG-M20S','PROJETOR','Transferido para o DIN','NÃO A SUB CATEGORIAS',NULL,764660),('12e1fdac-8afb-4894-84da-561c0ae49eba','2024-09-17','INFORMÁTICA',1,'SANSUNG','Almoxarifado 014 - Arm. 1| P1','SV2011H','HDD - 20 GB','HDD usado','ACESSÓRIOS',NULL,NULL),('1948d92a-23e8-441f-aa5a-efe03b053674','2024-09-17','MATERIAL PARA INSTALAÇÃO',2,'KAIOMY TECHNOLOGY','Almoxarifado 014 - Arm. 1| P2','UHUB-5P','HUB USB','PCI USB HUB 5 Ports','OUTROS',NULL,NULL),('1d897fab-0364-46d0-b8ac-8a8d4807db12','2024-09-13','DESCARTE',1,'SONY','Almoxarifado 014 - Arm. 1| P1','PVPL-CS6','PROJETOR','Lâmpada queimada','NÃO A SUB CATEGORIAS',NULL,79783),('1dade55b-67ff-426d-9a4c-2eee7933fa12','2024-09-17','INFORMÁTICA',2,'PIXELVIEW','Almoxarifado 014 - Arm. 1| P2','M4900','PLACA DE CAPTURA','Hight Quality MPEG2 TV Capture Card','ACESSÓRIOS',NULL,NULL),('1f6236f0-a95e-43c9-9eff-c345d8ca2aea','2024-09-17','MATERIAL PARA INSTALAÇÃO',1,'EPSON','Almoxarifado 014 - Arm. 1| P2','ELPLP 39','LÂMPADA DE PROJETOR','','ELÉTRICAS',NULL,NULL),('22cdc004-17d9-4d81-a717-f99c785d0e07','2024-09-17','INFORMÁTICA',1,'SANSUNG','Almoxarifado 014 - Arm. 1| P1','SP0842N','HDD - 80 GB','HDD usado','ACESSÓRIOS',NULL,NULL),('24795abf-3374-4b13-90a6-141172b1ab04','2024-09-17','INFORMÁTICA',1,'WESTERN DIGITAL','Almoxarifado 014 - Arm. 1| P1','WD1600JS','HDD - 160 GB','HDD usado','ACESSÓRIOS',NULL,NULL),('25d50ee6-9872-4663-981e-7d00cb073605','2024-09-11','Informática',28,'LENOVO','Almoxarifado 014 - Arm. 0 | P2','NÃO POSSUI','KIT COMPLETO LENOVO 2024','O kit possui os seguintes itens:\r\n- 1 UN Cabo USB para impressora;\r\n- 1 UN Cabo de força de 3 pinos;\r\n- 1 UN Organizador de cabos;\r\n- 1 UN Mouse Pad LENOVO\r\n- 1 UN Antena de rede; e\r\n- 2 UN manuais de usuários.','Acessórios',NULL,0),('2831b056-cf97-4bcf-8747-65d47cf00ea4','2024-09-17','INFORMÁTICA',1,'SEAGATE BARRACUDA 7200.10','Almoxarifado 014 - Arm. 1| P2','ST3250820AS','HDD - 250 GB','HDD usado','ACESSÓRIOS',NULL,NULL),('2865e55e-4a90-4b13-9bda-15c33556c4af','2024-09-17','INFORMÁTICA',2,'ASUS','Almoxarifado 014 - Arm. 1| P2','RT-AC51U','ROTEADOR','O pacote contém: \r\n\r\n- Roteador AC750 sem fio de banda dupla RT-AC1U;\r\n- Cabo RJ-45;\r\n- Adaptador de energia;\r\n- Guia de início rápido; e\r\n- Cartão de garantia.','EQUIPAMENTOS',NULL,NULL),('2ae4ff65-d73e-4744-a0fd-d1074eb2d68e','2024-09-13','INFORMÁTICA',1,'LG','Almoxarifado 014 - Arm. 1| P1','GH24NSCO','DVD WRITER','','ACESSÓRIOS',NULL,NULL),('2c856073-2749-4ce9-83ce-8b3e78dad36a','2024-09-17','INFORMÁTICA',1,'SANSUNG','Almoxarifado 014 - Arm. 1| P1','HD502HJ','HDD - 500 GB','HDD usado','ACESSÓRIOS',NULL,NULL),('2ddd5c77-d559-469b-b9de-1db371be159c','2024-09-17','MATERIAL PARA INSTALAÇÃO',1,'EPSON','Almoxarifado 014 - Arm. 1| P2','NÃO IDENTIFICADA','LÂMPADA DE PROJETOR','','ELÉTRICAS',NULL,NULL),('2e6cac02-0fb1-4244-ac5e-9f86bed5eee0','2024-09-17','MATERIAL PARA INSTALAÇÃO',2,'EPSON','Almoxarifado 014 - Arm. 1| P2','PL-58+','LÂMPADA DE PROJETOR','Uma lâmpada esta estragada','ELÉTRICAS',NULL,NULL),('313e4153-7797-4669-a626-d524944138db','2024-09-17','INFORMÁTICA',1,'SEAGATE BARRACUDA 7200.12','Almoxarifado 014 - Arm. 1| P1','ST3250318AS','HDD - 250 GB','HDD usado','ACESSÓRIOS',NULL,NULL),('36b586fb-2d88-44ab-8fef-56e3d8b39c19','2024-09-13','DESCARTE',1,'SONY','Almoxarifado 014 - Arm. 1| P1','VPL-EX70','PROJETOR','Com defeito, não liga\r\nLâmpada nova - pirata','NÃO A SUB CATEGORIAS',NULL,107549),('3bb1d460-4820-434b-bbdd-4b7552f2439d','2024-09-13','DESCARTE',1,'EPSON','Almoxarifado 014 - Arm. 1| P1','H309A','PROJETOR','Funcionando','NÃO A SUB CATEGORIAS',NULL,123831),('462fd91f-b9f4-4793-9f90-bfe727334ff8','2024-09-17','MATERIAL PARA INSTALAÇÃO',3,'DATA LAMPADAS','Almoxarifado 014 - Arm. 1| P2','ELPLP 78','LÂMPADA DE PROJETOR','Nova','ELÉTRICAS',NULL,NULL),('46a517d4-98a3-4cf7-b2d1-1aba8139ee22','2024-09-13','INFORMÁTICA',1,'LG','Almoxarifado 014 - Arm. 1| P1','GH22NS30','DVD REWRITER','','ACESSÓRIOS',NULL,NULL),('47d1eb5b-0ad4-4755-bf49-4084f1692685','2024-09-18','MATERIAL PARA INSTALAÇÃO',1,'HDL','Almoxarifado 014 - Arm. 1| P2','FEC-91LA','FECHO ELETROMAGNÉTICO','','OUTROS',NULL,91948),('48d64990-8340-4a40-bef1-22f82d0716f3','2024-09-18','MATERIAL DE CONSUMO',1,'SIEMENS','Almoxarifado 014 - Arm. 1| P2','OPEN STAGE 15 HFA','APARELHO TELEFÔNICO','Vem com fonte de energia dois pinos','ITEM USADO',NULL,NULL),('4b5b3dd1-cf30-4f03-a23b-5f579fc59b8e','2024-09-18','INFORMÁTICA',1,'GENÉRICO','Sala 229 - 2° Andar | Sala do Flávio Uber','GENÉRICA','MÁQUINA','Possui as seguintes configurações:\r\n- i7 3770\r\n- 8 GB\r\n- SATA 160 GB\r\n- SSD 128 GB','EQUIPAMENTOS',NULL,109177),('4bd53bbc-9aae-4f3b-aec7-7b216210922b','2024-09-18','MATERIAL PARA INSTALAÇÃO',2,'GENÉRICO','Almoxarifado 014 - Arm. 1| P2','GENÉRICO','PARAFUSOS DIVERSOS','','ELÉTRICAS',NULL,91948),('4e432a3f-b3e9-4463-9839-64de6a4c73ae','2024-09-17','INFORMÁTICA',1,'WESTERN DIGITAL','Almoxarifado 014 - Arm. 1| P1','WD2500AAJS','HDD - 250 GB','HDD usado','ACESSÓRIOS',NULL,NULL),('4ef09634-d9f7-43f3-aed9-f605157e439c','2024-09-17','MATERIAL PARA INSTALAÇÃO',2,'TP-LINK','Almoxarifado 014 - Arm. 1| P2','TL-PS110U','PRINT SERVER','Single USB 2.0 Port Fast Ethernet','OUTROS',NULL,NULL),('50f8992e-da24-4956-8cc5-5ca12819939f','2024-09-17','INFORMÁTICA',1,'SANSUNG','Almoxarifado 014 - Arm. 1| P1','HD502HI','HDD - 500 GB','HDD usado','ACESSÓRIOS',NULL,NULL),('524477b7-e57d-45ee-90e1-15fbe3fa8777','2024-09-13','INFORMÁTICA',1,'LG','Almoxarifado 014 - Arm. 1| P1','GH22NS50','DVD REWRITER','','ACESSÓRIOS',NULL,NULL),('54ba3b64-4eb3-4732-9dfd-191b60781dfc','2024-09-13','DESCARTE',1,'SONY','Almoxarifado 014 - Arm. 1| P1','VPL-CS7','PROJETOR','Defeito no LCD\r\nnão forma cores \"Amarelo\"','NÃO A SUB CATEGORIAS',NULL,83850),('59ce08cf-48b1-40e7-aeb6-a3dbb5f97fc5','2024-09-18','INFORMÁTICA',1,'GENÉRICO','Almoxarifado 014 - Arm. 1| P2','GENÉRICO','CABO MACHO VGA PARA VGA','','ACESSÓRIOS',NULL,NULL),('5abdf34e-6473-4ce0-b0b8-f8d85afb22c8','2024-09-17','INFORMÁTICA',3,'SANSUNG','Almoxarifado 014 - Arm. 1| P1','SP0411N','HDD - 40 GB','HDD\'s usados','ACESSÓRIOS',NULL,NULL),('5f6e40de-c7fd-457e-9845-5e37405734af','2024-09-18','INFORMÁTICA',1,'DELL','Almoxarifado 014 - Arm. 1| P1','GENÉRICO','SUPORTE DE HDD DELL','Suporte azul','ACESSÓRIOS',NULL,NULL),('61eaaeb0-7c71-4cd2-9f3a-d7444bda7031','2024-09-13','INFORMÁTICA',4,'PRONEER','Almoxarifado 014 - Arm. 1| P1','DVR-215DSV','DVD / CD WRITER','','ACESSÓRIOS',NULL,NULL),('62ecd6b9-4cac-4df5-8f7f-49d2aaabc462','2024-09-17','INFORMÁTICA',2,'SEAGATE BARRACUDA 7200.7','Almoxarifado 014 - Arm. 1| P1','ST340014A','HDD - 40 GB','HDD\'s usados','ACESSÓRIOS',NULL,NULL),('641074b4-ca39-4b10-809c-7568bf2eab55','2024-09-17','DESCARTE',1,'NÃO IDENTIFICADO','Almoxarifado 014 - Arm. 1| P2','NÃO IDENTIFICADO','TESTADOR DE CABOS DE REDE','','NÃO A SUB CATEGORIAS',NULL,NULL),('6cd8eb5b-1e46-4aa5-bd8e-22e699615483','2024-09-13','DESCARTE',1,'SONY','Almoxarifado 014 - Arm. 1| P1','VPL-ES5','PROJETOR','Verificar defeito','NÃO A SUB CATEGORIAS',NULL,123517),('6ce25afc-8fc7-42e0-bf88-f15b5c9cd579','2024-09-17','INFORMÁTICA',1,'SANSUNG','Almoxarifado 014 - Arm. 1| P1','HD161HJ','HDD - 160 GB','HDD usado','ACESSÓRIOS',NULL,NULL),('6f0477f7-0865-4c2e-b64f-3b3e3f011635','2024-09-17','INFORMÁTICA',1,'SUPERA THINAGE','Almoxarifado 014 - Arm. 1| P1','NÃO IDENTIFICADO','MÁQUINA ANTIGA LIN','Máquina antiga usando nos laboratórios','EQUIPAMENTOS',NULL,139508),('6f6b0a34-eb45-45f8-b377-ea67d982fc9b','2024-09-13','INFORMÁTICA',20,'EVOLUT','Almoxarifado 014 - Arm. 1| P1','EO-201','TECLADO DESKTOP','Conector USB\r\nTeclados novos','EQUIPAMENTOS',NULL,NULL),('704f3fd1-8d19-444b-91af-e925186d5b80','2024-09-17','INFORMÁTICA',1,'SEAGATE BARRACUDA 7200.9','Almoxarifado 014 - Arm. 1| P1','ST31160811AS','HDD - 160 GB','HDD usado | win 10','ACESSÓRIOS',NULL,NULL),('73f35d03-d2b8-43a1-90a4-57430c2610a7','2024-09-17','DESCARTE',1,'NÃO IDENTIFICADO','Almoxarifado 014 - Arm. 1| P2','NÃO IDENTIFICADO','MULTIMETER','','NÃO A SUB CATEGORIAS',NULL,NULL),('7639880f-25cb-4910-8363-fa837f70e17f','2024-09-17','INFORMÁTICA',1,'SUPERA THINAGE','Almoxarifado 014 - Arm. 1| P1','NÃO IDENTIFICADO','MÁQUINA ANTIGA LIN','Máquina usada antigamente nos laboratórios','EQUIPAMENTOS',NULL,139509),('7a7840ca-d3d4-437d-a841-cb3371865020','2024-09-17','INFORMÁTICA',2,'SEAGATE','Almoxarifado 014 - Arm. 1| P1','BARRACUDA 7200.12','HDD - 500 GB','HDD\'s usados','ACESSÓRIOS',NULL,NULL),('7b7ed23f-0cc5-412d-993f-ec7455f280d5','2024-09-11','INFORMÁTICA',6,'LENOVO','Almoxarifado 014 - Arm. 4 | P2','NÃO POSSUI','KIT INCOMPLETO LENOVO 2024','','ACESSÓRIOS',NULL,0),('7c5cebb7-236e-48a9-9a17-35b34869b3c2','2024-09-18','MATERIAL DE CONSUMO',1,'RMVB PLAYER','Almoxarifado 014 - Arm. 1| P2','RM-2009S','HDD PLAYER','Kit com: \r\n- Cabo Macho USB para USB\r\n- Fonte de energia Model. SCP0502000P','ITEM USADO',NULL,91948),('7efbd5eb-c0d5-4b4f-8827-591e8378365f','2024-09-13','DESCARTE',1,'SONY','Almoxarifado 014 - Arm. 1| P1','VPL-EX3','PROJETOR','','NÃO A SUB CATEGORIAS',NULL,92101),('819cd4c6-9b57-4efd-a901-568d3cb0c857','2024-09-17','INFORMÁTICA',9,'DIAMONDMAX PLUS 8','Almoxarifado 014 - Arm. 1| P1','6E040L0','HDD - 40 GB','3 Unidades HDD\'s usados\r\n6 Unidades HDD\'s novos','ACESSÓRIOS',NULL,NULL),('87ceb63d-5c32-4c09-a6c1-b8a786dab102','2024-09-13','DESCARTE',1,'SONY','Almoxarifado 014 - Arm. 1| P1','VPL-ES3','PROJETOR','','NÃO A SUB CATEGORIAS',NULL,93624),('88ba0637-b4a0-46bc-a7e0-b1de16bf2b81','2024-09-17','MATERIAL PARA INSTALAÇÃO',1,'SONY','Almoxarifado 014 - Arm. 1| P2','VPL ES5','LÂMPADA DE PROJETOR','Usada','ELÉTRICAS',NULL,NULL),('8949ca70-60a1-4093-9344-18780076606b','2024-09-17','INFORMÁTICA',6,'TP-LINK','Almoxarifado 014 - Arm. 1| P2','TL-MR3020','ROTEADOR PORTÁTIL','Portable 3G/4G Wireles N Router','EQUIPAMENTOS',NULL,NULL),('935dd96c-c166-4ec2-b447-f7918549c360','2024-09-17','MATERIAL PARA INSTALAÇÃO',1,'EPSON','Almoxarifado 014 - Arm. 1| P2','LITE X10+','LÂMPADA DE PROJETOR','','ELÉTRICAS',NULL,NULL),('9d50b5dc-499a-422d-bbb4-6a420a271483','2024-09-17','INFORMÁTICA',2,'SANSUNG','Almoxarifado 014 - Arm. 1| P1','HD161GJ','HDD - 160 GB','HDD\'s usados','ACESSÓRIOS',NULL,NULL),('a14e717f-a57a-40eb-b19c-50481ac81cc2','2024-09-17','FERRAMENTA',200,'NÃO IDENTIFICADO','Almoxarifado 014 - Arm. 1| P2','NÃO IDENTIFICADO','LACRE DE SEGURANÇA MALOTE','','NÃO SUB CATEGORIAS',NULL,NULL),('a6383334-70aa-4fbb-a881-5b035669add7','2024-09-17','INFORMÁTICA',1,'DIAMONDMAX PLUS 9','Almoxarifado 014 - Arm. 1| P1','6Y060L0421001','HDD - 60 GB','HDD usado','ACESSÓRIOS',NULL,NULL),('ad2caa17-c216-4541-8435-9a234fe27a18','2024-09-13','DESCARTE',1,'SONY','Almoxarifado 014 - Arm. 1| P1','VPL-ES5','PROJETOR','','NÃO A SUB CATEGORIAS',NULL,107550),('b43531d3-7cc1-4dc1-866d-dfc2d667576a','2024-09-18','MATERIAL PARA INSTALAÇÃO',1,'COIMBRA','Almoxarifado 014 - Arm. 1| P2','MOLA COIMBRA 453 - OURO','MOLA AUTOMÁTICA PARA PORTAS','Até 70 kg','OUTROS',NULL,NULL),('bcfecfd3-99b4-46b6-b7a0-0b33be191a12','2024-09-11','INFORMÁTICA',6,'LENOVO','Almoxarifado 014 - Arm. 4 | P2','NÃO POSSUI','KIT COMPLETO LENOVO 2024','O kit completo possui os seguintes itens:- 1 UN Cabo USB de impressora;- 1 UN Cabo de força 3 pinos;- 1 UN Mouse Pad LENOVO;- 1 UN Organizador de cabos;- 1 UN Antena de rede; e - 2 UN Manual de usuário.','ACESSÓRIOS',NULL,0),('bdc98588-7a70-4497-85d1-058ea0b40af9','2024-09-18','MATERIAL PARA INSTALAÇÃO',1,'D-LINK','Almoxarifado 014 - Arm. 1| P2','AF1805-A','FONTE DE ALIMENTAÇÃO MODEM ROTEADOR','100-120 V ~ 0.4A','REDE',NULL,NULL),('c0060fc3-db21-49f0-b848-38895c6d1cbb','2024-09-13','DESCARTE',1,'EPSON','Almoxarifado 014 - Arm. 1| P1','EMP-S5','PROJETOE','Trocar lâmpada, filtro e fazer limpeza','NÃO A SUB CATEGORIAS',NULL,99196),('c581b2d8-3bff-47d6-853f-34a22c2345a3','2024-09-18','INFORMÁTICA',1,'WESTERN DIGITAL','Almoxarifado 014 - Arm. 1| P1','WD10EARS','HDD - 1000 GB','HDD usado','ACESSÓRIOS',NULL,NULL),('c597803b-0863-4881-8647-5ea98cf598c3','2024-09-18','MATERIAL DE CONSUMO',1,'HP','Almoxarifado 014 - Arm. 1| P2','CN46TC70CG','CÂMERA FOTOGRÁFICA','','ITEM USADO',NULL,91948),('cae92b59-da10-4362-b137-3164dfeb8ba6','2024-09-17','MATERIAL PARA INSTALAÇÃO',1,'EPSON','Almoxarifado 014 - Arm. 1| P2','X24','LÂMPADA DE PROJETOR','','ELÉTRICAS',NULL,NULL),('d1cf4978-c12b-4d60-83a8-adb9135598ee','2024-09-13','MATERIAL PARA INSTALAÇÃO',2,'SEM ESPECIFICAÇÃO','Almoxarifado 014 - Arm. 1| P1','SEM ESPECIFICAÇÃO','SUPORTE DE FIXAÇÃO DE MÁQUINA SUPERA','Suporte usado para fixação de máquinas Supera dentro dos laborátorios','OUTROS',NULL,139509),('dcf83f10-d9c1-47fd-b4f0-fd6402d9e7a0','2024-09-11','INFORMÁTICA',28,'LENOVO','Almoxarifado 014 - Arm. 0 | P2','NÃO POSSUI','KIT COMPLETO LENOVO 2024','O kit completo possui os seguintes itens:\r\n- 1 UN Cabo USB de impressora;\r\n- 1 UN Cabo de força 3 pinos;\r\n- 1 UN Mouse Pad LENOVO;\r\n- 1 UN Organizador de cabos;\r\n- 1 UN Antena de rede; e\r\n- 2 UN Manual de usuário.','ACESSÓRIOS',NULL,0),('dd24c981-cbd9-407b-a6b5-9c1b08a15ba9','2024-09-17','INFORMÁTICA',1,'SEAGATE BARRACUDA 7200.7','Almoxarifado 014 - Arm. 1| P1','ST380013AS','HDD - 80 GB','HDD usado','ACESSÓRIOS',NULL,NULL),('de3d51b5-ba36-47af-9bce-5fa2bf01bcb1','2024-09-17','INFORMÁTICA',1,'WESTERN DIGITAL','Almoxarifado 014 - Arm. 1| P1','WD5000AAKS - 00UU3A0','HDD - 500 GB','HD usado','PERIFÉRICOS',NULL,NULL),('dfb2f02a-bfa5-45ca-96b2-b8d35c5be6e0','2024-09-13','DESCARTE',1,'SONY','Almoxarifado 014 - Arm. 1| P1','H368A','PROJETOR','Não funcionando','NÃO A SUB CATEGORIAS',NULL,135623),('e25661c9-b645-48bc-a83a-0b8a66c678ec','2024-09-17','INFORMÁTICA',1,'SEAGATE BARRACUDA 7200.10','Almoxarifado 014 - Arm. 1| P1','ST3250310AS','HDD - 250 GB','HDD usado','ACESSÓRIOS',NULL,NULL),('e36f1644-3ea4-48ad-938f-1a6208546f8d','2024-09-17','MATERIAL PARA INSTALAÇÃO',1,'NÃO IDENTIFICADA','Almoxarifado 014 - Arm. 1| P2','E180','LÂMPADA DE PROJETOR','Com defeito','ELÉTRICAS',NULL,NULL),('e8b0ec8d-37d9-47eb-a2a5-f6c3385d234b','2024-09-13','INFORMÁTICA',1,'HL- DATA STORAGE','Almoxarifado 014 - Arm. 1| P1','DH10N','DVD-ROM DRIVE','Trocar correia\r\nServidor - Sala 234 - Anderson','ACESSÓRIOS',NULL,NULL),('ec2bcb06-eb1a-4fff-b7ab-27964f01aed0','2024-09-17','INFORMÁTICA',1,'DIAMONDMAX 10','Almoxarifado 014 - Arm. 1| P1','6V200E0','HDD - 200 GB','HDD usado','ACESSÓRIOS',NULL,NULL),('f3bce3f5-a3e5-4a89-a387-f9e101012933','2024-09-17','MATERIAL PARA INSTALAÇÃO',2,'TP-LINK','Almoxarifado 014 - Arm. 1| P2','NC220','CÂMERA CLOUD','Câmera cloud com visão noturna, 300Mbps WI-FI','OUTROS',NULL,NULL),('f40733c7-97b5-4d14-b7f8-dec787794adb','2024-09-13','DESCARTE',1,'SONY','Almoxarifado 014 - Arm. 1| P1','VPL-EX175','PROJETOR','','NÃO A SUB CATEGORIAS',NULL,123517),('f6310b2a-5270-4d34-a1dd-f5b77de89d81','2024-09-17','INFORMÁTICA',2,'DIAMONDMAX PLUS 9','Almoxarifado 014 - Arm. 1| P1','6Y080L0422611','HDD - 80 GB','HDD\'s usados','ACESSÓRIOS',NULL,NULL);
/*!40000 ALTER TABLE `items_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_itemsauditlog`
--

DROP TABLE IF EXISTS `items_itemsauditlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_itemsauditlog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `action` varchar(50) NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `user_id` int DEFAULT NULL,
  `item_id` varchar(36) DEFAULT NULL,
  `observation` varchar(300) NOT NULL,
  `changes` longtext NOT NULL DEFAULT (_utf8mb3''),
  `item_deletado` varchar(300) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `items_itemsauditlog_user_id_067da718_fk_auth_user_id` (`user_id`),
  KEY `items_itemsauditlog_item_id_e27abb97_fk` (`item_id`),
  CONSTRAINT `items_itemsauditlog_item_id_e27abb97_fk` FOREIGN KEY (`item_id`) REFERENCES `items_items` (`id`),
  CONSTRAINT `items_itemsauditlog_user_id_067da718_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_itemsauditlog`
--

LOCK TABLES `items_itemsauditlog` WRITE;
/*!40000 ALTER TABLE `items_itemsauditlog` DISABLE KEYS */;
INSERT INTO `items_itemsauditlog` VALUES (1,'Deletado','2024-09-09 13:09:06.781311',1,NULL,'Item \'MONITOR\' deletado.','{\"item_deleted\": true}','MONITOR'),(2,'Deletado','2024-09-09 13:09:18.538320',1,NULL,'Item \'MONITOR\' deletado.','{\"item_deleted\": true}','MONITOR'),(3,'Deletado','2024-09-09 13:11:58.851421',1,NULL,'Item \'MONITOR\' deletado.','{\"item_deleted\": true}','MONITOR'),(4,'Deletado','2024-09-09 13:12:01.725929',1,NULL,'Item \'MONITOR\' deletado.','{\"item_deleted\": true}','MONITOR'),(5,'Criado','2024-09-09 13:36:32.891466',NULL,NULL,'Item \'MONITOR13\' criado.','{\n  \"id\": {\n    \"old\": null,\n    \"new\": 12\n  },\n  \"name\": {\n    \"old\": null,\n    \"new\": \"MONITOR13\"\n  },\n  \"brand\": {\n    \"old\": null,\n    \"new\": \"SONY\"\n  },\n  \"model\": {\n    \"old\": null,\n    \"new\": \"TESTE\"\n  },\n  \"location\": {\n    \"old\": null,\n    \"new\": \"ALMOXARIFADO\"\n  },\n  \"category\": {\n    \"old\": null,\n    \"new\": \"FERRAMENTA\"\n  },\n  \"sub_category\": {\n    \"old\": null,\n    \"new\": \"NÃO SUB CATEGORIAS\"\n  },\n  \"quantity\": {\n    \"old\": null,\n    \"new\": 10\n  },\n  \"create_at\": {\n    \"old\": null,\n    \"new\": \"2024-09-09\"\n  },\n  \"finished_at\": {\n    \"old\": null,\n    \"new\": null\n  },\n  \"locality\": {\n    \"old\": null,\n    \"new\": \"\"\n  },\n  \"observation\": {\n    \"old\": null,\n    \"new\": \"\"\n  },\n  \"modified_by\": {\n    \"old\": null,\n    \"new\": null\n  }\n}','MONITOR13'),(6,'Deletado','2024-09-10 11:19:24.479862',1,NULL,'Item \'MONITOR\' deletado.','{\"item_deleted\": true}','MONITOR'),(7,'Criado','2024-09-10 12:27:23.404392',NULL,NULL,'Item \'MONITOR13\' criado.','{\n  \"id\": {\n    \"old\": null,\n    \"new\": 16\n  },\n  \"name\": {\n    \"old\": null,\n    \"new\": \"MONITOR13\"\n  },\n  \"brand\": {\n    \"old\": null,\n    \"new\": \"SONY\"\n  },\n  \"model\": {\n    \"old\": null,\n    \"new\": \"TESTE\"\n  },\n  \"location\": {\n    \"old\": null,\n    \"new\": \"ALMOXARIFADO\"\n  },\n  \"category\": {\n    \"old\": null,\n    \"new\": \"MATERIAL PARA INSTALAÇÃO\"\n  },\n  \"sub_category\": {\n    \"old\": null,\n    \"new\": \"ELÉTRICAS\"\n  },\n  \"quantity\": {\n    \"old\": null,\n    \"new\": 10\n  },\n  \"create_at\": {\n    \"old\": null,\n    \"new\": \"2024-09-10\"\n  },\n  \"finished_at\": {\n    \"old\": null,\n    \"new\": null\n  },\n  \"locality\": {\n    \"old\": null,\n    \"new\": \"\"\n  },\n  \"observation\": {\n    \"old\": null,\n    \"new\": \"\"\n  },\n  \"modified_by\": {\n    \"old\": null,\n    \"new\": null\n  }\n}','MONITOR13'),(8,'Criado','2024-09-10 13:43:50.342783',1,NULL,'Item \'MÁQUINA\' criado.','','MÁQUINA'),(9,'Editado','2024-09-10 13:46:57.155603',1,NULL,'Item \'MONITOR LED\' editado.','','MONITOR LED'),(10,'Retirado: 3 UN','2024-09-10 13:47:22.661819',1,NULL,'Quantidade do item \'MONITOR13\' reduzida de 10 para 7.','','MONITOR13'),(11,'Retirado: 3 UN','2024-09-10 13:48:17.252775',1,NULL,'Quantidade do item \'MONITOR13\' reduzida de 7 para 4.','','MONITOR13'),(12,'Deletado','2024-09-10 13:55:50.308766',1,NULL,'Item \'MONITOR LED\' deletado.','{\"item_deleted\": true}','MONITOR LED'),(13,'Deletado','2024-09-10 13:55:53.600973',1,NULL,'Item \'MONITOR13\' deletado.','{\"item_deleted\": true}','MONITOR13'),(14,'Deletado','2024-09-10 13:55:56.332285',1,NULL,'Item \'MÁQUINA\' deletado.','{\"item_deleted\": true}','MÁQUINA'),(15,'Deletado','2024-09-10 13:55:59.513354',1,NULL,'Item \'MONITOR\' deletado.','{\"item_deleted\": true}','MONITOR'),(16,'Deletado','2024-09-10 13:56:03.045599',1,NULL,'Item \'MONITOR13\' deletado.','{\"item_deleted\": true}','MONITOR13'),(17,'Deletado','2024-09-10 13:56:06.276452',1,NULL,'Item \'MONITOR13\' deletado.','{\"item_deleted\": true}','MONITOR13'),(18,'Deletado','2024-09-10 13:56:09.682432',1,NULL,'Item \'MONITOR13\' deletado.','{\"item_deleted\": true}','MONITOR13'),(19,'Deletado','2024-09-10 13:56:12.788323',1,NULL,'Item \'MONITOR13\' deletado.','{\"item_deleted\": true}','MONITOR13'),(20,'Deletado','2024-09-10 13:56:15.548361',1,NULL,'Item \'MONITOR13\' deletado.','{\"item_deleted\": true}','MONITOR13'),(21,'Deletado','2024-09-10 13:56:18.533054',1,NULL,'Item \'MONITOR13\' deletado.','{\"item_deleted\": true}','MONITOR13'),(22,'Deletado','2024-09-10 13:56:21.534712',1,NULL,'Item \'MONITOR13\' deletado.','{\"item_deleted\": true}','MONITOR13'),(23,'Deletado','2024-09-10 13:56:24.291224',1,NULL,'Item \'MONITOR13\' deletado.','{\"item_deleted\": true}','MONITOR13'),(24,'Criado','2024-09-10 14:25:18.102877',1,NULL,'Item \'MÁQUINA\' criado.','','MÁQUINA'),(25,'Criado','2024-09-10 14:28:35.513132',1,NULL,'Item \'MÁQUINA3\' criado.','','MÁQUINA3'),(26,'Criado','2024-09-11 12:11:16.768102',1,NULL,'Item \'MÁQUINA3\' criado.','','MÁQUINA3'),(27,'Deletado','2024-09-11 13:56:43.586438',1,NULL,'Item \'MÁQUINA3\' deletado.','{\"item_deleted\": true}','MÁQUINA3'),(28,'Deletado','2024-09-11 13:56:48.848339',1,NULL,'Item \'MÁQUINA3\' deletado.','{\"item_deleted\": true}','MÁQUINA3'),(29,'Deletado','2024-09-11 13:56:53.679522',1,NULL,'Item \'MÁQUINA\' deletado.','{\"item_deleted\": true}','MÁQUINA'),(30,'Criado','2024-09-11 14:35:30.055099',1,'25d50ee6-9872-4663-981e-7d00cb073605','Item \'KIT COMPLETO LENOVO 2024\' criado.','','KIT COMPLETO LENOVO 2024'),(31,'Criado','2024-09-11 14:43:28.128039',1,'dcf83f10-d9c1-47fd-b4f0-fd6402d9e7a0','Item \'KIT COMPLETO LENOVO 2024\' criado.','','KIT COMPLETO LENOVO 2024'),(32,'Criado','2024-09-11 14:52:49.865455',1,'bcfecfd3-99b4-46b6-b7a0-0b33be191a12','Item \'KIT COMPLETO LENOVO 2024\' criado.','','KIT COMPLETO LENOVO 2024'),(33,'Criado','2024-09-11 14:54:12.623083',1,'7b7ed23f-0cc5-412d-993f-ec7455f280d5','Item \'KIT INCOMPLETO LENOVO 2024\' criado.','','KIT INCOMPLETO LENOVO 2024'),(34,'Retirado: 22 UN','2024-09-11 14:54:47.421477',1,'bcfecfd3-99b4-46b6-b7a0-0b33be191a12','Quantidade do item \'KIT COMPLETO LENOVO 2024\' reduzida de 28 para 6.','','KIT COMPLETO LENOVO 2024'),(35,'Criado','2024-09-13 13:31:41.906693',1,'1d897fab-0364-46d0-b8ac-8a8d4807db12','Item \'PROJETOR\' criado.','','PROJETOR'),(36,'Criado','2024-09-13 13:32:55.726304',1,'0435bf3b-818e-4642-902f-67bf992a4d1c','Item \'PROJETOR\' criado.','','PROJETOR'),(37,'Editado','2024-09-13 13:33:27.464692',1,'1d897fab-0364-46d0-b8ac-8a8d4807db12','Item \'PROJETOR\' editado.','','PROJETOR'),(38,'Criado','2024-09-13 13:34:34.441762',1,'dfb2f02a-bfa5-45ca-96b2-b8d35c5be6e0','Item \'PROJETOR\' criado.','','PROJETOR'),(39,'Criado','2024-09-13 13:35:53.762648',1,'6cd8eb5b-1e46-4aa5-bd8e-22e699615483','Item \'PROJETOR\' criado.','','PROJETOR'),(40,'Criado','2024-09-13 13:37:06.124544',1,'f40733c7-97b5-4d14-b7f8-dec787794adb','Item \'PROJETOR\' criado.','','PROJETOR'),(41,'Criado','2024-09-13 13:38:04.297838',1,'ad2caa17-c216-4541-8435-9a234fe27a18','Item \'PROJETOR\' criado.','','PROJETOR'),(42,'Criado','2024-09-13 13:48:19.198380',1,NULL,'Item \'MÁQUINA\' criado.','','MÁQUINA'),(43,'Criado','2024-09-13 13:55:22.156184',1,'d1cf4978-c12b-4d60-83a8-adb9135598ee','Item \'SUPORTE DE FIXAÇÃO DE MÁQUINA SUPERA\' criado.','','SUPORTE DE FIXAÇÃO DE MÁQUINA SUPERA'),(44,'Criado','2024-09-13 13:56:23.230185',1,NULL,'Item \'PROJETOR\' criado.','','PROJETOR'),(45,'Deletado','2024-09-13 13:59:28.253218',1,NULL,'Item \'PROJETOR\' deletado.','{\"item_deleted\": true}','PROJETOR'),(46,'Criado','2024-09-13 13:59:47.115095',1,'3bb1d460-4820-434b-bbdd-4b7552f2439d','Item \'PROJETOR\' criado.','','PROJETOR'),(47,'Criado','2024-09-13 14:01:11.862692',1,'54ba3b64-4eb3-4732-9dfd-191b60781dfc','Item \'PROJETOR\' criado.','','PROJETOR'),(48,'Criado','2024-09-13 14:02:22.299678',1,'36b586fb-2d88-44ab-8fef-56e3d8b39c19','Item \'PROJETOR\' criado.','','PROJETOR'),(49,'Editado','2024-09-13 14:10:32.397755',1,NULL,'Item \'MÁQUINA\' editado.','','MÁQUINA'),(50,'Criado','2024-09-13 14:14:07.612288',1,'6f6b0a34-eb45-45f8-b377-ea67d982fc9b','Item \'TECLADO DESKTOP\' criado.','','TECLADO DESKTOP'),(51,'Criado','2024-09-13 14:17:48.564894',1,'c0060fc3-db21-49f0-b848-38895c6d1cbb','Item \'PROJETOE\' criado.','','PROJETOE'),(52,'Criado','2024-09-13 14:20:40.813328',1,'61eaaeb0-7c71-4cd2-9f3a-d7444bda7031','Item \'DVD / CD WRITER\' criado.','','DVD / CD WRITER'),(53,'Criado','2024-09-13 14:21:53.869975',1,'46a517d4-98a3-4cf7-b2d1-1aba8139ee22','Item \'DVD REWRITER\' criado.','','DVD REWRITER'),(54,'Criado','2024-09-13 14:22:35.869295',1,'524477b7-e57d-45ee-90e1-15fbe3fa8777','Item \'DVD REWRITER\' criado.','','DVD REWRITER'),(55,'Criado','2024-09-13 14:23:49.562530',1,'2ae4ff65-d73e-4744-a0fd-d1074eb2d68e','Item \'DVD WRITER\' criado.','','DVD WRITER'),(56,'Criado','2024-09-13 14:27:34.827307',1,'e8b0ec8d-37d9-47eb-a2a5-f6c3385d234b','Item \'DVD-ROM DRIVE\' criado.','','DVD-ROM DRIVE'),(57,'Criado','2024-09-13 14:28:30.327378',1,'7efbd5eb-c0d5-4b4f-8827-591e8378365f','Item \'PROJETOR\' criado.','','PROJETOR'),(58,'Criado','2024-09-13 14:29:04.562284',1,'87ceb63d-5c32-4c09-a6c1-b8a786dab102','Item \'PROJETOR\' criado.','','PROJETOR'),(59,'Criado','2024-09-13 14:42:01.912551',1,'0dafb06d-3139-4d5b-a32c-158123f1cc3d','Item \'PROJETOR\' criado.','','PROJETOR'),(60,'Deletado','2024-09-16 18:31:11.031969',1,NULL,'Item \'MÁQUINA\' deletado.','{\"item_deleted\": true}','MÁQUINA'),(61,'Criado','2024-09-17 17:32:37.111362',1,'7639880f-25cb-4910-8363-fa837f70e17f','Item \'MÁQUINA ANTIGA LIN\' criado.','','MÁQUINA ANTIGA LIN'),(62,'Criado','2024-09-17 17:33:09.039495',1,'6f0477f7-0865-4c2e-b64f-3b3e3f011635','Item \'MÁQUINA ANTIGA LIN\' criado.','','MÁQUINA ANTIGA LIN'),(63,'Criado','2024-09-17 17:42:58.387296',1,'7a7840ca-d3d4-437d-a841-cb3371865020','Item \'HDD - 500 GB\' criado.','','HDD - 500 GB'),(64,'Criado','2024-09-17 17:44:58.078012',1,NULL,'Item \'HDD - 1000 GB\' criado.','','HDD - 1000 GB'),(65,'Criado','2024-09-17 17:46:19.206642',1,'ec2bcb06-eb1a-4fff-b7ab-27964f01aed0','Item \'HDD - 200 GB\' criado.','','HDD - 200 GB'),(66,'Editado','2024-09-17 17:46:48.773679',1,'ec2bcb06-eb1a-4fff-b7ab-27964f01aed0','Item \'HDD - 200 GB\' editado.','','HDD - 200 GB'),(67,'Criado','2024-09-17 17:50:18.856361',1,'dd24c981-cbd9-407b-a6b5-9c1b08a15ba9','Item \'HDD - 80 GB\' criado.','','HDD - 80 GB'),(68,'Criado','2024-09-17 17:51:41.858202',1,'de3d51b5-ba36-47af-9bce-5fa2bf01bcb1','Item \'HDD - 500 GB\' criado.','','HDD - 500 GB'),(69,'Criado','2024-09-17 17:53:44.764594',1,'a6383334-70aa-4fbb-a881-5b035669add7','Item \'HDD - 60 GB\' criado.','','HDD - 60 GB'),(70,'Criado','2024-09-17 17:54:50.175014',1,'f6310b2a-5270-4d34-a1dd-f5b77de89d81','Item \'HDD - 80 GB\' criado.','','HDD - 80 GB'),(71,'Criado','2024-09-17 17:55:57.239285',1,'313e4153-7797-4669-a626-d524944138db','Item \'HDD - 250 GB\' criado.','','HDD - 250 GB'),(72,'Criado','2024-09-17 17:57:17.075932',1,'62ecd6b9-4cac-4df5-8f7f-49d2aaabc462','Item \'HDD - 40 GB\' criado.','','HDD - 40 GB'),(73,'Criado','2024-09-17 17:58:04.927214',1,'5abdf34e-6473-4ce0-b0b8-f8d85afb22c8','Item \'HDD - 40 GB\' criado.','','HDD - 40 GB'),(74,'Editado','2024-09-17 17:59:01.981129',1,'5abdf34e-6473-4ce0-b0b8-f8d85afb22c8','Item \'HDD - 40 GB\' editado.','','HDD - 40 GB'),(75,'Criado','2024-09-17 18:00:15.281051',1,'12e1fdac-8afb-4894-84da-561c0ae49eba','Item \'HDD - 20 GB\' criado.','','HDD - 20 GB'),(76,'Criado','2024-09-17 18:01:02.527399',1,'22cdc004-17d9-4d81-a717-f99c785d0e07','Item \'HDD - 80 GB\' criado.','','HDD - 80 GB'),(77,'Criado','2024-09-17 18:01:58.591083',1,'24795abf-3374-4b13-90a6-141172b1ab04','Item \'HDD - 160 GB\' criado.','','HDD - 160 GB'),(78,'Criado','2024-09-17 18:02:39.765499',1,'4e432a3f-b3e9-4463-9839-64de6a4c73ae','Item \'HDD - 250 GB\' criado.','','HDD - 250 GB'),(79,'Criado','2024-09-17 18:03:29.154220',1,'9d50b5dc-499a-422d-bbb4-6a420a271483','Item \'HDD - 160 GB\' criado.','','HDD - 160 GB'),(80,'Criado','2024-09-17 18:04:22.233000',1,'6ce25afc-8fc7-42e0-bf88-f15b5c9cd579','Item \'HDD - 160 GB\' criado.','','HDD - 160 GB'),(81,'Criado','2024-09-17 18:04:55.265392',1,'2c856073-2749-4ce9-83ce-8b3e78dad36a','Item \'HDD - 500 GB\' criado.','','HDD - 500 GB'),(82,'Criado','2024-09-17 18:05:41.919922',1,'e25661c9-b645-48bc-a83a-0b8a66c678ec','Item \'HDD - 250 GB\' criado.','','HDD - 250 GB'),(83,'Criado','2024-09-17 18:06:25.025862',1,'704f3fd1-8d19-444b-91af-e925186d5b80','Item \'HDD - 160 GB\' criado.','','HDD - 160 GB'),(84,'Editado','2024-09-17 18:07:18.381724',1,'704f3fd1-8d19-444b-91af-e925186d5b80','Item \'HDD - 160 GB\' editado.','','HDD - 160 GB'),(85,'Criado','2024-09-17 18:08:12.993681',1,'50f8992e-da24-4956-8cc5-5ca12819939f','Item \'HDD - 500 GB\' criado.','','HDD - 500 GB'),(86,'Criado','2024-09-17 18:11:22.375691',1,'819cd4c6-9b57-4efd-a901-568d3cb0c857','Item \'HDD - 40 GB\' criado.','','HDD - 40 GB'),(87,'Criado','2024-09-17 18:18:05.273611',1,'f3bce3f5-a3e5-4a89-a387-f9e101012933','Item \'CÂMERA CLOUD\' criado.','','CÂMERA CLOUD'),(88,'Criado','2024-09-17 18:21:50.233993',1,'1948d92a-23e8-441f-aa5a-efe03b053674','Item \'HUB USB\' criado.','','HUB USB'),(89,'Criado','2024-09-17 18:24:28.619518',1,'4ef09634-d9f7-43f3-aed9-f605157e439c','Item \'PRINT SERVER\' criado.','','PRINT SERVER'),(90,'Criado','2024-09-17 18:31:31.856214',1,'1dade55b-67ff-426d-9a4c-2eee7933fa12','Item \'PLACA DE CAPTURA\' criado.','','PLACA DE CAPTURA'),(91,'Criado','2024-09-17 18:36:53.929432',1,'2865e55e-4a90-4b13-9bda-15c33556c4af','Item \'ROTEADOR\' criado.','','ROTEADOR'),(92,'Criado','2024-09-17 19:18:25.676997',1,'8949ca70-60a1-4093-9344-18780076606b','Item \'ROTEADOR PORTÁTIL\' criado.','','ROTEADOR PORTÁTIL'),(93,'Criado','2024-09-17 19:23:32.263297',1,'2e6cac02-0fb1-4244-ac5e-9f86bed5eee0','Item \'LÂMPADA DE PROJETOR\' criado.','','LÂMPADA DE PROJETOR'),(94,'Criado','2024-09-17 20:14:45.706391',1,'cae92b59-da10-4362-b137-3164dfeb8ba6','Item \'LÂMPADA DE PROJETOR\' criado.','','LÂMPADA DE PROJETOR'),(95,'Criado','2024-09-17 20:15:37.356685',1,'e36f1644-3ea4-48ad-938f-1a6208546f8d','Item \'LÂMPADA DE PROJETOR\' criado.','','LÂMPADA DE PROJETOR'),(96,'Criado','2024-09-17 20:16:21.198447',1,'1f6236f0-a95e-43c9-9eff-c345d8ca2aea','Item \'LÂMPADA DE PROJETOR\' criado.','','LÂMPADA DE PROJETOR'),(97,'Criado','2024-09-17 20:16:52.331890',1,'88ba0637-b4a0-46bc-a7e0-b1de16bf2b81','Item \'LÂMPADA DE PROJETOR\' criado.','','LÂMPADA DE PROJETOR'),(98,'Criado','2024-09-17 20:17:48.446406',1,'462fd91f-b9f4-4793-9f90-bfe727334ff8','Item \'LÂMPADA DE PROJETOR\' criado.','','LÂMPADA DE PROJETOR'),(99,'Criado','2024-09-17 20:18:14.433610',1,'2ddd5c77-d559-469b-b9de-1db371be159c','Item \'LÂMPADA DE PROJETOR\' criado.','','LÂMPADA DE PROJETOR'),(100,'Criado','2024-09-17 20:18:36.398581',1,'935dd96c-c166-4ec2-b447-f7918549c360','Item \'LÂMPADA DE PROJETOR\' criado.','','LÂMPADA DE PROJETOR'),(101,'Editado','2024-09-17 20:29:50.742043',1,'462fd91f-b9f4-4793-9f90-bfe727334ff8','Item \'LÂMPADA DE PROJETOR\' editado.','','LÂMPADA DE PROJETOR'),(102,'Editado','2024-09-17 20:30:14.365001',1,'462fd91f-b9f4-4793-9f90-bfe727334ff8','Item \'LÂMPADA DE PROJETOR\' editado.','','LÂMPADA DE PROJETOR'),(103,'Criado','2024-09-17 20:31:13.667237',1,'73f35d03-d2b8-43a1-90a4-57430c2610a7','Item \'MULTIMETER\' criado.','','MULTIMETER'),(104,'Criado','2024-09-17 20:32:13.267053',1,'641074b4-ca39-4b10-809c-7568bf2eab55','Item \'TESTADOR DE CABOS DE REDE\' criado.','','TESTADOR DE CABOS DE REDE'),(105,'Criado','2024-09-17 20:36:01.917569',1,'a14e717f-a57a-40eb-b19c-50481ac81cc2','Item \'LACRE DE SEGURANÇA MALOTE\' criado.','','LACRE DE SEGURANÇA MALOTE'),(106,'Retirado: 1 UN','2024-09-17 20:54:38.010070',1,NULL,'Quantidade do item \'HDD - 1000 GB\' reduzida de 1 para 0.','','HDD - 1000 GB'),(107,'Deletado','2024-09-17 20:54:53.110798',1,NULL,'Item \'HDD - 1000 GB\' deletado.','{\"item_deleted\": true}','HDD - 1000 GB'),(108,'Criado','2024-09-17 21:53:35.316654',1,'2831b056-cf97-4bcf-8747-65d47cf00ea4','Item \'HDD - 250 GB\' criado.','','HDD - 250 GB'),(109,'Criado','2024-09-18 19:08:39.063683',1,'4b5b3dd1-cf30-4f03-a23b-5f579fc59b8e','Item \'MÁQUINA\' criado.','','MÁQUINA'),(110,'Criado','2024-09-18 19:29:13.542332',1,'c581b2d8-3bff-47d6-853f-34a22c2345a3','Item \'HDD - 1000 GB\' criado.','','HDD - 1000 GB'),(111,'Criado','2024-09-18 19:29:58.657076',1,'5f6e40de-c7fd-457e-9845-5e37405734af','Item \'SUPORTE DE HDD DELL\' criado.','','SUPORTE DE HDD DELL'),(112,'Criado','2024-09-18 19:34:50.045404',1,'59ce08cf-48b1-40e7-aeb6-a3dbb5f97fc5','Item \'CABO MACHO VGA PARA VGA\' criado.','','CABO MACHO VGA PARA VGA'),(113,'Criado','2024-09-18 19:40:22.891204',1,'48d64990-8340-4a40-bef1-22f82d0716f3','Item \'APARELHO TELEFÔNICO\' criado.','','APARELHO TELEFÔNICO'),(114,'Criado','2024-09-18 19:42:48.800051',1,'bdc98588-7a70-4497-85d1-058ea0b40af9','Item \'FONTE DE ALIMENTAÇÃO MODEM ROTEADOR\' criado.','','FONTE DE ALIMENTAÇÃO MODEM ROTEADOR'),(115,'Criado','2024-09-18 19:44:59.988904',1,'c597803b-0863-4881-8647-5ea98cf598c3','Item \'CÂMERA FOTOGRÁFICA\' criado.','','CÂMERA FOTOGRÁFICA'),(116,'Criado','2024-09-18 19:49:02.027277',1,'4bd53bbc-9aae-4f3b-aec7-7b216210922b','Item \'PARAFUSOS DIVERSOS\' criado.','','PARAFUSOS DIVERSOS'),(117,'Criado','2024-09-18 19:55:42.898304',1,'7c5cebb7-236e-48a9-9a17-35b34869b3c2','Item \'HDD PLAYER\' criado.','','HDD PLAYER'),(118,'Criado','2024-09-18 19:57:19.085741',1,'47d1eb5b-0ad4-4755-bf49-4084f1692685','Item \'FECHO ELETROMAGNÉTICO\' criado.','','FECHO ELETROMAGNÉTICO'),(119,'Criado','2024-09-18 19:58:34.787213',1,'0ace6436-7212-468c-bb47-6a1c7978c231','Item \'TALK ABOUT\' criado.','','TALK ABOUT'),(120,'Criado','2024-09-18 20:00:31.489763',1,'b43531d3-7cc1-4dc1-866d-dfc2d667576a','Item \'MOLA AUTOMÁTICA PARA PORTAS\' criado.','','MOLA AUTOMÁTICA PARA PORTAS');
/*!40000 ALTER TABLE `items_itemsauditlog` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-19 10:52:18
