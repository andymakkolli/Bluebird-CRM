-- MySQL dump 10.13  Distrib 5.1.41, for debian-linux-gnu (x86_64)
--
-- Host: crmdbprod    Database: senate_prod_c_template
-- ------------------------------------------------------
-- Server version	5.1.55-rel12.6-log

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
-- Table structure for table `civicrm_acl`
--

DROP TABLE IF EXISTS `civicrm_acl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_acl` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique table ID',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'ACL Name.',
  `deny` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Is this ACL entry Allow  (0) or Deny (1) ?',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Table of the object possessing this ACL entry (Contact, Group, or ACL Group)',
  `entity_id` int(10) unsigned DEFAULT NULL COMMENT 'ID of the object possessing this ACL',
  `operation` enum('All','View','Edit','Create','Delete','Grant','Revoke','Search') COLLATE utf8_unicode_ci NOT NULL COMMENT 'What operation does this ACL entry control?',
  `object_table` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The table of the object controlled by this ACL entry',
  `object_id` int(10) unsigned DEFAULT NULL COMMENT 'The ID of the object controlled by this ACL entry',
  `acl_table` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'If this is a grant/revoke entry, what table are we granting?',
  `acl_id` int(10) unsigned DEFAULT NULL COMMENT 'ID of the ACL or ACL group being granted/revoked',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  PRIMARY KEY (`id`),
  KEY `index_acl_id` (`acl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_acl`
--

LOCK TABLES `civicrm_acl` WRITE;
/*!40000 ALTER TABLE `civicrm_acl` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_acl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_acl_cache`
--

DROP TABLE IF EXISTS `civicrm_acl_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_acl_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique table ID',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'Foreign Key to Contact',
  `acl_id` int(10) unsigned NOT NULL COMMENT 'Foreign Key to ACL',
  `modified_date` date DEFAULT NULL COMMENT 'When was this cache entry last modified',
  PRIMARY KEY (`id`),
  KEY `index_acl_id` (`acl_id`),
  KEY `FK_civicrm_acl_cache_contact_id` (`contact_id`),
  CONSTRAINT `FK_civicrm_acl_cache_acl_id` FOREIGN KEY (`acl_id`) REFERENCES `civicrm_acl` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_acl_cache_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_acl_cache`
--

LOCK TABLES `civicrm_acl_cache` WRITE;
/*!40000 ALTER TABLE `civicrm_acl_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_acl_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_acl_contact_cache`
--

DROP TABLE IF EXISTS `civicrm_acl_contact_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_acl_contact_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact (could be null for anon user)',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_contact',
  `operation` enum('All','View','Edit','Create','Delete','Grant','Revoke') COLLATE utf8_unicode_ci NOT NULL COMMENT 'What operation does this user have permission on?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_user_contact_operation` (`user_id`,`contact_id`,`operation`),
  KEY `FK_civicrm_acl_contact_cache_contact_id` (`contact_id`),
  CONSTRAINT `FK_civicrm_acl_contact_cache_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_acl_contact_cache_user_id` FOREIGN KEY (`user_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_acl_contact_cache`
--

LOCK TABLES `civicrm_acl_contact_cache` WRITE;
/*!40000 ALTER TABLE `civicrm_acl_contact_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_acl_contact_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_acl_entity_role`
--

DROP TABLE IF EXISTS `civicrm_acl_entity_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_acl_entity_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique table ID',
  `acl_role_id` int(10) unsigned NOT NULL COMMENT 'Foreign Key to ACL Role (which is an option value pair and hence an implicit FK)',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Table of the object joined to the ACL Role (Contact or Group)',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'ID of the group/contact object being joined',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  PRIMARY KEY (`id`),
  KEY `index_role` (`acl_role_id`),
  KEY `index_entity` (`entity_table`,`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_acl_entity_role`
--

LOCK TABLES `civicrm_acl_entity_role` WRITE;
/*!40000 ALTER TABLE `civicrm_acl_entity_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_acl_entity_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_activity`
--

DROP TABLE IF EXISTS `civicrm_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_activity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique  Other Activity ID',
  `source_contact_id` int(10) unsigned DEFAULT NULL COMMENT 'Contact ID of the person scheduling or logging this Activity. Usually the authenticated user.',
  `source_record_id` int(10) unsigned DEFAULT NULL COMMENT 'Artificial FK to original transaction (e.g. contribution) IF it is not an Activity. Table can be figured out through activity_type_id, and further through component registry.',
  `activity_type_id` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'FK to civicrm_option_value.id, that has to be valid, registered activity type.',
  `subject` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The subject/purpose/short description of the activity.',
  `activity_date_time` datetime DEFAULT NULL COMMENT 'Date and time this activity is scheduled to occur. Formerly named scheduled_date_time.',
  `duration` int(10) unsigned DEFAULT NULL COMMENT 'Planned or actual duration of activity expressed in minutes. Conglomerate of former duration_hours and duration_minutes.',
  `location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Location of the activity (optional, open text).',
  `phone_id` int(10) unsigned DEFAULT NULL COMMENT 'Phone ID of the number called (optional - used if an existing phone number is selected).',
  `phone_number` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Phone number in case the number does not exist in the civicrm_phone table.',
  `details` text COLLATE utf8_unicode_ci COMMENT 'Details about the activity (agenda, notes, etc).',
  `status_id` int(10) unsigned DEFAULT NULL COMMENT 'ID of the status this activity is currently in. Foreign key to civicrm_option_value.',
  `priority_id` int(10) unsigned DEFAULT NULL COMMENT 'ID of the priority given to this activity. Foreign key to civicrm_option_value.',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent meeting ID (if this is a follow-up item). This is not currently implemented',
  `is_test` tinyint(4) DEFAULT '0',
  `medium_id` int(10) unsigned DEFAULT NULL COMMENT 'Activity Medium, Implicit FK to civicrm_option_value where option_group = encounter_medium.',
  `is_auto` tinyint(4) DEFAULT '0',
  `relationship_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Relationship ID',
  `is_current_revision` tinyint(4) DEFAULT '1',
  `original_id` int(10) unsigned DEFAULT NULL COMMENT 'Activity ID of the first activity record in versioning chain.',
  `result` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Currently being used to store result for survey activity. FK to option value.',
  `is_deleted` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_activity_source_contact_id` (`source_contact_id`),
  KEY `FK_civicrm_activity_phone_id` (`phone_id`),
  KEY `FK_civicrm_activity_parent_id` (`parent_id`),
  KEY `FK_civicrm_activity_relationship_id` (`relationship_id`),
  KEY `FK_civicrm_activity_original_id` (`original_id`),
  KEY `UI_source_record_id` (`source_record_id`),
  KEY `index_medium_id` (`medium_id`),
  KEY `index_is_current_revision` (`is_current_revision`),
  KEY `index_is_deleted` (`is_deleted`),
  KEY `UI_activity_type_id` (`activity_type_id`),
  CONSTRAINT `FK_civicrm_activity_original_id` FOREIGN KEY (`original_id`) REFERENCES `civicrm_activity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_activity_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `civicrm_activity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_activity_phone_id` FOREIGN KEY (`phone_id`) REFERENCES `civicrm_phone` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_activity_relationship_id` FOREIGN KEY (`relationship_id`) REFERENCES `civicrm_relationship` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_activity_source_contact_id` FOREIGN KEY (`source_contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_activity`
--

LOCK TABLES `civicrm_activity` WRITE;
/*!40000 ALTER TABLE `civicrm_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_activity_assignment`
--

DROP TABLE IF EXISTS `civicrm_activity_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_activity_assignment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Activity assignment id',
  `activity_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to the activity for this assignment.',
  `assignee_contact_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to the contact for this assignment.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_activity_assignee_contact_id` (`assignee_contact_id`,`activity_id`),
  KEY `FK_civicrm_activity_assignment_activity_id` (`activity_id`),
  CONSTRAINT `FK_civicrm_activity_assignment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `civicrm_activity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_activity_assignment_assignee_contact_id` FOREIGN KEY (`assignee_contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_activity_assignment`
--

LOCK TABLES `civicrm_activity_assignment` WRITE;
/*!40000 ALTER TABLE `civicrm_activity_assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_activity_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_activity_target`
--

DROP TABLE IF EXISTS `civicrm_activity_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_activity_target` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Activity target id',
  `activity_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to the activity for this target.',
  `target_contact_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to the contact for this target.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_activity_target_contact_id` (`target_contact_id`,`activity_id`),
  KEY `FK_civicrm_activity_target_activity_id` (`activity_id`),
  CONSTRAINT `FK_civicrm_activity_target_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `civicrm_activity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_activity_target_target_contact_id` FOREIGN KEY (`target_contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_activity_target`
--

LOCK TABLES `civicrm_activity_target` WRITE;
/*!40000 ALTER TABLE `civicrm_activity_target` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_activity_target` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_address`
--

DROP TABLE IF EXISTS `civicrm_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Address ID',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `location_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Location does this address belong to.',
  `is_primary` tinyint(4) DEFAULT '0' COMMENT 'Is this the primary address.',
  `is_billing` tinyint(4) DEFAULT '0' COMMENT 'Is this the billing address.',
  `street_address` varchar(96) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Concatenation of all routable street address components (prefix, street number, street name, suffix, unit number OR P.O. Box). Apps should be able to determine physical location with this data (for mapping, mail delivery, etc.).',
  `street_number` int(11) DEFAULT NULL COMMENT 'Numeric portion of address number on the street, e.g. For 112A Main St, the street_number = 112.',
  `street_number_suffix` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Non-numeric portion of address number on the street, e.g. For 112A Main St, the street_number_suffix = A',
  `street_number_predirectional` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Directional prefix, e.g. SE Main St, SE is the prefix.',
  `street_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Actual street name, excluding St, Dr, Rd, Ave, e.g. For 112 Main St, the street_name = Main.',
  `street_type` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'St, Rd, Dr, etc.',
  `street_number_postdirectional` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Directional prefix, e.g. Main St S, S is the suffix.',
  `street_unit` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Secondary unit designator, e.g. Apt 3 or Unit # 14, or Bldg 1200',
  `supplemental_address_1` varchar(96) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Supplemental Address Information, Line 1',
  `supplemental_address_2` varchar(96) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Supplemental Address Information, Line 2',
  `supplemental_address_3` varchar(96) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Supplemental Address Information, Line 3',
  `city` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'City, Town or Village Name.',
  `county_id` int(10) unsigned DEFAULT NULL COMMENT 'Which County does this address belong to.',
  `state_province_id` int(10) unsigned DEFAULT NULL COMMENT 'Which State_Province does this address belong to.',
  `postal_code_suffix` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Store the suffix, like the +4 part in the USPS system.',
  `postal_code` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Store both US (zip5) AND international postal codes. App is responsible for country/region appropriate validation.',
  `usps_adc` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'USPS Bulk mailing code.',
  `country_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Country does this address belong to.',
  `geo_code_1` double DEFAULT NULL COMMENT 'Latitude',
  `geo_code_2` double DEFAULT NULL COMMENT 'Longitude',
  `timezone` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Timezone expressed as a UTC offset - e.g. United States CST would be written as "UTC-6".',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `master_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Address ID',
  PRIMARY KEY (`id`),
  KEY `index_location_type` (`location_type_id`),
  KEY `index_is_primary` (`is_primary`),
  KEY `index_is_billing` (`is_billing`),
  KEY `index_street_name` (`street_name`),
  KEY `index_city` (`city`),
  KEY `FK_civicrm_address_contact_id` (`contact_id`),
  KEY `FK_civicrm_address_county_id` (`county_id`),
  KEY `FK_civicrm_address_state_province_id` (`state_province_id`),
  KEY `FK_civicrm_address_country_id` (`country_id`),
  KEY `dedupe_index_street_address` (`street_address`),
  KEY `dedupe_index_street_address_10` (`street_address`(10)),
  KEY `dedupe_index_postal_code` (`postal_code`),
  KEY `dedupe_index_street_address_8` (`street_address`(8)),
  KEY `dedupe_index_city_8` (`city`(8)),
  KEY `FK_civicrm_address_master_id` (`master_id`),
  CONSTRAINT `FK_civicrm_address_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_address_country_id` FOREIGN KEY (`country_id`) REFERENCES `civicrm_country` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_address_county_id` FOREIGN KEY (`county_id`) REFERENCES `civicrm_county` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_address_master_id` FOREIGN KEY (`master_id`) REFERENCES `civicrm_address` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_address_state_province_id` FOREIGN KEY (`state_province_id`) REFERENCES `civicrm_state_province` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_address`
--

LOCK TABLES `civicrm_address` WRITE;
/*!40000 ALTER TABLE `civicrm_address` DISABLE KEYS */;
INSERT INTO `civicrm_address` VALUES (4,NULL,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1031,NULL,NULL,NULL,1228,40.7143528,-74.0059731,NULL,NULL,NULL);
/*!40000 ALTER TABLE `civicrm_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_address_format`
--

DROP TABLE IF EXISTS `civicrm_address_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_address_format` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Format Id',
  `format` text COLLATE utf8_unicode_ci COMMENT 'The format of an address',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_address_format`
--

LOCK TABLES `civicrm_address_format` WRITE;
/*!40000 ALTER TABLE `civicrm_address_format` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_address_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_batch`
--

DROP TABLE IF EXISTS `civicrm_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_batch` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Address ID.',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Variable name/programmatic handle for this batch.',
  `label` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Friendly Name.',
  `description` text COLLATE utf8_unicode_ci COMMENT 'Description of this batch set.',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `created_date` datetime DEFAULT NULL COMMENT 'When was this item created',
  `modified_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `modified_date` datetime DEFAULT NULL COMMENT 'When was this item created',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_batch_created_id` (`created_id`),
  KEY `FK_civicrm_batch_modified_id` (`modified_id`),
  CONSTRAINT `FK_civicrm_batch_created_id` FOREIGN KEY (`created_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_batch_modified_id` FOREIGN KEY (`modified_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_batch`
--

LOCK TABLES `civicrm_batch` WRITE;
/*!40000 ALTER TABLE `civicrm_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_cache`
--

DROP TABLE IF EXISTS `civicrm_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT 'group name for cache element, useful in cleaning cache elements',
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Unique path name for cache element',
  `data` longtext COLLATE utf8_unicode_ci COMMENT 'data associated with this path',
  `component_id` int(10) unsigned DEFAULT NULL COMMENT 'Component that this menu item belongs to',
  `created_date` datetime DEFAULT NULL COMMENT 'When was the cache item created',
  `expired_date` datetime DEFAULT NULL COMMENT 'When should the cache item expire',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_group_path` (`group_name`,`path`),
  KEY `FK_civicrm_cache_component_id` (`component_id`),
  CONSTRAINT `FK_civicrm_cache_component_id` FOREIGN KEY (`component_id`) REFERENCES `civicrm_component` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_cache`
--

LOCK TABLES `civicrm_cache` WRITE;
/*!40000 ALTER TABLE `civicrm_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_campaign`
--

DROP TABLE IF EXISTS `civicrm_campaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_campaign` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Campaign ID.',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the Campaign.',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Title of the Campaign.',
  `description` text COLLATE utf8_unicode_ci COMMENT 'Full description of Campaign.',
  `start_date` datetime DEFAULT NULL COMMENT 'Date and time that Campaign starts.',
  `end_date` datetime DEFAULT NULL COMMENT 'Date and time that Campaign ends.',
  `campaign_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Campaign Type ID.Implicit FK to civicrm_option_value where option_group = campaign_type',
  `status_id` int(10) unsigned DEFAULT NULL COMMENT 'Campaign status ID.Implicit FK to civicrm_option_value where option_group = campaign_status',
  `external_identifier` int(10) unsigned DEFAULT NULL COMMENT 'Unique trusted external ID (generally from a legacy app/datasource). Particularly useful for deduping operations.',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Optional parent id for this Campaign.',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Is this Campaign enabled or disabled/cancelled?',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who created this Campaign.',
  `created_date` datetime DEFAULT NULL COMMENT 'Date and time that Campaign was created.',
  `last_modified_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who recently edited this Campaign.',
  `last_modified_date` datetime DEFAULT NULL COMMENT 'Date and time that Campaign was edited last time.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_external_identifier` (`external_identifier`),
  KEY `UI_campaign_type_id` (`campaign_type_id`),
  KEY `UI_campaign_status_id` (`status_id`),
  KEY `FK_civicrm_campaign_created_id` (`created_id`),
  KEY `FK_civicrm_campaign_last_modified_id` (`last_modified_id`),
  KEY `FK_civicrm_campaign_parent_id` (`parent_id`),
  CONSTRAINT `FK_civicrm_campaign_created_id` FOREIGN KEY (`created_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_campaign_last_modified_id` FOREIGN KEY (`last_modified_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_campaign_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `civicrm_campaign` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_campaign`
--

LOCK TABLES `civicrm_campaign` WRITE;
/*!40000 ALTER TABLE `civicrm_campaign` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_campaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_campaign_group`
--

DROP TABLE IF EXISTS `civicrm_campaign_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_campaign_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Campaign Group id.',
  `campaign_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to the activity Campaign.',
  `group_type` enum('Include','Exclude') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Type of Group.',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name of table where item being referenced is stored.',
  `entity_id` int(10) unsigned DEFAULT NULL COMMENT 'Entity id of referenced table.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_campaign_group_campaign_id` (`campaign_id`),
  CONSTRAINT `FK_civicrm_campaign_group_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `civicrm_campaign` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_campaign_group`
--

LOCK TABLES `civicrm_campaign_group` WRITE;
/*!40000 ALTER TABLE `civicrm_campaign_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_campaign_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_case`
--

DROP TABLE IF EXISTS `civicrm_case`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_case` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Case ID',
  `case_type_id` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Id of first case category.',
  `subject` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Short name of the case.',
  `start_date` date DEFAULT NULL COMMENT 'Date on which given case starts.',
  `end_date` date DEFAULT NULL COMMENT 'Date on which given case ends.',
  `details` text COLLATE utf8_unicode_ci COMMENT 'Details about the meeting (agenda, notes, etc).',
  `status_id` int(10) unsigned NOT NULL COMMENT 'Id of case status.',
  `is_deleted` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_case`
--

LOCK TABLES `civicrm_case` WRITE;
/*!40000 ALTER TABLE `civicrm_case` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_case` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_case_activity`
--

DROP TABLE IF EXISTS `civicrm_case_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_case_activity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique case-activity association id',
  `case_id` int(10) unsigned NOT NULL COMMENT 'Case ID of case-activity association.',
  `activity_id` int(10) unsigned NOT NULL COMMENT 'Activity ID of case-activity association.',
  PRIMARY KEY (`id`),
  KEY `UI_case_activity_id` (`case_id`,`activity_id`),
  KEY `FK_civicrm_case_activity_activity_id` (`activity_id`),
  CONSTRAINT `FK_civicrm_case_activity_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `civicrm_activity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_case_activity_case_id` FOREIGN KEY (`case_id`) REFERENCES `civicrm_case` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_case_activity`
--

LOCK TABLES `civicrm_case_activity` WRITE;
/*!40000 ALTER TABLE `civicrm_case_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_case_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_case_contact`
--

DROP TABLE IF EXISTS `civicrm_case_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_case_contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique case-contact association id',
  `case_id` int(10) unsigned NOT NULL COMMENT 'Case ID of case-contact association.',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'Contact ID of contact record given case belongs to.',
  PRIMARY KEY (`id`),
  KEY `UI_case_contact_id` (`case_id`,`contact_id`),
  KEY `FK_civicrm_case_contact_contact_id` (`contact_id`),
  CONSTRAINT `FK_civicrm_case_contact_case_id` FOREIGN KEY (`case_id`) REFERENCES `civicrm_case` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_case_contact_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_case_contact`
--

LOCK TABLES `civicrm_case_contact` WRITE;
/*!40000 ALTER TABLE `civicrm_case_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_case_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_component`
--

DROP TABLE IF EXISTS `civicrm_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_component` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Component ID',
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the component.',
  `namespace` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Path to components main directory in a form of a class\nnamespace.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_component`
--

LOCK TABLES `civicrm_component` WRITE;
/*!40000 ALTER TABLE `civicrm_component` DISABLE KEYS */;
INSERT INTO `civicrm_component` VALUES (1,'CiviEvent','CRM_Event'),(2,'CiviContribute','CRM_Contribute'),(3,'CiviMember','CRM_Member'),(4,'CiviMail','CRM_Mailing'),(5,'CiviGrant','CRM_Grant'),(6,'CiviPledge','CRM_Pledge'),(7,'CiviCase','CRM_Case'),(8,'CiviReport','CRM_Report'),(9,'CiviCampaign','CRM_Campaign');
/*!40000 ALTER TABLE `civicrm_component` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_contact`
--

DROP TABLE IF EXISTS `civicrm_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Contact ID',
  `contact_type` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Type of Contact.',
  `contact_sub_type` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'May be used to over-ride contact view and edit templates.',
  `do_not_email` tinyint(4) DEFAULT '0',
  `do_not_phone` tinyint(4) DEFAULT '0',
  `do_not_mail` tinyint(4) DEFAULT '0',
  `do_not_sms` tinyint(4) DEFAULT '0',
  `do_not_trade` tinyint(4) DEFAULT '0',
  `is_opt_out` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Has the contact opted out from receiving all bulk email from the organization or site domain?',
  `legal_identifier` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'May be used for SSN, EIN/TIN, Household ID (census) or other applicable unique legal/government ID.',
  `external_identifier` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Unique trusted external ID (generally from a legacy app/datasource). Particularly useful for deduping operations.',
  `sort_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name used for sorting different contact types',
  `display_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Formatted name representing preferred format for display/print/other output.',
  `nick_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Nick Name.',
  `legal_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Legal Name.',
  `image_URL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'optional URL for preferred image (photo, logo, etc.) to display for this contact.',
  `preferred_communication_method` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'What is the preferred mode of communication.',
  `preferred_language` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Which language is preferred for communication. FK to languages in civicrm_option_value.',
  `preferred_mail_format` enum('Text','HTML','Both') COLLATE utf8_unicode_ci DEFAULT 'Both' COMMENT 'What is the preferred mode of sending an email.',
  `hash` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Key for validating requests related to this contact.',
  `api_key` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'API Key for validating requests related to this contact.',
  `source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'where contact come from, e.g. import, donate module insert...',
  `first_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'First Name.',
  `middle_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Middle Name.',
  `last_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Last Name.',
  `prefix_id` int(10) unsigned DEFAULT NULL COMMENT 'Prefix or Title for name (Ms, Mr...). FK to prefix ID',
  `suffix_id` int(10) unsigned DEFAULT NULL COMMENT 'Suffix for name (Jr, Sr...). FK to suffix ID',
  `email_greeting_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value.id, that has to be valid registered Email Greeting.',
  `email_greeting_custom` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Custom Email Greeting.',
  `email_greeting_display` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Cache Email Greeting.',
  `postal_greeting_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value.id, that has to be valid registered Postal Greeting.',
  `postal_greeting_custom` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Custom Postal greeting.',
  `postal_greeting_display` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Cache Postal greeting.',
  `addressee_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value.id, that has to be valid registered Addressee.',
  `addressee_custom` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Custom Addressee.',
  `addressee_display` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Cache Addressee.',
  `job_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Job Title',
  `gender_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to gender ID',
  `birth_date` date DEFAULT NULL COMMENT 'Date of birth',
  `is_deceased` tinyint(4) DEFAULT '0',
  `deceased_date` date DEFAULT NULL COMMENT 'Date of deceased',
  `household_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Household Name.',
  `primary_contact_id` int(10) unsigned DEFAULT NULL COMMENT 'Optional FK to Primary Contact for this household.',
  `organization_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Organization Name.',
  `sic_code` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Standard Industry Classification Code.',
  `user_unique_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'the OpenID (or OpenID-style http://username.domain/) unique identifier for this contact mainly used for logging in to CiviCRM',
  `employer_id` int(10) unsigned DEFAULT NULL COMMENT 'OPTIONAL FK to civicrm_contact record.',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_external_identifier` (`external_identifier`),
  KEY `index_contact_type` (`contact_type`),
  KEY `index_contact_sub_type` (`contact_sub_type`),
  KEY `index_sort_name` (`sort_name`),
  KEY `index_preferred_communication_method` (`preferred_communication_method`),
  KEY `index_hash` (`hash`),
  KEY `index_api_key` (`api_key`),
  KEY `index_first_name` (`first_name`),
  KEY `index_last_name` (`last_name`),
  KEY `UI_prefix` (`prefix_id`),
  KEY `UI_suffix` (`suffix_id`),
  KEY `UI_gender` (`gender_id`),
  KEY `index_household_name` (`household_name`),
  KEY `index_organization_name` (`organization_name`),
  KEY `index_is_deleted` (`is_deleted`),
  KEY `FK_civicrm_contact_primary_contact_id` (`primary_contact_id`),
  KEY `FK_civicrm_contact_employer_id` (`employer_id`),
  KEY `dedupe_index_household_name_10` (`household_name`(10)),
  KEY `dedupe_index_birth_date` (`birth_date`),
  KEY `dedupe_index_first_name_8` (`first_name`(8)),
  KEY `dedupe_index_last_name_8` (`last_name`(8)),
  KEY `dedupe_index_first_name_10` (`first_name`(10)),
  KEY `dedupe_index_last_name_10` (`last_name`(10)),
  KEY `dedupe_index_organization_name_8` (`organization_name`(8)),
  KEY `individualStrict1` (`first_name`,`last_name`,`birth_date`),
  CONSTRAINT `FK_civicrm_contact_employer_id` FOREIGN KEY (`employer_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_contact_primary_contact_id` FOREIGN KEY (`primary_contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_contact`
--

LOCK TABLES `civicrm_contact` WRITE;
/*!40000 ALTER TABLE `civicrm_contact` DISABLE KEYS */;
INSERT INTO `civicrm_contact` VALUES (1,'Individual',NULL,0,0,0,0,0,0,NULL,NULL,'Administrator, Bluebird','Bluebird Administrator',NULL,NULL,NULL,'',NULL,'Both','887e18b0aa07486d5b7e78223b739de3',NULL,NULL,'Bluebird',NULL,'Administrator',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `civicrm_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_contact_type`
--

DROP TABLE IF EXISTS `civicrm_contact_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_contact_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Contact Type ID',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Internal name of Contact Type (or Subtype).',
  `label` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'localized Name of Contact Type.',
  `description` text COLLATE utf8_unicode_ci COMMENT 'localized Optional verbose description of the type.',
  `image_URL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'URL of image if any.',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Optional FK to parent contact type.',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this entry active?',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'Is this contact type a predefined system type',
  PRIMARY KEY (`id`),
  UNIQUE KEY `contact_type` (`name`),
  KEY `FK_civicrm_contact_type_parent_id` (`parent_id`),
  CONSTRAINT `FK_civicrm_contact_type_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `civicrm_contact_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_contact_type`
--

LOCK TABLES `civicrm_contact_type` WRITE;
/*!40000 ALTER TABLE `civicrm_contact_type` DISABLE KEYS */;
INSERT INTO `civicrm_contact_type` VALUES (1,'Individual','Individual',NULL,NULL,NULL,1,1),(2,'Household','Household',NULL,NULL,NULL,1,1),(3,'Organization','Organization',NULL,NULL,NULL,1,1);
/*!40000 ALTER TABLE `civicrm_contact_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_contribution`
--

DROP TABLE IF EXISTS `civicrm_contribution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_contribution` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Contribution ID',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to Contact ID',
  `contribution_type_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contribution Type',
  `contribution_page_id` int(10) unsigned DEFAULT NULL COMMENT 'The Contribution Page which triggered this contribution',
  `payment_instrument_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Payment Instrument',
  `receive_date` datetime DEFAULT NULL COMMENT 'when was gift received',
  `non_deductible_amount` decimal(20,2) DEFAULT '0.00' COMMENT 'Portion of total amount which is NOT tax deductible. Equal to total_amount for non-deductible contribution types.',
  `total_amount` decimal(20,2) NOT NULL COMMENT 'Total amount of this contribution. Use market value for non-monetary gifts.',
  `fee_amount` decimal(20,2) DEFAULT NULL COMMENT 'actual processor fee if known - may be 0.',
  `net_amount` decimal(20,2) DEFAULT NULL COMMENT 'actual funds transfer amount. total less fees. if processor does not report actual fee during transaction, this is set to total_amount.',
  `trxn_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'unique transaction id. may be processor id, bank id + trans id, or account number + check number... depending on payment_method',
  `invoice_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'unique invoice id, system generated or passed in',
  `currency` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `cancel_date` datetime DEFAULT NULL COMMENT 'when was gift cancelled',
  `cancel_reason` text COLLATE utf8_unicode_ci,
  `receipt_date` datetime DEFAULT NULL COMMENT 'when (if) receipt was sent. populated automatically for online donations w/ automatic receipting',
  `thankyou_date` datetime DEFAULT NULL COMMENT 'when (if) was donor thanked',
  `source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Origin of this Contribution.',
  `amount_level` text COLLATE utf8_unicode_ci,
  `contribution_recur_id` int(10) unsigned DEFAULT NULL COMMENT 'Conditional foreign key to civicrm_contribution_recur id. Each contribution made in connection with a recurring contribution carries a foreign key to the recurring contribution record. This assumes we can track these processor initiated events.',
  `honor_contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to contact ID',
  `is_test` tinyint(4) DEFAULT '0',
  `is_pay_later` tinyint(4) DEFAULT '0',
  `contribution_status_id` int(10) unsigned DEFAULT '1',
  `honor_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Implicit FK to civicrm_option_value.',
  `address_id` int(10) unsigned DEFAULT NULL COMMENT 'Conditional foreign key to civicrm_address.id. We insert an address record for each contribution when we have associated billing name and address data.',
  `check_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_contrib_trxn_id` (`trxn_id`),
  UNIQUE KEY `UI_contrib_invoice_id` (`invoice_id`),
  KEY `UI_contrib_payment_instrument_id` (`payment_instrument_id`),
  KEY `index_contribution_status` (`contribution_status_id`),
  KEY `received_date` (`receive_date`),
  KEY `check_number` (`check_number`),
  KEY `FK_civicrm_contribution_contact_id` (`contact_id`),
  KEY `FK_civicrm_contribution_contribution_type_id` (`contribution_type_id`),
  KEY `FK_civicrm_contribution_contribution_page_id` (`contribution_page_id`),
  KEY `FK_civicrm_contribution_contribution_recur_id` (`contribution_recur_id`),
  KEY `FK_civicrm_contribution_honor_contact_id` (`honor_contact_id`),
  KEY `FK_civicrm_contribution_address_id` (`address_id`),
  CONSTRAINT `FK_civicrm_contribution_address_id` FOREIGN KEY (`address_id`) REFERENCES `civicrm_address` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_contribution_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_contribution_contribution_page_id` FOREIGN KEY (`contribution_page_id`) REFERENCES `civicrm_contribution_page` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_contribution_contribution_recur_id` FOREIGN KEY (`contribution_recur_id`) REFERENCES `civicrm_contribution_recur` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_contribution_contribution_type_id` FOREIGN KEY (`contribution_type_id`) REFERENCES `civicrm_contribution_type` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_contribution_honor_contact_id` FOREIGN KEY (`honor_contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_contribution`
--

LOCK TABLES `civicrm_contribution` WRITE;
/*!40000 ALTER TABLE `civicrm_contribution` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_contribution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_contribution_page`
--

DROP TABLE IF EXISTS `civicrm_contribution_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_contribution_page` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Contribution Id',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Contribution Page title. For top of page display',
  `intro_text` text COLLATE utf8_unicode_ci COMMENT 'Text and html allowed. Displayed below title.',
  `contribution_type_id` int(10) unsigned NOT NULL COMMENT 'default Contribution type assigned to contributions submitted via this page, e.g. Contribution, Campaign Contribution',
  `payment_processor_id` int(10) unsigned DEFAULT NULL COMMENT 'Payment Processor for this contribution Page ',
  `is_credit_card_only` tinyint(4) DEFAULT '0' COMMENT 'if true - processing logic must reject transaction at confirmation stage if pay method != credit card',
  `is_monetary` tinyint(4) DEFAULT '1' COMMENT 'if true - allows real-time monetary transactions otherwise non-monetary transactions',
  `is_recur` tinyint(4) DEFAULT '0' COMMENT 'if true - allows recurring contributions, valid only for PayPal_Standard',
  `recur_frequency_unit` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Supported recurring frequency units.',
  `is_recur_interval` tinyint(4) DEFAULT '0' COMMENT 'if true - supports recurring intervals',
  `is_pay_later` tinyint(4) DEFAULT '0' COMMENT 'if true - allows the user to send payment directly to the org later',
  `pay_later_text` text COLLATE utf8_unicode_ci COMMENT 'The text displayed to the user in the main form',
  `pay_later_receipt` text COLLATE utf8_unicode_ci COMMENT 'The receipt sent to the user instead of the normal receipt text',
  `is_allow_other_amount` tinyint(4) DEFAULT '0' COMMENT 'if true, page will include an input text field where user can enter their own amount',
  `default_amount_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value.',
  `min_amount` decimal(20,2) DEFAULT NULL COMMENT 'if other amounts allowed, user can configure minimum allowed.',
  `max_amount` decimal(20,2) DEFAULT NULL COMMENT 'if other amounts allowed, user can configure maximum allowed.',
  `goal_amount` decimal(20,2) DEFAULT NULL COMMENT 'The target goal for this page, allows people to build a goal meter',
  `thankyou_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Title for Thank-you page (header title tag, and display at the top of the page).',
  `thankyou_text` text COLLATE utf8_unicode_ci COMMENT 'text and html allowed. displayed above result on success page',
  `thankyou_footer` text COLLATE utf8_unicode_ci COMMENT 'Text and html allowed. displayed at the bottom of the success page. Common usage is to include link(s) to other pages such as tell-a-friend, etc.',
  `is_for_organization` tinyint(4) DEFAULT '0' COMMENT 'if true, signup is done on behalf of an organization',
  `for_organization` text COLLATE utf8_unicode_ci COMMENT 'This text field is shown when is_for_organization is checked. For example - I am contributing on behalf on an organization.',
  `is_email_receipt` tinyint(4) DEFAULT '1' COMMENT 'if true, receipt is automatically emailed to contact on success',
  `receipt_from_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'FROM email name used for receipts generated by contributions to this contribution page.',
  `receipt_from_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'FROM email address used for receipts generated by contributions to this contribution page.',
  `cc_receipt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'comma-separated list of email addresses to cc each time a receipt is sent',
  `bcc_receipt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'comma-separated list of email addresses to bcc each time a receipt is sent',
  `receipt_text` text COLLATE utf8_unicode_ci COMMENT 'text to include above standard receipt info on receipt email. emails are text-only, so do not allow html for now',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  `footer_text` text COLLATE utf8_unicode_ci COMMENT 'Text and html allowed. Displayed at the bottom of the first page of the contribution wizard.',
  `amount_block_is_active` tinyint(4) DEFAULT '1' COMMENT 'Is this property active?',
  `honor_block_is_active` tinyint(4) DEFAULT NULL COMMENT 'Should this contribution have the honor  block enabled?',
  `honor_block_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Title for honor block.',
  `honor_block_text` text COLLATE utf8_unicode_ci COMMENT 'text for honor block.',
  `start_date` datetime DEFAULT NULL COMMENT 'Date and time that this page starts.',
  `end_date` datetime DEFAULT NULL COMMENT 'Date and time that this page ends. May be NULL if no defined end date/time',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who created this contribution page',
  `created_date` datetime DEFAULT NULL COMMENT 'Date and time that contribution page was created.',
  `currency` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_contribution_page_contribution_type_id` (`contribution_type_id`),
  KEY `FK_civicrm_contribution_page_payment_processor_id` (`payment_processor_id`),
  KEY `FK_civicrm_contribution_page_created_id` (`created_id`),
  CONSTRAINT `FK_civicrm_contribution_page_contribution_type_id` FOREIGN KEY (`contribution_type_id`) REFERENCES `civicrm_contribution_type` (`id`),
  CONSTRAINT `FK_civicrm_contribution_page_created_id` FOREIGN KEY (`created_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_contribution_page_payment_processor_id` FOREIGN KEY (`payment_processor_id`) REFERENCES `civicrm_payment_processor` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_contribution_page`
--

LOCK TABLES `civicrm_contribution_page` WRITE;
/*!40000 ALTER TABLE `civicrm_contribution_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_contribution_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_contribution_product`
--

DROP TABLE IF EXISTS `civicrm_contribution_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_contribution_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `contribution_id` int(10) unsigned NOT NULL,
  `product_option` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Option value selected if applicable - e.g. color, size etc.',
  `quantity` int(11) DEFAULT NULL,
  `fulfilled_date` date DEFAULT NULL COMMENT 'Optional. Can be used to record the date this product was fulfilled or shipped.',
  `start_date` date DEFAULT NULL COMMENT 'Actual start date for a time-delimited premium (subscription, service or membership)',
  `end_date` date DEFAULT NULL COMMENT 'Actual end date for a time-delimited premium (subscription, service or membership)',
  `comment` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_contribution_product_contribution_id` (`contribution_id`),
  CONSTRAINT `FK_civicrm_contribution_product_contribution_id` FOREIGN KEY (`contribution_id`) REFERENCES `civicrm_contribution` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_contribution_product`
--

LOCK TABLES `civicrm_contribution_product` WRITE;
/*!40000 ALTER TABLE `civicrm_contribution_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_contribution_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_contribution_recur`
--

DROP TABLE IF EXISTS `civicrm_contribution_recur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_contribution_recur` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Contribution Recur ID',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to civicrm_contact.id .',
  `amount` decimal(20,2) NOT NULL COMMENT 'Amount to be contributed or charged each recurrence.',
  `currency` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `frequency_unit` enum('day','week','month','year') COLLATE utf8_unicode_ci DEFAULT 'month' COMMENT 'Time units for recurrence of payment.',
  `frequency_interval` int(10) unsigned NOT NULL COMMENT 'Number of time units for recurrence of payment.',
  `installments` int(10) unsigned DEFAULT NULL COMMENT 'Total number of payments to be made. Set this to 0 if this is an open-ended commitment i.e. no set end date.',
  `start_date` datetime NOT NULL COMMENT 'The date the first scheduled recurring contribution occurs.',
  `create_date` datetime NOT NULL COMMENT 'When this recurring contribution record was created.',
  `modified_date` datetime DEFAULT NULL COMMENT 'Last updated date for this record. mostly the last time a payment was received',
  `cancel_date` datetime DEFAULT NULL COMMENT 'Date this recurring contribution was cancelled by contributor- if we can get access to it',
  `end_date` datetime DEFAULT NULL COMMENT 'Date this recurring contribution finished successfully',
  `processor_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Possibly needed to store a unique identifier for this recurring payment order - if this is available from the processor??',
  `trxn_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'unique transaction id. may be processor id, bank id + trans id, or account number + check number... depending on payment_method',
  `invoice_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'unique invoice id, system generated or passed in',
  `contribution_status_id` int(10) unsigned DEFAULT '1',
  `is_test` tinyint(4) DEFAULT '0',
  `cycle_day` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'Day in the period when the payment should be charged e.g. 1st of month, 15th etc.',
  `next_sched_contribution` datetime DEFAULT NULL COMMENT 'At Groundspring this was used by the cron job which triggered payments. If we''re not doing that but we know about payments, it might still be useful to store for display to org andor contributors.',
  `failure_count` int(10) unsigned DEFAULT '0' COMMENT 'Number of failed charge attempts since last success. Business rule could be set to deactivate on more than x failures.',
  `failure_retry_date` datetime DEFAULT NULL COMMENT 'At Groundspring we set a business rule to retry failed payments every 7 days - and stored the next scheduled attempt date there.',
  `auto_renew` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Some systems allow contributor to set a number of installments - but then auto-renew the subscription or commitment if they do not cancel.',
  `payment_processor_id` int(10) unsigned DEFAULT NULL COMMENT 'Foreign key to civicrm_payment_processor.id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_contrib_trxn_id` (`trxn_id`),
  UNIQUE KEY `UI_contrib_invoice_id` (`invoice_id`),
  KEY `index_contribution_status` (`contribution_status_id`),
  KEY `FK_civicrm_contribution_recur_contact_id` (`contact_id`),
  KEY `FK_civicrm_contribution_recur_payment_processor_id` (`payment_processor_id`),
  CONSTRAINT `FK_civicrm_contribution_recur_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_contribution_recur_payment_processor_id` FOREIGN KEY (`payment_processor_id`) REFERENCES `civicrm_payment_processor` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_contribution_recur`
--

LOCK TABLES `civicrm_contribution_recur` WRITE;
/*!40000 ALTER TABLE `civicrm_contribution_recur` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_contribution_recur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_contribution_soft`
--

DROP TABLE IF EXISTS `civicrm_contribution_soft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_contribution_soft` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Soft Contribution ID',
  `contribution_id` int(10) unsigned NOT NULL COMMENT 'FK to contribution table.',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to Contact ID',
  `amount` decimal(20,2) NOT NULL COMMENT 'Amount of this soft contribution.',
  `currency` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `pcp_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_pcp.id',
  `pcp_display_in_roll` tinyint(4) DEFAULT '0',
  `pcp_roll_nickname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pcp_personal_note` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_id` (`pcp_id`),
  KEY `FK_civicrm_contribution_soft_contribution_id` (`contribution_id`),
  KEY `FK_civicrm_contribution_soft_contact_id` (`contact_id`),
  CONSTRAINT `FK_civicrm_contribution_soft_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_contribution_soft_contribution_id` FOREIGN KEY (`contribution_id`) REFERENCES `civicrm_contribution` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_contribution_soft_pcp_id` FOREIGN KEY (`pcp_id`) REFERENCES `civicrm_pcp` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_contribution_soft`
--

LOCK TABLES `civicrm_contribution_soft` WRITE;
/*!40000 ALTER TABLE `civicrm_contribution_soft` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_contribution_soft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_contribution_type`
--

DROP TABLE IF EXISTS `civicrm_contribution_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_contribution_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Contribution Type ID',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Contribution Type Name.',
  `accounting_code` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Optional value for mapping contributions to accounting system codes for each type/category of contribution.',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Contribution Type Description.',
  `is_deductible` tinyint(4) DEFAULT '1' COMMENT 'Is this contribution type tax-deductible? If true, contributions of this type may be fully OR partially deductible - non-deductible amount is stored in the Contribution record.',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'Is this a predefined system object?',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_contribution_type`
--

LOCK TABLES `civicrm_contribution_type` WRITE;
/*!40000 ALTER TABLE `civicrm_contribution_type` DISABLE KEYS */;
INSERT INTO `civicrm_contribution_type` VALUES (1,'Donation',NULL,NULL,1,0,1),(2,'Member Dues',NULL,NULL,1,0,1),(3,'Campaign Contribution',NULL,NULL,0,0,1),(4,'Event Fee',NULL,NULL,0,0,1);
/*!40000 ALTER TABLE `civicrm_contribution_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_contribution_widget`
--

DROP TABLE IF EXISTS `civicrm_contribution_widget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_contribution_widget` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Contribution Id',
  `contribution_page_id` int(10) unsigned DEFAULT NULL COMMENT 'The Contribution Page which triggered this contribution',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Widget title.',
  `url_logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'URL to Widget logo',
  `button_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Button title.',
  `about` text COLLATE utf8_unicode_ci COMMENT 'About description.',
  `url_homepage` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'URL to Homepage.',
  `color_title` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `color_button` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `color_bar` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `color_main_text` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `color_main` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `color_main_bg` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `color_bg` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `color_about_link` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `color_homepage_link` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_contribution_widget_contribution_page_id` (`contribution_page_id`),
  CONSTRAINT `FK_civicrm_contribution_widget_contribution_page_id` FOREIGN KEY (`contribution_page_id`) REFERENCES `civicrm_contribution_page` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_contribution_widget`
--

LOCK TABLES `civicrm_contribution_widget` WRITE;
/*!40000 ALTER TABLE `civicrm_contribution_widget` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_contribution_widget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_country`
--

DROP TABLE IF EXISTS `civicrm_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_country` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Country Id',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Country Name',
  `iso_code` char(2) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'ISO Code',
  `country_code` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'National prefix to be used when dialing TO this country.',
  `address_format_id` int(10) unsigned DEFAULT NULL COMMENT 'Foreign key to civicrm_address_format.id.',
  `idd_prefix` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'International direct dialing prefix from within the country TO another country',
  `ndd_prefix` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Access prefix to call within a country to a different area',
  `region_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to civicrm_worldregion.id.',
  `is_province_abbreviated` tinyint(4) DEFAULT '0' COMMENT 'Should state/province be displayed as abbreviation for contacts from this country?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name_iso_code` (`name`,`iso_code`),
  KEY `FK_civicrm_country_address_format_id` (`address_format_id`),
  KEY `FK_civicrm_country_region_id` (`region_id`),
  CONSTRAINT `FK_civicrm_country_address_format_id` FOREIGN KEY (`address_format_id`) REFERENCES `civicrm_address_format` (`id`),
  CONSTRAINT `FK_civicrm_country_region_id` FOREIGN KEY (`region_id`) REFERENCES `civicrm_worldregion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1247 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_country`
--

LOCK TABLES `civicrm_country` WRITE;
/*!40000 ALTER TABLE `civicrm_country` DISABLE KEYS */;
INSERT INTO `civicrm_country` VALUES (1001,'Afghanistan','AF',NULL,NULL,NULL,NULL,4,0),(1002,'Albania','AL',NULL,NULL,NULL,NULL,1,0),(1003,'Algeria','DZ',NULL,NULL,NULL,NULL,3,0),(1004,'American Samoa','AS',NULL,NULL,NULL,NULL,2,0),(1005,'Andorra','AD',NULL,NULL,NULL,NULL,1,0),(1006,'Angola','AO',NULL,NULL,NULL,NULL,5,0),(1007,'Anguilla','AI',NULL,NULL,NULL,NULL,2,0),(1008,'Antarctica','AQ',NULL,NULL,NULL,NULL,1,0),(1009,'Antigua and Barbuda','AG',NULL,NULL,NULL,NULL,2,0),(1010,'Argentina','AR',NULL,NULL,NULL,NULL,2,0),(1011,'Armenia','AM',NULL,NULL,NULL,NULL,4,0),(1012,'Aruba','AW',NULL,NULL,NULL,NULL,2,0),(1013,'Australia','AU',NULL,NULL,NULL,NULL,4,0),(1014,'Austria','AT',NULL,NULL,NULL,NULL,1,0),(1015,'Azerbaijan','AZ',NULL,NULL,NULL,NULL,1,0),(1016,'Bahrain','BH',NULL,NULL,NULL,NULL,3,0),(1017,'Bangladesh','BD',NULL,NULL,NULL,NULL,4,0),(1018,'Barbados','BB',NULL,NULL,NULL,NULL,4,0),(1019,'Belarus','BY',NULL,NULL,NULL,NULL,1,0),(1020,'Belgium','BE',NULL,NULL,NULL,NULL,1,0),(1021,'Belize','BZ',NULL,NULL,NULL,NULL,2,0),(1022,'Benin','BJ',NULL,NULL,NULL,NULL,5,0),(1023,'Bermuda','BM',NULL,NULL,NULL,NULL,2,0),(1024,'Bhutan','BT',NULL,NULL,NULL,NULL,4,0),(1025,'Bolivia','BO',NULL,NULL,NULL,NULL,2,0),(1026,'Bosnia and Herzegovina','BA',NULL,NULL,NULL,NULL,1,0),(1027,'Botswana','BW',NULL,NULL,NULL,NULL,5,0),(1028,'Bouvet Island','BV',NULL,NULL,NULL,NULL,1,0),(1029,'Brazil','BR',NULL,NULL,NULL,NULL,2,0),(1030,'British Indian Ocean Territory','IO',NULL,NULL,NULL,NULL,4,0),(1031,'Virgin Islands, British','VG',NULL,NULL,NULL,NULL,2,0),(1032,'Brunei Darussalam','BN',NULL,NULL,NULL,NULL,4,0),(1033,'Bulgaria','BG',NULL,NULL,NULL,NULL,1,0),(1034,'Burkina Faso','BF',NULL,NULL,NULL,NULL,5,0),(1035,'Myanmar','MM',NULL,NULL,NULL,NULL,4,0),(1036,'Burundi','BI',NULL,NULL,NULL,NULL,5,0),(1037,'Cambodia','KH',NULL,NULL,NULL,NULL,4,0),(1038,'Cameroon','CM',NULL,NULL,NULL,NULL,5,0),(1039,'Canada','CA',NULL,NULL,NULL,NULL,2,1),(1040,'Cape Verde','CV',NULL,NULL,NULL,NULL,5,0),(1041,'Cayman Islands','KY',NULL,NULL,NULL,NULL,5,0),(1042,'Central African Republic','CF',NULL,NULL,NULL,NULL,5,0),(1043,'Chad','TD',NULL,NULL,NULL,NULL,5,0),(1044,'Chile','CL',NULL,NULL,NULL,NULL,2,0),(1045,'China','CN',NULL,NULL,NULL,NULL,4,0),(1046,'Christmas Island','CX',NULL,NULL,NULL,NULL,4,0),(1047,'Cocos (Keeling) Islands','CC',NULL,NULL,NULL,NULL,4,0),(1048,'Colombia','CO',NULL,NULL,NULL,NULL,2,0),(1049,'Comoros','KM',NULL,NULL,NULL,NULL,5,0),(1050,'Congo, The Democratic Republic of the','CD',NULL,NULL,NULL,NULL,5,0),(1051,'Congo','CG',NULL,NULL,NULL,NULL,5,0),(1052,'Cook Islands','CK',NULL,NULL,NULL,NULL,4,0),(1053,'Costa Rica','CR',NULL,NULL,NULL,NULL,2,0),(1054,'CÃ´te d\'Ivoire','CI',NULL,NULL,NULL,NULL,5,0),(1055,'Croatia','HR',NULL,NULL,NULL,NULL,1,0),(1056,'Cuba','CU',NULL,NULL,NULL,NULL,2,0),(1057,'Cyprus','CY',NULL,NULL,NULL,NULL,1,0),(1058,'Czech Republic','CZ',NULL,NULL,NULL,NULL,1,0),(1059,'Denmark','DK',NULL,NULL,NULL,NULL,1,0),(1060,'Djibouti','DJ',NULL,NULL,NULL,NULL,5,0),(1061,'Dominica','DM',NULL,NULL,NULL,NULL,2,0),(1062,'Dominican Republic','DO',NULL,NULL,NULL,NULL,2,0),(1063,'Timor-Leste','TL',NULL,NULL,NULL,NULL,4,0),(1064,'Ecuador','EC',NULL,NULL,NULL,NULL,2,0),(1065,'Egypt','EG',NULL,NULL,NULL,NULL,3,0),(1066,'El Salvador','SV',NULL,NULL,NULL,NULL,2,0),(1067,'Equatorial Guinea','GQ',NULL,NULL,NULL,NULL,5,0),(1068,'Eritrea','ER',NULL,NULL,NULL,NULL,5,0),(1069,'Estonia','EE',NULL,NULL,NULL,NULL,1,0),(1070,'Ethiopia','ET',NULL,NULL,NULL,NULL,5,0),(1072,'Falkland Islands (Malvinas)','FK',NULL,NULL,NULL,NULL,2,0),(1073,'Faroe Islands','FO',NULL,NULL,NULL,NULL,1,0),(1074,'Fiji','FJ',NULL,NULL,NULL,NULL,4,0),(1075,'Finland','FI',NULL,NULL,NULL,NULL,1,0),(1076,'France','FR',NULL,NULL,NULL,NULL,1,0),(1077,'French Guiana','GF',NULL,NULL,NULL,NULL,2,0),(1078,'French Polynesia','PF',NULL,NULL,NULL,NULL,4,0),(1079,'French Southern Territories','TF',NULL,NULL,NULL,NULL,1,0),(1080,'Gabon','GA',NULL,NULL,NULL,NULL,5,0),(1081,'Georgia','GE',NULL,NULL,NULL,NULL,4,0),(1082,'Germany','DE',NULL,NULL,NULL,NULL,1,0),(1083,'Ghana','GH',NULL,NULL,NULL,NULL,5,0),(1084,'Gibraltar','GI',NULL,NULL,NULL,NULL,1,0),(1085,'Greece','GR',NULL,NULL,NULL,NULL,1,0),(1086,'Greenland','GL',NULL,NULL,NULL,NULL,2,0),(1087,'Grenada','GD',NULL,NULL,NULL,NULL,2,0),(1088,'Guadeloupe','GP',NULL,NULL,NULL,NULL,2,0),(1089,'Guam','GU',NULL,NULL,NULL,NULL,4,0),(1090,'Guatemala','GT',NULL,NULL,NULL,NULL,2,0),(1091,'Guinea','GN',NULL,NULL,NULL,NULL,5,0),(1092,'Guinea-Bissau','GW',NULL,NULL,NULL,NULL,5,0),(1093,'Guyana','GY',NULL,NULL,NULL,NULL,2,0),(1094,'Haiti','HT',NULL,NULL,NULL,NULL,2,0),(1095,'Heard Island and McDonald Islands','HM',NULL,NULL,NULL,NULL,4,0),(1096,'Holy See (Vatican City State)','VA',NULL,NULL,NULL,NULL,1,0),(1097,'Honduras','HN',NULL,NULL,NULL,NULL,2,0),(1098,'Hong Kong','HK',NULL,NULL,NULL,NULL,4,0),(1099,'Hungary','HU',NULL,NULL,NULL,NULL,1,0),(1100,'Iceland','IS',NULL,NULL,NULL,NULL,1,0),(1101,'India','IN',NULL,NULL,NULL,NULL,4,0),(1102,'Indonesia','ID',NULL,NULL,NULL,NULL,4,0),(1103,'Iran, Islamic Republic of','IR',NULL,NULL,NULL,NULL,3,0),(1104,'Iraq','IQ',NULL,NULL,NULL,NULL,3,0),(1105,'Ireland','IE',NULL,NULL,NULL,NULL,1,0),(1106,'Israel','IL',NULL,NULL,NULL,NULL,3,0),(1107,'Italy','IT',NULL,NULL,NULL,NULL,1,0),(1108,'Jamaica','JM',NULL,NULL,NULL,NULL,2,0),(1109,'Japan','JP',NULL,NULL,NULL,NULL,4,0),(1110,'Jordan','JO',NULL,NULL,NULL,NULL,3,0),(1111,'Kazakhstan','KZ',NULL,NULL,NULL,NULL,1,0),(1112,'Kenya','KE',NULL,NULL,NULL,NULL,5,0),(1113,'Kiribati','KI',NULL,NULL,NULL,NULL,4,0),(1114,'Korea, Democratic People\'s Republic of','KP',NULL,NULL,NULL,NULL,4,0),(1115,'Korea, Republic of','KR',NULL,NULL,NULL,NULL,4,0),(1116,'Kuwait','KW',NULL,NULL,NULL,NULL,3,0),(1117,'Kyrgyzstan','KG',NULL,NULL,NULL,NULL,1,0),(1118,'Lao People\'s Democratic Republic','LA',NULL,NULL,NULL,NULL,4,0),(1119,'Latvia','LV',NULL,NULL,NULL,NULL,1,0),(1120,'Lebanon','LB',NULL,NULL,NULL,NULL,3,0),(1121,'Lesotho','LS',NULL,NULL,NULL,NULL,5,0),(1122,'Liberia','LR',NULL,NULL,NULL,NULL,5,0),(1123,'Libyan Arab Jamahiriya','LY',NULL,NULL,NULL,NULL,3,0),(1124,'Liechtenstein','LI',NULL,NULL,NULL,NULL,1,0),(1125,'Lithuania','LT',NULL,NULL,NULL,NULL,1,0),(1126,'Luxembourg','LU',NULL,NULL,NULL,NULL,1,0),(1127,'Macao','MO',NULL,NULL,NULL,NULL,4,0),(1128,'Macedonia, Republic of','MK',NULL,NULL,NULL,NULL,1,0),(1129,'Madagascar','MG',NULL,NULL,NULL,NULL,5,0),(1130,'Malawi','MW',NULL,NULL,NULL,NULL,5,0),(1131,'Malaysia','MY',NULL,NULL,NULL,NULL,4,0),(1132,'Maldives','MV',NULL,NULL,NULL,NULL,4,0),(1133,'Mali','ML',NULL,NULL,NULL,NULL,5,0),(1134,'Malta','MT',NULL,NULL,NULL,NULL,1,0),(1135,'Marshall Islands','MH',NULL,NULL,NULL,NULL,4,0),(1136,'Martinique','MQ',NULL,NULL,NULL,NULL,2,0),(1137,'Mauritania','MR',NULL,NULL,NULL,NULL,5,0),(1138,'Mauritius','MU',NULL,NULL,NULL,NULL,5,0),(1139,'Mayotte','YT',NULL,NULL,NULL,NULL,5,0),(1140,'Mexico','MX',NULL,NULL,NULL,NULL,2,0),(1141,'Micronesia, Federated States of','FM',NULL,NULL,NULL,NULL,4,0),(1142,'Moldova','MD',NULL,NULL,NULL,NULL,1,0),(1143,'Monaco','MC',NULL,NULL,NULL,NULL,1,0),(1144,'Mongolia','MN',NULL,NULL,NULL,NULL,4,0),(1145,'Montserrat','MS',NULL,NULL,NULL,NULL,2,0),(1146,'Morocco','MA',NULL,NULL,NULL,NULL,3,0),(1147,'Mozambique','MZ',NULL,NULL,NULL,NULL,5,0),(1148,'Namibia','NA',NULL,NULL,NULL,NULL,5,0),(1149,'Nauru','NR',NULL,NULL,NULL,NULL,4,0),(1150,'Nepal','NP',NULL,NULL,NULL,NULL,4,0),(1151,'Netherlands Antilles','AN',NULL,NULL,NULL,NULL,2,0),(1152,'Netherlands','NL',NULL,NULL,NULL,NULL,1,0),(1153,'New Caledonia','NC',NULL,NULL,NULL,NULL,4,0),(1154,'New Zealand','NZ',NULL,NULL,NULL,NULL,4,0),(1155,'Nicaragua','NI',NULL,NULL,NULL,NULL,2,0),(1156,'Niger','NE',NULL,NULL,NULL,NULL,5,0),(1157,'Nigeria','NG',NULL,NULL,NULL,NULL,5,0),(1158,'Niue','NU',NULL,NULL,NULL,NULL,4,0),(1159,'Norfolk Island','NF',NULL,NULL,NULL,NULL,4,0),(1160,'Northern Mariana Islands','MP',NULL,NULL,NULL,NULL,2,0),(1161,'Norway','NO',NULL,NULL,NULL,NULL,1,0),(1162,'Oman','OM',NULL,NULL,NULL,NULL,3,0),(1163,'Pakistan','PK',NULL,NULL,NULL,NULL,4,0),(1164,'Palau','PW',NULL,NULL,NULL,NULL,4,0),(1165,'Palestinian Territory, Occupied','PS',NULL,NULL,NULL,NULL,3,0),(1166,'Panama','PA',NULL,NULL,NULL,NULL,5,0),(1167,'Papua New Guinea','PG',NULL,NULL,NULL,NULL,4,0),(1168,'Paraguay','PY',NULL,NULL,NULL,NULL,2,0),(1169,'Peru','PE',NULL,NULL,NULL,NULL,2,0),(1170,'Philippines','PH',NULL,NULL,NULL,NULL,4,0),(1171,'Pitcairn','PN',NULL,NULL,NULL,NULL,4,0),(1172,'Poland','PL',NULL,NULL,NULL,NULL,1,0),(1173,'Portugal','PT',NULL,NULL,NULL,NULL,1,0),(1174,'Puerto Rico','PR',NULL,NULL,NULL,NULL,2,0),(1175,'Qatar','QA',NULL,NULL,NULL,NULL,3,0),(1176,'Romania','RO',NULL,NULL,NULL,NULL,1,0),(1177,'Russian Federation','RU',NULL,NULL,NULL,NULL,1,0),(1178,'Rwanda','RW',NULL,NULL,NULL,NULL,5,0),(1179,'Reunion','RE',NULL,NULL,NULL,NULL,5,0),(1180,'Saint Helena','SH',NULL,NULL,NULL,NULL,5,0),(1181,'Saint Kitts and Nevis','KN',NULL,NULL,NULL,NULL,2,0),(1182,'Saint Lucia','LC',NULL,NULL,NULL,NULL,2,0),(1183,'Saint Pierre and Miquelon','PM',NULL,NULL,NULL,NULL,2,0),(1184,'Saint Vincent and the Grenadines','VC',NULL,NULL,NULL,NULL,2,0),(1185,'Samoa','WS',NULL,NULL,NULL,NULL,4,0),(1186,'San Marino','SM',NULL,NULL,NULL,NULL,1,0),(1187,'Saudi Arabia','SA',NULL,NULL,NULL,NULL,3,0),(1188,'Senegal','SN',NULL,NULL,NULL,NULL,5,0),(1189,'Seychelles','SC',NULL,NULL,NULL,NULL,5,0),(1190,'Sierra Leone','SL',NULL,NULL,NULL,NULL,5,0),(1191,'Singapore','SG',NULL,NULL,NULL,NULL,4,0),(1192,'Slovakia','SK',NULL,NULL,NULL,NULL,1,0),(1193,'Slovenia','SI',NULL,NULL,NULL,NULL,1,0),(1194,'Solomon Islands','SB',NULL,NULL,NULL,NULL,4,0),(1195,'Somalia','SO',NULL,NULL,NULL,NULL,5,0),(1196,'South Africa','ZA',NULL,NULL,NULL,NULL,5,0),(1197,'South Georgia and the South Sandwich Islands','GS',NULL,NULL,NULL,NULL,2,0),(1198,'Spain','ES',NULL,NULL,NULL,NULL,1,0),(1199,'Sri Lanka','LK',NULL,NULL,NULL,NULL,4,0),(1200,'Sudan','SD',NULL,NULL,NULL,NULL,5,0),(1201,'Suriname','SR',NULL,NULL,NULL,NULL,2,0),(1202,'Svalbard and Jan Mayen','SJ',NULL,NULL,NULL,NULL,1,0),(1203,'Swaziland','SZ',NULL,NULL,NULL,NULL,5,0),(1204,'Sweden','SE',NULL,NULL,NULL,NULL,1,0),(1205,'Switzerland','CH',NULL,NULL,NULL,NULL,1,0),(1206,'Syrian Arab Republic','SY',NULL,NULL,NULL,NULL,3,0),(1207,'Sao Tome and Principe','ST',NULL,NULL,NULL,NULL,5,0),(1208,'Taiwan','TW',NULL,NULL,NULL,NULL,4,0),(1209,'Tajikistan','TJ',NULL,NULL,NULL,NULL,4,0),(1210,'Tanzania, United Republic of','TZ',NULL,NULL,NULL,NULL,5,0),(1211,'Thailand','TH',NULL,NULL,NULL,NULL,4,0),(1212,'Bahamas','BS',NULL,NULL,NULL,NULL,2,0),(1213,'Gambia','GM',NULL,NULL,NULL,NULL,5,0),(1214,'Togo','TG',NULL,NULL,NULL,NULL,5,0),(1215,'Tokelau','TK',NULL,NULL,NULL,NULL,4,0),(1216,'Tonga','TO',NULL,NULL,NULL,NULL,4,0),(1217,'Trinidad and Tobago','TT',NULL,NULL,NULL,NULL,2,0),(1218,'Tunisia','TN',NULL,NULL,NULL,NULL,3,0),(1219,'Turkey','TR',NULL,NULL,NULL,NULL,1,0),(1220,'Turkmenistan','TM',NULL,NULL,NULL,NULL,1,0),(1221,'Turks and Caicos Islands','TC',NULL,NULL,NULL,NULL,2,0),(1222,'Tuvalu','TV',NULL,NULL,NULL,NULL,4,0),(1223,'Uganda','UG',NULL,NULL,NULL,NULL,5,0),(1224,'Ukraine','UA',NULL,NULL,NULL,NULL,1,0),(1225,'United Arab Emirates','AE',NULL,NULL,NULL,NULL,3,0),(1226,'United Kingdom','GB',NULL,NULL,NULL,NULL,1,0),(1227,'United States Minor Outlying Islands','UM',NULL,NULL,NULL,NULL,2,0),(1228,'United States','US',NULL,NULL,NULL,NULL,2,1),(1229,'Uruguay','UY',NULL,NULL,NULL,NULL,2,0),(1230,'Uzbekistan','UZ',NULL,NULL,NULL,NULL,1,0),(1231,'Vanuatu','VU',NULL,NULL,NULL,NULL,4,0),(1232,'Venezuela','VE',NULL,NULL,NULL,NULL,2,0),(1233,'Viet Nam','VN',NULL,NULL,NULL,NULL,4,0),(1234,'Virgin Islands, U.S.','VI',NULL,NULL,NULL,NULL,2,0),(1235,'Wallis and Futuna','WF',NULL,NULL,NULL,NULL,4,0),(1236,'Western Sahara','EH',NULL,NULL,NULL,NULL,3,0),(1237,'Yemen','YE',NULL,NULL,NULL,NULL,3,0),(1238,'Serbia and Montenegro','CS',NULL,NULL,NULL,NULL,1,0),(1239,'Zambia','ZM',NULL,NULL,NULL,NULL,5,0),(1240,'Zimbabwe','ZW',NULL,NULL,NULL,NULL,5,0),(1241,'Ã…land Islands','AX',NULL,NULL,NULL,NULL,1,0),(1242,'Serbia','RS',NULL,NULL,NULL,NULL,1,0),(1243,'Montenegro','ME',NULL,NULL,NULL,NULL,1,0),(1244,'Jersey','JE',NULL,NULL,NULL,NULL,99,0),(1245,'Guernsey','GG',NULL,NULL,NULL,NULL,99,0),(1246,'Isle of Man','IM',NULL,NULL,NULL,NULL,99,0);
/*!40000 ALTER TABLE `civicrm_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_county`
--

DROP TABLE IF EXISTS `civicrm_county`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_county` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'County ID',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name of County',
  `abbreviation` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '2-4 Character Abbreviation of County',
  `state_province_id` int(10) unsigned NOT NULL COMMENT 'ID of State / Province that County belongs',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name_state_id` (`name`,`state_province_id`),
  KEY `FK_civicrm_county_state_province_id` (`state_province_id`),
  CONSTRAINT `FK_civicrm_county_state_province_id` FOREIGN KEY (`state_province_id`) REFERENCES `civicrm_state_province` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_county`
--

LOCK TABLES `civicrm_county` WRITE;
/*!40000 ALTER TABLE `civicrm_county` DISABLE KEYS */;
INSERT INTO `civicrm_county` VALUES (1,'Alameda',NULL,1004),(2,'Contra Costa',NULL,1004),(3,'Marin',NULL,1004),(4,'San Francisco',NULL,1004),(5,'San Mateo',NULL,1004),(6,'Santa Clara',NULL,1004);
/*!40000 ALTER TABLE `civicrm_county` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_currency`
--

DROP TABLE IF EXISTS `civicrm_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_currency` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Currency Id',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Currency Name',
  `symbol` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Currency Symbol',
  `numeric_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Numeric currency code',
  `full_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Full currency name',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_currency`
--

LOCK TABLES `civicrm_currency` WRITE;
/*!40000 ALTER TABLE `civicrm_currency` DISABLE KEYS */;
INSERT INTO `civicrm_currency` VALUES (1,'AUD','$','036','Australian Dollar'),(2,'CAD','$','124','Canadian Dollar'),(3,'EUR','â‚¬','978','Euro'),(4,'GBP','Â£','826','Pound Sterling'),(5,'ILS','â‚ª','826','New Israeli Shekel'),(6,'INR','â‚¨','356','Indian Rupee'),(7,'JPY','Â¥','392','Japanese Yen'),(8,'KRW','â‚©','410','South Korean Won'),(9,'LAK','â‚­','418','Lao Kip'),(10,'MNT','â‚®','496','Mongolian Tugrik'),(11,'NGN','â‚¦','566','Nigerian Naira'),(12,'PLN','zÅ‚','985','Polish ZÅ‚oty'),(13,'THB','à¸¿','764','Thai Baht'),(14,'USD','$','840','US Dollar'),(15,'VND','â‚«','704','Viet Nam Dong'),(16,'ZAR','R','710','South African Rand'),(17,'AED',NULL,'784','UAE Dirham'),(18,'AFN','Ø‹','971','Afghani'),(19,'ALL','Lek','008','Albanian Lek'),(20,'AMD',NULL,'051','Armenian Dram'),(21,'ANG','Æ’','532','Netherlands Antillian Guilder'),(22,'AOA',NULL,'973','Angola Kwanza'),(23,'ARS','$','032','Argentine Peso'),(24,'AWG','Æ’','533','Aruban Guilder'),(25,'AZN','Ð¼Ð°Ð½','944','Azerbaijanian Manat'),(26,'BAM','KM','977','Convertible Marks'),(27,'BBD','$','052','Barbados Dollar'),(28,'BDT',NULL,'050','Bangladeshi Taka'),(29,'BGN','Ð»Ð²','975','Bulgarian Lev'),(30,'BHD',NULL,'048','Bahraini Dinar'),(31,'BIF',NULL,'108','Burundi Franc'),(32,'BMD','$','060','Bermudian Dollar'),(33,'BND','$','096','Brunei Dollar'),(34,'BOB','$b','068','Boliviano'),(35,'BOV',NULL,'984','Bolivian Mvdol'),(36,'BRL','R$','986','Brazilian Real'),(37,'BSD','$','044','Bahamian Dollar'),(38,'BTN',NULL,'064','Bhutan Ngultrum'),(39,'BWP','P','072','Botswana Pula'),(40,'BYR','p.','974','Belarussian Rouble'),(41,'BZD','BZ$','084','Belize Dollar'),(42,'CDF',NULL,'976','Franc Congolais'),(43,'CHE',NULL,'947','WIR Euro'),(44,'CHF','CHF','756','Swiss Franc'),(45,'CHW',NULL,'948','WIR Franc'),(46,'CLF',NULL,'990','Unidades de fomento'),(47,'CLP','$','152','Chilean Peso'),(48,'CNY','å…ƒ','156','Chinese Yuan Renminbi'),(49,'COP','$','170','Colombian Peso'),(50,'COU',NULL,'970','Unidad de Valor Real'),(51,'CRC','â‚¡','188','Costa Rican Colon'),(52,'CSD','Ð”Ð¸Ð½.','891','Serbian Dinar'),(53,'CUP','â‚±','192','Cuban Peso'),(54,'CVE',NULL,'132','Cape Verde Escudo'),(55,'CYP','Â£','196','Cyprus Pound'),(56,'CZK','KÄ','203','Czech Koruna'),(57,'DJF',NULL,'262','Djibouti Franc'),(58,'DKK','kr','208','Danish Krone'),(59,'DOP','RD$','214','Dominican Peso'),(60,'DZD',NULL,'012','Algerian Dinar'),(61,'EEK','kr','233','Estonian Kroon'),(62,'EGP','Â£','818','Egyptian Pound'),(63,'ERN',NULL,'232','Eritrean Nakfa'),(64,'ETB',NULL,'230','Ethiopian Birr'),(65,'FJD','$','242','Fiji Dollar'),(66,'FKP','Â£','238','Falkland Islands Pound'),(67,'GEL',NULL,'981','Georgian Lari'),(68,'GHC','Â¢','288','Ghanaian Cedi'),(69,'GIP','Â£','292','Gibraltar Pound'),(70,'GMD',NULL,'270','Gambian Dalasi'),(71,'GNF',NULL,'324','Guinea Franc'),(72,'GTQ','Q','320','Guatemalan Quetzal'),(73,'GWP',NULL,'624','Guinea-Bissau Peso'),(74,'GYD','$','328','Guyana Dollar'),(75,'HKD','HK$','344','Hong Kong Dollar'),(76,'HNL','L','340','Honduran Lempira'),(77,'HRK','kn','191','Croatian Kuna'),(78,'HTG',NULL,'332','Haitian Gourde'),(79,'HUF','Ft','348','Hungarian Forint'),(80,'IDR','Rp','360','Indonesian Rupiah'),(81,'IQD',NULL,'368','Iraqi Dinar'),(82,'IRR','ï·¼','364','Iranian Rial'),(83,'ISK','kr','352','Iceland Krona'),(84,'JMD','J$','388','Jamaican Dollar'),(85,'JOD',NULL,'400','Jordanian Dinar'),(86,'KES',NULL,'404','Kenyan Shilling'),(87,'KGS','Ð»Ð²','417','Kyrgyzstan Som'),(88,'KHR','áŸ›','116','Cambodian Riel'),(89,'KMF',NULL,'174','Comoro Franc'),(90,'KPW','â‚©','408','North Korean Won'),(91,'KWD',NULL,'414','Kuwaiti Dinar'),(92,'KYD','$','136','Cayman Islands Dollar'),(93,'KZT','Ð»Ð²','398','Kazakhstan Tenge'),(94,'LBP','Â£','422','Lebanese Pound'),(95,'LKR','â‚¨','144','Sri Lanka Rupee'),(96,'LRD','$','430','Liberian Dollar'),(97,'LSL',NULL,'426','Lesotho Loti'),(98,'LTL','Lt','440','Lithuanian Litas'),(99,'LVL','Ls','428','Latvian Lats'),(100,'LYD',NULL,'434','Libyan Dinar'),(101,'MAD',NULL,'504','Moroccan Dirham'),(102,'MDL',NULL,'498','Moldovan Leu'),(103,'MGA',NULL,'969','Malagascy Ariary'),(104,'MKD','Ð´ÐµÐ½','807','Macedonian Denar'),(105,'MMK',NULL,'104','Myanmar Kyat'),(106,'MOP',NULL,'446','Macao Pataca'),(107,'MRO',NULL,'478','Mauritanian Ouguiya'),(108,'MTL','Lm','470','Maltese Lira'),(109,'MUR','â‚¨','480','Mauritius Rupee'),(110,'MVR',NULL,'462','Maldive Rufiyaa'),(111,'MWK',NULL,'454','Malawi Kwacha'),(112,'MXN','$','484','Mexican Peso'),(113,'MXV',NULL,'979','Mexican Unidad de Inversion (UID)'),(114,'MYR','RM','458','Malaysian Ringgit'),(115,'MZN','MT','943','Mozambique Metical'),(116,'NAD','$','516','Namibian Dollar'),(117,'NIO','C$','558','Nicaraguan Cordoba Oro'),(118,'NOK','kr','578','Norwegian Krone'),(119,'NPR','â‚¨','524','Nepalese Rupee'),(120,'NZD','$','554','New Zealand Dollar'),(121,'OMR','ï·¼','512','Rial Omani'),(122,'PAB','B/.','590','Panamanian Balboa'),(123,'PEN','S/.','604','Peruvian Nuevo Sol'),(124,'PGK',NULL,'598','Papua New Guinea Kina'),(125,'PHP','Php','608','Philippine Peso'),(126,'PKR','â‚¨','586','Pakistan Rupee'),(127,'PYG','Gs','600','Paraguay Guarani'),(128,'QAR','ï·¼','634','Qatari Rial'),(129,'ROL',NULL,'642','Romanian Old Leu'),(130,'RON','lei','946','Romanian New Leu'),(131,'RUB','Ñ€ÑƒÐ±','643','Russian Rouble'),(132,'RWF',NULL,'646','Rwanda Franc'),(133,'SAR','ï·¼','682','Saudi Riyal'),(134,'SBD','$','090','Solomon Islands Dollar'),(135,'SCR','â‚¨','690','Seychelles Rupee'),(136,'SDD',NULL,'736','Sudanese Dinar'),(137,'SEK','kr','752','Swedish Krona'),(138,'SGD','$','702','Singapore Dollar'),(139,'SHP','Â£','654','Saint Helena Pound'),(140,'SIT',NULL,'705','Slovenian Tolar'),(141,'SKK','SIT','703','Slovak Koruna'),(142,'SLL',NULL,'694','Leone'),(143,'SOS','S','706','Somali Shilling'),(144,'SRD','$','968','Surinam Dollar'),(145,'STD',NULL,'678','SÃ£o Tome and Principe Dobra'),(146,'SVC','$','222','El Salvador Colon'),(147,'SYP','Â£','760','Syrian Pound'),(148,'SZL',NULL,'748','Swaziland Lilangeni'),(149,'TJS',NULL,'972','Tajik Somoni'),(150,'TMM',NULL,'795','Turkmenistan Manat'),(151,'TND',NULL,'788','Tunisian Dinar'),(152,'TOP',NULL,'776','Tongan Pa\'anga'),(153,'TRY','YTL','949','New Turkish Lira'),(154,'TTD','TT$','780','Trinidad and Tobago Dollar'),(155,'TWD','NT$','901','New Taiwan Dollar'),(156,'TZS',NULL,'834','Tanzanian Shilling'),(157,'UAH','â‚´','980','Ukrainian Hryvnia'),(158,'UGX',NULL,'800','Ugandan Shilling'),(159,'USN',NULL,'997','US Dollar (Next day)'),(160,'USS',NULL,'998','US Dollar (Same day)'),(161,'UYU','$U','858','Peso Uruguayo'),(162,'UZS','Ð»Ð²','860','Uzbekistan Sum'),(163,'VEB','Bs','862','Venezuela Bolivar'),(164,'VUV',NULL,'548','Vanuatu Vatu'),(165,'WST',NULL,'882','Samoan Tala'),(166,'XAF',NULL,'950','CFA Franc BEAC'),(167,'XAG',NULL,'961','Silver'),(168,'XAU',NULL,'959','Gold'),(169,'XBA',NULL,'955','Bond Markets Units European Composite Unit (EURCO)'),(170,'XBB',NULL,'956','European Monetary Unit (E.M.U.-6)'),(171,'XBC',NULL,'957','European Unit of Account 9 (E.U.A.-9)'),(172,'XBD',NULL,'958','European Unit of Account 17 (E.U.A.-17)'),(173,'XCD','$','951','East Caribbean Dollar'),(174,'XDR',NULL,'960','Special Drawing Right'),(175,'XFO',NULL,NULL,'Gold-Franc'),(176,'XFU',NULL,NULL,'UIC-Franc'),(177,'XOF',NULL,'952','CFA Franc BCEAO'),(178,'XPD',NULL,'964','Palladium'),(179,'XPF',NULL,'953','CFP Franc'),(180,'XPT',NULL,'962','Platinum'),(181,'XTS',NULL,'963','Code for testing purposes'),(182,'XXX',NULL,'999','No currency involved'),(183,'YER','ï·¼','886','Yemeni Rial'),(184,'ZMK',NULL,'894','Zambian Kwacha'),(185,'ZWD','Z$','716','Zimbabwe Dollar');
/*!40000 ALTER TABLE `civicrm_currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_custom_field`
--

DROP TABLE IF EXISTS `civicrm_custom_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_custom_field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Custom Field ID',
  `custom_group_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_custom_group.',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Text for form field label (also friendly name for administering this custom property).',
  `data_type` enum('String','Int','Float','Money','Memo','Date','Boolean','StateProvince','Country','File','Link','ContactReference') COLLATE utf8_unicode_ci NOT NULL COMMENT 'Controls location of data storage in extended_data table.',
  `html_type` enum('Text','TextArea','Select','Multi-Select','AdvMulti-Select','Radio','CheckBox','Select Date','Select State/Province','Select Country','Multi-Select Country','Multi-Select State/Province','File','Link','RichTextEditor','Autocomplete-Select') COLLATE utf8_unicode_ci NOT NULL COMMENT 'HTML types plus several built-in extended types.',
  `default_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Use form_options.is_default for field_types which use options.',
  `is_required` tinyint(4) DEFAULT NULL COMMENT 'Is a value required for this property.',
  `is_searchable` tinyint(4) DEFAULT NULL COMMENT 'Is this property searchable.',
  `is_search_range` tinyint(4) DEFAULT '0' COMMENT 'Is this property range searchable.',
  `weight` int(11) NOT NULL DEFAULT '1' COMMENT 'Controls field display order within an extended property group.',
  `help_pre` text COLLATE utf8_unicode_ci COMMENT 'Description and/or help text to display before this field.',
  `help_post` text COLLATE utf8_unicode_ci COMMENT 'Description and/or help text to display after this field.',
  `mask` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Optional format instructions for specific field types, like date types.',
  `attributes` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Store collection of type-appropriate attributes, e.g. textarea  needs rows/cols attributes',
  `javascript` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Optional scripting attributes for field.',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  `is_view` tinyint(4) DEFAULT NULL COMMENT 'Is this property set by PHP Code? A code field is viewable but not editable',
  `options_per_line` int(10) unsigned DEFAULT NULL COMMENT 'number of options per line for checkbox and radio',
  `text_length` int(10) unsigned DEFAULT NULL COMMENT 'field length if alphanumeric',
  `start_date_years` int(10) unsigned DEFAULT NULL COMMENT 'Date may be up to start_date_years years prior to tcurrent date  ',
  `end_date_years` int(10) unsigned DEFAULT NULL COMMENT 'Date may be up to end_date_years years after to tcurrent date ',
  `date_format` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'date format for custom date',
  `time_format` int(10) unsigned DEFAULT NULL COMMENT 'time format for custom date',
  `note_columns` int(10) unsigned DEFAULT NULL COMMENT ' Number of columns in Note Field ',
  `note_rows` int(10) unsigned DEFAULT NULL COMMENT ' Number of rows in Note Field ',
  `column_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name of the column that holds the values for this field.',
  `option_group_id` int(10) unsigned DEFAULT NULL COMMENT 'For elements with options, the option group id that is used',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_label_custom_group_id` (`label`,`custom_group_id`),
  KEY `FK_civicrm_custom_field_custom_group_id` (`custom_group_id`),
  CONSTRAINT `FK_civicrm_custom_field_custom_group_id` FOREIGN KEY (`custom_group_id`) REFERENCES `civicrm_custom_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_custom_field`
--

LOCK TABLES `civicrm_custom_field` WRITE;
/*!40000 ALTER TABLE `civicrm_custom_field` DISABLE KEYS */;
INSERT INTO `civicrm_custom_field` VALUES (16,1,'Professional_Accreditations','Professional Accreditations','String','Text',NULL,0,1,0,7,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'professional_accreditations_16',NULL),(17,1,'Interest_in_Volunteering_','Interest in Volunteering?','Boolean','Radio',NULL,0,1,0,24,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'interest_in_volunteering__17',NULL),(18,1,'Active_Constituent_','Active Constituent?','Boolean','Radio',NULL,0,1,0,25,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'active_constituent__18',NULL),(19,1,'Friend_of_the_Senator_','Friend of the Senator?','Boolean','Radio',NULL,0,1,0,38,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'friend_of_the_senator__19',NULL),(20,1,'Skills_Areas_of_Interest','Skills/Areas of Interest','Memo','TextArea',NULL,0,1,0,45,NULL,NULL,NULL,'rows=4, cols=60',NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'skills_areas_of_interest_20',NULL),(21,1,'Honors_and_Awards','Honors and Awards','String','Text',NULL,0,0,0,49,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'honors_and_awards_21',NULL),(23,1,'Voter_Registration_Status','Voter Registration Status','String','Select',NULL,0,1,0,83,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'voter_registration_status_23',70),(24,1,'BOE_Date_of_Registration','BOE Date of Registration','Date','Select Date',NULL,0,1,1,84,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,'mm/dd/yy',NULL,60,4,'boe_date_of_registration_24',NULL),(25,3,'Charity_Registration__DOS_','Charity Registration (DOS)','String','Text',NULL,0,1,0,1,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'charity_registration__dos__25',NULL),(26,3,'Employer_Identification_Number__EIN_','Employer Identification Number (EIN)','String','Text',NULL,0,1,0,8,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'employer_identification_number___26',NULL),(36,5,'Attachment_1','Attachment 1','File','File',NULL,0,0,0,4,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'attachment_36',NULL),(37,5,'Attachment_2','Attachment 2','File','File',NULL,0,0,0,11,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'attachment_2_37',NULL),(38,5,'Attachment_3','Attachment 3','File','File',NULL,0,0,0,14,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'attachment_3_38',NULL),(39,5,'Attachment_4','Attachment 4','File','File',NULL,0,0,0,17,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'attachment_4_39',NULL),(40,5,'Attachment_5','Attachment 5','File','File',NULL,0,0,0,19,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'attachment_5_40',NULL),(41,3,'Organization_Category','Organization Category','String','Select',NULL,0,1,0,15,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'organization_category_41',66),(42,1,'Individual_Category','Individual Category','String','Select',NULL,0,1,0,85,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'individual_category_42',67),(43,6,'Place_of_Inquiry','Place of Inquiry','String','Select',NULL,0,1,0,5,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'place_of_inquiry_43',71),(44,6,'Activity_Category','Activity Category','String','Select',NULL,0,1,0,12,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'activity_category_44',68),(45,1,'Other_Gender','Other Gender','String','Text',NULL,0,1,0,86,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'other_gender_45',NULL),(46,7,'Congressional_District','Congressional District','String','Text',NULL,0,1,0,6,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'congressional_district_46',NULL),(47,7,'NY_Senate_District','NY Senate District','String','Text',NULL,0,1,0,13,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'ny_senate_district_47',NULL),(48,7,'NY_Assembly_District','NY Assembly District','String','Text',NULL,0,1,0,16,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'ny_assembly_district_48',NULL),(49,7,'Election_District','Election District','String','Text',NULL,0,1,0,18,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'election_district_49',NULL),(50,7,'County','County','String','Text',NULL,0,1,0,20,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'county_50',NULL),(51,7,'County_Legislative_District','County Legislative District','String','Text',NULL,0,1,0,21,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'county_legislative_district_51',NULL),(52,7,'Town','Town','String','Text',NULL,0,1,0,26,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'town_52',NULL),(53,7,'Ward','Ward','String','Text',NULL,0,1,0,29,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'ward_53',NULL),(54,7,'School_District','School District','String','Text',NULL,0,1,0,32,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'school_district_54',NULL),(55,7,'New_York_City_Council','New York City Council','String','Text',NULL,0,1,0,34,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'new_york_city_council_55',NULL),(56,7,'Neighborhood','Neighborhood','String','Text',NULL,0,1,0,35,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'neighborhood_56',NULL),(57,7,'Last_Import','Last Import','Date','Select Date',NULL,0,0,0,39,NULL,NULL,NULL,NULL,NULL,1,1,NULL,255,NULL,NULL,'yy-mm-dd',2,60,4,'last_import_57',NULL),(58,1,'Ethnicity','Ethnicity','String','Multi-Select',NULL,0,1,0,54,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'ethnicity1_58',63),(60,1,'Contact_Source','Contact Source','String','Select',NULL,0,1,0,2,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'contact_source_60',64),(61,1,'Record_Type','Record Type','String','Select',NULL,0,1,0,87,NULL,NULL,NULL,NULL,NULL,1,1,NULL,255,NULL,NULL,NULL,NULL,60,4,'record_type_61',73),(62,1,'Other_Ethnicity','Other Ethnicity','String','Text',NULL,0,1,0,58,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'other_ethnicity_62',NULL),(63,1,'Religion','Religion','String','Text',NULL,0,1,0,88,NULL,NULL,NULL,NULL,NULL,1,0,NULL,255,NULL,NULL,NULL,NULL,60,4,'religion_63',NULL);
/*!40000 ALTER TABLE `civicrm_custom_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_custom_group`
--

DROP TABLE IF EXISTS `civicrm_custom_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_custom_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Custom Group ID',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Variable name/programmatic handle for this group.',
  `title` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Friendly Name.',
  `extends` enum('Contact','Individual','Household','Organization','Location','Address','Contribution','Activity','Relationship','Group','Membership','Participant','Event','Grant','Pledge','Case') COLLATE utf8_unicode_ci DEFAULT 'Contact' COMMENT 'Type of object this group extends (can add other options later e.g. contact_address, etc.).',
  `extends_entity_column_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value.id (for option group custom_data_type.)',
  `extends_entity_column_value` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'linking custom group for dynamic object',
  `style` enum('Tab','Inline') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Visual relationship between this form and its parent.',
  `collapse_display` int(10) unsigned DEFAULT '0' COMMENT 'Will this group be in collapsed or expanded mode on initial display ?',
  `help_pre` text COLLATE utf8_unicode_ci COMMENT 'Description and/or help text to display before fields in form.',
  `help_post` text COLLATE utf8_unicode_ci COMMENT 'Description and/or help text to display after fields in form.',
  `weight` int(11) NOT NULL DEFAULT '1' COMMENT 'Controls display order when multiple extended property groups are setup for the same class.',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  `table_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name of the table that holds the values for this group.',
  `is_multiple` tinyint(4) DEFAULT NULL COMMENT 'Does this group hold multiple values?',
  `min_multiple` int(10) unsigned DEFAULT NULL COMMENT 'minimum number of multiple records (typically 0?)',
  `max_multiple` int(10) unsigned DEFAULT NULL COMMENT 'maximum number of multiple records, if 0 - no max',
  `collapse_adv_display` int(10) unsigned DEFAULT '0' COMMENT 'Will this group be in collapsed or expanded mode on advanced search display ?',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who created this custom group',
  `created_date` datetime DEFAULT NULL COMMENT 'Date and time this custom group was created.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_title_extends` (`title`,`extends`),
  UNIQUE KEY `UI_name_extends` (`name`,`extends`),
  KEY `FK_civicrm_custom_group_created_id` (`created_id`),
  CONSTRAINT `FK_civicrm_custom_group_created_id` FOREIGN KEY (`created_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_custom_group`
--

LOCK TABLES `civicrm_custom_group` WRITE;
/*!40000 ALTER TABLE `civicrm_custom_group` DISABLE KEYS */;
INSERT INTO `civicrm_custom_group` VALUES (1,'Additional_Constituent_Information','Additional Constituent Information','Individual',NULL,NULL,'Inline',0,'<p>\r\n	Please enter additional constituent information as data becomes available for this contact.</p>','<br />',1,1,'civicrm_value_constituent_information_1',0,NULL,NULL,0,1,NULL),(3,'Organization_Constituent_Information','Organization Constituent Information','Organization',NULL,NULL,'Inline',0,'','',2,1,'civicrm_value_organization_constituent_informa_3',0,NULL,NULL,0,1,'2010-03-09 21:52:36'),(5,'Attachments','Attachments','Contact',NULL,NULL,'Inline',0,'','',3,1,'civicrm_value_attachments_5',0,NULL,NULL,1,1,'2010-03-10 18:41:43'),(6,'Activity_Details','Activity Details','Activity',NULL,NULL,'Inline',0,'','',4,1,'civicrm_value_activity_details_6',0,NULL,NULL,0,1,'2010-03-10 21:20:36'),(7,'District_Information','District Information','Address',NULL,NULL,'Inline',1,NULL,NULL,5,1,'civicrm_value_district_information_7',0,NULL,NULL,0,1,'2010-03-30 16:02:33');
/*!40000 ALTER TABLE `civicrm_custom_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_dashboard`
--

DROP TABLE IF EXISTS `civicrm_dashboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_dashboard` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Domain for dashboard',
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'dashlet title',
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'url in case of external dashlet',
  `content` text COLLATE utf8_unicode_ci COMMENT 'dashlet content',
  `permission` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Permission for the dashlet',
  `permission_operator` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Permission Operator',
  `column_no` tinyint(4) DEFAULT '0' COMMENT 'column no for this dashlet',
  `is_minimized` tinyint(4) DEFAULT '0' COMMENT 'Is Minimized?',
  `is_fullscreen` tinyint(4) DEFAULT '1' COMMENT 'Is Fullscreen?',
  `is_active` tinyint(4) DEFAULT '0' COMMENT 'Is this dashlet active?',
  `is_reserved` tinyint(4) DEFAULT '0' COMMENT 'Is this dashlet reserved?',
  `weight` int(11) DEFAULT '0' COMMENT 'Ordering of the dashlets.',
  `created_date` datetime DEFAULT NULL COMMENT 'When was content populated',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_dashboard_domain_id` (`domain_id`),
  CONSTRAINT `FK_civicrm_dashboard_domain_id` FOREIGN KEY (`domain_id`) REFERENCES `civicrm_domain` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_dashboard`
--

LOCK TABLES `civicrm_dashboard` WRITE;
/*!40000 ALTER TABLE `civicrm_dashboard` DISABLE KEYS */;
INSERT INTO `civicrm_dashboard` VALUES (1,1,'Activities','civicrm/dashlet/activity&reset=1&snippet=4',NULL,'access CiviCRM',NULL,0,0,1,1,1,1,'2011-01-29 14:26:23'),(2,1,'My Cases','civicrm/dashlet/myCases&reset=1&snippet=4',NULL,'access my cases and activities',NULL,0,0,1,1,1,1,'2011-01-29 14:26:23'),(3,1,'All Cases','civicrm/dashlet/allCases&reset=1&snippet=4',NULL,'access all cases and activities',NULL,0,0,1,1,1,1,'2011-01-29 14:26:23'),(4,1,'Twitter','civicrm/dashlet/twitter&reset=1&snippet=4',NULL,'access CiviCRM',NULL,0,0,0,1,1,1,'2011-01-29 14:26:23'),(5,1,'All Activities, Last 7 Days','civicrm/report/instance/23&reset=1&section=2&snippet=4',NULL,'access all cases and activities',NULL,0,0,1,1,1,0,'2011-01-29 14:26:23'),(6,1,'Emails Received, Last 7 Days','civicrm/report/instance/24&reset=1&section=2&snippet=4',NULL,'access all cases and activities',NULL,0,0,1,1,1,0,'2011-01-29 14:26:23');
/*!40000 ALTER TABLE `civicrm_dashboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_dashboard_contact`
--

DROP TABLE IF EXISTS `civicrm_dashboard_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_dashboard_contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dashboard_id` int(10) unsigned NOT NULL COMMENT 'Dashboard ID',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'Contact ID',
  `column_no` tinyint(4) DEFAULT '0' COMMENT 'column no for this widget',
  `is_minimized` tinyint(4) DEFAULT '0' COMMENT 'Is Minimized?',
  `is_fullscreen` tinyint(4) DEFAULT '1' COMMENT 'Is Fullscreen?',
  `is_active` tinyint(4) DEFAULT '0' COMMENT 'Is this widget active?',
  `weight` int(11) DEFAULT '0' COMMENT 'Ordering of the widgets.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_dashboard_contact_dashboard_id` (`dashboard_id`),
  KEY `FK_civicrm_dashboard_contact_contact_id` (`contact_id`),
  CONSTRAINT `FK_civicrm_dashboard_contact_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_dashboard_contact_dashboard_id` FOREIGN KEY (`dashboard_id`) REFERENCES `civicrm_dashboard` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_dashboard_contact`
--

LOCK TABLES `civicrm_dashboard_contact` WRITE;
/*!40000 ALTER TABLE `civicrm_dashboard_contact` DISABLE KEYS */;
INSERT INTO `civicrm_dashboard_contact` VALUES (1,1,1,0,0,1,1,2),(2,3,1,0,0,1,1,4),(3,2,1,0,0,1,1,3),(4,4,1,1,0,1,1,1),(5,5,1,0,0,1,1,5),(6,6,1,0,0,1,1,1);
/*!40000 ALTER TABLE `civicrm_dashboard_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_dedupe_exception`
--

DROP TABLE IF EXISTS `civicrm_dedupe_exception`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_dedupe_exception` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique dedupe exception id.',
  `contact_id1` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `contact_id2` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_contact_id1_contact_id2` (`contact_id1`,`contact_id2`),
  KEY `FK_civicrm_dedupe_exception_contact_id2` (`contact_id2`),
  CONSTRAINT `FK_civicrm_dedupe_exception_contact_id1` FOREIGN KEY (`contact_id1`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_dedupe_exception_contact_id2` FOREIGN KEY (`contact_id2`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_dedupe_exception`
--

LOCK TABLES `civicrm_dedupe_exception` WRITE;
/*!40000 ALTER TABLE `civicrm_dedupe_exception` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_dedupe_exception` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_dedupe_rule`
--

DROP TABLE IF EXISTS `civicrm_dedupe_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_dedupe_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique dedupe rule id',
  `dedupe_rule_group_id` int(10) unsigned NOT NULL COMMENT 'The id of the rule group this rule belongs to',
  `rule_table` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The name of the table this rule is about',
  `rule_field` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The name of the field of the table referenced in rule_table',
  `rule_length` int(10) unsigned DEFAULT NULL COMMENT 'The lenght of the matching substring',
  `rule_weight` int(11) NOT NULL COMMENT 'The weight of the rule',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_dedupe_rule_dedupe_rule_group_id` (`dedupe_rule_group_id`),
  CONSTRAINT `FK_civicrm_dedupe_rule_dedupe_rule_group_id` FOREIGN KEY (`dedupe_rule_group_id`) REFERENCES `civicrm_dedupe_rule_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_dedupe_rule`
--

LOCK TABLES `civicrm_dedupe_rule` WRITE;
/*!40000 ALTER TABLE `civicrm_dedupe_rule` DISABLE KEYS */;
INSERT INTO `civicrm_dedupe_rule` VALUES (113,8,'civicrm_contact','birth_date',NULL,1),(114,8,'civicrm_contact','last_name',NULL,5),(115,8,'civicrm_contact','first_name',NULL,5),(116,8,'civicrm_address','city',NULL,5),(121,1,'civicrm_address','street_address',NULL,1),(122,1,'civicrm_contact','last_name',NULL,5),(123,1,'civicrm_contact','first_name',NULL,5),(124,1,'civicrm_address','city',NULL,5),(125,9,'civicrm_contact','first_name',NULL,10),(126,9,'civicrm_contact','last_name',NULL,10),(127,9,'civicrm_email','email',NULL,10),(138,6,'civicrm_contact','household_name',NULL,10),(139,6,'civicrm_address','street_address',NULL,10),(140,6,'civicrm_address','city',NULL,10),(141,6,'civicrm_email','email',NULL,10),(142,7,'civicrm_contact','household_name',NULL,10),(143,7,'civicrm_address','street_address',NULL,10),(144,7,'civicrm_address','city',NULL,10),(145,3,'civicrm_contact','household_name',NULL,10),(146,3,'civicrm_address','street_address',NULL,10),(147,3,'civicrm_address','postal_code',NULL,10),(152,5,'civicrm_contact','organization_name',NULL,10),(153,5,'civicrm_address','street_address',NULL,10),(154,5,'civicrm_address','city',NULL,10),(155,5,'civicrm_email','email',NULL,10),(170,2,'civicrm_contact','organization_name',NULL,4),(171,2,'civicrm_address','street_address',NULL,3),(172,2,'civicrm_address','postal_code',NULL,2),(173,2,'civicrm_address','city',NULL,1),(174,10,'civicrm_contact','organization_name',NULL,3),(175,10,'civicrm_address','street_address',NULL,2),(176,10,'civicrm_address','city',NULL,1),(177,4,'civicrm_contact','last_name',NULL,1);
/*!40000 ALTER TABLE `civicrm_dedupe_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_dedupe_rule_group`
--

DROP TABLE IF EXISTS `civicrm_dedupe_rule_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_dedupe_rule_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique dedupe rule group id',
  `contact_type` enum('Individual','Organization','Household') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The type of contacts this group applies to',
  `threshold` int(11) NOT NULL COMMENT 'The weight threshold the sum of the rule weights has to cross to consider two contacts the same',
  `level` enum('Strict','Fuzzy') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Whether the rule should be used for cases where strict maching of the given contact type is required or a fuzzy one',
  `is_default` tinyint(4) DEFAULT NULL COMMENT 'Is this a default rule (one rule for every contact type + level combination should be default)',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name of the rule group',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_dedupe_rule_group`
--

LOCK TABLES `civicrm_dedupe_rule_group` WRITE;
/*!40000 ALTER TABLE `civicrm_dedupe_rule_group` DISABLE KEYS */;
INSERT INTO `civicrm_dedupe_rule_group` VALUES (1,'Individual',16,'Fuzzy',1,'Level 3 (street + lname + fname + city)'),(2,'Organization',10,'Fuzzy',1,'Level 2 (name + street + city + zip)'),(3,'Household',30,'Fuzzy',1,'Level 2 (name + street + zip)'),(4,'Individual',1,'Strict',1,'Level 1 (fname + lname + birth + postal)'),(5,'Organization',40,'Strict',1,'Level 1 (name + address + city + email)'),(6,'Household',40,'Strict',1,'Level 1 (name + street + city + email)'),(7,'Household',30,'Fuzzy',0,'Level 3 (name + street + city)'),(8,'Individual',16,'Strict',0,'Level 2 (fname + lname + city + birth)'),(9,'Individual',30,'Fuzzy',0,'Level 4 (fname + lname + email)'),(10,'Organization',6,'Fuzzy',0,'Level 3 (name + street + city)');
/*!40000 ALTER TABLE `civicrm_dedupe_rule_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_discount`
--

DROP TABLE IF EXISTS `civicrm_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_discount` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'physical tablename for entity being joined to discount, e.g. civicrm_event',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'FK to entity table specified in entity_table column.',
  `option_group_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_option_group',
  `start_date` date DEFAULT NULL COMMENT 'Date when discount starts.',
  `end_date` date DEFAULT NULL COMMENT 'Date when discount ends.',
  PRIMARY KEY (`id`),
  KEY `index_entity` (`entity_table`,`entity_id`),
  KEY `index_entity_option_id` (`entity_table`,`entity_id`,`option_group_id`),
  KEY `FK_civicrm_discount_option_group_id` (`option_group_id`),
  CONSTRAINT `FK_civicrm_discount_option_group_id` FOREIGN KEY (`option_group_id`) REFERENCES `civicrm_option_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_discount`
--

LOCK TABLES `civicrm_discount` WRITE;
/*!40000 ALTER TABLE `civicrm_discount` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_domain`
--

DROP TABLE IF EXISTS `civicrm_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_domain` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Domain ID',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name of Domain / Organization',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Description of Domain.',
  `config_backend` text COLLATE utf8_unicode_ci COMMENT 'Backend configuration.',
  `version` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The civicrm version this instance is running',
  `loc_block_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Location Block ID. This is specifically not an FK to avoid circular constraints',
  `locales` text COLLATE utf8_unicode_ci COMMENT 'list of locales supported by the current db state (NULL for single-lang install)',
  `locale_custom_strings` text COLLATE utf8_unicode_ci COMMENT 'Locale specific string overrides',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_domain`
--

LOCK TABLES `civicrm_domain` WRITE;
/*!40000 ALTER TABLE `civicrm_domain` DISABLE KEYS */;
INSERT INTO `civicrm_domain` VALUES (1,'NY Senate Constituent Services',NULL,'a:74:{s:9:\"enableSSL\";s:0:\"\";s:15:\"civiRelativeURL\";s:1:\"/\";s:11:\"mapProvider\";s:6:\"Google\";s:9:\"mapAPIKey\";s:86:\"ABQIAAAAzY9VyTEuublBDc-Htl9EvhQuOUP8hd2qhSL-nJEVisOKANWd3xQi7-zJ-V3SB2GbiDzS7GSEa0pZeg\";s:11:\"geoProvider\";s:4:\"SAGE\";s:9:\"geoAPIKey\";s:31:\"SQ0lzOepSH3qnh2r4kN1QeRCMAAan2u\";s:21:\"includeWildCardInName\";s:1:\"0\";s:18:\"includeEmailInName\";s:1:\"1\";s:21:\"includeNickNameInName\";s:1:\"0\";s:24:\"includeAlphabeticalPager\";s:1:\"1\";s:20:\"includeOrderByClause\";s:1:\"1\";s:22:\"smartGroupCacheTimeout\";s:1:\"0\";s:22:\"defaultSearchProfileID\";s:2:\"11\";s:25:\"autocompleteContactSearch\";a:2:{i:1;s:1:\"1\";i:2;s:1:\"1\";}s:5:\"debug\";s:1:\"0\";s:20:\"userFrameworkLogging\";s:1:\"0\";s:9:\"backtrace\";s:1:\"0\";s:18:\"fatalErrorTemplate\";s:20:\"CRM/common/fatal.tpl\";s:17:\"fatalErrorHandler\";s:0:\"\";s:15:\"civiAbsoluteURL\";s:29:\"http://sd99.crm.nysenate.gov/\";s:16:\"enableComponents\";a:2:{i:0;s:10:\"CiviReport\";i:1;s:8:\"CiviCase\";}s:18:\"enableComponentIDs\";a:2:{i:0;s:1:\"8\";i:1;s:1:\"7\";}s:13:\"userFramework\";s:6:\"Drupal\";s:11:\"initialized\";s:1:\"0\";s:15:\"DAOFactoryClass\";s:23:\"CRM_Contact_DAO_Factory\";s:17:\"componentRegistry\";O:18:\"CRM_Core_Component\":0:{}s:9:\"inCiviCRM\";s:0:\"\";s:18:\"recaptchaPublicKey\";s:0:\"\";s:12:\"resourceBase\";s:0:\"\";s:12:\"countryLimit\";a:1:{i:0;s:4:\"1228\";}s:13:\"provinceLimit\";a:1:{i:0;s:4:\"1228\";}s:21:\"defaultContactCountry\";s:4:\"1228\";s:15:\"defaultCurrency\";s:3:\"USD\";s:10:\"lcMessages\";s:5:\"en_US\";s:18:\"dateformatDatetime\";s:20:\"%B %E%f, %Y %l:%M %P\";s:14:\"dateformatFull\";s:11:\"%B %E%f, %Y\";s:17:\"dateformatPartial\";s:5:\"%B %Y\";s:14:\"dateformatYear\";s:2:\"%Y\";s:14:\"dateformatTime\";s:8:\"%l:%M %P\";s:15:\"timeInputFormat\";s:1:\"1\";s:15:\"dateInputFormat\";s:8:\"mm/dd/yy\";s:15:\"fiscalYearStart\";a:2:{s:1:\"M\";i:1;s:1:\"d\";i:1;}s:11:\"moneyformat\";s:5:\"%c %a\";s:16:\"moneyvalueformat\";s:3:\"%!i\";s:15:\"currencySymbols\";s:0:\"\";s:21:\"defaultCurrencySymbol\";s:1:\"$\";s:20:\"monetaryDecimalPoint\";s:1:\".\";s:25:\"monetaryThousandSeparator\";s:1:\",\";s:14:\"gettextCodeset\";s:5:\"utf-8\";s:13:\"gettextDomain\";s:7:\"civicrm\";s:20:\"userFrameworkVersion\";s:4:\"6.15\";s:27:\"userFrameworkUsersTableName\";s:5:\"users\";s:21:\"userFrameworkFrontend\";s:0:\"\";s:17:\"maxImportFileSize\";s:7:\"1048576\";s:14:\"maxAttachments\";s:1:\"3\";s:11:\"maxFileSize\";s:1:\"2\";s:7:\"civiHRD\";s:1:\"0\";s:13:\"geocodeMethod\";s:0:\"\";s:12:\"mapGeoCoding\";s:1:\"1\";s:15:\"contactUndelete\";s:1:\"1\";s:12:\"versionCheck\";s:1:\"1\";s:14:\"legacyEncoding\";s:12:\"Windows-1252\";s:14:\"fieldSeparator\";s:1:\",\";s:17:\"maxLocationBlocks\";s:1:\"2\";s:15:\"captchaFontPath\";s:25:\"/usr/X11R6/lib/X11/fonts/\";s:11:\"captchaFont\";s:17:\"HelveticaBold.ttf\";s:21:\"dashboardCacheTimeout\";s:4:\"1440\";s:15:\"doNotResetCache\";s:1:\"0\";s:13:\"oldInputStyle\";s:1:\"1\";s:14:\"formKeyDisable\";s:0:\"\";s:13:\"verpSeparator\";s:1:\".\";s:12:\"mailerPeriod\";s:3:\"180\";s:16:\"mailerSpoolLimit\";s:1:\"0\";s:16:\"mailerBatchLimit\";s:1:\"0\";}','3.3.5',2,NULL,'a:1:{s:5:\"en_US\";a:2:{s:7:\"enabled\";a:2:{s:13:\"wildcardMatch\";a:15:{s:7:\"CiviCRM\";s:8:\"Bluebird\";s:9:\"Full-text\";s:13:\"Find Anything\";s:16:\"Addt\'l Address 1\";s:15:\"Mailing Address\";s:16:\"Addt\'l Address 2\";s:8:\"Building\";s:73:\"Supplemental address info, e.g. c/o, department name, building name, etc.\";s:70:\"Department name, building name, complex, or extension of company name.\";s:7:\"deatils\";s:7:\"details\";s:11:\"sucessfully\";s:12:\"successfully\";s:40:\"groups, contributions, memberships, etc.\";s:27:\"groups, relationships, etc.\";s:18:\"email OR an OpenID\";s:5:\"email\";s:6:\"Client\";s:11:\"Constituent\";s:6:\"client\";s:11:\"constituent\";s:9:\"Job title\";s:9:\"Job Title\";s:9:\"Nick Name\";s:8:\"Nickname\";s:8:\"CiviMail\";s:12:\"BluebirdMail\";s:18:\"CiviCase Dashboard\";s:14:\"Case Dashboard\";}s:10:\"exactMatch\";a:6:{s:8:\"Position\";s:9:\"Job Title\";s:2:\"Id\";s:2:\"ID\";s:6:\"Client\";s:11:\"Constituent\";s:6:\"client\";s:11:\"constituent\";s:10:\"CiviReport\";s:7:\"Reports\";s:8:\"CiviCase\";s:5:\"Cases\";}}s:8:\"disabled\";a:2:{s:13:\"wildcardMatch\";a:0:{}s:10:\"exactMatch\";a:0:{}}}}\"');
/*!40000 ALTER TABLE `civicrm_domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_email`
--

DROP TABLE IF EXISTS `civicrm_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_email` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Email ID',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `location_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Location does this email belong to.',
  `email` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Email address',
  `is_primary` tinyint(4) DEFAULT '0' COMMENT 'Is this the primary?',
  `is_billing` tinyint(4) DEFAULT '0' COMMENT 'Is this the billing?',
  `on_hold` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Is this address on bounce hold?',
  `is_bulkmail` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Is this address for bulk mail ?',
  `hold_date` datetime DEFAULT NULL COMMENT 'When the address went on bounce hold',
  `reset_date` datetime DEFAULT NULL COMMENT 'When the address bounce status was last reset',
  `signature_text` text COLLATE utf8_unicode_ci COMMENT 'Text formatted signature for the email.',
  `signature_html` text COLLATE utf8_unicode_ci COMMENT 'HTML formatted signature for the email.',
  PRIMARY KEY (`id`),
  KEY `index_location_type` (`location_type_id`),
  KEY `UI_email` (`email`),
  KEY `index_is_primary` (`is_primary`),
  KEY `index_is_billing` (`is_billing`),
  KEY `FK_civicrm_email_contact_id` (`contact_id`),
  CONSTRAINT `FK_civicrm_email_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_email`
--

LOCK TABLES `civicrm_email` WRITE;
/*!40000 ALTER TABLE `civicrm_email` DISABLE KEYS */;
INSERT INTO `civicrm_email` VALUES (1,NULL,1,'\"Domain Email\" <domainemail@example.org>',0,0,0,0,NULL,NULL,NULL,NULL),(2,1,1,'bluebird.admin@nysenate.gov',1,0,0,0,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `civicrm_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_entity_batch`
--

DROP TABLE IF EXISTS `civicrm_entity_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_entity_batch` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'physical tablename for entity being joined to file, e.g. civicrm_contact',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'FK to entity table specified in entity_table column.',
  `batch_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_batch',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_batch_entity` (`batch_id`,`entity_id`,`entity_table`),
  KEY `index_entity` (`entity_table`,`entity_id`),
  CONSTRAINT `FK_civicrm_entity_batch_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `civicrm_batch` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_entity_batch`
--

LOCK TABLES `civicrm_entity_batch` WRITE;
/*!40000 ALTER TABLE `civicrm_entity_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_entity_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_entity_file`
--

DROP TABLE IF EXISTS `civicrm_entity_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_entity_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'physical tablename for entity being joined to file, e.g. civicrm_contact',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'FK to entity table specified in entity_table column.',
  `file_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_file',
  PRIMARY KEY (`id`),
  KEY `index_entity` (`entity_table`,`entity_id`),
  KEY `index_entity_file_id` (`entity_table`,`entity_id`,`file_id`),
  KEY `FK_civicrm_entity_file_file_id` (`file_id`),
  CONSTRAINT `FK_civicrm_entity_file_file_id` FOREIGN KEY (`file_id`) REFERENCES `civicrm_file` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_entity_file`
--

LOCK TABLES `civicrm_entity_file` WRITE;
/*!40000 ALTER TABLE `civicrm_entity_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_entity_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_entity_financial_trxn`
--

DROP TABLE IF EXISTS `civicrm_entity_financial_trxn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_entity_financial_trxn` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `entity_id` int(10) unsigned NOT NULL,
  `financial_trxn_id` int(10) unsigned DEFAULT NULL,
  `amount` decimal(20,2) NOT NULL COMMENT 'allocated amount of transaction to this entity',
  `currency` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_entity_financial_trxn_financial_trxn_id` (`financial_trxn_id`),
  CONSTRAINT `FK_civicrm_entity_financial_trxn_financial_trxn_id` FOREIGN KEY (`financial_trxn_id`) REFERENCES `civicrm_financial_trxn` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_entity_financial_trxn`
--

LOCK TABLES `civicrm_entity_financial_trxn` WRITE;
/*!40000 ALTER TABLE `civicrm_entity_financial_trxn` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_entity_financial_trxn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_entity_tag`
--

DROP TABLE IF EXISTS `civicrm_entity_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_entity_tag` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'physical tablename for entity being joined to file, e.g. civicrm_contact',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'FK to entity table specified in entity_table column.',
  `tag_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_tag',
  PRIMARY KEY (`id`),
  KEY `index_entity` (`entity_table`,`entity_id`),
  KEY `FK_civicrm_entity_tag_tag_id` (`tag_id`),
  CONSTRAINT `FK_civicrm_entity_tag_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `civicrm_tag` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_entity_tag`
--

LOCK TABLES `civicrm_entity_tag` WRITE;
/*!40000 ALTER TABLE `civicrm_entity_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_entity_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_event`
--

DROP TABLE IF EXISTS `civicrm_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Event Title (e.g. Fall Fundraiser Dinner)',
  `summary` text COLLATE utf8_unicode_ci COMMENT 'Brief summary of event. Text and html allowed. Displayed on Event Registration form and can be used on other CMS pages which need an event summary.',
  `description` text COLLATE utf8_unicode_ci COMMENT 'Full description of event. Text and html allowed. Displayed on built-in Event Information screens.',
  `event_type_id` int(10) unsigned DEFAULT '0' COMMENT 'Event Type ID.Implicit FK to civicrm_option_value where option_group = event_type.',
  `participant_listing_id` int(10) unsigned DEFAULT '0' COMMENT 'Should we expose the participant list? Implicit FK to civicrm_option_value where option_group = participant_listing.',
  `is_public` tinyint(4) DEFAULT '1' COMMENT 'Public events will be included in the iCal feeds. Access to private event information may be limited using ACLs.',
  `start_date` datetime DEFAULT NULL COMMENT 'Date and time that event starts.',
  `end_date` datetime DEFAULT NULL COMMENT 'Date and time that event ends. May be NULL if no defined end date/time',
  `is_online_registration` tinyint(4) DEFAULT '0' COMMENT 'If true, include registration link on Event Info page.',
  `registration_link_text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Text for link to Event Registration form which is displayed on Event Information screen when is_online_registration is true.',
  `registration_start_date` datetime DEFAULT NULL COMMENT 'Date and time that online registration starts.',
  `registration_end_date` datetime DEFAULT NULL COMMENT 'Date and time that online registration ends.',
  `max_participants` int(10) unsigned DEFAULT NULL COMMENT 'Maximum number of registered participants to allow. After max is reached, a custom Event Full message is displayed. If NULL, allow unlimited number of participants.',
  `event_full_text` text COLLATE utf8_unicode_ci COMMENT 'Message to display on Event Information page and INSTEAD OF Event Registration form if maximum participants are signed up. Can include email address/info about getting on a waiting list, etc. Text and html allowed.',
  `is_monetary` tinyint(4) DEFAULT '0' COMMENT 'Is this a PAID event? If true, one or more fee amounts must be set and a Payment Processor must be configured for Online Event Registration.',
  `contribution_type_id` int(10) unsigned DEFAULT '0' COMMENT 'Contribution type assigned to paid event registrations for this event. Required if is_monetary is true.',
  `payment_processor_id` int(10) unsigned DEFAULT NULL COMMENT 'Payment Processor for this Event (if is_monetary is true)',
  `is_map` tinyint(4) DEFAULT '0' COMMENT 'Include a map block on the Event Information page when geocode info is available and a mapping provider has been specified?',
  `is_active` tinyint(4) DEFAULT '0' COMMENT 'Is this Event enabled or disabled/cancelled?',
  `fee_label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_show_location` tinyint(4) DEFAULT '1' COMMENT 'If true, show event location.',
  `loc_block_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Location Block ID',
  `default_role_id` int(10) unsigned DEFAULT '1' COMMENT 'Participant role ID. Implicit FK to civicrm_option_value where option_group = participant_role.',
  `intro_text` text COLLATE utf8_unicode_ci COMMENT 'Introductory message for Event Registration page. Text and html allowed. Displayed at the top of Event Registration form.',
  `footer_text` text COLLATE utf8_unicode_ci COMMENT 'Footer message for Event Registration page. Text and html allowed. Displayed at the bottom of Event Registration form.',
  `confirm_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Title for Confirmation page.',
  `confirm_text` text COLLATE utf8_unicode_ci COMMENT 'Introductory message for Event Registration page. Text and html allowed. Displayed at the top of Event Registration form.',
  `confirm_footer_text` text COLLATE utf8_unicode_ci COMMENT 'Footer message for Event Registration page. Text and html allowed. Displayed at the bottom of Event Registration form.',
  `is_email_confirm` tinyint(4) DEFAULT '0' COMMENT 'If true, confirmation is automatically emailed to contact on successful registration.',
  `confirm_email_text` text COLLATE utf8_unicode_ci COMMENT 'text to include above standard event info on confirmation email. emails are text-only, so do not allow html for now',
  `confirm_from_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'FROM email name used for confirmation emails.',
  `confirm_from_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'FROM email address used for confirmation emails.',
  `cc_confirm` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'comma-separated list of email addresses to cc each time a confirmation is sent',
  `bcc_confirm` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'comma-separated list of email addresses to bcc each time a confirmation is sent',
  `default_fee_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value.',
  `default_discount_fee_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value.',
  `thankyou_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Title for ThankYou page.',
  `thankyou_text` text COLLATE utf8_unicode_ci COMMENT 'ThankYou Text.',
  `thankyou_footer_text` text COLLATE utf8_unicode_ci COMMENT 'Footer message.',
  `is_pay_later` tinyint(4) DEFAULT '0' COMMENT 'if true - allows the user to send payment directly to the org later',
  `pay_later_text` text COLLATE utf8_unicode_ci COMMENT 'The text displayed to the user in the main form',
  `pay_later_receipt` text COLLATE utf8_unicode_ci COMMENT 'The receipt sent to the user instead of the normal receipt text',
  `is_multiple_registrations` tinyint(4) DEFAULT '0' COMMENT 'if true - allows the user to register multiple participants for event',
  `allow_same_participant_emails` tinyint(4) DEFAULT '0' COMMENT 'if true - allows the user to register multiple registrations from same email address.',
  `has_waitlist` tinyint(4) DEFAULT NULL COMMENT 'Whether the event has waitlist support.',
  `requires_approval` tinyint(4) DEFAULT NULL COMMENT 'Whether participants require approval before they can finish registering.',
  `expiration_time` int(10) unsigned DEFAULT NULL COMMENT 'Expire pending but unconfirmed registrations after this many hours.',
  `waitlist_text` text COLLATE utf8_unicode_ci COMMENT 'Text to display when the event is full, but participants can signup for a waitlist.',
  `approval_req_text` text COLLATE utf8_unicode_ci COMMENT 'Text to display when the approval is required to complete registration for an event.',
  `is_template` tinyint(4) DEFAULT '0' COMMENT 'whether the event has template',
  `template_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Event Template Title',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who created this event',
  `created_date` datetime DEFAULT NULL COMMENT 'Date and time that event was created.',
  `currency` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  PRIMARY KEY (`id`),
  KEY `index_event_type_id` (`event_type_id`),
  KEY `index_participant_listing_id` (`participant_listing_id`),
  KEY `FK_civicrm_event_payment_processor_id` (`payment_processor_id`),
  KEY `FK_civicrm_event_loc_block_id` (`loc_block_id`),
  KEY `FK_civicrm_event_created_id` (`created_id`),
  CONSTRAINT `FK_civicrm_event_created_id` FOREIGN KEY (`created_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_event_loc_block_id` FOREIGN KEY (`loc_block_id`) REFERENCES `civicrm_loc_block` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_event_payment_processor_id` FOREIGN KEY (`payment_processor_id`) REFERENCES `civicrm_payment_processor` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_event`
--

LOCK TABLES `civicrm_event` WRITE;
/*!40000 ALTER TABLE `civicrm_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_file`
--

DROP TABLE IF EXISTS `civicrm_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique ID',
  `file_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Type of file (e.g. Transcript, Income Tax Return, etc). FK to civicrm_option_value.',
  `mime_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'mime type of the document',
  `uri` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'uri of the file on disk',
  `document` mediumblob COMMENT 'contents of the document',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Additional descriptive text regarding this attachment (optional).',
  `upload_date` datetime DEFAULT NULL COMMENT 'Date and time that this attachment was uploaded or written to server.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_file`
--

LOCK TABLES `civicrm_file` WRITE;
/*!40000 ALTER TABLE `civicrm_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_financial_account`
--

DROP TABLE IF EXISTS `civicrm_financial_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_financial_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_contact',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `account_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_financial_account_contact_id` (`contact_id`),
  CONSTRAINT `FK_civicrm_financial_account_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_financial_account`
--

LOCK TABLES `civicrm_financial_account` WRITE;
/*!40000 ALTER TABLE `civicrm_financial_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_financial_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_financial_trxn`
--

DROP TABLE IF EXISTS `civicrm_financial_trxn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_financial_trxn` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Gift ID',
  `from_account_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to financial_account table.',
  `to_account_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to financial_account table.',
  `trxn_date` datetime NOT NULL,
  `trxn_type` enum('Debit','Credit') COLLATE utf8_unicode_ci NOT NULL,
  `total_amount` decimal(20,2) NOT NULL COMMENT 'amount of transaction',
  `fee_amount` decimal(20,2) DEFAULT NULL COMMENT 'actual processor fee if known - may be 0.',
  `net_amount` decimal(20,2) DEFAULT NULL COMMENT 'actual funds transfer amount. total less fees. if processor does not report actual fee during transaction, this is set to total_amount.',
  `currency` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `payment_processor` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'derived from Processor setting in civicrm.settings.php.',
  `trxn_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'unique processor transaction id, bank id + trans id,... depending on payment_method',
  `trxn_result_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'processor result code',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_ft_trxn_id` (`trxn_id`),
  KEY `FK_civicrm_financial_trxn_from_account_id` (`from_account_id`),
  KEY `FK_civicrm_financial_trxn_to_account_id` (`to_account_id`),
  CONSTRAINT `FK_civicrm_financial_trxn_from_account_id` FOREIGN KEY (`from_account_id`) REFERENCES `civicrm_financial_account` (`id`),
  CONSTRAINT `FK_civicrm_financial_trxn_to_account_id` FOREIGN KEY (`to_account_id`) REFERENCES `civicrm_financial_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_financial_trxn`
--

LOCK TABLES `civicrm_financial_trxn` WRITE;
/*!40000 ALTER TABLE `civicrm_financial_trxn` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_financial_trxn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_grant`
--

DROP TABLE IF EXISTS `civicrm_grant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_grant` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Grant id',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'Contact ID of contact record given grant belongs to.',
  `application_received_date` date DEFAULT NULL COMMENT 'Date on which grant application was received by donor.',
  `decision_date` date DEFAULT NULL COMMENT 'Date on which grant decision was made.',
  `money_transfer_date` date DEFAULT NULL COMMENT 'Date on which grant money transfer was made.',
  `grant_due_date` date DEFAULT NULL COMMENT 'Date on which grant report is due.',
  `grant_report_received` tinyint(4) DEFAULT NULL COMMENT 'Yes/No field stating whether grant report was received by donor.',
  `grant_type_id` int(10) unsigned NOT NULL COMMENT 'Type of grant. Implicit FK to civicrm_option_value in grant_type option_group.',
  `amount_total` decimal(20,2) NOT NULL COMMENT 'Requested grant amount, in default currency.',
  `amount_requested` decimal(20,2) DEFAULT NULL COMMENT 'Requested grant amount, in original currency (optional).',
  `amount_granted` decimal(20,2) DEFAULT NULL COMMENT 'Granted amount, in default currency.',
  `currency` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `rationale` text COLLATE utf8_unicode_ci COMMENT 'Grant rationale.',
  `status_id` int(10) unsigned NOT NULL COMMENT 'Id of Grant status.',
  PRIMARY KEY (`id`),
  KEY `index_grant_type_id` (`grant_type_id`),
  KEY `index_status_id` (`status_id`),
  KEY `FK_civicrm_grant_contact_id` (`contact_id`),
  CONSTRAINT `FK_civicrm_grant_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_grant`
--

LOCK TABLES `civicrm_grant` WRITE;
/*!40000 ALTER TABLE `civicrm_grant` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_grant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_group`
--

DROP TABLE IF EXISTS `civicrm_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Group ID',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Internal name of Group.',
  `title` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name of Group.',
  `description` text COLLATE utf8_unicode_ci COMMENT 'Optional verbose description of the group.',
  `source` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Module or process which created this group.',
  `saved_search_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to saved search table.',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this entry active?',
  `visibility` enum('User and User Admin Only','Public Pages') COLLATE utf8_unicode_ci DEFAULT 'User and User Admin Only' COMMENT 'In what context(s) is this field visible.',
  `where_clause` text COLLATE utf8_unicode_ci COMMENT 'the sql where clause if a saved search acl',
  `select_tables` text COLLATE utf8_unicode_ci COMMENT 'the tables to be included in a select data',
  `where_tables` text COLLATE utf8_unicode_ci COMMENT 'the tables to be included in the count statement',
  `group_type` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'FK to group type',
  `cache_date` datetime DEFAULT NULL COMMENT 'Date when we created the cache for a smart group',
  `parents` text COLLATE utf8_unicode_ci COMMENT 'IDs of the parent(s)',
  `children` text COLLATE utf8_unicode_ci COMMENT 'IDs of the child(ren)',
  `is_hidden` tinyint(4) DEFAULT '0' COMMENT 'Is this group hidden?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_title` (`title`),
  UNIQUE KEY `UI_name` (`name`),
  KEY `index_group_type` (`group_type`),
  KEY `FK_civicrm_group_saved_search_id` (`saved_search_id`),
  CONSTRAINT `FK_civicrm_group_saved_search_id` FOREIGN KEY (`saved_search_id`) REFERENCES `civicrm_saved_search` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_group`
--

LOCK TABLES `civicrm_group` WRITE;
/*!40000 ALTER TABLE `civicrm_group` DISABLE KEYS */;
INSERT INTO `civicrm_group` VALUES (1,'Administrators','Administrators','Contacts in this group are assigned Administrator role permissions.',NULL,NULL,1,'User and User Admin Only',NULL,NULL,NULL,'1',NULL,NULL,NULL,0),(2,'Case_Resources','Case Resources','Contacts in this group are listed in the case resources panel, case management screen.',NULL,NULL,1,'User and User Admin Only',' ( `civicrm_group_contact-5`.group_id IN ( 5 ) AND `civicrm_group_contact-5`.status IN (\"Added\") ) ','a:12:{s:15:\"civicrm_contact\";i:1;s:15:\"civicrm_address\";i:1;s:22:\"civicrm_state_province\";i:1;s:15:\"civicrm_country\";i:1;s:13:\"civicrm_email\";i:1;s:13:\"civicrm_phone\";i:1;s:10:\"civicrm_im\";i:1;s:19:\"civicrm_worldregion\";i:1;s:25:\"`civicrm_group_contact-5`\";s:114:\" LEFT JOIN civicrm_group_contact `civicrm_group_contact-5` ON contact_a.id = `civicrm_group_contact-5`.contact_id \";s:6:\"gender\";i:1;s:17:\"individual_prefix\";i:1;s:17:\"individual_suffix\";i:1;}','a:2:{s:15:\"civicrm_contact\";i:1;s:25:\"`civicrm_group_contact-5`\";s:114:\" LEFT JOIN civicrm_group_contact `civicrm_group_contact-5` ON contact_a.id = `civicrm_group_contact-5`.contact_id \";}',NULL,NULL,NULL,NULL,0),(3,'Office_Staff','Office Staff','Contacts in this group will be available to the quick search when assigning an activity or case role.',NULL,NULL,1,'User and User Admin Only',' ( `civicrm_group_contact-12`.group_id IN ( 12 ) AND `civicrm_group_contact-12`.status IN (\"Added\") ) ','a:12:{s:15:\"civicrm_contact\";i:1;s:15:\"civicrm_address\";i:1;s:22:\"civicrm_state_province\";i:1;s:15:\"civicrm_country\";i:1;s:13:\"civicrm_email\";i:1;s:13:\"civicrm_phone\";i:1;s:10:\"civicrm_im\";i:1;s:19:\"civicrm_worldregion\";i:1;s:26:\"`civicrm_group_contact-12`\";s:116:\" LEFT JOIN civicrm_group_contact `civicrm_group_contact-12` ON contact_a.id = `civicrm_group_contact-12`.contact_id \";s:6:\"gender\";i:1;s:17:\"individual_prefix\";i:1;s:17:\"individual_suffix\";i:1;}','a:2:{s:15:\"civicrm_contact\";i:1;s:26:\"`civicrm_group_contact-12`\";s:116:\" LEFT JOIN civicrm_group_contact `civicrm_group_contact-12` ON contact_a.id = `civicrm_group_contact-12`.contact_id \";}',NULL,NULL,NULL,NULL,0),(4,'Mailing_Exclusions','Mailing Exclusions','Deceased and do not mail contacts.',NULL,5,1,'User and User Admin Only',' ( `civicrm_group_contact_cache_4`.group_id = 4 ) ','a:12:{s:15:\"civicrm_contact\";i:1;s:15:\"civicrm_address\";i:1;s:22:\"civicrm_state_province\";i:1;s:15:\"civicrm_country\";i:1;s:13:\"civicrm_email\";i:1;s:13:\"civicrm_phone\";i:1;s:10:\"civicrm_im\";i:1;s:19:\"civicrm_worldregion\";i:1;s:31:\"`civicrm_group_contact_cache_4`\";s:132:\" LEFT JOIN civicrm_group_contact_cache `civicrm_group_contact_cache_4` ON contact_a.id = `civicrm_group_contact_cache_4`.contact_id \";s:6:\"gender\";i:1;s:17:\"individual_prefix\";i:1;s:17:\"individual_suffix\";i:1;}','a:2:{s:15:\"civicrm_contact\";i:1;s:31:\"`civicrm_group_contact_cache_4`\";s:132:\" LEFT JOIN civicrm_group_contact_cache `civicrm_group_contact_cache_4` ON contact_a.id = `civicrm_group_contact_cache_4`.contact_id \";}',NULL,NULL,NULL,NULL,0),(5,'Mailing_Seeds','Mailing Seeds','Contacts in this group will be added to mailings generated using print production export.',NULL,NULL,1,'User and User Admin Only',' ( `civicrm_group_contact-5`.group_id IN ( 5 ) AND `civicrm_group_contact-5`.status IN (\"Added\") ) ','a:12:{s:15:\"civicrm_contact\";i:1;s:15:\"civicrm_address\";i:1;s:22:\"civicrm_state_province\";i:1;s:15:\"civicrm_country\";i:1;s:13:\"civicrm_email\";i:1;s:13:\"civicrm_phone\";i:1;s:10:\"civicrm_im\";i:1;s:19:\"civicrm_worldregion\";i:1;s:25:\"`civicrm_group_contact-5`\";s:114:\" LEFT JOIN civicrm_group_contact `civicrm_group_contact-5` ON contact_a.id = `civicrm_group_contact-5`.contact_id \";s:6:\"gender\";i:1;s:17:\"individual_prefix\";i:1;s:17:\"individual_suffix\";i:1;}','a:2:{s:15:\"civicrm_contact\";i:1;s:25:\"`civicrm_group_contact-5`\";s:114:\" LEFT JOIN civicrm_group_contact `civicrm_group_contact-5` ON contact_a.id = `civicrm_group_contact-5`.contact_id \";}',NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `civicrm_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_group_contact`
--

DROP TABLE IF EXISTS `civicrm_group_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_group_contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `group_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_group',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_contact',
  `status` enum('Added','Removed','Pending') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'status of contact relative to membership in group',
  `location_id` int(10) unsigned DEFAULT NULL COMMENT 'Optional location to associate with this membership',
  `email_id` int(10) unsigned DEFAULT NULL COMMENT 'Optional email to associate with this membership',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_contact_group` (`contact_id`,`group_id`),
  KEY `FK_civicrm_group_contact_group_id` (`group_id`),
  KEY `FK_civicrm_group_contact_location_id` (`location_id`),
  KEY `FK_civicrm_group_contact_email_id` (`email_id`),
  CONSTRAINT `FK_civicrm_group_contact_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_group_contact_email_id` FOREIGN KEY (`email_id`) REFERENCES `civicrm_email` (`id`),
  CONSTRAINT `FK_civicrm_group_contact_group_id` FOREIGN KEY (`group_id`) REFERENCES `civicrm_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_group_contact_location_id` FOREIGN KEY (`location_id`) REFERENCES `civicrm_loc_block` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_group_contact`
--

LOCK TABLES `civicrm_group_contact` WRITE;
/*!40000 ALTER TABLE `civicrm_group_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_group_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_group_contact_cache`
--

DROP TABLE IF EXISTS `civicrm_group_contact_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_group_contact_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `group_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_group',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_contact',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_contact_group` (`contact_id`,`group_id`),
  KEY `FK_civicrm_group_contact_cache_group_id` (`group_id`),
  CONSTRAINT `FK_civicrm_group_contact_cache_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_group_contact_cache_group_id` FOREIGN KEY (`group_id`) REFERENCES `civicrm_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_group_contact_cache`
--

LOCK TABLES `civicrm_group_contact_cache` WRITE;
/*!40000 ALTER TABLE `civicrm_group_contact_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_group_contact_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_group_nesting`
--

DROP TABLE IF EXISTS `civicrm_group_nesting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_group_nesting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Relationship ID',
  `child_group_id` int(10) unsigned NOT NULL COMMENT 'ID of the child group',
  `parent_group_id` int(10) unsigned NOT NULL COMMENT 'ID of the parent group',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_group_nesting_child_group_id` (`child_group_id`),
  KEY `FK_civicrm_group_nesting_parent_group_id` (`parent_group_id`),
  CONSTRAINT `FK_civicrm_group_nesting_child_group_id` FOREIGN KEY (`child_group_id`) REFERENCES `civicrm_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_group_nesting_parent_group_id` FOREIGN KEY (`parent_group_id`) REFERENCES `civicrm_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_group_nesting`
--

LOCK TABLES `civicrm_group_nesting` WRITE;
/*!40000 ALTER TABLE `civicrm_group_nesting` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_group_nesting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_group_organization`
--

DROP TABLE IF EXISTS `civicrm_group_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_group_organization` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Relationship ID',
  `group_id` int(10) unsigned NOT NULL COMMENT 'ID of the group',
  `organization_id` int(10) unsigned NOT NULL COMMENT 'ID of the Organization Contact',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_group_organization` (`group_id`,`organization_id`),
  KEY `FK_civicrm_group_organization_organization_id` (`organization_id`),
  CONSTRAINT `FK_civicrm_group_organization_group_id` FOREIGN KEY (`group_id`) REFERENCES `civicrm_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_group_organization_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_group_organization`
--

LOCK TABLES `civicrm_group_organization` WRITE;
/*!40000 ALTER TABLE `civicrm_group_organization` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_group_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_im`
--

DROP TABLE IF EXISTS `civicrm_im`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_im` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique IM ID',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `location_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Location does this email belong to.',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'IM screen name',
  `provider_id` int(10) unsigned DEFAULT NULL COMMENT 'Which IM Provider does this screen name belong to.',
  `is_primary` tinyint(4) DEFAULT '0' COMMENT 'Is this the primary IM for this contact and location.',
  `is_billing` tinyint(4) DEFAULT '0' COMMENT 'Is this the billing?',
  PRIMARY KEY (`id`),
  KEY `index_location_type` (`location_type_id`),
  KEY `UI_provider_id` (`provider_id`),
  KEY `index_is_primary` (`is_primary`),
  KEY `index_is_billing` (`is_billing`),
  KEY `FK_civicrm_im_contact_id` (`contact_id`),
  CONSTRAINT `FK_civicrm_im_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_im`
--

LOCK TABLES `civicrm_im` WRITE;
/*!40000 ALTER TABLE `civicrm_im` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_im` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_line_item`
--

DROP TABLE IF EXISTS `civicrm_line_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_line_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Line Item',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'table which has the transaction',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'entry in table',
  `price_field_id` int(10) unsigned NOT NULL COMMENT 'FK to price_field',
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'descriptive label for item - from custom_option.label',
  `qty` int(10) unsigned NOT NULL COMMENT 'How many items ordered',
  `unit_price` decimal(20,2) NOT NULL COMMENT 'price of each item',
  `line_total` decimal(20,2) NOT NULL COMMENT 'qty * unit_price',
  `participant_count` int(10) unsigned DEFAULT NULL COMMENT 'Participant count for field',
  `price_field_value_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_line_item_value` (`entity_table`,`entity_id`,`price_field_value_id`,`price_field_id`),
  KEY `index_entity` (`entity_table`,`entity_id`),
  KEY `FK_civicrm_line_item_price_field_id` (`price_field_id`),
  KEY `FK_civicrm_price_field_value_id` (`price_field_value_id`),
  CONSTRAINT `FK_civicrm_line_item_price_field_id` FOREIGN KEY (`price_field_id`) REFERENCES `civicrm_price_field` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_price_field_value_id` FOREIGN KEY (`price_field_value_id`) REFERENCES `civicrm_price_field_value` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_line_item`
--

LOCK TABLES `civicrm_line_item` WRITE;
/*!40000 ALTER TABLE `civicrm_line_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_line_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_loc_block`
--

DROP TABLE IF EXISTS `civicrm_loc_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_loc_block` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique ID',
  `address_id` int(10) unsigned DEFAULT NULL,
  `email_id` int(10) unsigned DEFAULT NULL,
  `phone_id` int(10) unsigned DEFAULT NULL,
  `im_id` int(10) unsigned DEFAULT NULL,
  `address_2_id` int(10) unsigned DEFAULT NULL,
  `email_2_id` int(10) unsigned DEFAULT NULL,
  `phone_2_id` int(10) unsigned DEFAULT NULL,
  `im_2_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_loc_block_address_id` (`address_id`),
  KEY `FK_civicrm_loc_block_email_id` (`email_id`),
  KEY `FK_civicrm_loc_block_phone_id` (`phone_id`),
  KEY `FK_civicrm_loc_block_im_id` (`im_id`),
  KEY `FK_civicrm_loc_block_address_2_id` (`address_2_id`),
  KEY `FK_civicrm_loc_block_email_2_id` (`email_2_id`),
  KEY `FK_civicrm_loc_block_phone_2_id` (`phone_2_id`),
  KEY `FK_civicrm_loc_block_im_2_id` (`im_2_id`),
  CONSTRAINT `FK_civicrm_loc_block_address_2_id` FOREIGN KEY (`address_2_id`) REFERENCES `civicrm_address` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_loc_block_address_id` FOREIGN KEY (`address_id`) REFERENCES `civicrm_address` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_loc_block_email_2_id` FOREIGN KEY (`email_2_id`) REFERENCES `civicrm_email` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_loc_block_email_id` FOREIGN KEY (`email_id`) REFERENCES `civicrm_email` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_loc_block_im_2_id` FOREIGN KEY (`im_2_id`) REFERENCES `civicrm_im` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_loc_block_im_id` FOREIGN KEY (`im_id`) REFERENCES `civicrm_im` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_loc_block_phone_2_id` FOREIGN KEY (`phone_2_id`) REFERENCES `civicrm_phone` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_loc_block_phone_id` FOREIGN KEY (`phone_id`) REFERENCES `civicrm_phone` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_loc_block`
--

LOCK TABLES `civicrm_loc_block` WRITE;
/*!40000 ALTER TABLE `civicrm_loc_block` DISABLE KEYS */;
INSERT INTO `civicrm_loc_block` VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `civicrm_loc_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_location_type`
--

DROP TABLE IF EXISTS `civicrm_location_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_location_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Location Type ID',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Location Type Name.',
  `vcard_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'vCard Location Type Name.',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Location Type Description.',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'Is this location type a predefined system location?',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  `is_default` tinyint(4) DEFAULT NULL COMMENT 'Is this location type the default?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_location_type`
--

LOCK TABLES `civicrm_location_type` WRITE;
/*!40000 ALTER TABLE `civicrm_location_type` DISABLE KEYS */;
INSERT INTO `civicrm_location_type` VALUES (1,'Home','HOME','Place of residence',0,1,1),(2,'Work','WORK','Work location',0,1,NULL),(3,'Main',NULL,'Main office location',0,1,NULL),(4,'Other',NULL,'Other location',0,1,NULL),(5,'Billing',NULL,'Billing Address location',1,0,NULL),(6,'BOE','','Board of Election periodic import; locked for users.',0,1,0),(7,'NCOA','','Used for NCOA import based on procedural rules only.',0,1,0),(8,'Home2','','',NULL,1,0),(9,'Home3','','',NULL,1,0),(10,'Work2','','',NULL,1,0),(11,'Other2','','',NULL,1,0),(12,'Main2','','',NULL,1,0);
/*!40000 ALTER TABLE `civicrm_location_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_log`
--

DROP TABLE IF EXISTS `civicrm_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of table where item being referenced is stored.',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to the referenced item.',
  `data` text COLLATE utf8_unicode_ci COMMENT 'Updates does to this object if any.',
  `modified_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID of person under whose credentials this data modification was made.',
  `modified_date` datetime DEFAULT NULL COMMENT 'When was the referenced entity created or modified or deleted.',
  PRIMARY KEY (`id`),
  KEY `index_entity` (`entity_table`,`entity_id`),
  KEY `FK_civicrm_log_modified_id` (`modified_id`),
  CONSTRAINT `FK_civicrm_log_modified_id` FOREIGN KEY (`modified_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_log`
--

LOCK TABLES `civicrm_log` WRITE;
/*!40000 ALTER TABLE `civicrm_log` DISABLE KEYS */;
INSERT INTO `civicrm_log` VALUES (1,'civicrm_domain',1,'upgrade:3.2.3->3.2.4.upgrade',NULL,'2011-03-12 10:20:33'),(2,'civicrm_domain',1,'upgrade:3.2.4.upgrade->3.2.4',NULL,'2011-03-12 10:20:33'),(3,'civicrm_domain',1,'upgrade:3.2.4->3.2.5.upgrade',NULL,'2011-03-12 10:20:33'),(4,'civicrm_domain',1,'upgrade:3.2.5.upgrade->3.2.5',NULL,'2011-03-12 10:20:33'),(5,'civicrm_domain',1,'upgrade:3.2.5->3.3.alpha1.upgrade',NULL,'2011-03-12 10:20:33'),(6,'civicrm_domain',1,'upgrade:3.3.alpha1.upgrade->3.3.alpha1',NULL,'2011-03-12 10:20:40'),(7,'civicrm_domain',1,'upgrade:3.3.alpha1->3.3.alpha2.upgrade',NULL,'2011-03-12 10:20:40'),(8,'civicrm_domain',1,'upgrade:3.3.alpha2.upgrade->3.3.alpha2',NULL,'2011-03-12 10:20:40'),(9,'civicrm_domain',1,'upgrade:3.3.alpha2->3.3.beta1.upgrade',NULL,'2011-03-12 10:20:40'),(10,'civicrm_domain',1,'upgrade:3.3.beta1.upgrade->3.3.beta1',NULL,'2011-03-12 10:20:43'),(11,'civicrm_domain',1,'upgrade:3.3.beta1->3.3.beta2.upgrade',NULL,'2011-03-12 10:20:43'),(12,'civicrm_domain',1,'upgrade:3.3.beta2.upgrade->3.3.beta2',NULL,'2011-03-12 10:20:46'),(13,'civicrm_domain',1,'upgrade:3.3.beta2->3.3.beta3.upgrade',NULL,'2011-03-12 10:20:46'),(14,'civicrm_domain',1,'upgrade:3.3.beta3.upgrade->3.3.beta3',NULL,'2011-03-12 10:20:46'),(15,'civicrm_domain',1,'upgrade:3.3.beta3->3.3.0.upgrade',NULL,'2011-03-12 10:20:46'),(16,'civicrm_domain',1,'upgrade:3.3.0.upgrade->3.3.0',NULL,'2011-03-12 10:20:46'),(17,'civicrm_domain',1,'upgrade:3.3.0->3.3.1.upgrade',NULL,'2011-03-12 10:20:46'),(18,'civicrm_domain',1,'upgrade:3.3.1.upgrade->3.3.1',NULL,'2011-03-12 10:20:47'),(19,'civicrm_domain',1,'upgrade:3.3.1->3.3.2.upgrade',NULL,'2011-03-12 10:20:47'),(20,'civicrm_domain',1,'upgrade:3.3.2.upgrade->3.3.2',NULL,'2011-03-12 10:20:49'),(21,'civicrm_domain',1,'upgrade:3.3.2->3.3.3.upgrade',NULL,'2011-03-12 10:20:49'),(22,'civicrm_domain',1,'upgrade:3.3.3.upgrade->3.3.3',NULL,'2011-03-12 10:20:49'),(23,'civicrm_domain',1,'upgrade:3.3.3->3.3.4.upgrade',NULL,'2011-03-12 10:20:49'),(24,'civicrm_domain',1,'upgrade:3.3.4.upgrade->3.3.4',NULL,'2011-03-12 10:20:49'),(25,'civicrm_domain',1,'upgrade:3.3.4->3.3.5',NULL,'2011-03-12 10:20:49');
/*!40000 ALTER TABLE `civicrm_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mail_settings`
--

DROP TABLE IF EXISTS `civicrm_mail_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mail_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this match entry for',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'name of this group of settings',
  `is_default` tinyint(4) DEFAULT NULL COMMENT 'whether this is the default set of settings for this domain',
  `domain` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'email address domain (the part after @)',
  `localpart` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'optional local part (like civimail+ for addresses like civimail+s.1.2@example.com)',
  `return_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'contents of the Return-Path header',
  `protocol` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'name of the protocol to use for polling (like IMAP, POP3 or Maildir)',
  `server` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'server to use when polling',
  `port` int(10) unsigned DEFAULT NULL COMMENT 'port to use when polling',
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'username to use when polling',
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'password to use when polling',
  `is_ssl` tinyint(4) DEFAULT NULL COMMENT 'whether to use SSL or not',
  `source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'folder to poll from when using IMAP, path to poll from when using Maildir, etc.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mail_settings`
--

LOCK TABLES `civicrm_mail_settings` WRITE;
/*!40000 ALTER TABLE `civicrm_mail_settings` DISABLE KEYS */;
INSERT INTO `civicrm_mail_settings` VALUES (1,1,'default',1,'FIXME.ORG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `civicrm_mail_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing`
--

DROP TABLE IF EXISTS `civicrm_mailing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `header_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to the header component.',
  `footer_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to the footer component.',
  `reply_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to the auto-responder component.',
  `unsubscribe_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to the unsubscribe component.',
  `resubscribe_id` int(10) unsigned DEFAULT NULL,
  `optout_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to the opt-out component.',
  `name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Mailing Name.',
  `from_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'From Header of mailing',
  `from_email` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'From Email of mailing',
  `replyto_email` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Reply-To Email of mailing',
  `subject` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Subject of mailing',
  `body_text` longtext COLLATE utf8_unicode_ci COMMENT 'Body of the mailing in text format.',
  `body_html` longtext COLLATE utf8_unicode_ci COMMENT 'Body of the mailing in html format.',
  `url_tracking` tinyint(4) DEFAULT NULL COMMENT 'Should we track URL click-throughs for this mailing?',
  `forward_replies` tinyint(4) DEFAULT NULL COMMENT 'Should we forward replies back to the author?',
  `auto_responder` tinyint(4) DEFAULT NULL COMMENT 'Should we enable the auto-responder?',
  `open_tracking` tinyint(4) DEFAULT NULL COMMENT 'Should we track when recipients open/read this mailing?',
  `is_completed` tinyint(4) DEFAULT NULL COMMENT 'Has at least one job associated with this mailing finished?',
  `msg_template_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to the message template.',
  `override_verp` tinyint(4) DEFAULT '0' COMMENT 'Should we overrite VERP address in Reply-To',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID who first created this mailing',
  `created_date` datetime DEFAULT NULL COMMENT 'Date and time this mailing was created.',
  `scheduled_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID who scheduled this mailing',
  `is_archived` tinyint(4) DEFAULT '0' COMMENT 'Is this mailing archived?',
  `scheduled_date` datetime DEFAULT NULL COMMENT 'Date and time this mailing was scheduled.',
  `approver_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID who approved this mailing',
  `approval_date` datetime DEFAULT NULL COMMENT 'Date and time this mailing was approved.',
  `approval_status_id` int(10) unsigned DEFAULT NULL COMMENT 'The status of this mailing. values: none, approved, rejected',
  `approval_note` longtext COLLATE utf8_unicode_ci COMMENT 'Note behind the decision.',
  `visibilty` enum('User and User Admin Only','Public User Pages') COLLATE utf8_unicode_ci DEFAULT 'User and User Admin Only' COMMENT 'In what context(s) is the mailing contents visible (online viewing)',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_header_id` (`header_id`),
  KEY `FK_civicrm_mailing_footer_id` (`footer_id`),
  KEY `FK_civicrm_mailing_reply_id` (`reply_id`),
  KEY `FK_civicrm_mailing_unsubscribe_id` (`unsubscribe_id`),
  KEY `FK_civicrm_mailing_optout_id` (`optout_id`),
  KEY `FK_civicrm_mailing_msg_template_id` (`msg_template_id`),
  KEY `FK_civicrm_mailing_created_id` (`created_id`),
  KEY `FK_civicrm_mailing_scheduled_id` (`scheduled_id`),
  KEY `FK_civicrm_mailing_approver_id` (`approver_id`),
  CONSTRAINT `FK_civicrm_mailing_approver_id` FOREIGN KEY (`approver_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_mailing_created_id` FOREIGN KEY (`created_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_mailing_footer_id` FOREIGN KEY (`footer_id`) REFERENCES `civicrm_mailing_component` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_mailing_header_id` FOREIGN KEY (`header_id`) REFERENCES `civicrm_mailing_component` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_mailing_msg_template_id` FOREIGN KEY (`msg_template_id`) REFERENCES `civicrm_msg_template` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_mailing_optout_id` FOREIGN KEY (`optout_id`) REFERENCES `civicrm_mailing_component` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_mailing_reply_id` FOREIGN KEY (`reply_id`) REFERENCES `civicrm_mailing_component` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_mailing_scheduled_id` FOREIGN KEY (`scheduled_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_mailing_unsubscribe_id` FOREIGN KEY (`unsubscribe_id`) REFERENCES `civicrm_mailing_component` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing`
--

LOCK TABLES `civicrm_mailing` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_mailing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing_bounce_pattern`
--

DROP TABLE IF EXISTS `civicrm_mailing_bounce_pattern`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing_bounce_pattern` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bounce_type_id` int(10) unsigned NOT NULL COMMENT 'Type of bounce',
  `pattern` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'A regexp to match a message to a bounce type',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_bounce_pattern_bounce_type_id` (`bounce_type_id`),
  CONSTRAINT `FK_civicrm_mailing_bounce_pattern_bounce_type_id` FOREIGN KEY (`bounce_type_id`) REFERENCES `civicrm_mailing_bounce_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing_bounce_pattern`
--

LOCK TABLES `civicrm_mailing_bounce_pattern` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing_bounce_pattern` DISABLE KEYS */;
INSERT INTO `civicrm_mailing_bounce_pattern` VALUES (1,1,'Client TOS Notification'),(2,2,'(be|am)? (out of|away from) (the|my)? (office|computer|town)'),(3,2,'i am on vacation'),(4,3,'name(server entry| lookup failure)'),(5,3,'no (mail server|matches to nameserver query|dns entries)'),(6,3,'reverse dns entry'),(7,4,'(unknown|not local) host'),(8,4,'all hosts have been failing'),(9,4,'allowed rcpthosts'),(10,4,'connection (refused|timed out)'),(11,4,'not connected'),(12,4,'couldn\'t find any host named'),(13,4,'error involving remote host'),(14,4,'host unknown'),(15,4,'invalid host name'),(16,4,'isn\'t in my control/locals file'),(17,4,'local configuration error'),(18,4,'not a gateway'),(19,4,'server is down or unreachable'),(20,4,'too many connections'),(21,4,'unable to connect'),(22,5,'(my )?e-?mail( address)? has changed'),(23,5,'account (inactive|expired|deactivated)'),(24,5,'account is locked'),(25,5,'changed w+( e-?mail)? address'),(26,5,'deactivated mailbox'),(27,5,'disabled or discontinued'),(28,5,'inactive user'),(29,5,'is inactive on this domain'),(30,5,'mail receiving disabled'),(31,5,'mail( ?)address is administrative?ly disabled'),(32,5,'mailbox (temporarily disabled|currently suspended)'),(33,5,'no longer (accepting mail|on server|in use|with|employed|on staff|works for|using this account)'),(34,5,'not accepting mail'),(35,5,'please use my new e-?mail address'),(36,5,'this address no longer accepts mail'),(37,5,'user account suspended'),(38,6,'(user|recipient( name)?) is not recognized'),(39,6,'554 delivery error'),(40,6,'address does not exist'),(41,6,'address(es)? could not be found'),(42,6,'addressee unknown'),(43,6,'bad destination'),(44,6,'badly formatted address'),(45,6,'can\'t open mailbox for'),(46,6,'cannot deliver'),(47,6,'delivery to the following recipient(s)? failed'),(48,6,'destination addresses were unknown'),(49,6,'did not reach the following recipient'),(50,6,'does not exist'),(51,6,'does not like recipient'),(52,6,'does not specify a valid notes mail file'),(53,6,'illegal alias'),(54,6,'invalid (mailbox|(e-?mail )?address|recipient|final delivery)'),(55,6,'invalid( or unknown)?( virtual)? user'),(56,6,'mail delivery to this user is not allowed'),(57,6,'mailbox (not found|unavailable|name not allowed)'),(58,6,'message could not be forwarded'),(59,6,'missing or malformed local(-| )part'),(60,6,'no e-?mail address registered'),(61,6,'no such (mail drop|mailbox( w+)?|(e-?mail )?address|recipient|(local )?user)( here)?'),(62,6,'no mailbox here by that name'),(63,6,'not (listed in|found in directory|known at this site|our customer)'),(64,6,'not a valid( (user|mailbox))?'),(65,6,'not present in directory entry'),(66,6,'recipient (does not exist|(is )?unknown)'),(67,6,'this user doesn\'t have a yahoo.com address'),(68,6,'unavailable to take delivery of the message'),(69,6,'unavailable mailbox'),(70,6,'unknown (local( |-)part|recipient)'),(71,6,'unknown( or illegal)? user( account)?'),(72,6,'unrecognized recipient'),(73,6,'unregistered address'),(74,6,'user (unknown|does not exist)'),(75,6,'user doesn\'t have an? w+ account'),(76,6,'user(\'s e-?mail name is)? not found'),(77,7,'(mail|routing) loop'),(78,7,'excessive recursion'),(79,7,'loop detected'),(80,7,'maximum hop count exceeded'),(81,7,'message was forwarded more than the maximum allowed times'),(82,7,'too many hops'),(83,8,'(disk|over the allowed|exceed(ed|s)?|storage) quota'),(84,8,'522_mailbox_full'),(85,8,'exceeds allowed message count'),(86,8,'file too large'),(87,8,'full mailbox'),(88,8,'mailbox ((for user w+ )?is )?full'),(89,8,'mailbox has exceeded the limit'),(90,8,'mailbox( exceeds allowed)? size'),(91,8,'no space left for this user'),(92,8,'over\\s?quota'),(93,8,'quota (for the mailbox )?has been exceeded'),(94,8,'quota (usage|violation|exceeded)'),(95,8,'recipient storage full'),(96,8,'not able to receive more mail'),(97,9,'cannot find your hostname'),(98,9,'ip name lookup'),(99,9,'not configured to relay mail'),(100,9,'relay (not permitted|access denied)'),(101,9,'relayed mail to .+? not allowed'),(102,9,'sender ip must resolve'),(103,9,'unable to relay'),(104,10,'(bulk( e-?mail)|content|attachment blocking|virus|mail system) filters?'),(105,10,'(hostile|questionable|unacceptable) content'),(106,10,'address .+? has not been verified'),(107,10,'anti-?spam (policw+|software)'),(108,10,'anti-?virus gateway has detected'),(109,10,'blacklisted'),(110,10,'blocked message'),(111,10,'content control'),(112,10,'delivery not authorized'),(113,10,'does not conform to our e-?mail policy'),(114,10,'excessive spam content'),(115,10,'message looks suspicious'),(116,10,'open relay'),(117,10,'sender was rejected'),(118,10,'spam(check| reduction software| filters?)'),(119,10,'blocked by a user configured filter'),(120,10,'detected as spam'),(121,11,'nonstandard smtp line terminator'),(122,11,'syntax error in from address'),(123,11,'unknown smtp code'),(124,6,'^Validation failed for:');
/*!40000 ALTER TABLE `civicrm_mailing_bounce_pattern` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing_bounce_type`
--

DROP TABLE IF EXISTS `civicrm_mailing_bounce_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing_bounce_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` enum('AOL','Away','DNS','Host','Inactive','Invalid','Loop','Quota','Relay','Spam','Syntax','Unknown') COLLATE utf8_unicode_ci NOT NULL COMMENT 'Type of bounce',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'A description of this bounce type',
  `hold_threshold` int(10) unsigned NOT NULL COMMENT 'Number of bounces of this type required before the email address is put on bounce hold',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing_bounce_type`
--

LOCK TABLES `civicrm_mailing_bounce_type` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing_bounce_type` DISABLE KEYS */;
INSERT INTO `civicrm_mailing_bounce_type` VALUES (1,'AOL','AOL Terms of Service complaint',1),(2,'Away','Recipient is on vacation',3),(3,'DNS','Unable to resolve recipient domain',3),(4,'Host','Unable to deliver to destintation mail server',3),(5,'Inactive','User account is no longer active',1),(6,'Invalid','Email address is not valid',1),(7,'Loop','Mail routing error',3),(8,'Quota','User inbox is full',3),(9,'Relay','Unable to reach destination mail server',3),(10,'Spam','Message caught by a content filter',1),(11,'Syntax','Error in SMTP transaction',3);
/*!40000 ALTER TABLE `civicrm_mailing_bounce_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing_component`
--

DROP TABLE IF EXISTS `civicrm_mailing_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing_component` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The name of this component',
  `component_type` enum('Header','Footer','Subscribe','Welcome','Unsubscribe','OptOut','Reply','Resubscribe') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Type of Component.',
  `subject` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body_html` text COLLATE utf8_unicode_ci COMMENT 'Body of the component in html format.',
  `body_text` text COLLATE utf8_unicode_ci COMMENT 'Body of the component in text format.',
  `is_default` tinyint(4) DEFAULT '0' COMMENT 'Is this the default component for this component_type?',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing_component`
--

LOCK TABLES `civicrm_mailing_component` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing_component` DISABLE KEYS */;
INSERT INTO `civicrm_mailing_component` VALUES (1,'Mailing Header','Header','Descriptive Title for this Header','Sample Header for HTML formatted content.','Sample Header for TEXT formatted content.',1,1),(2,'Mailing Footer','Footer','Descriptive Title for this Footer.','Sample Footer for HTML formatted content<br/><a href=\"{action.optOutUrl}\">Unsubscribe</a>  <br/> {domain.address}','to unsubscribe: {action.optOutUrl}\n{domain.address}',1,1),(3,'Subscribe Message','Subscribe','Subscription Confirmation Request','You have a pending subscription to the {subscribe.group} mailing list. To confirm this subscription, reply to this email or click <a href=\"{subscribe.url}\">here</a>.','You have a pending subscription to the {subscribe.group} mailing list. To confirm this subscription, reply to this email or click on this link: {subscribe.url}',1,1),(4,'Welcome Message','Welcome','Your Subscription has been Activated','Welcome. Your subscription to the {welcome.group} mailing list has been activated.','Welcome. Your subscription to the {welcome.group} mailing list has been activated.',1,1),(5,'Unsubscribe Message','Unsubscribe','Un-subscribe Confirmation','You have been un-subscribed from the following groups: {unsubscribe.group}. You can re-subscribe by mailing {action.resubscribe} or clicking <a href=\"{action.resubscribeUrl}\">here</a>.','You have been un-subscribed from the following groups: {unsubscribe.group}. You can re-subscribe by mailing {action.resubscribe} or clicking %3',1,1),(6,'Resubscribe Message','Resubscribe','Re-subscribe Confirmation','You have been re-subscribed to the following groups: {resubscribe.group}. You can un-subscribe by mailing {action.unsubscribe} or clicking <a href=\"{action.unsubscribeUrl}\">here</a>.','You have been re-subscribed to the following groups: {resubscribe.group}. You can un-subscribe by mailing {action.unsubscribe} or clicking {action.unsubscribeUrl}',1,1),(7,'Opt-out Message','OptOut','Opt-out Confirmation','Your email address has been removed from {domain.name} mailing lists.','Your email address has been removed from {domain.name} mailing lists.',1,1),(8,'Auto-responder','Reply','Please Send Inquiries to Our Contact Email Address','This is an automated reply from an un-attended mailbox. Please send any inquiries to the contact email address listed on our web-site.','This is an automated reply from an un-attended mailbox. Please send any inquiries to the contact email address listed on our web-site.',1,1);
/*!40000 ALTER TABLE `civicrm_mailing_component` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing_event_bounce`
--

DROP TABLE IF EXISTS `civicrm_mailing_event_bounce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing_event_bounce` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_queue_id` int(10) unsigned NOT NULL COMMENT 'FK to EventQueue',
  `bounce_type_id` int(10) unsigned DEFAULT NULL COMMENT 'What type of bounce was it?',
  `bounce_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The reason the email bounced.',
  `time_stamp` datetime NOT NULL COMMENT 'When this bounce event occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_bounce_event_queue_id` (`event_queue_id`),
  CONSTRAINT `FK_civicrm_mailing_event_bounce_event_queue_id` FOREIGN KEY (`event_queue_id`) REFERENCES `civicrm_mailing_event_queue` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing_event_bounce`
--

LOCK TABLES `civicrm_mailing_event_bounce` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing_event_bounce` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_mailing_event_bounce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing_event_confirm`
--

DROP TABLE IF EXISTS `civicrm_mailing_event_confirm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing_event_confirm` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_subscribe_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_mailing_event_subscribe',
  `time_stamp` datetime NOT NULL COMMENT 'When this confirmation event occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_confirm_event_subscribe_id` (`event_subscribe_id`),
  CONSTRAINT `FK_civicrm_mailing_event_confirm_event_subscribe_id` FOREIGN KEY (`event_subscribe_id`) REFERENCES `civicrm_mailing_event_subscribe` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing_event_confirm`
--

LOCK TABLES `civicrm_mailing_event_confirm` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing_event_confirm` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_mailing_event_confirm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing_event_delivered`
--

DROP TABLE IF EXISTS `civicrm_mailing_event_delivered`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing_event_delivered` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_queue_id` int(10) unsigned NOT NULL COMMENT 'FK to EventQueue',
  `time_stamp` datetime NOT NULL COMMENT 'When this delivery event occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_delivered_event_queue_id` (`event_queue_id`),
  CONSTRAINT `FK_civicrm_mailing_event_delivered_event_queue_id` FOREIGN KEY (`event_queue_id`) REFERENCES `civicrm_mailing_event_queue` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing_event_delivered`
--

LOCK TABLES `civicrm_mailing_event_delivered` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing_event_delivered` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_mailing_event_delivered` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing_event_forward`
--

DROP TABLE IF EXISTS `civicrm_mailing_event_forward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing_event_forward` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_queue_id` int(10) unsigned NOT NULL COMMENT 'FK to EventQueue',
  `dest_queue_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to EventQueue for destination',
  `time_stamp` datetime NOT NULL COMMENT 'When this forward event occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_forward_event_queue_id` (`event_queue_id`),
  KEY `FK_civicrm_mailing_event_forward_dest_queue_id` (`dest_queue_id`),
  CONSTRAINT `FK_civicrm_mailing_event_forward_dest_queue_id` FOREIGN KEY (`dest_queue_id`) REFERENCES `civicrm_mailing_event_queue` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_mailing_event_forward_event_queue_id` FOREIGN KEY (`event_queue_id`) REFERENCES `civicrm_mailing_event_queue` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing_event_forward`
--

LOCK TABLES `civicrm_mailing_event_forward` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing_event_forward` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_mailing_event_forward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing_event_opened`
--

DROP TABLE IF EXISTS `civicrm_mailing_event_opened`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing_event_opened` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_queue_id` int(10) unsigned NOT NULL COMMENT 'FK to EventQueue',
  `time_stamp` datetime NOT NULL COMMENT 'When this open event occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_opened_event_queue_id` (`event_queue_id`),
  CONSTRAINT `FK_civicrm_mailing_event_opened_event_queue_id` FOREIGN KEY (`event_queue_id`) REFERENCES `civicrm_mailing_event_queue` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing_event_opened`
--

LOCK TABLES `civicrm_mailing_event_opened` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing_event_opened` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_mailing_event_opened` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing_event_queue`
--

DROP TABLE IF EXISTS `civicrm_mailing_event_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing_event_queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `job_id` int(10) unsigned NOT NULL COMMENT 'FK to Job',
  `email_id` int(10) unsigned NOT NULL COMMENT 'FK to Email',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to Contact',
  `hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Security hash',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_queue_job_id` (`job_id`),
  KEY `FK_civicrm_mailing_event_queue_email_id` (`email_id`),
  KEY `FK_civicrm_mailing_event_queue_contact_id` (`contact_id`),
  CONSTRAINT `FK_civicrm_mailing_event_queue_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_mailing_event_queue_email_id` FOREIGN KEY (`email_id`) REFERENCES `civicrm_email` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_mailing_event_queue_job_id` FOREIGN KEY (`job_id`) REFERENCES `civicrm_mailing_job` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing_event_queue`
--

LOCK TABLES `civicrm_mailing_event_queue` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing_event_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_mailing_event_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing_event_reply`
--

DROP TABLE IF EXISTS `civicrm_mailing_event_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing_event_reply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_queue_id` int(10) unsigned NOT NULL COMMENT 'FK to EventQueue',
  `time_stamp` datetime NOT NULL COMMENT 'When this reply event occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_reply_event_queue_id` (`event_queue_id`),
  CONSTRAINT `FK_civicrm_mailing_event_reply_event_queue_id` FOREIGN KEY (`event_queue_id`) REFERENCES `civicrm_mailing_event_queue` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing_event_reply`
--

LOCK TABLES `civicrm_mailing_event_reply` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing_event_reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_mailing_event_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing_event_subscribe`
--

DROP TABLE IF EXISTS `civicrm_mailing_event_subscribe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing_event_subscribe` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(10) unsigned NOT NULL COMMENT 'FK to Group',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to Contact',
  `hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Security hash',
  `time_stamp` datetime NOT NULL COMMENT 'When this subscription event occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_subscribe_group_id` (`group_id`),
  KEY `FK_civicrm_mailing_event_subscribe_contact_id` (`contact_id`),
  CONSTRAINT `FK_civicrm_mailing_event_subscribe_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_mailing_event_subscribe_group_id` FOREIGN KEY (`group_id`) REFERENCES `civicrm_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing_event_subscribe`
--

LOCK TABLES `civicrm_mailing_event_subscribe` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing_event_subscribe` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_mailing_event_subscribe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing_event_trackable_url_open`
--

DROP TABLE IF EXISTS `civicrm_mailing_event_trackable_url_open`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing_event_trackable_url_open` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_queue_id` int(10) unsigned NOT NULL COMMENT 'FK to EventQueue',
  `trackable_url_id` int(10) unsigned NOT NULL COMMENT 'FK to TrackableURL',
  `time_stamp` datetime NOT NULL COMMENT 'When this trackable URL open occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_trackable_url_open_event_queue_id` (`event_queue_id`),
  KEY `FK_civicrm_mailing_event_trackable_url_open_trackable_url_id` (`trackable_url_id`),
  CONSTRAINT `FK_civicrm_mailing_event_trackable_url_open_event_queue_id` FOREIGN KEY (`event_queue_id`) REFERENCES `civicrm_mailing_event_queue` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_mailing_event_trackable_url_open_trackable_url_id` FOREIGN KEY (`trackable_url_id`) REFERENCES `civicrm_mailing_trackable_url` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing_event_trackable_url_open`
--

LOCK TABLES `civicrm_mailing_event_trackable_url_open` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing_event_trackable_url_open` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_mailing_event_trackable_url_open` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing_event_unsubscribe`
--

DROP TABLE IF EXISTS `civicrm_mailing_event_unsubscribe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing_event_unsubscribe` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_queue_id` int(10) unsigned NOT NULL COMMENT 'FK to EventQueue',
  `org_unsubscribe` tinyint(4) NOT NULL COMMENT 'Unsubscribe at org- or group-level',
  `time_stamp` datetime NOT NULL COMMENT 'When this delivery event occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_unsubscribe_event_queue_id` (`event_queue_id`),
  CONSTRAINT `FK_civicrm_mailing_event_unsubscribe_event_queue_id` FOREIGN KEY (`event_queue_id`) REFERENCES `civicrm_mailing_event_queue` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing_event_unsubscribe`
--

LOCK TABLES `civicrm_mailing_event_unsubscribe` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing_event_unsubscribe` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_mailing_event_unsubscribe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing_group`
--

DROP TABLE IF EXISTS `civicrm_mailing_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mailing_id` int(10) unsigned NOT NULL COMMENT 'The ID of a previous mailing to include/exclude recipients.',
  `group_type` enum('Include','Exclude','Base') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Are the members of the group included or excluded?.',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of table where item being referenced is stored.',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to the referenced item.',
  `search_id` int(11) DEFAULT NULL COMMENT 'The filtering search. custom search id or -1 for civicrm api search',
  `search_args` text COLLATE utf8_unicode_ci COMMENT 'The arguments to be sent to the search function',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_group_mailing_id` (`mailing_id`),
  CONSTRAINT `FK_civicrm_mailing_group_mailing_id` FOREIGN KEY (`mailing_id`) REFERENCES `civicrm_mailing` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing_group`
--

LOCK TABLES `civicrm_mailing_group` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_mailing_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing_job`
--

DROP TABLE IF EXISTS `civicrm_mailing_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing_job` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mailing_id` int(10) unsigned NOT NULL COMMENT 'The ID of the mailing this Job will send.',
  `scheduled_date` datetime DEFAULT NULL COMMENT 'date on which this job was scheduled.',
  `start_date` datetime DEFAULT NULL COMMENT 'date on which this job was started.',
  `end_date` datetime DEFAULT NULL COMMENT 'date on which this job ended.',
  `status` enum('Scheduled','Running','Complete','Paused','Canceled') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The state of this job',
  `is_test` tinyint(4) DEFAULT '0' COMMENT 'Is this job for a test mail?',
  `job_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `job_offset` int(20) DEFAULT '0',
  `job_limit` int(20) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_job_mailing_id` (`mailing_id`),
  KEY `FK_civicrm_mailing_job_parent_id` (`parent_id`),
  CONSTRAINT `FK_civicrm_mailing_job_mailing_id` FOREIGN KEY (`mailing_id`) REFERENCES `civicrm_mailing` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_mailing_job_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `civicrm_mailing_job` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing_job`
--

LOCK TABLES `civicrm_mailing_job` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_mailing_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing_spool`
--

DROP TABLE IF EXISTS `civicrm_mailing_spool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing_spool` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `job_id` int(10) unsigned NOT NULL COMMENT 'The ID of the Job .',
  `recipient_email` text COLLATE utf8_unicode_ci COMMENT 'The email of the receipients this mail is to be sent.',
  `headers` text COLLATE utf8_unicode_ci COMMENT 'The header information of this mailing .',
  `body` text COLLATE utf8_unicode_ci COMMENT 'The body of this mailing.',
  `added_at` datetime DEFAULT NULL COMMENT 'date on which this job was added.',
  `removed_at` datetime DEFAULT NULL COMMENT 'date on which this job was removed.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_spool_job_id` (`job_id`),
  CONSTRAINT `FK_civicrm_mailing_spool_job_id` FOREIGN KEY (`job_id`) REFERENCES `civicrm_mailing_job` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing_spool`
--

LOCK TABLES `civicrm_mailing_spool` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing_spool` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_mailing_spool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mailing_trackable_url`
--

DROP TABLE IF EXISTS `civicrm_mailing_trackable_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mailing_trackable_url` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The URL to be tracked.',
  `mailing_id` int(10) unsigned NOT NULL COMMENT 'FK to the mailing',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_trackable_url_mailing_id` (`mailing_id`),
  CONSTRAINT `FK_civicrm_mailing_trackable_url_mailing_id` FOREIGN KEY (`mailing_id`) REFERENCES `civicrm_mailing` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mailing_trackable_url`
--

LOCK TABLES `civicrm_mailing_trackable_url` WRITE;
/*!40000 ALTER TABLE `civicrm_mailing_trackable_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_mailing_trackable_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mapping`
--

DROP TABLE IF EXISTS `civicrm_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mapping` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Mapping ID',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name of Mapping',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Description of Mapping.',
  `mapping_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Mapping Type',
  PRIMARY KEY (`id`),
  KEY `UI_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mapping`
--

LOCK TABLES `civicrm_mapping` WRITE;
/*!40000 ALTER TABLE `civicrm_mapping` DISABLE KEYS */;
INSERT INTO `civicrm_mapping` VALUES (1,'Standard Export','Export includes standard contact fields.',7),(3,'Basic Export','Includes basic name, greeting, and address fields.',7),(4,'Email List Export','Includes name, greeting, and email fields for individuals and households.',7),(5,NULL,NULL,NULL);
/*!40000 ALTER TABLE `civicrm_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_mapping_field`
--

DROP TABLE IF EXISTS `civicrm_mapping_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_mapping_field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Mapping Field ID',
  `mapping_id` int(10) unsigned NOT NULL COMMENT 'Mapping to which this field belongs',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Mapping field key',
  `contact_type` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Contact Type in mapping',
  `column_number` int(10) unsigned NOT NULL COMMENT 'Column number for mapping set',
  `location_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Location type of this mapping, if required',
  `phone_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which type of phone does this number belongs.',
  `im_provider_id` int(10) unsigned DEFAULT NULL COMMENT 'Which type of IM Provider does this name belong.',
  `relationship_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Relationship type, if required',
  `relationship_direction` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `grouping` int(10) unsigned DEFAULT '1' COMMENT 'Used to group mapping_field records into related sets (e.g. for criteria sets in search builder mappings).',
  `operator` enum('=','!=','>','<','>=','<=','IN','NOT IN','LIKE','NOT LIKE','IS NULL','IS NOT NULL') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'SQL WHERE operator for search-builder mapping fields (search criteria).',
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'SQL WHERE value for search-builder mapping fields.',
  `website_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which type of website does this site belong',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mapping_field_mapping_id` (`mapping_id`),
  KEY `FK_civicrm_mapping_field_location_type_id` (`location_type_id`),
  KEY `FK_civicrm_mapping_field_relationship_type_id` (`relationship_type_id`),
  CONSTRAINT `FK_civicrm_mapping_field_location_type_id` FOREIGN KEY (`location_type_id`) REFERENCES `civicrm_location_type` (`id`),
  CONSTRAINT `FK_civicrm_mapping_field_mapping_id` FOREIGN KEY (`mapping_id`) REFERENCES `civicrm_mapping` (`id`),
  CONSTRAINT `FK_civicrm_mapping_field_relationship_type_id` FOREIGN KEY (`relationship_type_id`) REFERENCES `civicrm_relationship_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_mapping_field`
--

LOCK TABLES `civicrm_mapping_field` WRITE;
/*!40000 ALTER TABLE `civicrm_mapping_field` DISABLE KEYS */;
INSERT INTO `civicrm_mapping_field` VALUES (1,1,'id','Individual',0,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(2,1,'id','Household',1,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(3,1,'id','Organization',2,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(4,1,'contact_type','Individual',3,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(5,1,'contact_type','Household',4,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(6,1,'contact_type','Organization',5,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(7,1,'display_name','Individual',6,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(8,1,'display_name','Household',7,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(9,1,'display_name','Organization',8,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(10,1,'individual_prefix','Individual',9,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(11,1,'first_name','Individual',10,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(12,1,'middle_name','Individual',11,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(13,1,'last_name','Individual',12,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(14,1,'individual_suffix','Individual',13,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(15,1,'job_title','Individual',14,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(16,1,'current_employer','Individual',15,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(17,1,'birth_date','Individual',16,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(18,1,'street_address','Individual',17,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(19,1,'street_address','Household',18,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(20,1,'street_address','Organization',19,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(21,1,'supplemental_address_1','Individual',20,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(22,1,'supplemental_address_1','Household',21,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(23,1,'supplemental_address_1','Organization',22,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(24,1,'city','Individual',23,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(25,1,'city','Household',24,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(26,1,'city','Organization',25,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(27,1,'state_province','Individual',26,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(28,1,'state_province','Household',27,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(29,1,'state_province','Organization',28,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(30,1,'postal_code','Individual',29,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(31,1,'postal_code','Household',30,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(32,1,'postal_code','Organization',31,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(33,1,'postal_code_suffix','Individual',32,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(34,1,'postal_code_suffix','Household',33,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(35,1,'postal_code_suffix','Organization',34,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(36,1,'addressee','Individual',35,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(37,1,'addressee','Household',36,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(38,1,'addressee','Organization',37,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(39,1,'postal_greeting','Individual',38,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(40,1,'postal_greeting','Household',39,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(41,1,'custom_47','Individual',40,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(42,1,'custom_47','Household',41,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(43,1,'custom_47','Organization',42,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(44,1,'custom_48','Individual',43,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(45,1,'custom_48','Household',44,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(46,1,'custom_48','Organization',45,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(47,1,'custom_49','Individual',46,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(48,1,'custom_49','Household',47,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(49,1,'custom_49','Organization',48,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(50,1,'custom_46','Individual',49,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(51,1,'custom_46','Household',50,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(52,1,'custom_46','Organization',51,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(53,1,'url','Individual',52,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(54,1,'url','Household',53,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(55,1,'url','Organization',54,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(56,1,'phone','Individual',55,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(57,1,'phone','Household',56,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(58,1,'phone','Organization',57,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(59,1,'email','Individual',58,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(60,1,'email','Household',59,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(61,1,'email','Organization',60,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(104,3,'id','Individual',0,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(105,3,'id','Household',1,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(106,3,'id','Organization',2,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(107,3,'contact_type','Individual',3,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(108,3,'contact_type','Household',4,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(109,3,'contact_type','Organization',5,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(110,3,'display_name','Individual',6,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(111,3,'display_name','Household',7,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(112,3,'display_name','Organization',8,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(113,3,'individual_prefix','Individual',9,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(114,3,'first_name','Individual',10,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(115,3,'middle_name','Individual',11,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(116,3,'last_name','Individual',12,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(117,3,'individual_suffix','Individual',13,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(118,3,'job_title','Individual',14,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(119,3,'current_employer','Individual',15,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(120,3,'supplemental_address_2','Individual',16,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(121,3,'supplemental_address_2','Household',17,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(122,3,'supplemental_address_2','Organization',18,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(123,3,'street_address','Organization',19,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(124,3,'street_address','Individual',20,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(125,3,'street_address','Household',21,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(126,3,'supplemental_address_1','Organization',22,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(127,3,'supplemental_address_1','Individual',23,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(128,3,'supplemental_address_1','Household',24,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(129,3,'city','Organization',25,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(130,3,'city','Individual',26,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(131,3,'city','Household',27,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(132,3,'state_province','Organization',28,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(133,3,'state_province','Individual',29,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(134,3,'state_province','Household',30,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(135,3,'postal_code','Organization',31,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(136,3,'postal_code','Individual',32,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(137,3,'postal_code','Household',33,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(138,3,'postal_code_suffix','Organization',34,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(139,3,'postal_code_suffix','Individual',35,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(140,3,'postal_code_suffix','Household',36,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(141,3,'addressee','Organization',37,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(142,3,'addressee','Individual',38,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(143,3,'addressee','Household',39,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(144,3,'postal_greeting','Individual',40,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(145,3,'postal_greeting','Household',41,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(146,4,'id','Individual',0,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(147,4,'id','Household',1,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(148,4,'first_name','Individual',2,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(149,4,'last_name','Individual',3,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(150,4,'display_name','Individual',4,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(151,4,'display_name','Household',5,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(152,4,'email_greeting','Individual',6,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(153,4,'email_greeting','Household',7,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(154,4,'email','Individual',8,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(155,4,'email','Household',9,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(156,5,'is_deceased','Individual',0,NULL,NULL,NULL,NULL,NULL,1,'=','1',NULL),(157,5,'do_not_mail','Individual',0,NULL,NULL,NULL,NULL,NULL,2,'=','1',NULL),(158,5,'do_not_mail','Household',0,NULL,NULL,NULL,NULL,NULL,3,'=','1',NULL),(159,5,'do_not_mail','Organization',0,NULL,NULL,NULL,NULL,NULL,4,'=','1',NULL);
/*!40000 ALTER TABLE `civicrm_mapping_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_membership`
--

DROP TABLE IF EXISTS `civicrm_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_membership` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Membership Id',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to Contact ID',
  `membership_type_id` int(10) unsigned NOT NULL COMMENT 'FK to Membership Type',
  `join_date` date DEFAULT NULL COMMENT 'Beginning of initial membership period (member since...).',
  `start_date` date DEFAULT NULL COMMENT 'Beginning of current uninterrupted membership period.',
  `end_date` date DEFAULT NULL COMMENT 'Current membership period expire date.',
  `source` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_id` int(10) unsigned NOT NULL COMMENT 'FK to Membership Status',
  `is_override` tinyint(4) DEFAULT NULL COMMENT 'Admin users may set a manual status which overrides the calculated status. When this flag is true, automated status update scripts should NOT modify status for the record.',
  `reminder_date` date DEFAULT NULL COMMENT 'When should a reminder be sent.',
  `owner_membership_id` int(10) unsigned DEFAULT NULL COMMENT 'Optional FK to Parent Membership.',
  `is_test` tinyint(4) DEFAULT '0',
  `is_pay_later` tinyint(4) DEFAULT '0',
  `contribution_recur_id` int(10) unsigned DEFAULT NULL COMMENT 'Conditional foreign key to civicrm_contribution_recur.id.',
  PRIMARY KEY (`id`),
  KEY `index_owner_membership_id` (`owner_membership_id`),
  KEY `FK_civicrm_membership_contact_id` (`contact_id`),
  KEY `FK_civicrm_membership_membership_type_id` (`membership_type_id`),
  KEY `FK_civicrm_membership_status_id` (`status_id`),
  KEY `FK_civicrm_membership_contribution_recur_id` (`contribution_recur_id`),
  CONSTRAINT `FK_civicrm_membership_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_membership_contribution_recur_id` FOREIGN KEY (`contribution_recur_id`) REFERENCES `civicrm_contribution_recur` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_membership_membership_type_id` FOREIGN KEY (`membership_type_id`) REFERENCES `civicrm_membership_type` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_membership_owner_membership_id` FOREIGN KEY (`owner_membership_id`) REFERENCES `civicrm_membership` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_membership_status_id` FOREIGN KEY (`status_id`) REFERENCES `civicrm_membership_status` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_membership`
--

LOCK TABLES `civicrm_membership` WRITE;
/*!40000 ALTER TABLE `civicrm_membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_membership_block`
--

DROP TABLE IF EXISTS `civicrm_membership_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_membership_block` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Membership Id',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name for Membership Status',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_contribution_page.id',
  `membership_types` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Membership types to be exposed by this block',
  `membership_type_default` int(10) unsigned DEFAULT NULL COMMENT 'Optional foreign key to membership_type',
  `display_min_fee` tinyint(4) DEFAULT '1' COMMENT 'Display minimum membership fee',
  `is_separate_payment` tinyint(4) DEFAULT '1' COMMENT 'Should membership transactions be processed separately',
  `new_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Title to display at top of block',
  `new_text` text COLLATE utf8_unicode_ci COMMENT 'Text to display below title',
  `renewal_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Title for renewal',
  `renewal_text` text COLLATE utf8_unicode_ci COMMENT 'Text to display for member renewal',
  `is_required` tinyint(4) DEFAULT '0' COMMENT 'Is membership sign up optional',
  `is_active` tinyint(4) DEFAULT '1' COMMENT 'Is this membership_block enabled',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_membership_block_entity_id` (`entity_id`),
  KEY `FK_civicrm_membership_block_membership_type_default` (`membership_type_default`),
  CONSTRAINT `FK_civicrm_membership_block_entity_id` FOREIGN KEY (`entity_id`) REFERENCES `civicrm_contribution_page` (`id`),
  CONSTRAINT `FK_civicrm_membership_block_membership_type_default` FOREIGN KEY (`membership_type_default`) REFERENCES `civicrm_membership_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_membership_block`
--

LOCK TABLES `civicrm_membership_block` WRITE;
/*!40000 ALTER TABLE `civicrm_membership_block` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_membership_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_membership_log`
--

DROP TABLE IF EXISTS `civicrm_membership_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_membership_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `membership_id` int(10) unsigned NOT NULL COMMENT 'FK to Membership table',
  `status_id` int(10) unsigned NOT NULL COMMENT 'New status assigned to membership by this action. FK to Membership Status',
  `start_date` date DEFAULT NULL COMMENT 'New membership period start date',
  `end_date` date DEFAULT NULL COMMENT 'New membership period expiration date.',
  `modified_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID of person under whose credentials this data modification was made.',
  `modified_date` date DEFAULT NULL COMMENT 'Date this membership modification action was logged.',
  `renewal_reminder_date` date DEFAULT NULL COMMENT 'The day we sent a renewal reminder',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_membership_log_membership_id` (`membership_id`),
  KEY `FK_civicrm_membership_log_status_id` (`status_id`),
  KEY `FK_civicrm_membership_log_modified_id` (`modified_id`),
  CONSTRAINT `FK_civicrm_membership_log_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `civicrm_membership` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_membership_log_modified_id` FOREIGN KEY (`modified_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_membership_log_status_id` FOREIGN KEY (`status_id`) REFERENCES `civicrm_membership_status` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_membership_log`
--

LOCK TABLES `civicrm_membership_log` WRITE;
/*!40000 ALTER TABLE `civicrm_membership_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_membership_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_membership_payment`
--

DROP TABLE IF EXISTS `civicrm_membership_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_membership_payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `membership_id` int(10) unsigned NOT NULL COMMENT 'FK to Membership table',
  `contribution_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to contribution table.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_contribution_membership` (`contribution_id`,`membership_id`),
  KEY `FK_civicrm_membership_payment_membership_id` (`membership_id`),
  CONSTRAINT `FK_civicrm_membership_payment_contribution_id` FOREIGN KEY (`contribution_id`) REFERENCES `civicrm_contribution` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_membership_payment_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `civicrm_membership` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_membership_payment`
--

LOCK TABLES `civicrm_membership_payment` WRITE;
/*!40000 ALTER TABLE `civicrm_membership_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_membership_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_membership_status`
--

DROP TABLE IF EXISTS `civicrm_membership_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_membership_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Membership Id',
  `name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name for Membership Status',
  `start_event` enum('start_date','end_date','join_date') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Event when this status starts.',
  `start_event_adjust_unit` enum('day','month','year') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Unit used for adjusting from start_event.',
  `start_event_adjust_interval` int(11) DEFAULT NULL COMMENT 'Status range begins this many units from start_event.',
  `end_event` enum('start_date','end_date','join_date') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Event after which this status ends.',
  `end_event_adjust_unit` enum('day','month','year') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Unit used for adjusting from the ending event.',
  `end_event_adjust_interval` int(11) DEFAULT NULL COMMENT 'Status range ends this many units from end_event.',
  `is_current_member` tinyint(4) DEFAULT NULL COMMENT 'Does this status aggregate to current members (e.g. New, Renewed, Grace might all be TRUE... while Unrenewed, Lapsed, Inactive would be FALSE).',
  `is_admin` tinyint(4) DEFAULT NULL COMMENT 'Is this status for admin/manual assignment only.',
  `weight` int(11) DEFAULT NULL,
  `is_default` tinyint(4) DEFAULT NULL COMMENT 'Assign this status to a membership record if no other status match is found.',
  `is_active` tinyint(4) DEFAULT '1' COMMENT 'Is this membership_status enabled.',
  `is_reserved` tinyint(4) DEFAULT '0' COMMENT 'Is this membership_status reserved.',
  `label` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Label for Membership Status',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_membership_status`
--

LOCK TABLES `civicrm_membership_status` WRITE;
/*!40000 ALTER TABLE `civicrm_membership_status` DISABLE KEYS */;
INSERT INTO `civicrm_membership_status` VALUES (1,'New','join_date',NULL,NULL,'join_date','month',3,1,0,1,0,1,0,'New'),(2,'Current','start_date',NULL,NULL,'end_date',NULL,NULL,1,0,2,1,1,0,'Current'),(3,'Grace','end_date',NULL,NULL,'end_date','month',1,1,0,3,0,1,0,'Grace'),(4,'Expired','end_date','month',1,NULL,NULL,NULL,0,0,4,0,1,0,'Expired'),(5,'Pending','join_date',NULL,NULL,'join_date',NULL,NULL,0,0,5,0,1,1,'Pending'),(6,'Cancelled','join_date',NULL,NULL,'join_date',NULL,NULL,0,0,6,0,1,0,'Cancelled'),(7,'Deceased',NULL,NULL,NULL,NULL,NULL,NULL,0,1,7,0,1,1,'Deceased');
/*!40000 ALTER TABLE `civicrm_membership_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_membership_type`
--

DROP TABLE IF EXISTS `civicrm_membership_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_membership_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Membership Id',
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this match entry for',
  `name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name of Membership Type',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Description of Membership Type',
  `member_of_contact_id` int(10) unsigned NOT NULL COMMENT 'Owner organization for this membership type. FK to Contact ID',
  `contribution_type_id` int(10) unsigned NOT NULL COMMENT 'If membership is paid by a contribution - what contribution type should be used. FK to Contribution Type ID',
  `minimum_fee` decimal(20,2) DEFAULT '0.00' COMMENT 'Minimum fee for this membership (0 for free/complimentary memberships).',
  `duration_unit` enum('day','month','year','lifetime') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Unit in which membership period is expressed.',
  `duration_interval` int(11) DEFAULT NULL COMMENT 'Number of duration units in membership period (e.g. 1 year, 12 months).',
  `period_type` enum('rolling','fixed') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Rolling membership period starts on signup date. Fixed membership periods start on fixed_period_start_day.',
  `fixed_period_start_day` int(11) DEFAULT NULL COMMENT 'For fixed period memberships, month and day (mmdd) on which subscription/membership will start. Period start is back-dated unless after rollover day.',
  `fixed_period_rollover_day` int(11) DEFAULT NULL COMMENT 'For fixed period memberships, signups after this day (mmdd) rollover to next period.',
  `relationship_type_id` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `relationship_direction` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `visibility` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `renewal_msg_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_msg_template.id',
  `renewal_reminder_day` int(11) DEFAULT NULL COMMENT 'Number of days prior to expiration to send renewal reminder',
  `receipt_text_signup` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Receipt Text for membership signup',
  `receipt_text_renewal` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Receipt Text for membership renewal',
  `is_active` tinyint(4) DEFAULT '1' COMMENT 'Is this membership_type enabled',
  `auto_renew` tinyint(4) DEFAULT '0',
  `autorenewal_msg_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_msg_template.id',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_membership_type_domain_id` (`domain_id`),
  KEY `FK_civicrm_membership_type_member_of_contact_id` (`member_of_contact_id`),
  KEY `FK_civicrm_membership_type_contribution_type_id` (`contribution_type_id`),
  KEY `FK_civicrm_membership_type_renewal_msg_id` (`renewal_msg_id`),
  KEY `index_relationship_type_id` (`relationship_type_id`),
  KEY `FK_civicrm_membership_autorenewal_msg_id` (`autorenewal_msg_id`),
  CONSTRAINT `FK_civicrm_membership_autorenewal_msg_id` FOREIGN KEY (`autorenewal_msg_id`) REFERENCES `civicrm_msg_template` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_membership_type_contribution_type_id` FOREIGN KEY (`contribution_type_id`) REFERENCES `civicrm_contribution_type` (`id`),
  CONSTRAINT `FK_civicrm_membership_type_domain_id` FOREIGN KEY (`domain_id`) REFERENCES `civicrm_domain` (`id`),
  CONSTRAINT `FK_civicrm_membership_type_member_of_contact_id` FOREIGN KEY (`member_of_contact_id`) REFERENCES `civicrm_contact` (`id`),
  CONSTRAINT `FK_civicrm_membership_type_renewal_msg_id` FOREIGN KEY (`renewal_msg_id`) REFERENCES `civicrm_msg_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_membership_type`
--

LOCK TABLES `civicrm_membership_type` WRITE;
/*!40000 ALTER TABLE `civicrm_membership_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_membership_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_menu`
--

DROP TABLE IF EXISTS `civicrm_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this menu item for',
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Path Name',
  `path_arguments` text COLLATE utf8_unicode_ci COMMENT 'Arguments to pass to the url',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Menu Title',
  `access_callback` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Function to call to check access permissions',
  `access_arguments` text COLLATE utf8_unicode_ci COMMENT 'Arguments to pass to access callback',
  `page_callback` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'function to call for this url',
  `page_arguments` text COLLATE utf8_unicode_ci COMMENT 'Arguments to pass to page callback',
  `breadcrumb` text COLLATE utf8_unicode_ci COMMENT 'Breadcrumb for the path.',
  `return_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Url where a page should redirected to, if next url not known.',
  `return_url_args` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Arguments to pass to return_url',
  `component_id` int(10) unsigned DEFAULT NULL COMMENT 'Component that this menu item belongs to',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this menu item active?',
  `is_public` tinyint(4) DEFAULT NULL COMMENT 'Is this menu accessible to the public?',
  `is_exposed` tinyint(4) DEFAULT NULL COMMENT 'Is this menu exposed to the navigation system?',
  `is_ssl` tinyint(4) DEFAULT NULL COMMENT 'Should this menu be exposed via SSL if enabled?',
  `weight` int(11) NOT NULL DEFAULT '1' COMMENT 'Ordering of the menu items in various blocks.',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT 'Drupal menu type.',
  `page_type` int(11) NOT NULL DEFAULT '1' COMMENT 'CiviCRM menu type.',
  `skipBreadcrumb` tinyint(4) DEFAULT NULL COMMENT 'skip this url being exposed to breadcrumb',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_path_domain_id` (`path`,`domain_id`),
  KEY `FK_civicrm_menu_domain_id` (`domain_id`),
  KEY `FK_civicrm_menu_component_id` (`component_id`),
  CONSTRAINT `FK_civicrm_menu_component_id` FOREIGN KEY (`component_id`) REFERENCES `civicrm_component` (`id`),
  CONSTRAINT `FK_civicrm_menu_domain_id` FOREIGN KEY (`domain_id`) REFERENCES `civicrm_domain` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_menu`
--

LOCK TABLES `civicrm_menu` WRITE;
/*!40000 ALTER TABLE `civicrm_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_msg_template`
--

DROP TABLE IF EXISTS `civicrm_msg_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_msg_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Message Template ID',
  `msg_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Descriptive title of message',
  `msg_subject` text COLLATE utf8_unicode_ci COMMENT 'Subject for email message.',
  `msg_text` text COLLATE utf8_unicode_ci COMMENT 'Text formatted message',
  `msg_html` text COLLATE utf8_unicode_ci COMMENT 'HTML formatted message',
  `is_active` tinyint(4) DEFAULT '1',
  `workflow_id` int(10) unsigned DEFAULT NULL COMMENT 'a pseudo-FK to civicrm_option_value',
  `is_default` tinyint(4) DEFAULT '1' COMMENT 'is this the default message template for the workflow referenced by workflow_id?',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'is this the reserved message template which we ship for the workflow referenced by workflow_id?',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_msg_template`
--

LOCK TABLES `civicrm_msg_template` WRITE;
/*!40000 ALTER TABLE `civicrm_msg_template` DISABLE KEYS */;
INSERT INTO `civicrm_msg_template` VALUES (1,'Cases - Send Copy of an Activity','[Bluebird] ','===========================================================\n{ts}Activity Summary{/ts} - {$activityTypeName}\n===========================================================\n{if $isCaseActivity}\n{ts}Your Case Role(s){/ts} : {$contact.role}\n{/if}\n\n{foreach from=$activity.fields item=field}\n{if $field.type eq \'Date\'}\n{$field.label}{if $field.category}({$field.category}){/if} : {$field.value|crmDate:$config->dateformatDatetime}\n{else}\n{$field.label}{if $field.category}({$field.category}){/if} : {$field.value}\n{/if}\n{/foreach}\n\n{foreach from=$activity.customGroups key=customGroupName item=customGroup}\n==========================================================\n{$customGroupName}\n==========================================================\n{foreach from=$customGroup item=field}\n{if $field.type eq \'Date\'}\n{$field.label} : {$field.value|crmDate:$config->dateformatDatetime}\n{else}\n{$field.label} : {$field.value}\n{/if}\n{/foreach}\n\n{/foreach}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Activity Summary{/ts} - {$activityTypeName}\n      </th>\n     </tr>\n     {if $isCaseActivity}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Your Case Role(s){/ts}\n       </td>\n       <td {$valueStyle}>\n        {$contact.role}\n       </td>\n      </tr>\n     {/if}\n     {foreach from=$activity.fields item=field}\n      <tr>\n       <td {$labelStyle}>\n        {$field.label}{if $field.category}({$field.category}){/if}\n       </td>\n       <td {$valueStyle}>\n        {if $field.type eq \'Date\'}\n         {$field.value|crmDate:$config->dateformatDatetime}\n        {else}\n         {$field.value}\n        {/if}\n       </td>\n      </tr>\n     {/foreach}\n\n     {foreach from=$activity.customGroups key=customGroupName item=customGroup}\n      <tr>\n       <th {$headerStyle}>\n        {$customGroupName}\n       </th>\n      </tr>\n      {foreach from=$customGroup item=field}\n       <tr>\n        <td {$labelStyle}>\n         {$field.label}\n        </td>\n        <td {$valueStyle}>\n         {if $field.type eq \'Date\'}\n          {$field.value|crmDate:$config->dateformatDatetime}\n         {else}\n          {$field.value}\n         {/if}\n        </td>\n       </tr>\n      {/foreach}\n     {/foreach}\n    </table>\n   </td>\n  </tr>\n </table>\n</center>\n\n</body>\n</html>\n',1,486,1,0),(2,'Cases - Send Copy of an Activity','{if $idHash}[case #{$idHash}]{/if} {$activitySubject}\n','===========================================================\n{ts}Activity Summary{/ts} - {$activityTypeName}\n===========================================================\n{if $isCaseActivity}\n{ts}Your Case Role(s){/ts} : {$contact.role}\n{/if}\n\n{foreach from=$activity.fields item=field}\n{if $field.type eq \'Date\'}\n{$field.label}{if $field.category}({$field.category}){/if} : {$field.value|crmDate:$config->dateformatDatetime}\n{else}\n{$field.label}{if $field.category}({$field.category}){/if} : {$field.value}\n{/if}\n{/foreach}\n\n{foreach from=$activity.customGroups key=customGroupName item=customGroup}\n==========================================================\n{$customGroupName}\n==========================================================\n{foreach from=$customGroup item=field}\n{if $field.type eq \'Date\'}\n{$field.label} : {$field.value|crmDate:$config->dateformatDatetime}\n{else}\n{$field.label} : {$field.value}\n{/if}\n{/foreach}\n\n{/foreach}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Activity Summary{/ts} - {$activityTypeName}\n      </th>\n     </tr>\n     {if $isCaseActivity}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Your Case Role(s){/ts}\n       </td>\n       <td {$valueStyle}>\n        {$contact.role}\n       </td>\n      </tr>\n     {/if}\n     {foreach from=$activity.fields item=field}\n      <tr>\n       <td {$labelStyle}>\n        {$field.label}{if $field.category}({$field.category}){/if}\n       </td>\n       <td {$valueStyle}>\n        {if $field.type eq \'Date\'}\n         {$field.value|crmDate:$config->dateformatDatetime}\n        {else}\n         {$field.value}\n        {/if}\n       </td>\n      </tr>\n     {/foreach}\n\n     {foreach from=$activity.customGroups key=customGroupName item=customGroup}\n      <tr>\n       <th {$headerStyle}>\n        {$customGroupName}\n       </th>\n      </tr>\n      {foreach from=$customGroup item=field}\n       <tr>\n        <td {$labelStyle}>\n         {$field.label}\n        </td>\n        <td {$valueStyle}>\n         {if $field.type eq \'Date\'}\n          {$field.value|crmDate:$config->dateformatDatetime}\n         {else}\n          {$field.value}\n         {/if}\n        </td>\n       </tr>\n      {/foreach}\n     {/foreach}\n    </table>\n   </td>\n  </tr>\n </table>\n</center>\n\n</body>\n</html>\n',1,486,0,1),(3,'Contributions - Duplicate Organization Alert','{ts}CiviContribute Alert: Possible Duplicate Contact Record{/ts}\n','{ts}A contribution / membership signup was made on behalf of the organization listed below.{/ts}\n{ts}The information provided matched multiple existing database records based on the configured\nDuplicate Matching Rules for your site.{/ts}\n\n{ts}Organization Name{/ts}: {$onBehalfName}\n{ts}Organization Email{/ts}: {$onBehalfEmail}\n{ts}Organization Contact Id{/ts}: {$onBehalfID}\n\n{ts}If you think this may be a duplicate contact which should be merged with an existing record -\nGo to \"CiviCRM >> Administer CiviCRM >> Find and Merge Duplicate Contacts\". Use the strict\nrule for Organizations to find the potential duplicates and merge them if appropriate.{/ts}\n\n{if $receiptMessage}\n###########################################################\n{ts}Copy of Contribution Receipt{/ts}\n\n###########################################################\n{$receiptMessage}\n\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <p>{ts}A contribution / membership signup was made on behalf of the organization listed below.{/ts}</p>\n    <p>{ts}The information provided matched multiple existing database records based on the configured\nDuplicate Matching Rules for your site.{/ts}</p>\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <td {$labelStyle}>\n       {ts}Organization Name{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$onBehalfName}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Organization Email{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$onBehalfEmail}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Organization Contact Id{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$onBehalfID}\n      </td>\n     </tr>\n    </table>\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <p>{ts}If you think this may be a duplicate contact which should be merged with an existing record -\nGo to \"CiviCRM >> Administer CiviCRM >> Find and Merge Duplicate Contacts\". Use the strict\nrule for Organizations to find the potential duplicates and merge them if appropriate.{/ts}</p>\n   </td>\n  </tr>\n  {if $receiptMessage}\n   <tr>\n    <td>\n     <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n      <tr>\n       <th {$headerStyle}>\n        {ts}Copy of Contribution Receipt{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {* FIXME: the below is most probably not HTML-ised *}\n        {$receiptMessage}\n       </td>\n      </tr>\n     </table>\n    </td>\n   </tr>\n  {/if}\n </table>\n</center>\n\n</body>\n</html>\n',1,487,1,0),(4,'Contributions - Duplicate Organization Alert','{ts}CiviContribute Alert: Possible Duplicate Contact Record{/ts}\n','{ts}A contribution / membership signup was made on behalf of the organization listed below.{/ts}\n{ts}The information provided matched multiple existing database records based on the configured\nDuplicate Matching Rules for your site.{/ts}\n\n{ts}Organization Name{/ts}: {$onBehalfName}\n{ts}Organization Email{/ts}: {$onBehalfEmail}\n{ts}Organization Contact Id{/ts}: {$onBehalfID}\n\n{ts}If you think this may be a duplicate contact which should be merged with an existing record -\nGo to \"CiviCRM >> Administer CiviCRM >> Find and Merge Duplicate Contacts\". Use the strict\nrule for Organizations to find the potential duplicates and merge them if appropriate.{/ts}\n\n{if $receiptMessage}\n###########################################################\n{ts}Copy of Contribution Receipt{/ts}\n\n###########################################################\n{$receiptMessage}\n\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <p>{ts}A contribution / membership signup was made on behalf of the organization listed below.{/ts}</p>\n    <p>{ts}The information provided matched multiple existing database records based on the configured\nDuplicate Matching Rules for your site.{/ts}</p>\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <td {$labelStyle}>\n       {ts}Organization Name{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$onBehalfName}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Organization Email{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$onBehalfEmail}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Organization Contact Id{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$onBehalfID}\n      </td>\n     </tr>\n    </table>\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <p>{ts}If you think this may be a duplicate contact which should be merged with an existing record -\nGo to \"CiviCRM >> Administer CiviCRM >> Find and Merge Duplicate Contacts\". Use the strict\nrule for Organizations to find the potential duplicates and merge them if appropriate.{/ts}</p>\n   </td>\n  </tr>\n  {if $receiptMessage}\n   <tr>\n    <td>\n     <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n      <tr>\n       <th {$headerStyle}>\n        {ts}Copy of Contribution Receipt{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {* FIXME: the below is most probably not HTML-ised *}\n        {$receiptMessage}\n       </td>\n      </tr>\n     </table>\n    </td>\n   </tr>\n  {/if}\n </table>\n</center>\n\n</body>\n</html>\n',1,487,0,1),(5,'Contributions - Receipt (off-line)','{ts}Contribution Receipt{/ts}\n','{if $formValues.receipt_text}\n{$formValues.receipt_text}\n{else}{ts}Thanks for your support.{/ts}{/if}\n\n{ts}Please print this receipt for your records.{/ts}\n\n\n===========================================================\n{ts}Contribution Information{/ts}\n\n===========================================================\n{ts}Contribution Type{/ts}: {$formValues.contributionType_name}\n{if $lineItem}\n{foreach from=$lineItem item=value key=priceset}\n---------------------------------------------------------\n{capture assign=ts_item}{ts}Item{/ts}{/capture}\n{capture assign=ts_qty}{ts}Qty{/ts}{/capture}\n{capture assign=ts_each}{ts}Each{/ts}{/capture}\n{capture assign=ts_total}{ts}Total{/ts}{/capture}\n{$ts_item|string_format:\"%-30s\"} {$ts_qty|string_format:\"%5s\"} {$ts_each|string_format:\"%10s\"} {$ts_total|string_format:\"%10s\"}\n----------------------------------------------------------\n{foreach from=$value item=line}\n{$line.description|truncate:30:\"...\"|string_format:\"%-30s\"} {$line.qty|string_format:\"%5s\"} {$line.unit_price|crmMoney|string_format:\"%10s\"} {$line.line_total|crmMoney|string_format:\"%10s\"}\n{/foreach}\n{/foreach}\n{/if}\n\n{ts}Total Amount{/ts}: {$formValues.total_amount|crmMoney}\n{if $receive_date}\n{ts}Received Date{/ts}: {$receive_date|truncate:10:\'\'|crmDate}\n{/if}\n{if $receipt_date}\n{ts}Receipt Date{/ts}: {$receipt_date|truncate:10:\'\'|crmDate}\n{/if}\n{if $formValues.paidBy and !$formValues.hidden_CreditCard}\n{ts}Paid By{/ts}: {$formValues.paidBy}\n{if $formValues.check_number}\n{ts}Check Number{/ts}: {$formValues.check_number}\n{/if}\n{/if}\n{if $formValues.trxn_id}\n{ts}Transaction ID{/ts}: {$formValues.trxn_id}\n{/if}\n\n{if $ccContribution}\n===========================================================\n{ts}Billing Name and Address{/ts}\n\n===========================================================\n{$billingName}\n{$address}\n\n===========================================================\n{ts}Credit Card Information{/ts}\n\n===========================================================\n{$credit_card_type}\n{$credit_card_number}\n{ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n{/if}\n{if $customGroup}\n{foreach from=$customGroup item=value key=customName}\n===========================================================\n{$customName}\n===========================================================\n{foreach from=$value item=v key=n}\n{$n}: {$v}\n{/foreach}\n{/foreach}\n{/if}\n{if $formValues.honor_first_name}\n\n===========================================================\n{$formValues.honor_type}\n===========================================================\n{$formValues.honor_prefix} {$formValues.honor_first_name} {$formValues.honor_last_name}\n{if $formValues.honor_email}\n{ts}Honoree Email{/ts}: {$formValues.honor_email}\n{/if}\n{/if}\n\n{if $formValues.product_name}\n===========================================================\n{ts}Premium Information{/ts}\n\n===========================================================\n{$formValues.product_name}\n{if $formValues.product_option}\n{ts}Option{/ts}: {$formValues.product_option}\n{/if}\n{if $formValues.product_sku}\n{ts}SKU{/ts}: {$formValues.product_sku}\n{/if}\n{if $fulfilled_date}\n{ts}Sent{/ts}: {$fulfilled_date|crmDate}\n{/if}\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n\n    {if $formValues.receipt_text}\n     <p>{$formValues.receipt_text|htmlize}</p>\n    {else}\n     <p>{ts}Thanks for your support.{/ts}</p>\n    {/if}\n\n    <p>{ts}Please print this receipt for your records.{/ts}</p>\n\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Contribution Information{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Contribution Type{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$formValues.contributionType_name}\n      </td>\n     </tr>\n\n     {if $lineItem}\n      {foreach from=$lineItem item=value key=priceset}\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         <table> {* FIXME: style this table so that it looks like the text version (justification, etc.) *}\n          <tr>\n           <th>{ts}Item{/ts}</th>\n           <th>{ts}Qty{/ts}</th>\n           <th>{ts}Each{/ts}</th>\n           <th>{ts}Total{/ts}</th>\n          </tr>\n          {foreach from=$value item=line}\n           <tr>\n            <td>\n             {$line.description|truncate:30:\"...\"}\n            </td>\n            <td>\n             {$line.qty}\n            </td>\n            <td>\n             {$line.unit_price|crmMoney}\n            </td>\n            <td>\n             {$line.line_total|crmMoney}\n            </td>\n           </tr>\n          {/foreach}\n         </table>\n        </td>\n       </tr>\n      {/foreach}\n     {/if}\n\n     <tr>\n      <td {$labelStyle}>\n       {ts}Total Amount{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$formValues.total_amount|crmMoney}\n      </td>\n     </tr>\n\n     {if $receive_date}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Received Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$receive_date|truncate:10:\'\'|crmDate}\n       </td>\n      </tr>\n     {/if}\n\n      {if $receipt_date}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Receipt Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$receipt_date|truncate:10:\'\'|crmDate}\n       </td>\n      </tr>\n     {/if}\n\n     {if $formValues.paidBy and !$formValues.hidden_CreditCard}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Paid By{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$formValues.paidBy}\n       </td>\n      </tr>\n      {if $formValues.check_number}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Check Number{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$formValues.check_number}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $formValues.trxn_id}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Transaction ID{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$formValues.trxn_id}\n       </td>\n      </tr>\n     {/if}\n\n     {if $ccContribution}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Billing Name and Address{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$billingName}<br />\n        {$address|nl2br}\n       </td>\n      </tr>\n      <tr>\n       <th {$headerStyle}>\n        {ts}Credit Card Information{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$credit_card_type}<br />\n        {$credit_card_number}<br />\n        {ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n       </td>\n      </tr>\n     {/if}\n\n     {if $customGroup}\n      {foreach from=$customGroup item=value key=customName}\n       <tr>\n        <th {$headerStyle}>\n         {$customName}\n        </th>\n       </tr>\n       {foreach from=$value item=v key=n}\n        <tr>\n         <td {$labelStyle}>\n          {$n}\n         </td>\n         <td {$valueStyle}>\n          {$v}\n         </td>\n        </tr>\n       {/foreach}\n      {/foreach}\n     {/if}\n\n     {if $formValues.honor_first_name}\n      <tr>\n       <th {$headerStyle}>\n        {$formValues.honor_type}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$formValues.honor_prefix} {$formValues.honor_first_name} {$formValues.honor_last_name}<br />\n        {if $formValues.honor_email}\n         {ts}Honoree Email{/ts}: {$formValues.honor_email}\n        {/if}\n       </td>\n      </tr>\n     {/if}\n\n     {if $formValues.product_name}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Premium Information{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {$formValues.product_name}\n       </td>\n      </tr>\n      {if $formValues.product_option}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Option{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$formValues.product_option}\n        </td>\n       </tr>\n      {/if}\n      {if $formValues.product_sku}\n       <tr>\n        <td {$labelStyle}>\n         {ts}SKU{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$formValues.product_sku}\n        </td>\n       </tr>\n      {/if}\n      {if $fulfilled_date}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Sent{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$fulfilled_date|truncate:10:\'\'|crmDate}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,488,1,0),(6,'Contributions - Receipt (off-line)','{ts}Contribution Receipt{/ts}\n','{if $formValues.receipt_text}\n{$formValues.receipt_text}\n{else}{ts}Thanks for your support.{/ts}{/if}\n\n{ts}Please print this receipt for your records.{/ts}\n\n\n===========================================================\n{ts}Contribution Information{/ts}\n\n===========================================================\n{ts}Contribution Type{/ts}: {$formValues.contributionType_name}\n{if $lineItem}\n{foreach from=$lineItem item=value key=priceset}\n---------------------------------------------------------\n{capture assign=ts_item}{ts}Item{/ts}{/capture}\n{capture assign=ts_qty}{ts}Qty{/ts}{/capture}\n{capture assign=ts_each}{ts}Each{/ts}{/capture}\n{capture assign=ts_total}{ts}Total{/ts}{/capture}\n{$ts_item|string_format:\"%-30s\"} {$ts_qty|string_format:\"%5s\"} {$ts_each|string_format:\"%10s\"} {$ts_total|string_format:\"%10s\"}\n----------------------------------------------------------\n{foreach from=$value item=line}\n{$line.description|truncate:30:\"...\"|string_format:\"%-30s\"} {$line.qty|string_format:\"%5s\"} {$line.unit_price|crmMoney|string_format:\"%10s\"} {$line.line_total|crmMoney|string_format:\"%10s\"}\n{/foreach}\n{/foreach}\n{/if}\n\n{ts}Total Amount{/ts}: {$formValues.total_amount|crmMoney}\n{if $receive_date}\n{ts}Received Date{/ts}: {$receive_date|truncate:10:\'\'|crmDate}\n{/if}\n{if $receipt_date}\n{ts}Receipt Date{/ts}: {$receipt_date|truncate:10:\'\'|crmDate}\n{/if}\n{if $formValues.paidBy and !$formValues.hidden_CreditCard}\n{ts}Paid By{/ts}: {$formValues.paidBy}\n{if $formValues.check_number}\n{ts}Check Number{/ts}: {$formValues.check_number}\n{/if}\n{/if}\n{if $formValues.trxn_id}\n{ts}Transaction ID{/ts}: {$formValues.trxn_id}\n{/if}\n\n{if $ccContribution}\n===========================================================\n{ts}Billing Name and Address{/ts}\n\n===========================================================\n{$billingName}\n{$address}\n\n===========================================================\n{ts}Credit Card Information{/ts}\n\n===========================================================\n{$credit_card_type}\n{$credit_card_number}\n{ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n{/if}\n{if $customGroup}\n{foreach from=$customGroup item=value key=customName}\n===========================================================\n{$customName}\n===========================================================\n{foreach from=$value item=v key=n}\n{$n}: {$v}\n{/foreach}\n{/foreach}\n{/if}\n{if $formValues.honor_first_name}\n\n===========================================================\n{$formValues.honor_type}\n===========================================================\n{$formValues.honor_prefix} {$formValues.honor_first_name} {$formValues.honor_last_name}\n{if $formValues.honor_email}\n{ts}Honoree Email{/ts}: {$formValues.honor_email}\n{/if}\n{/if}\n\n{if $formValues.product_name}\n===========================================================\n{ts}Premium Information{/ts}\n\n===========================================================\n{$formValues.product_name}\n{if $formValues.product_option}\n{ts}Option{/ts}: {$formValues.product_option}\n{/if}\n{if $formValues.product_sku}\n{ts}SKU{/ts}: {$formValues.product_sku}\n{/if}\n{if $fulfilled_date}\n{ts}Sent{/ts}: {$fulfilled_date|crmDate}\n{/if}\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n\n    {if $formValues.receipt_text}\n     <p>{$formValues.receipt_text|htmlize}</p>\n    {else}\n     <p>{ts}Thanks for your support.{/ts}</p>\n    {/if}\n\n    <p>{ts}Please print this receipt for your records.{/ts}</p>\n\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Contribution Information{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Contribution Type{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$formValues.contributionType_name}\n      </td>\n     </tr>\n\n     {if $lineItem}\n      {foreach from=$lineItem item=value key=priceset}\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         <table> {* FIXME: style this table so that it looks like the text version (justification, etc.) *}\n          <tr>\n           <th>{ts}Item{/ts}</th>\n           <th>{ts}Qty{/ts}</th>\n           <th>{ts}Each{/ts}</th>\n           <th>{ts}Total{/ts}</th>\n          </tr>\n          {foreach from=$value item=line}\n           <tr>\n            <td>\n             {$line.description|truncate:30:\"...\"}\n            </td>\n            <td>\n             {$line.qty}\n            </td>\n            <td>\n             {$line.unit_price|crmMoney}\n            </td>\n            <td>\n             {$line.line_total|crmMoney}\n            </td>\n           </tr>\n          {/foreach}\n         </table>\n        </td>\n       </tr>\n      {/foreach}\n     {/if}\n\n     <tr>\n      <td {$labelStyle}>\n       {ts}Total Amount{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$formValues.total_amount|crmMoney}\n      </td>\n     </tr>\n\n     {if $receive_date}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Received Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$receive_date|truncate:10:\'\'|crmDate}\n       </td>\n      </tr>\n     {/if}\n\n      {if $receipt_date}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Receipt Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$receipt_date|truncate:10:\'\'|crmDate}\n       </td>\n      </tr>\n     {/if}\n\n     {if $formValues.paidBy and !$formValues.hidden_CreditCard}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Paid By{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$formValues.paidBy}\n       </td>\n      </tr>\n      {if $formValues.check_number}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Check Number{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$formValues.check_number}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $formValues.trxn_id}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Transaction ID{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$formValues.trxn_id}\n       </td>\n      </tr>\n     {/if}\n\n     {if $ccContribution}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Billing Name and Address{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$billingName}<br />\n        {$address|nl2br}\n       </td>\n      </tr>\n      <tr>\n       <th {$headerStyle}>\n        {ts}Credit Card Information{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$credit_card_type}<br />\n        {$credit_card_number}<br />\n        {ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n       </td>\n      </tr>\n     {/if}\n\n     {if $customGroup}\n      {foreach from=$customGroup item=value key=customName}\n       <tr>\n        <th {$headerStyle}>\n         {$customName}\n        </th>\n       </tr>\n       {foreach from=$value item=v key=n}\n        <tr>\n         <td {$labelStyle}>\n          {$n}\n         </td>\n         <td {$valueStyle}>\n          {$v}\n         </td>\n        </tr>\n       {/foreach}\n      {/foreach}\n     {/if}\n\n     {if $formValues.honor_first_name}\n      <tr>\n       <th {$headerStyle}>\n        {$formValues.honor_type}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$formValues.honor_prefix} {$formValues.honor_first_name} {$formValues.honor_last_name}<br />\n        {if $formValues.honor_email}\n         {ts}Honoree Email{/ts}: {$formValues.honor_email}\n        {/if}\n       </td>\n      </tr>\n     {/if}\n\n     {if $formValues.product_name}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Premium Information{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {$formValues.product_name}\n       </td>\n      </tr>\n      {if $formValues.product_option}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Option{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$formValues.product_option}\n        </td>\n       </tr>\n      {/if}\n      {if $formValues.product_sku}\n       <tr>\n        <td {$labelStyle}>\n         {ts}SKU{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$formValues.product_sku}\n        </td>\n       </tr>\n      {/if}\n      {if $fulfilled_date}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Sent{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$fulfilled_date|truncate:10:\'\'|crmDate}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,488,0,1),(7,'Contributions - Receipt (on-line)','{if $is_pay_later}{ts}Invoice{/ts}{else}{ts}Receipt{/ts}{/if} - {$title}\n','{if $receipt_text}\n{$receipt_text}\n{/if}\n{if $is_pay_later}\n\n===========================================================\n{$pay_later_receipt}\n===========================================================\n{else}\n\n{ts}Please print this receipt for your records.{/ts}\n{/if}\n\n{if $amount}\n===========================================================\n{ts}Contribution Information{/ts}\n\n===========================================================\n{if $lineItem and $priceSetID}\n{foreach from=$lineItem item=value key=priceset}\n---------------------------------------------------------\n{capture assign=ts_item}{ts}Item{/ts}{/capture}\n{capture assign=ts_qty}{ts}Qty{/ts}{/capture}\n{capture assign=ts_each}{ts}Each{/ts}{/capture}\n{capture assign=ts_total}{ts}Total{/ts}{/capture}\n{$ts_item|string_format:\"%-30s\"} {$ts_qty|string_format:\"%5s\"} {$ts_each|string_format:\"%10s\"} {$ts_total|string_format:\"%10s\"}\n----------------------------------------------------------\n{foreach from=$value item=line}\n{$line.description|truncate:30:\"...\"|string_format:\"%-30s\"} {$line.qty|string_format:\"%5s\"} {$line.unit_price|crmMoney|string_format:\"%10s\"} {$line.line_total|crmMoney|string_format:\"%10s\"}\n{/foreach}\n{/foreach}\n\n{ts}Total Amount{/ts}: {$amount|crmMoney}\n{else}\n{ts}Amount{/ts}: {$amount|crmMoney} {if $amount_level } - {$amount_level} {/if}\n{/if}\n{/if}\n{if $receive_date}\n\n{ts}Date{/ts}: {$receive_date|crmDate}\n{/if}\n{if $is_monetary and $trxn_id}\n{ts}Transaction #{/ts}: {$trxn_id}\n{/if}\n\n{if $is_recur}\n{if $contributeMode eq \'notify\'}\n{ts}This is a recurring contribution. You can modify or cancel future contributions by logging in to your account at:{/ts}\n\n{$cancelSubscriptionUrl}\n{elseif $contributeMode eq \'directIPN\' and $receiptFromEmail}\n{ts 1=$receiptFromEmail}This is a recurring contribution. To modify or cancel future contributions please contact us at %1.{/ts}\n\n{/if}\n{/if}\n\n{if $honor_block_is_active }\n===========================================================\n{$honor_type}\n===========================================================\n{$honor_prefix} {$honor_first_name} {$honor_last_name}\n{if $honor_email}\n{ts}Honoree Email{/ts}: {$honor_email}\n{/if}\n\n{/if}\n{if $pcpBlock}\n===========================================================\n{ts}Personal Campaign Page{/ts}\n\n===========================================================\n{ts}Display In Honor Roll{/ts}: {if $pcp_display_in_roll}{ts}Yes{/ts}{else}{ts}No{/ts}{/if}\n\n{if $pcp_roll_nickname}{ts}Nick Name{/ts}: {$pcp_roll_nickname}{/if}\n\n{if $pcp_personal_note}{ts}Personal Note{/ts}: {$pcp_personal_note}{/if}\n\n{/if}\n{if $onBehalfName}\n===========================================================\n{ts}On Behalf Of{/ts}\n\n===========================================================\n{$onBehalfName}\n{$onBehalfAddress}\n\n{$onBehalfEmail}\n\n{/if}\n\n{if !( $contributeMode eq \'notify\' OR $contributeMode eq \'directIPN\' ) and $is_monetary}\n{if $is_pay_later}\n===========================================================\n{ts}Registered Email{/ts}\n\n===========================================================\n{$email}\n{elseif $amount GT 0}\n===========================================================\n{ts}Billing Name and Address{/ts}\n\n===========================================================\n{$billingName}\n{$address}\n\n{$email}\n{/if} {* End ! is_pay_later condition. *}\n{/if}\n{if $contributeMode eq \'direct\' AND !$is_pay_later AND $amount GT 0}\n\n===========================================================\n{ts}Credit Card Information{/ts}\n\n===========================================================\n{$credit_card_type}\n{$credit_card_number}\n{ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n{/if}\n\n{if $selectPremium }\n===========================================================\n{ts}Premium Information{/ts}\n\n===========================================================\n{$product_name}\n{if $option}\n{ts}Option{/ts}: {$option}\n{/if}\n{if $sku}\n{ts}SKU{/ts}: {$sku}\n{/if}\n{if $start_date}\n{ts}Start Date{/ts}: {$start_date|crmDate}\n{/if}\n{if $end_date}\n{ts}End Date{/ts}: {$end_date|crmDate}\n{/if}\n{if $contact_email OR $contact_phone}\n\n{ts}For information about this premium, contact:{/ts}\n\n{if $contact_email}\n  {$contact_email}\n{/if}\n{if $contact_phone}\n  {$contact_phone}\n{/if}\n{/if}\n{if $is_deductible AND $price}\n\n{ts 1=$price|crmMoney}The value of this premium is %1. This may affect the amount of the tax deduction you can claim. Consult your tax advisor for more information.{/ts}{/if}\n{/if}\n\n{if $customPre}\n===========================================================\n{$customPre_grouptitle}\n\n===========================================================\n{foreach from=$customPre item=customValue key=customName}\n{if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n {$customName}: {$customValue}\n{/if}\n{/foreach}\n{/if}\n\n\n{if $customPost}\n===========================================================\n{$customPost_grouptitle}\n\n===========================================================\n{foreach from=$customPost item=customValue key=customName}\n{if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n {$customName}: {$customValue}\n{/if}\n{/foreach}\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n\n    {if $receipt_text}\n     <p>{$receipt_text|htmlize}</p>\n    {/if}\n\n    {if $is_pay_later}\n     <p>{$pay_later_receipt}</p> {* FIXME: this might be text rather than HTML *}\n    {else}\n     <p>{ts}Please print this confirmation for your records.{/ts}</p>\n    {/if}\n\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n\n     {if $amount}\n\n\n      <tr>\n       <th {$headerStyle}>\n        {ts}Contribution Information{/ts}\n       </th>\n      </tr>\n\n      {if $lineItem and $priceSetID}\n\n       {foreach from=$lineItem item=value key=priceset}\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          <table> {* FIXME: style this table so that it looks like the text version (justification, etc.) *}\n           <tr>\n            <th>{ts}Item{/ts}</th>\n            <th>{ts}Qty{/ts}</th>\n            <th>{ts}Each{/ts}</th>\n            <th>{ts}Total{/ts}</th>\n           </tr>\n           {foreach from=$value item=line}\n            <tr>\n             <td>\n              {$line.description|truncate:30:\"...\"}\n             </td>\n             <td>\n              {$line.qty}\n             </td>\n             <td>\n              {$line.unit_price|crmMoney}\n             </td>\n             <td>\n              {$line.line_total|crmMoney}\n             </td>\n            </tr>\n           {/foreach}\n          </table>\n         </td>\n        </tr>\n       {/foreach}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Total Amount{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$amount|crmMoney}\n        </td>\n       </tr>\n\n      {else}\n\n       <tr>\n        <td {$labelStyle}>\n         {ts}Amount{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$amount|crmMoney} {if $amount_level} - {$amount_level}{/if}\n        </td>\n       </tr>\n\n      {/if}\n\n\n     {/if}\n\n\n     {if $receive_date}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$receive_date|crmDate}\n       </td>\n      </tr>\n     {/if}\n\n     {if $is_monetary and $trxn_id}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Transaction #{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$trxn_id}\n       </td>\n      </tr>\n     {/if}\n\n     {if $is_recur}\n      {if $contributeMode eq \'notify\'}\n       <tr>\n        <td {$labelStyle}>\n         {ts 1=$cancelSubscriptionUrl}This is a recurring contribution. You can modify or cancel future contributions by <a href=\"%1\">logging in to your account</a>.{/ts}\n        </td>\n       </tr>\n      {elseif $contributeMode eq \'directIPN\' and $receiptFromEmail}\n       <tr>\n        <td {$labelStyle}>\n         {ts 1=$receiptFromEmail}This is a recurring contribution. To modify or cancel future contributions please contact us at %1.{/ts}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $honor_block_is_active}\n      <tr>\n       <th {$headerStyle}>\n        {$honor_type}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {$honor_prefix} {$honor_first_name} {$honor_last_name}\n       </td>\n      </tr>\n      {if $honor_email}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Honoree Email{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$honor_email}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $pcpBlock}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Personal Campaign Page{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td {$labelStyle}>\n        {ts}Display In Honor Roll{/ts}\n       </td>\n       <td {$valueStyle}>\n        {if $pcp_display_in_roll}{ts}Yes{/ts}{else}{ts}No{/ts}{/if}\n       </td>\n      </tr>\n      {if $pcp_roll_nickname}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Nick Name{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$pcp_roll_nickname}\n        </td>\n       </tr>\n      {/if}\n      {if $pcp_personal_note}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Personal Note{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$pcp_personal_note}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $onBehalfName}\n      <tr>\n       <th {$headerStyle}>\n        {ts}On Behalf Of{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$onBehalfName}<br />\n        {$onBehalfAddress|nl2br}<br />\n        {$onBehalfEmail}\n       </td>\n      </tr>\n     {/if}\n\n     {if ! ($contributeMode eq \'notify\' OR $contributeMode eq \'directIPN\') and $is_monetary}\n      {if $is_pay_later}\n       <tr>\n        <th {$headerStyle}>\n         {ts}Registered Email{/ts}\n        </th>\n       </tr>\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         {$email}\n        </td>\n       </tr>\n      {elseif $amount GT 0}\n       <tr>\n        <th {$headerStyle}>\n         {ts}Billing Name and Address{/ts}\n        </th>\n       </tr>\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         {$billingName}<br />\n         {$address|nl2br}<br />\n         {$email}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $contributeMode eq \'direct\' AND !$is_pay_later AND $amount GT 0}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Credit Card Information{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$credit_card_type}<br />\n        {$credit_card_number}<br />\n        {ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}<br />\n       </td>\n      </tr>\n     {/if}\n\n     {if $selectPremium}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Premium Information{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {$product_name}\n       </td>\n      </tr>\n      {if $option}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Option{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$option}\n        </td>\n       </tr>\n      {/if}\n      {if $sku}\n       <tr>\n        <td {$labelStyle}>\n         {ts}SKU{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$sku}\n        </td>\n       </tr>\n      {/if}\n      {if $start_date}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Start Date{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$start_date|crmDate}\n        </td>\n       </tr>\n      {/if}\n      {if $end_date}\n       <tr>\n        <td {$labelStyle}>\n         {ts}End Date{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$end_date|crmDate}\n        </td>\n       </tr>\n      {/if}\n      {if $contact_email OR $contact_phone}\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         <p>{ts}For information about this premium, contact:{/ts}</p>\n         {if $contact_email}\n          <p>{$contact_email}</p>\n         {/if}\n         {if $contact_phone}\n          <p>{$contact_phone}</p>\n         {/if}\n        </td>\n       </tr>\n      {/if}\n      {if $is_deductible AND $price}\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          <p>{ts 1=$price|crmMoney}The value of this premium is %1. This may affect the amount of the tax deduction you can claim. Consult your tax advisor for more information.{/ts}</p>\n         </td>\n        </tr>\n      {/if}\n     {/if}\n\n     {if $customPre}\n      <tr>\n       <th {$headerStyle}>\n        {$customPre_grouptitle}\n       </th>\n      </tr>\n      {foreach from=$customPre item=customValue key=customName}\n       {if ($trackingFields and ! in_array($customName, $trackingFields)) or ! $trackingFields}\n        <tr>\n         <td {$labelStyle}>\n          {$customName}\n         </td>\n         <td {$valueStyle}>\n          {$customValue}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {if $customPost}\n      <tr>\n       <th {$headerStyle}>\n        {$customPost_grouptitle}\n       </th>\n      </tr>\n      {foreach from=$customPost item=customValue key=customName}\n       {if ($trackingFields and ! in_array($customName, $trackingFields)) or ! $trackingFields}\n        <tr>\n         <td {$labelStyle}>\n          {$customName}\n         </td>\n         <td {$valueStyle}>\n          {$customValue}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,489,1,0),(8,'Contributions - Receipt (on-line)','{if $is_pay_later}{ts}Invoice{/ts}{else}{ts}Receipt{/ts}{/if} - {$title}\n','{if $receipt_text}\n{$receipt_text}\n{/if}\n{if $is_pay_later}\n\n===========================================================\n{$pay_later_receipt}\n===========================================================\n{else}\n\n{ts}Please print this receipt for your records.{/ts}\n{/if}\n\n{if $amount}\n===========================================================\n{ts}Contribution Information{/ts}\n\n===========================================================\n{if $lineItem and $priceSetID}\n{foreach from=$lineItem item=value key=priceset}\n---------------------------------------------------------\n{capture assign=ts_item}{ts}Item{/ts}{/capture}\n{capture assign=ts_qty}{ts}Qty{/ts}{/capture}\n{capture assign=ts_each}{ts}Each{/ts}{/capture}\n{capture assign=ts_total}{ts}Total{/ts}{/capture}\n{$ts_item|string_format:\"%-30s\"} {$ts_qty|string_format:\"%5s\"} {$ts_each|string_format:\"%10s\"} {$ts_total|string_format:\"%10s\"}\n----------------------------------------------------------\n{foreach from=$value item=line}\n{$line.description|truncate:30:\"...\"|string_format:\"%-30s\"} {$line.qty|string_format:\"%5s\"} {$line.unit_price|crmMoney|string_format:\"%10s\"} {$line.line_total|crmMoney|string_format:\"%10s\"}\n{/foreach}\n{/foreach}\n\n{ts}Total Amount{/ts}: {$amount|crmMoney}\n{else}\n{ts}Amount{/ts}: {$amount|crmMoney} {if $amount_level } - {$amount_level} {/if}\n{/if}\n{/if}\n{if $receive_date}\n\n{ts}Date{/ts}: {$receive_date|crmDate}\n{/if}\n{if $is_monetary and $trxn_id}\n{ts}Transaction #{/ts}: {$trxn_id}\n{/if}\n\n{if $is_recur}\n{if $contributeMode eq \'notify\'}\n{ts}This is a recurring contribution. You can modify or cancel future contributions by logging in to your account at:{/ts}\n\n{$cancelSubscriptionUrl}\n{elseif $contributeMode eq \'directIPN\' and $receiptFromEmail}\n{ts 1=$receiptFromEmail}This is a recurring contribution. To modify or cancel future contributions please contact us at %1.{/ts}\n\n{/if}\n{/if}\n\n{if $honor_block_is_active }\n===========================================================\n{$honor_type}\n===========================================================\n{$honor_prefix} {$honor_first_name} {$honor_last_name}\n{if $honor_email}\n{ts}Honoree Email{/ts}: {$honor_email}\n{/if}\n\n{/if}\n{if $pcpBlock}\n===========================================================\n{ts}Personal Campaign Page{/ts}\n\n===========================================================\n{ts}Display In Honor Roll{/ts}: {if $pcp_display_in_roll}{ts}Yes{/ts}{else}{ts}No{/ts}{/if}\n\n{if $pcp_roll_nickname}{ts}Nick Name{/ts}: {$pcp_roll_nickname}{/if}\n\n{if $pcp_personal_note}{ts}Personal Note{/ts}: {$pcp_personal_note}{/if}\n\n{/if}\n{if $onBehalfName}\n===========================================================\n{ts}On Behalf Of{/ts}\n\n===========================================================\n{$onBehalfName}\n{$onBehalfAddress}\n\n{$onBehalfEmail}\n\n{/if}\n\n{if !( $contributeMode eq \'notify\' OR $contributeMode eq \'directIPN\' ) and $is_monetary}\n{if $is_pay_later}\n===========================================================\n{ts}Registered Email{/ts}\n\n===========================================================\n{$email}\n{elseif $amount GT 0}\n===========================================================\n{ts}Billing Name and Address{/ts}\n\n===========================================================\n{$billingName}\n{$address}\n\n{$email}\n{/if} {* End ! is_pay_later condition. *}\n{/if}\n{if $contributeMode eq \'direct\' AND !$is_pay_later AND $amount GT 0}\n\n===========================================================\n{ts}Credit Card Information{/ts}\n\n===========================================================\n{$credit_card_type}\n{$credit_card_number}\n{ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n{/if}\n\n{if $selectPremium }\n===========================================================\n{ts}Premium Information{/ts}\n\n===========================================================\n{$product_name}\n{if $option}\n{ts}Option{/ts}: {$option}\n{/if}\n{if $sku}\n{ts}SKU{/ts}: {$sku}\n{/if}\n{if $start_date}\n{ts}Start Date{/ts}: {$start_date|crmDate}\n{/if}\n{if $end_date}\n{ts}End Date{/ts}: {$end_date|crmDate}\n{/if}\n{if $contact_email OR $contact_phone}\n\n{ts}For information about this premium, contact:{/ts}\n\n{if $contact_email}\n  {$contact_email}\n{/if}\n{if $contact_phone}\n  {$contact_phone}\n{/if}\n{/if}\n{if $is_deductible AND $price}\n\n{ts 1=$price|crmMoney}The value of this premium is %1. This may affect the amount of the tax deduction you can claim. Consult your tax advisor for more information.{/ts}{/if}\n{/if}\n\n{if $customPre}\n===========================================================\n{$customPre_grouptitle}\n\n===========================================================\n{foreach from=$customPre item=customValue key=customName}\n{if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n {$customName}: {$customValue}\n{/if}\n{/foreach}\n{/if}\n\n\n{if $customPost}\n===========================================================\n{$customPost_grouptitle}\n\n===========================================================\n{foreach from=$customPost item=customValue key=customName}\n{if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n {$customName}: {$customValue}\n{/if}\n{/foreach}\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n\n    {if $receipt_text}\n     <p>{$receipt_text|htmlize}</p>\n    {/if}\n\n    {if $is_pay_later}\n     <p>{$pay_later_receipt}</p> {* FIXME: this might be text rather than HTML *}\n    {else}\n     <p>{ts}Please print this confirmation for your records.{/ts}</p>\n    {/if}\n\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n\n     {if $amount}\n\n\n      <tr>\n       <th {$headerStyle}>\n        {ts}Contribution Information{/ts}\n       </th>\n      </tr>\n\n      {if $lineItem and $priceSetID}\n\n       {foreach from=$lineItem item=value key=priceset}\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          <table> {* FIXME: style this table so that it looks like the text version (justification, etc.) *}\n           <tr>\n            <th>{ts}Item{/ts}</th>\n            <th>{ts}Qty{/ts}</th>\n            <th>{ts}Each{/ts}</th>\n            <th>{ts}Total{/ts}</th>\n           </tr>\n           {foreach from=$value item=line}\n            <tr>\n             <td>\n              {$line.description|truncate:30:\"...\"}\n             </td>\n             <td>\n              {$line.qty}\n             </td>\n             <td>\n              {$line.unit_price|crmMoney}\n             </td>\n             <td>\n              {$line.line_total|crmMoney}\n             </td>\n            </tr>\n           {/foreach}\n          </table>\n         </td>\n        </tr>\n       {/foreach}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Total Amount{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$amount|crmMoney}\n        </td>\n       </tr>\n\n      {else}\n\n       <tr>\n        <td {$labelStyle}>\n         {ts}Amount{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$amount|crmMoney} {if $amount_level} - {$amount_level}{/if}\n        </td>\n       </tr>\n\n      {/if}\n\n\n     {/if}\n\n\n     {if $receive_date}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$receive_date|crmDate}\n       </td>\n      </tr>\n     {/if}\n\n     {if $is_monetary and $trxn_id}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Transaction #{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$trxn_id}\n       </td>\n      </tr>\n     {/if}\n\n     {if $is_recur}\n      {if $contributeMode eq \'notify\'}\n       <tr>\n        <td {$labelStyle}>\n         {ts 1=$cancelSubscriptionUrl}This is a recurring contribution. You can modify or cancel future contributions by <a href=\"%1\">logging in to your account</a>.{/ts}\n        </td>\n       </tr>\n      {elseif $contributeMode eq \'directIPN\' and $receiptFromEmail}\n       <tr>\n        <td {$labelStyle}>\n         {ts 1=$receiptFromEmail}This is a recurring contribution. To modify or cancel future contributions please contact us at %1.{/ts}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $honor_block_is_active}\n      <tr>\n       <th {$headerStyle}>\n        {$honor_type}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {$honor_prefix} {$honor_first_name} {$honor_last_name}\n       </td>\n      </tr>\n      {if $honor_email}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Honoree Email{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$honor_email}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $pcpBlock}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Personal Campaign Page{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td {$labelStyle}>\n        {ts}Display In Honor Roll{/ts}\n       </td>\n       <td {$valueStyle}>\n        {if $pcp_display_in_roll}{ts}Yes{/ts}{else}{ts}No{/ts}{/if}\n       </td>\n      </tr>\n      {if $pcp_roll_nickname}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Nick Name{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$pcp_roll_nickname}\n        </td>\n       </tr>\n      {/if}\n      {if $pcp_personal_note}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Personal Note{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$pcp_personal_note}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $onBehalfName}\n      <tr>\n       <th {$headerStyle}>\n        {ts}On Behalf Of{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$onBehalfName}<br />\n        {$onBehalfAddress|nl2br}<br />\n        {$onBehalfEmail}\n       </td>\n      </tr>\n     {/if}\n\n     {if ! ($contributeMode eq \'notify\' OR $contributeMode eq \'directIPN\') and $is_monetary}\n      {if $is_pay_later}\n       <tr>\n        <th {$headerStyle}>\n         {ts}Registered Email{/ts}\n        </th>\n       </tr>\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         {$email}\n        </td>\n       </tr>\n      {elseif $amount GT 0}\n       <tr>\n        <th {$headerStyle}>\n         {ts}Billing Name and Address{/ts}\n        </th>\n       </tr>\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         {$billingName}<br />\n         {$address|nl2br}<br />\n         {$email}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $contributeMode eq \'direct\' AND !$is_pay_later AND $amount GT 0}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Credit Card Information{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$credit_card_type}<br />\n        {$credit_card_number}<br />\n        {ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}<br />\n       </td>\n      </tr>\n     {/if}\n\n     {if $selectPremium}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Premium Information{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {$product_name}\n       </td>\n      </tr>\n      {if $option}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Option{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$option}\n        </td>\n       </tr>\n      {/if}\n      {if $sku}\n       <tr>\n        <td {$labelStyle}>\n         {ts}SKU{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$sku}\n        </td>\n       </tr>\n      {/if}\n      {if $start_date}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Start Date{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$start_date|crmDate}\n        </td>\n       </tr>\n      {/if}\n      {if $end_date}\n       <tr>\n        <td {$labelStyle}>\n         {ts}End Date{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$end_date|crmDate}\n        </td>\n       </tr>\n      {/if}\n      {if $contact_email OR $contact_phone}\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         <p>{ts}For information about this premium, contact:{/ts}</p>\n         {if $contact_email}\n          <p>{$contact_email}</p>\n         {/if}\n         {if $contact_phone}\n          <p>{$contact_phone}</p>\n         {/if}\n        </td>\n       </tr>\n      {/if}\n      {if $is_deductible AND $price}\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          <p>{ts 1=$price|crmMoney}The value of this premium is %1. This may affect the amount of the tax deduction you can claim. Consult your tax advisor for more information.{/ts}</p>\n         </td>\n        </tr>\n      {/if}\n     {/if}\n\n     {if $customPre}\n      <tr>\n       <th {$headerStyle}>\n        {$customPre_grouptitle}\n       </th>\n      </tr>\n      {foreach from=$customPre item=customValue key=customName}\n       {if ($trackingFields and ! in_array($customName, $trackingFields)) or ! $trackingFields}\n        <tr>\n         <td {$labelStyle}>\n          {$customName}\n         </td>\n         <td {$valueStyle}>\n          {$customValue}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {if $customPost}\n      <tr>\n       <th {$headerStyle}>\n        {$customPost_grouptitle}\n       </th>\n      </tr>\n      {foreach from=$customPost item=customValue key=customName}\n       {if ($trackingFields and ! in_array($customName, $trackingFields)) or ! $trackingFields}\n        <tr>\n         <td {$labelStyle}>\n          {$customName}\n         </td>\n         <td {$valueStyle}>\n          {$customValue}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,489,0,1),(9,'Contributions - Recurring Start and End Notification','{ts}Recurring Contribution Notification{/ts}\n','{ts 1=$displayName}Dear %1{/ts},\n\n{if $recur_txnType eq \'START\'}\n\n{ts}Thanks for your recurring contribution sign-up.{/ts}\n\n\n{ts 1=$recur_frequency_interval 2=$recur_frequency_unit 3=$recur_installments}This recurring contribution will be automatically processed every %1 %2(s) for a total %3 installment.{/ts}\n\n\n{ts}Start Date{/ts}:  {$recur_start_date|crmDate}\n\n\n{ts 1=$receipt_from_name 2=$receipt_from_email}You have pledged to make this recurring donation. You will be charged periodically (per frequency listed above), and you will receive an email receipt from %1 following each charge. These recurring donations will continue until you explicitly cancel the donation. You may change or cancel your recurring donation at anytime by logged in your account. If you have questions about recurring donations please contact us at %2.{/ts}\n\n{elseif $recur_txnType eq \'END\'}\n\n{ts}Your recurring contribution term has ended.{/ts}\n\n\n{ts 1=$recur_installments}You have successfully completed %1 recurring contributions. Thank you for your support.{/ts}\n\n\n==================================================\n{ts 1=$recur_installments}Interval of Subscription for %1 installments{/ts}\n\n==================================================\n{ts}Start Date{/ts}: {$recur_start_date|crmDate}\n\n{ts}End Date{/ts}: {$recur_end_date|crmDate}\n\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n\n    <p>{ts 1=$displayName}Dear %1{/ts},</p>\n\n    {if $recur_txnType eq \'START\'}\n\n     <p>{ts}Thanks for your recurring contribution sign-up.{/ts}</p>\n     <p>{ts 1=$recur_frequency_interval 2=$recur_frequency_unit 3=$recur_installments}This recurring contribution will be automatically processed every %1 %2(s) for a total %3 installment.{/ts}</p>\n     <p>{ts}Start Date{/ts}: {$recur_start_date|crmDate}</p>\n     <p>{ts 1=$receipt_from_name 2=$receipt_from_email}You have pledged to make this recurring donation. You will be charged periodically (per frequency listed above), and you will receive an email receipt from %1 following each charge. These recurring donations will continue until you explicitly cancel the donation. You may change or cancel your recurring donation at anytime by logged in your account. If you have questions about recurring donations please contact us at %2.{/ts}</p>\n\n    {elseif $recur_txnType eq \'END\'}\n\n     <p>{ts}Your recurring contribution term has ended.{/ts}</p>\n     <p>{ts 1=$recur_installments}You have successfully completed %1 recurring contributions. Thank you for your support.{/ts}</p>\n     <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n      <tr>\n       <th {$headerStyle}>\n        {ts 1=$recur_installments}Interval of Subscription for %1 installments{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td {$labelStyle}>\n        {ts}Start Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$recur_start_date|crmDate}\n       </td>\n      </tr>\n      <tr>\n       <td {$labelStyle}>\n        {ts}End Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$recur_end_date|crmDate}\n       </td>\n      </tr>\n     </table>\n\n    {/if}\n\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,490,1,0),(10,'Contributions - Recurring Start and End Notification','{ts}Recurring Contribution Notification{/ts}\n','{ts 1=$displayName}Dear %1{/ts},\n\n{if $recur_txnType eq \'START\'}\n\n{ts}Thanks for your recurring contribution sign-up.{/ts}\n\n\n{ts 1=$recur_frequency_interval 2=$recur_frequency_unit 3=$recur_installments}This recurring contribution will be automatically processed every %1 %2(s) for a total %3 installment.{/ts}\n\n\n{ts}Start Date{/ts}:  {$recur_start_date|crmDate}\n\n\n{ts 1=$receipt_from_name 2=$receipt_from_email}You have pledged to make this recurring donation. You will be charged periodically (per frequency listed above), and you will receive an email receipt from %1 following each charge. These recurring donations will continue until you explicitly cancel the donation. You may change or cancel your recurring donation at anytime by logged in your account. If you have questions about recurring donations please contact us at %2.{/ts}\n\n{elseif $recur_txnType eq \'END\'}\n\n{ts}Your recurring contribution term has ended.{/ts}\n\n\n{ts 1=$recur_installments}You have successfully completed %1 recurring contributions. Thank you for your support.{/ts}\n\n\n==================================================\n{ts 1=$recur_installments}Interval of Subscription for %1 installments{/ts}\n\n==================================================\n{ts}Start Date{/ts}: {$recur_start_date|crmDate}\n\n{ts}End Date{/ts}: {$recur_end_date|crmDate}\n\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n\n    <p>{ts 1=$displayName}Dear %1{/ts},</p>\n\n    {if $recur_txnType eq \'START\'}\n\n     <p>{ts}Thanks for your recurring contribution sign-up.{/ts}</p>\n     <p>{ts 1=$recur_frequency_interval 2=$recur_frequency_unit 3=$recur_installments}This recurring contribution will be automatically processed every %1 %2(s) for a total %3 installment.{/ts}</p>\n     <p>{ts}Start Date{/ts}: {$recur_start_date|crmDate}</p>\n     <p>{ts 1=$receipt_from_name 2=$receipt_from_email}You have pledged to make this recurring donation. You will be charged periodically (per frequency listed above), and you will receive an email receipt from %1 following each charge. These recurring donations will continue until you explicitly cancel the donation. You may change or cancel your recurring donation at anytime by logged in your account. If you have questions about recurring donations please contact us at %2.{/ts}</p>\n\n    {elseif $recur_txnType eq \'END\'}\n\n     <p>{ts}Your recurring contribution term has ended.{/ts}</p>\n     <p>{ts 1=$recur_installments}You have successfully completed %1 recurring contributions. Thank you for your support.{/ts}</p>\n     <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n      <tr>\n       <th {$headerStyle}>\n        {ts 1=$recur_installments}Interval of Subscription for %1 installments{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td {$labelStyle}>\n        {ts}Start Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$recur_start_date|crmDate}\n       </td>\n      </tr>\n      <tr>\n       <td {$labelStyle}>\n        {ts}End Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$recur_end_date|crmDate}\n       </td>\n      </tr>\n     </table>\n\n    {/if}\n\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,490,0,1),(11,'Personal Campaign Pages - Admin Notification','{ts}Personal Campaign Page Notification{/ts}\n','===========================================================\n{ts}Personal Campaign Page Notification{/ts}\n\n===========================================================\n{ts}Action{/ts}: {if $mode EQ \'Update\'}{ts}Updated personal campaign page{/ts}{else}{ts}New personal campaign page{/ts}{/if}\n{ts}Personal Campaign Page Title{/ts}: {$pcpTitle}\n{ts}Current Status{/ts}: {$pcpStatus}\n{capture assign=pcpURL}{crmURL p=\"civicrm/contribute/pcp/info\" q=\"reset=1&id=`$pcpId`\" h=0 a=1}{/capture}\n{ts}View Page{/ts}:\n>> {$pcpURL}\n\n{ts}Supporter{/ts}: {$supporterName}\n>> {$supporterUrl}\n\n{ts}Linked to Contribution Page{/ts}: {$contribPageTitle}\n>> {$contribPageUrl}\n\n{ts}Manage Personal Campaign Pages{/ts}:\n>> {$managePCPUrl}\n\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n{capture assign=pcpURL     }{crmURL p=\"civicrm/contribute/pcp/info\" q=\"reset=1&id=`$pcpId`\" h=0 a=1}{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Personal Campaign Page Notification{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Action{/ts}:\n      </td>\n      <td {$valueStyle}>\n       {if $mode EQ \'Update\'}\n        {ts}Updated personal campaign page{/ts}\n       {else}\n        {ts}New personal campaign page{/ts}\n       {/if}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Personal Campaign Page Title{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$pcpTitle}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Current Status{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$pcpStatus}\n      </td>\n     </tr>\n\n     <tr>\n      <td rowspan=\"2\" {$labelStyle}>\n       <a href=\"{$pcpURL}\">{ts}View Page{/ts}</a>\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Supporter{/ts}\n      </td>\n      <td {$valueStyle}>\n       <a href=\"{$supporterUrl}\">{$supporterName}</a>\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Linked to Contribution Page{/ts}\n      </td>\n      <td {$valueStyle}>\n       <a href=\"{$contribPageUrl}\">{$contribPageTitle}</a>\n      </td>\n     </tr>\n     <tr>\n      <td rowspan=\"2\" {$labelStyle}>\n       <a href=\"{$managePCPUrl}\">{ts}Manage Personal Campaign Pages{/ts}</a>\n      </td>\n     </tr>\n\n    </table>\n   </td>\n  </tr>\n </table>\n</center>\n\n</body>\n</html>\n',1,491,1,0),(12,'Personal Campaign Pages - Admin Notification','{ts}Personal Campaign Page Notification{/ts}\n','===========================================================\n{ts}Personal Campaign Page Notification{/ts}\n\n===========================================================\n{ts}Action{/ts}: {if $mode EQ \'Update\'}{ts}Updated personal campaign page{/ts}{else}{ts}New personal campaign page{/ts}{/if}\n{ts}Personal Campaign Page Title{/ts}: {$pcpTitle}\n{ts}Current Status{/ts}: {$pcpStatus}\n{capture assign=pcpURL}{crmURL p=\"civicrm/contribute/pcp/info\" q=\"reset=1&id=`$pcpId`\" h=0 a=1}{/capture}\n{ts}View Page{/ts}:\n>> {$pcpURL}\n\n{ts}Supporter{/ts}: {$supporterName}\n>> {$supporterUrl}\n\n{ts}Linked to Contribution Page{/ts}: {$contribPageTitle}\n>> {$contribPageUrl}\n\n{ts}Manage Personal Campaign Pages{/ts}:\n>> {$managePCPUrl}\n\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n{capture assign=pcpURL     }{crmURL p=\"civicrm/contribute/pcp/info\" q=\"reset=1&id=`$pcpId`\" h=0 a=1}{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Personal Campaign Page Notification{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Action{/ts}:\n      </td>\n      <td {$valueStyle}>\n       {if $mode EQ \'Update\'}\n        {ts}Updated personal campaign page{/ts}\n       {else}\n        {ts}New personal campaign page{/ts}\n       {/if}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Personal Campaign Page Title{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$pcpTitle}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Current Status{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$pcpStatus}\n      </td>\n     </tr>\n\n     <tr>\n      <td rowspan=\"2\" {$labelStyle}>\n       <a href=\"{$pcpURL}\">{ts}View Page{/ts}</a>\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Supporter{/ts}\n      </td>\n      <td {$valueStyle}>\n       <a href=\"{$supporterUrl}\">{$supporterName}</a>\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Linked to Contribution Page{/ts}\n      </td>\n      <td {$valueStyle}>\n       <a href=\"{$contribPageUrl}\">{$contribPageTitle}</a>\n      </td>\n     </tr>\n     <tr>\n      <td rowspan=\"2\" {$labelStyle}>\n       <a href=\"{$managePCPUrl}\">{ts}Manage Personal Campaign Pages{/ts}</a>\n      </td>\n     </tr>\n\n    </table>\n   </td>\n  </tr>\n </table>\n</center>\n\n</body>\n</html>\n',1,491,0,1),(13,'Personal Campaign Pages - Supporter Status Change Notification','{ts 1=$contribPageTitle}Your Personal Campaign Page for %1{/ts}\n','{if $pcpStatus eq \'Approved\'}\n============================\n{ts}Your Personal Campaign Page{/ts}\n\n============================\n\n{ts}Your personal campaign page has been approved and is now live.{/ts}\n\n{ts}Whenever you want to preview, update or promote your page{/ts}:\n1. {ts}Login to your account at{/ts}:\n{$loginUrl}\n\n2. {ts}Click or paste this link into your browser to go to your page{/ts}:\n{$pcpInfoURL}\n\n{ts}When you view your campaign page WHILE LOGGED IN, the page includes links to edit\nyour page, tell friends, and update your contact info.{/ts}\n\n{if $isTellFriendEnabled}\n\n{ts}After logging in, you can use this form to promote your fundraising page{/ts}:\n{$pcpTellFriendURL}\n\n{/if}\n\n{if $pcpNotifyEmailAddress}\n{ts}Questions? Send email to{/ts}:\n{$pcpNotifyEmailAddress}\n{/if}\n\n{* Rejected message *}\n{elseif $pcpStatus eq \'Not Approved\'}\n============================\n{ts}Your Personal Campaign Page{/ts}\n\n============================\n\n{ts}Your personal campaign page has been reviewed. There were some issues with the content\nwhich prevented us from approving the page. We are sorry for any inconvenience.{/ts}\n\n{if $pcpNotifyEmailAddress}\n\n{ts}Please contact our site administrator for more information{/ts}:\n{$pcpNotifyEmailAddress}\n{/if}\n\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n\n    <h1>{ts}Your Personal Campaign Page{/ts}</h1>\n\n    {if $pcpStatus eq \'Approved\'}\n\n     <p>{ts}Your personal campaign page has been approved and is now live.{/ts}</p>\n     <p>{ts}Whenever you want to preview, update or promote your page{/ts}:</p>\n     <ol>\n      <li><a href=\"{$loginUrl}\">{ts}Login to your account{/ts}</a></li>\n      <li><a href=\"{$pcpInfoURL}\">{ts}Go to your page{/ts}</a></li>\n     </ol>\n     <p>{ts}When you view your campaign page WHILE LOGGED IN, the page includes links to edit\nyour page, tell friends, and update your contact info.{/ts}</p>\n\n     {if $isTellFriendEnabled}\n      <p><a href=\"{$pcpTellFriendURL}\">{ts}After logging in, you can use this form to promote your fundraising page{/ts}</a></p>\n     {/if}\n\n     {if $pcpNotifyEmailAddress}\n      <p>{ts}Questions? Send email to{/ts}: {$pcpNotifyEmailAddress}</p>\n     {/if}\n\n    {elseif $pcpStatus eq \'Not Approved\'}\n\n     <p>{ts}Your personal campaign page has been reviewed. There were some issues with the content\nwhich prevented us from approving the page. We are sorry for any inconvenience.{/ts}</p>\n     {if $pcpNotifyEmailAddress}\n      <p>{ts}Please contact our site administrator for more information{/ts}: {$pcpNotifyEmailAddress}</p>\n     {/if}\n\n    {/if}\n\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,492,1,0),(14,'Personal Campaign Pages - Supporter Status Change Notification','{ts 1=$contribPageTitle}Your Personal Campaign Page for %1{/ts}\n','{if $pcpStatus eq \'Approved\'}\n============================\n{ts}Your Personal Campaign Page{/ts}\n\n============================\n\n{ts}Your personal campaign page has been approved and is now live.{/ts}\n\n{ts}Whenever you want to preview, update or promote your page{/ts}:\n1. {ts}Login to your account at{/ts}:\n{$loginUrl}\n\n2. {ts}Click or paste this link into your browser to go to your page{/ts}:\n{$pcpInfoURL}\n\n{ts}When you view your campaign page WHILE LOGGED IN, the page includes links to edit\nyour page, tell friends, and update your contact info.{/ts}\n\n{if $isTellFriendEnabled}\n\n{ts}After logging in, you can use this form to promote your fundraising page{/ts}:\n{$pcpTellFriendURL}\n\n{/if}\n\n{if $pcpNotifyEmailAddress}\n{ts}Questions? Send email to{/ts}:\n{$pcpNotifyEmailAddress}\n{/if}\n\n{* Rejected message *}\n{elseif $pcpStatus eq \'Not Approved\'}\n============================\n{ts}Your Personal Campaign Page{/ts}\n\n============================\n\n{ts}Your personal campaign page has been reviewed. There were some issues with the content\nwhich prevented us from approving the page. We are sorry for any inconvenience.{/ts}\n\n{if $pcpNotifyEmailAddress}\n\n{ts}Please contact our site administrator for more information{/ts}:\n{$pcpNotifyEmailAddress}\n{/if}\n\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n\n    <h1>{ts}Your Personal Campaign Page{/ts}</h1>\n\n    {if $pcpStatus eq \'Approved\'}\n\n     <p>{ts}Your personal campaign page has been approved and is now live.{/ts}</p>\n     <p>{ts}Whenever you want to preview, update or promote your page{/ts}:</p>\n     <ol>\n      <li><a href=\"{$loginUrl}\">{ts}Login to your account{/ts}</a></li>\n      <li><a href=\"{$pcpInfoURL}\">{ts}Go to your page{/ts}</a></li>\n     </ol>\n     <p>{ts}When you view your campaign page WHILE LOGGED IN, the page includes links to edit\nyour page, tell friends, and update your contact info.{/ts}</p>\n\n     {if $isTellFriendEnabled}\n      <p><a href=\"{$pcpTellFriendURL}\">{ts}After logging in, you can use this form to promote your fundraising page{/ts}</a></p>\n     {/if}\n\n     {if $pcpNotifyEmailAddress}\n      <p>{ts}Questions? Send email to{/ts}: {$pcpNotifyEmailAddress}</p>\n     {/if}\n\n    {elseif $pcpStatus eq \'Not Approved\'}\n\n     <p>{ts}Your personal campaign page has been reviewed. There were some issues with the content\nwhich prevented us from approving the page. We are sorry for any inconvenience.{/ts}</p>\n     {if $pcpNotifyEmailAddress}\n      <p>{ts}Please contact our site administrator for more information{/ts}: {$pcpNotifyEmailAddress}</p>\n     {/if}\n\n    {/if}\n\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,492,0,1),(15,'Personal Campaign Pages - Supporter Welcome','{ts 1=$contribPageTitle}Your Personal Campaign Page for %1{/ts}\n','{ts}Dear supporter{/ts},\n{ts 1=\"$contribPageTitle\"}Thanks for creating a personal campaign page in support of %1.{/ts}\n\n{if $pcpStatus eq \'Approved\'}\n====================\n{ts}Promoting Your Page{/ts}\n\n====================\n{if $isTellFriendEnabled}\n\n{ts}You can begin your fundraising efforts using our \"Tell a Friend\" form{/ts}:\n\n1. {ts}Login to your account at{/ts}:\n{$loginUrl}\n\n2. {ts}Click or paste this link into your browser and follow the prompts{/ts}:\n{$pcpTellFriendURL}\n{else}\n\n{ts}Send email to family, friends and colleagues with a personal message about this campaign.{/ts}\n{ts}Include this link to your fundraising page in your emails{/ts}:\n{$pcpInfoURL}\n{/if}\n\n===================\n{ts}Managing Your Page{/ts}\n\n===================\n{ts}Whenever you want to preview, update or promote your page{/ts}:\n1. {ts}Login to your account at{/ts}:\n{$loginUrl}\n\n2. {ts}Click or paste this link into your browser to go to your page{/ts}:\n{$pcpInfoURL}\n\n{ts}When you view your campaign page WHILE LOGGED IN, the page includes links to edit\nyour page, tell friends, and update your contact info.{/ts}\n\n\n{elseif $pcpStatus EQ \'Waiting Review\'}\n{ts}Your page requires administrator review before you can begin your fundraising efforts.{/ts}\n\n\n{ts}A notification email has been sent to the site administrator, and you will receive another notification from them as soon as the review process is complete.{/ts}\n\n\n{ts}You can still preview your page prior to approval{/ts}:\n1. {ts}Login to your account at{/ts}:\n{$loginUrl}\n\n2. {ts}Click or paste this link into your browser{/ts}:\n{$pcpInfoURL}\n\n{/if}\n{if $pcpNotifyEmailAddress}\n{ts}Questions? Send email to{/ts}:\n{$pcpNotifyEmailAddress}\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <p>{ts}Dear supporter{/ts},</p>\n    <p>{ts 1=\"$contribPageTitle\"}Thanks for creating a personal campaign page in support of %1.{/ts}</p>\n   </td>\n  </tr>\n\n  {if $pcpStatus eq \'Approved\'}\n\n    <tr>\n     <td>\n      <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n       <tr>\n        <th {$headerStyle}>\n         {ts}Promoting Your Page{/ts}\n        </th>\n       </tr>\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         {if $isTellFriendEnabled}\n          <p>{ts}You can begin your fundraising efforts using our \"Tell a Friend\" form{/ts}:</p>\n          <ol>\n           <li><a href=\"{$loginUrl}\">{ts}Login to your account{/ts}</a></li>\n           <li><a href=\"{$pcpTellFriendURL}\">{ts}Click this link and follow the prompts{/ts}</a></li>\n          </ol>\n         {else}\n          <p>{ts}Send email to family, friends and colleagues with a personal message about this campaign.{/ts} {ts}Include this link to your fundraising page in your emails{/ts}: {$pcpInfoURL}</p>\n         {/if}\n        </td>\n       </tr>\n       <tr>\n        <th {$headerStyle}>\n         {ts}Managing Your Page{/ts}\n        </th>\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         <p>{ts}Whenever you want to preview, update or promote your page{/ts}:</p>\n         <ol>\n          <li><a href=\"{$loginUrl}\">{ts}Login to your account{/ts}</a></li>\n          <li><a href=\"{$pcpInfoURL}\">{ts}Go to your page{/ts}</a></li>\n         </ol>\n         <p>{ts}When you view your campaign page WHILE LOGGED IN, the page includes links to edit\nyour page, tell friends, and update your contact info.{/ts}</p>\n        </td>\n       </tr>\n       </tr>\n      </table>\n     </td>\n    </tr>\n\n   {elseif $pcpStatus EQ \'Waiting Review\'}\n\n    <tr>\n     <td>\n      <p>{ts}Your page requires administrator review before you can begin your fundraising efforts.{/ts}</p>\n      <p>{ts}A notification email has been sent to the site administrator, and you will receive another notification from them as soon as the review process is complete.{/ts}</p>\n      <p>{ts}You can still preview your page prior to approval{/ts}:</p>\n      <ol>\n       <li><a href=\"{$loginUrl}\">{ts}Login to your account{/ts}</a></li>\n       <li><a href=\"{$pcpInfoURL}\">{ts}Click this link{/ts}</a></li>\n      </ol>\n     </td>\n    </tr>\n\n   {/if}\n\n   {if $pcpNotifyEmailAddress}\n    <tr>\n     <td>\n      <p>{ts}Questions? Send email to{/ts}: {$pcpNotifyEmailAddress}</p>\n     </td>\n    </tr>\n   {/if}\n\n </table>\n</center>\n\n</body>\n</html>\n',1,493,1,0),(16,'Personal Campaign Pages - Supporter Welcome','{ts 1=$contribPageTitle}Your Personal Campaign Page for %1{/ts}\n','{ts}Dear supporter{/ts},\n{ts 1=\"$contribPageTitle\"}Thanks for creating a personal campaign page in support of %1.{/ts}\n\n{if $pcpStatus eq \'Approved\'}\n====================\n{ts}Promoting Your Page{/ts}\n\n====================\n{if $isTellFriendEnabled}\n\n{ts}You can begin your fundraising efforts using our \"Tell a Friend\" form{/ts}:\n\n1. {ts}Login to your account at{/ts}:\n{$loginUrl}\n\n2. {ts}Click or paste this link into your browser and follow the prompts{/ts}:\n{$pcpTellFriendURL}\n{else}\n\n{ts}Send email to family, friends and colleagues with a personal message about this campaign.{/ts}\n{ts}Include this link to your fundraising page in your emails{/ts}:\n{$pcpInfoURL}\n{/if}\n\n===================\n{ts}Managing Your Page{/ts}\n\n===================\n{ts}Whenever you want to preview, update or promote your page{/ts}:\n1. {ts}Login to your account at{/ts}:\n{$loginUrl}\n\n2. {ts}Click or paste this link into your browser to go to your page{/ts}:\n{$pcpInfoURL}\n\n{ts}When you view your campaign page WHILE LOGGED IN, the page includes links to edit\nyour page, tell friends, and update your contact info.{/ts}\n\n\n{elseif $pcpStatus EQ \'Waiting Review\'}\n{ts}Your page requires administrator review before you can begin your fundraising efforts.{/ts}\n\n\n{ts}A notification email has been sent to the site administrator, and you will receive another notification from them as soon as the review process is complete.{/ts}\n\n\n{ts}You can still preview your page prior to approval{/ts}:\n1. {ts}Login to your account at{/ts}:\n{$loginUrl}\n\n2. {ts}Click or paste this link into your browser{/ts}:\n{$pcpInfoURL}\n\n{/if}\n{if $pcpNotifyEmailAddress}\n{ts}Questions? Send email to{/ts}:\n{$pcpNotifyEmailAddress}\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <p>{ts}Dear supporter{/ts},</p>\n    <p>{ts 1=\"$contribPageTitle\"}Thanks for creating a personal campaign page in support of %1.{/ts}</p>\n   </td>\n  </tr>\n\n  {if $pcpStatus eq \'Approved\'}\n\n    <tr>\n     <td>\n      <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n       <tr>\n        <th {$headerStyle}>\n         {ts}Promoting Your Page{/ts}\n        </th>\n       </tr>\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         {if $isTellFriendEnabled}\n          <p>{ts}You can begin your fundraising efforts using our \"Tell a Friend\" form{/ts}:</p>\n          <ol>\n           <li><a href=\"{$loginUrl}\">{ts}Login to your account{/ts}</a></li>\n           <li><a href=\"{$pcpTellFriendURL}\">{ts}Click this link and follow the prompts{/ts}</a></li>\n          </ol>\n         {else}\n          <p>{ts}Send email to family, friends and colleagues with a personal message about this campaign.{/ts} {ts}Include this link to your fundraising page in your emails{/ts}: {$pcpInfoURL}</p>\n         {/if}\n        </td>\n       </tr>\n       <tr>\n        <th {$headerStyle}>\n         {ts}Managing Your Page{/ts}\n        </th>\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         <p>{ts}Whenever you want to preview, update or promote your page{/ts}:</p>\n         <ol>\n          <li><a href=\"{$loginUrl}\">{ts}Login to your account{/ts}</a></li>\n          <li><a href=\"{$pcpInfoURL}\">{ts}Go to your page{/ts}</a></li>\n         </ol>\n         <p>{ts}When you view your campaign page WHILE LOGGED IN, the page includes links to edit\nyour page, tell friends, and update your contact info.{/ts}</p>\n        </td>\n       </tr>\n       </tr>\n      </table>\n     </td>\n    </tr>\n\n   {elseif $pcpStatus EQ \'Waiting Review\'}\n\n    <tr>\n     <td>\n      <p>{ts}Your page requires administrator review before you can begin your fundraising efforts.{/ts}</p>\n      <p>{ts}A notification email has been sent to the site administrator, and you will receive another notification from them as soon as the review process is complete.{/ts}</p>\n      <p>{ts}You can still preview your page prior to approval{/ts}:</p>\n      <ol>\n       <li><a href=\"{$loginUrl}\">{ts}Login to your account{/ts}</a></li>\n       <li><a href=\"{$pcpInfoURL}\">{ts}Click this link{/ts}</a></li>\n      </ol>\n     </td>\n    </tr>\n\n   {/if}\n\n   {if $pcpNotifyEmailAddress}\n    <tr>\n     <td>\n      <p>{ts}Questions? Send email to{/ts}: {$pcpNotifyEmailAddress}</p>\n     </td>\n    </tr>\n   {/if}\n\n </table>\n</center>\n\n</body>\n</html>\n',1,493,0,1),(17,'Events - Registration Confirmation and Receipt (off-line)','{ts}Event Confirmation{/ts} - {$event.title}\n','{if $event.confirm_email_text AND (not $isOnWaitlist AND not $isRequireApproval)}\n{$event.confirm_email_text}\n{/if}\n\n{if $isOnWaitlist}\n==========================================================={if $participantCount }===================={/if}\n\n{ts}You have been added to the WAIT LIST for this event.{/ts}\n\n{if $isPrimary}\n{ts}If space becomes available you will receive an email with\na link to a web page where you can complete your registration.{/ts}\n\n{/if}\n==========================================================={if $participantCount }===================={/if}\n\n{elseif $isRequireApproval}\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Your registration has been submitted.{/ts}\n\n{if $isPrimary}\n{ts}Once your registration has been reviewed, you will receive\nan email with a link to a web page where you can complete the\nregistration process.{/ts}\n\n{/if}\n==========================================================={if $participantCount }===================={/if}\n\n{elseif $is_pay_later}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$pay_later_receipt}\n==========================================================={if $participantCount }===================={/if}\n\n{else}\n\n{ts}Please print this confirmation for your records.{/ts}\n{/if}\n\n\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Event Information and Location{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$event.event_title}\n{$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n\n{if $event.participant_role neq \'Attendee\' and $defaultRole}\n{ts}Participant Role{/ts}: {$event.participant_role}\n{/if}\n\n{if $isShowLocation}\n{if $location.address.1.name}\n\n{$location.address.1.name}\n{/if}\n{if $location.address.1.street_address}{$location.address.1.street_address}\n{/if}\n{if $location.address.1.supplemental_address_1}{$location.address.1.supplemental_address_1}\n{/if}\n{if $location.address.1.supplemental_address_2}{$location.address.1.supplemental_address_2}\n{/if}\n{if $location.address.1.city}{$location.address.1.city} {$location.address.1.postal_code}{if $location.address.1.postal_code_suffix} - {$location.address.1.postal_code_suffix}{/if}\n{/if}\n\n{/if}{*End of isShowLocation condition*}\n\n{if $location.phone.1.phone || $location.email.1.email}\n\n{ts}Event Contacts:{/ts}\n{foreach from=$location.phone item=phone}\n{if $phone.phone}\n\n{if $phone.phone_type}{$phone.phone_type_display}{else}{ts}Phone{/ts}{/if}: {$phone.phone}{/if}\n{/foreach}\n{foreach from=$location.email item=eventEmail}\n{if $eventEmail.email}\n\n{ts}Email{/ts}: {$eventEmail.email}{/if}{/foreach}\n{/if}\n\n{capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n{ts}Download iCalendar File:{/ts} {$icalFeed}\n{if $email}\n\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Registered Email{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$email}\n{/if}\n{if $event.is_monetary} {* This section for Paid events only.*}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$event.fee_label}\n==========================================================={if $participantCount }===================={/if}\n\n{if $lineItem}{foreach from=$lineItem item=value key=priceset}\n\n{if $value neq \'skip\'}\n{if $isPrimary}\n{if $lineItem|@count GT 1} {* Header for multi participant registration cases. *}\n{ts 1=$priceset+1}Participant %1{/ts}\n{/if}\n{/if}\n---------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{capture assign=ts_item}{ts}Item{/ts}{/capture}\n{capture assign=ts_qty}{ts}Qty{/ts}{/capture}\n{capture assign=ts_each}{ts}Each{/ts}{/capture}\n{capture assign=ts_total}{ts}Total{/ts}{/capture}\n{capture assign=ts_participant_total}{if $participantCount }{ts}Total Participants{/ts}{/if}{/capture}\n{$ts_item|string_format:\"%-30s\"} {$ts_qty|string_format:\"%5s\"} {$ts_each|string_format:\"%10s\"} {$ts_total|string_format:\"%10s\"} {$ts_participant_total|string_format:\"%10s\"}\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{foreach from=$value item=line}\n{if $participantCount }{capture assign=ts_participant_count}{$line.participant_count}{/capture}{/if}\n{$line.description|truncate:30:\"...\"|string_format:\"%-30s\"} {$line.qty|string_format:\"%5s\"} {$line.unit_price|crmMoney|string_format:\"%10s\"} {$line.line_total|crmMoney|string_format:\"%10s\"} {$ts_participant_count|string_format:\"%10s\"}\n{/foreach}\n{/if}\n{/foreach}\n{/if}\n{if $amount && !$lineItem}\n{foreach from=$amount item=amnt key=level}{$amnt.amount|crmMoney} {$amnt.label}\n{/foreach}\n{/if}\n{if $isPrimary }\n\n{ts}Total Amount{/ts}: {$totalAmount|crmMoney} {if $hookDiscount.message}({$hookDiscount.message}){/if}\n\n{if $participantCount }\n      {assign var=\"count\" value= 0}\n      {foreach from=$lineItem item=pcount}\n      {foreach from=$pcount item=p_count}\n      {assign var=\"count\" value=$count+$p_count.participant_count}\n      {/foreach}\n      {/foreach}\n\n{ts}Total Participants{/ts}: {$count}\n{/if}\n   \n{if $is_pay_later }\n\n==========================================================={if $participantCount }===================={/if}\n\n{$pay_later_receipt}\n==========================================================={if $participantCount }===================={/if}\n\n{/if}\n\n{if $register_date}\n{ts}Registration Date{/ts}: {$register_date|crmDate}\n{/if}\n{if $receive_date}\n{ts}Transaction Date{/ts}: {$receive_date|crmDate}\n{/if}\n{if $contributionTypeName}\n{ts}Contribution Type{/ts}: {$contributionTypeName}\n{/if}\n{if $trxn_id}\n{ts}Transaction #{/ts}: {$trxn_id}\n{/if}\n{if $paidBy}\n{ts}Paid By{/ts}: {$paidBy}\n{/if}\n{if $checkNumber}\n{ts}Check Number{/ts}: {$checkNumber}\n{/if}\n{if $contributeMode ne \'notify\' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}\n\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Billing Name and Address{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$billingName}\n{$address}\n{/if}\n\n{if $contributeMode eq \'direct\' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}\n===========================================================\n{ts}Credit Card Information{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$credit_card_type}\n{$credit_card_number}\n{ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n{/if}\n{/if}\n{/if} {* End of conditional section for Paid events *}\n\n{if $customPre}\n==========================================================={if $participantCount }===================={/if}\n\n{$customPre_grouptitle}\n==========================================================={if $participantCount }===================={/if}\n\n{foreach from=$customPre item=value key=customName}\n{if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n{$customName}: {$value}\n{/if}\n{/foreach}\n{/if}\n\n{if $customPost}\n==========================================================={if $participantCount }===================={/if}\n\n{$customPost_grouptitle}\n==========================================================={if $participantCount }===================={/if}\n\n{foreach from=$customPost item=value key=customName}\n{if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n{$customName}: {$value}\n{/if}\n{/foreach}\n{/if}\n{if $customProfile}\n\n{foreach from=$customProfile item=value key=customName}\n==========================================================={if $participantCount }===================={/if}\n\n{ts 1=$customName+1}Participant Information - Participant %1{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{foreach from=$value item=val key=field}\n{if $field eq \'additionalCustomPre\' or $field eq \'additionalCustomPost\' }\n{if $field eq \'additionalCustomPre\' }\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{$additionalCustomPre_grouptitle}\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{else}\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{$additionalCustomPost_grouptitle}\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{/if}\n{foreach from=$val item=v key=f}\n{$f}: {$v}\n{/foreach}\n{/if}\n{/foreach}\n{/foreach}\n{/if}\n{if $customGroup}\n{foreach from=$customGroup item=value key=customName}\n=========================================================={if $participantCount }===================={/if}\n\n{$customName}\n=========================================================={if $participantCount }===================={/if}\n\n{foreach from=$value item=v key=n}\n{$n}: {$v}\n{/foreach}\n{/foreach}\n{/if}\n\n\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n\n    {if $event.confirm_email_text AND (not $isOnWaitlist AND not $isRequireApproval)}\n     <p>{$event.confirm_email_text|htmlize}</p>\n    {/if}\n\n    {if $isOnWaitlist}\n     <p>{ts}You have been added to the WAIT LIST for this event.{/ts}</p>\n     {if $isPrimary}\n       <p>{ts}If space becomes available you will receive an email with\na link to a web page where you can complete your registration.{/ts}</p>\n     {/if}\n    {elseif $isRequireApproval}\n     <p>{ts}Your registration has been submitted.{/ts}</p>\n     {if $isPrimary}\n      <p>{ts}Once your registration has been reviewed, you will receive\nan email with a link to a web page where you can complete the\nregistration process.{/ts}</p>\n     {/if}\n    {elseif $is_pay_later}\n     <p>{$pay_later_receipt}</p> {* FIXME: this might be text rather than HTML *}\n    {else}\n     <p>{ts}Please print this confirmation for your records.{/ts}</p>\n    {/if}\n\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Event Information and Location{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       {$event.event_title}<br />\n       {$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n      </td>\n     </tr>\n\n     {if $event.participant_role neq \'Attendee\' and $defaultRole}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Participant Role{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$event.participant_role}\n       </td>\n      </tr>\n     {/if}\n\n     {if $isShowLocation}\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {if $location.address.1.name}\n         {$location.address.1.name}<br />\n        {/if}\n        {if $location.address.1.street_address}\n         {$location.address.1.street_address}<br />\n        {/if}\n        {if $location.address.1.supplemental_address_1}\n         {$location.address.1.supplemental_address_1}<br />\n        {/if}\n        {if $location.address.1.supplemental_address_2}\n         {$location.address.1.supplemental_address_2}<br />\n        {/if}\n        {if $location.address.1.city}\n         {$location.address.1.city} {$location.address.1.postal_code}{if $location.address.1.postal_code_suffix} - {$location.address.1.postal_code_suffix}{/if}<br />\n        {/if}\n       </td>\n      </tr>\n     {/if}\n\n     {if $location.phone.1.phone || $location.email.1.email}\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {ts}Event Contacts:{/ts}\n       </td>\n      </tr>\n      {foreach from=$location.phone item=phone}\n       {if $phone.phone}\n        <tr>\n         <td {$labelStyle}>\n          {if $phone.phone_type}\n           {$phone.phone_type_display}\n          {else}\n           {ts}Phone{/ts}\n          {/if}\n         </td>\n         <td {$valueStyle}>\n          {$phone.phone}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n      {foreach from=$location.email item=eventEmail}\n       {if $eventEmail.email}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Email{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$eventEmail.email}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       {capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n       <a href=\"{$icalFeed}\">{ts}Download iCalendar File{/ts}</a>\n      </td>\n     </tr>\n     {if $email}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Registered Email{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$email}\n       </td>\n      </tr>\n     {/if}\n\n\n     {if $event.is_monetary}\n\n      <tr>\n       <th {$headerStyle}>\n        {$event.fee_label}\n       </th>\n      </tr>\n\n      {if $lineItem}\n       {foreach from=$lineItem item=value key=priceset}\n        {if $value neq \'skip\'}\n         {if $isPrimary}\n          {if $lineItem|@count GT 1} {* Header for multi participant registration cases. *}\n           <tr>\n            <td colspan=\"2\" {$labelStyle}>\n             {ts 1=$priceset+1}Participant %1{/ts}\n            </td>\n           </tr>\n          {/if}\n         {/if}\n         <tr>\n          <td colspan=\"2\" {$valueStyle}>\n           <table> {* FIXME: style this table so that it looks like the text version (justification, etc.) *}\n            <tr>\n             <th>{ts}Item{/ts}</th>\n             <th>{ts}Qty{/ts}</th>\n             <th>{ts}Each{/ts}</th>\n             <th>{ts}Total{/ts}</th>\n	     {if  $participantCount }<th>{ts}Total Participants{/ts}</th>{/if}\n            </tr>\n            {foreach from=$value item=line}\n             <tr>\n              <td>\n               {$line.description|truncate:30:\"...\"}\n              </td>\n              <td>\n               {$line.qty}\n              </td>\n              <td>\n               {$line.unit_price|crmMoney}\n              </td>\n              <td>\n               {$line.line_total|crmMoney}\n              </td>\n	      {if  $participantCount }\n	      <td>\n		{$line.participant_count}\n              </td>\n	      {/if}\n             </tr>\n            {/foreach}\n           </table>\n          </td>\n         </tr>\n        {/if}\n       {/foreach}\n      {/if}\n\n      {if $amount && !$lineItem}\n       {foreach from=$amount item=amnt key=level}\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          {$amnt.amount|crmMoney} {$amnt.label}\n         </td>\n        </tr>\n       {/foreach}\n      {/if}\n\n      {if $isPrimary}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Total Amount{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$totalAmount|crmMoney} {if $hookDiscount.message}({$hookDiscount.message}){/if}\n        </td>\n       </tr>\n       {if $participantCount }\n     <tr>\n       <td {$labelStyle}> \n	 {ts}Total Participants{/ts}</td>   \n       <td {$valueStyle}>\n	 {assign var=\"count\" value= 0}\n	 {foreach from=$lineItem item=pcount}\n	 {foreach from=$pcount item=p_count}\n	 {assign var=\"count\" value=$count+$p_count.participant_count}\n	 {/foreach}\n	 {/foreach}\n	 {$count}\n       </td>\n     </tr>\n     {/if}\n       {if $is_pay_later}\n        <tr>\n         <td colspan=\"2\" {$labelStyle}>\n          {$pay_later_receipt}\n         </td>\n        </tr>\n       {/if}\n\n       {if $register_date}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Registration Date{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$register_date|crmDate}\n         </td>\n        </tr>\n       {/if}\n\n       {if $receive_date}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Transaction Date{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$receive_date|crmDate}\n         </td>\n        </tr>\n       {/if}\n\n       {if $contributionTypeName}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Contribution Type{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$contributionTypeName}\n         </td>\n        </tr>\n       {/if}\n\n       {if $trxn_id}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Transaction #{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$trxn_id}\n         </td>\n        </tr>\n       {/if}\n\n       {if $paidBy}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Paid By{/ts}\n         </td>\n         <td {$valueStyle}>\n         {$paidBy}\n         </td>\n        </tr>\n       {/if}\n\n       {if $checkNumber}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Check Number{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$checkNumber}\n         </td>\n        </tr>\n       {/if}\n\n       {if $contributeMode ne \'notify\' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}\n        <tr>\n         <th {$headerStyle}>\n          {ts}Billing Name and Address{/ts}\n         </th>\n        </tr>\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          {$billingName}<br />\n          {$address|nl2br}\n         </td>\n        </tr>\n       {/if}\n\n       {if $contributeMode eq \'direct\' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}\n        <tr>\n         <th {$headerStyle}>\n          {ts}Credit Card Information{/ts}\n         </th>\n        </tr>\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          {$credit_card_type}<br />\n          {$credit_card_number}<br />\n          {ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n         </td>\n        </tr>\n       {/if}\n\n      {/if}\n\n     {/if} {* End of conditional section for Paid events *}\n\n     {if $customPre}\n      <tr>\n       <th {$headerStyle}>\n        {$customPre_grouptitle}\n       </th>\n      </tr>\n      {foreach from=$customPre item=value key=customName}\n       {if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n        <tr>\n         <td {$labelStyle}>\n          {$customName}\n         </td>\n         <td {$valueStyle}>\n          {$value}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {if $customPost}\n      <tr>\n       <th {$headerStyle}>\n        {$customPost_grouptitle}\n       </th>\n      </tr>\n      {foreach from=$customPost item=value key=customName}\n       {if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n        <tr>\n         <td {$labelStyle}>\n          {$customName}\n         </td>\n         <td {$valueStyle}>\n          {$value}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {if $customProfile}\n      {foreach from=$customProfile item=value key=customName}\n       <tr>\n        <th {$headerStyle}>\n         {ts 1=$customName+1}Participant Information - Participant %1{/ts}\n        </th>\n       <tr>\n       {foreach from=$value item=val key=field}\n        {if $field eq \'additionalCustomPre\' or $field eq \'additionalCustomPost\'}\n         <tr>\n          <td colspan=\"2\" {$labelStyle}>\n           {if $field eq \'additionalCustomPre\'}\n            {$additionalCustomPre_grouptitle}\n           {else}\n            {$additionalCustomPost_grouptitle}\n           {/if}\n          </td>\n         </tr>\n         {foreach from=$val item=v key=f}\n          <tr>\n           <td {$labelStyle}>\n            {$f}\n           </td>\n           <td {$valueStyle}>\n            {$v}\n           </td>\n          </tr>\n         {/foreach}\n        {/if}\n       {/foreach}\n      {/foreach}\n     {/if}\n\n     {if $customGroup}\n      {foreach from=$customGroup item=value key=customName}\n       <tr>\n        <th {$headerStyle}>\n         {$customName}\n        </th>\n       </tr>\n       {foreach from=$value item=v key=n}\n        <tr>\n         <td {$labelStyle}>\n          {$n}\n         </td>\n         <td {$valueStyle}>\n          {$v}\n         </td>\n        </tr>\n       {/foreach}\n      {/foreach}\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,494,1,0),(18,'Events - Registration Confirmation and Receipt (off-line)','{ts}Event Confirmation{/ts} - {$event.title}\n','{if $event.confirm_email_text AND (not $isOnWaitlist AND not $isRequireApproval)}\n{$event.confirm_email_text}\n{/if}\n\n{if $isOnWaitlist}\n==========================================================={if $participantCount }===================={/if}\n\n{ts}You have been added to the WAIT LIST for this event.{/ts}\n\n{if $isPrimary}\n{ts}If space becomes available you will receive an email with\na link to a web page where you can complete your registration.{/ts}\n\n{/if}\n==========================================================={if $participantCount }===================={/if}\n\n{elseif $isRequireApproval}\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Your registration has been submitted.{/ts}\n\n{if $isPrimary}\n{ts}Once your registration has been reviewed, you will receive\nan email with a link to a web page where you can complete the\nregistration process.{/ts}\n\n{/if}\n==========================================================={if $participantCount }===================={/if}\n\n{elseif $is_pay_later}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$pay_later_receipt}\n==========================================================={if $participantCount }===================={/if}\n\n{else}\n\n{ts}Please print this confirmation for your records.{/ts}\n{/if}\n\n\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Event Information and Location{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$event.event_title}\n{$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n\n{if $event.participant_role neq \'Attendee\' and $defaultRole}\n{ts}Participant Role{/ts}: {$event.participant_role}\n{/if}\n\n{if $isShowLocation}\n{if $location.address.1.name}\n\n{$location.address.1.name}\n{/if}\n{if $location.address.1.street_address}{$location.address.1.street_address}\n{/if}\n{if $location.address.1.supplemental_address_1}{$location.address.1.supplemental_address_1}\n{/if}\n{if $location.address.1.supplemental_address_2}{$location.address.1.supplemental_address_2}\n{/if}\n{if $location.address.1.city}{$location.address.1.city} {$location.address.1.postal_code}{if $location.address.1.postal_code_suffix} - {$location.address.1.postal_code_suffix}{/if}\n{/if}\n\n{/if}{*End of isShowLocation condition*}\n\n{if $location.phone.1.phone || $location.email.1.email}\n\n{ts}Event Contacts:{/ts}\n{foreach from=$location.phone item=phone}\n{if $phone.phone}\n\n{if $phone.phone_type}{$phone.phone_type_display}{else}{ts}Phone{/ts}{/if}: {$phone.phone}{/if}\n{/foreach}\n{foreach from=$location.email item=eventEmail}\n{if $eventEmail.email}\n\n{ts}Email{/ts}: {$eventEmail.email}{/if}{/foreach}\n{/if}\n\n{capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n{ts}Download iCalendar File:{/ts} {$icalFeed}\n{if $email}\n\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Registered Email{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$email}\n{/if}\n{if $event.is_monetary} {* This section for Paid events only.*}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$event.fee_label}\n==========================================================={if $participantCount }===================={/if}\n\n{if $lineItem}{foreach from=$lineItem item=value key=priceset}\n\n{if $value neq \'skip\'}\n{if $isPrimary}\n{if $lineItem|@count GT 1} {* Header for multi participant registration cases. *}\n{ts 1=$priceset+1}Participant %1{/ts}\n{/if}\n{/if}\n---------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{capture assign=ts_item}{ts}Item{/ts}{/capture}\n{capture assign=ts_qty}{ts}Qty{/ts}{/capture}\n{capture assign=ts_each}{ts}Each{/ts}{/capture}\n{capture assign=ts_total}{ts}Total{/ts}{/capture}\n{capture assign=ts_participant_total}{if $participantCount }{ts}Total Participants{/ts}{/if}{/capture}\n{$ts_item|string_format:\"%-30s\"} {$ts_qty|string_format:\"%5s\"} {$ts_each|string_format:\"%10s\"} {$ts_total|string_format:\"%10s\"} {$ts_participant_total|string_format:\"%10s\"}\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{foreach from=$value item=line}\n{if $participantCount }{capture assign=ts_participant_count}{$line.participant_count}{/capture}{/if}\n{$line.description|truncate:30:\"...\"|string_format:\"%-30s\"} {$line.qty|string_format:\"%5s\"} {$line.unit_price|crmMoney|string_format:\"%10s\"} {$line.line_total|crmMoney|string_format:\"%10s\"} {$ts_participant_count|string_format:\"%10s\"}\n{/foreach}\n{/if}\n{/foreach}\n{/if}\n{if $amount && !$lineItem}\n{foreach from=$amount item=amnt key=level}{$amnt.amount|crmMoney} {$amnt.label}\n{/foreach}\n{/if}\n{if $isPrimary }\n\n{ts}Total Amount{/ts}: {$totalAmount|crmMoney} {if $hookDiscount.message}({$hookDiscount.message}){/if}\n\n{if $participantCount }\n      {assign var=\"count\" value= 0}\n      {foreach from=$lineItem item=pcount}\n      {foreach from=$pcount item=p_count}\n      {assign var=\"count\" value=$count+$p_count.participant_count}\n      {/foreach}\n      {/foreach}\n\n{ts}Total Participants{/ts}: {$count}\n{/if}\n   \n{if $is_pay_later }\n\n==========================================================={if $participantCount }===================={/if}\n\n{$pay_later_receipt}\n==========================================================={if $participantCount }===================={/if}\n\n{/if}\n\n{if $register_date}\n{ts}Registration Date{/ts}: {$register_date|crmDate}\n{/if}\n{if $receive_date}\n{ts}Transaction Date{/ts}: {$receive_date|crmDate}\n{/if}\n{if $contributionTypeName}\n{ts}Contribution Type{/ts}: {$contributionTypeName}\n{/if}\n{if $trxn_id}\n{ts}Transaction #{/ts}: {$trxn_id}\n{/if}\n{if $paidBy}\n{ts}Paid By{/ts}: {$paidBy}\n{/if}\n{if $checkNumber}\n{ts}Check Number{/ts}: {$checkNumber}\n{/if}\n{if $contributeMode ne \'notify\' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}\n\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Billing Name and Address{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$billingName}\n{$address}\n{/if}\n\n{if $contributeMode eq \'direct\' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}\n===========================================================\n{ts}Credit Card Information{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$credit_card_type}\n{$credit_card_number}\n{ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n{/if}\n{/if}\n{/if} {* End of conditional section for Paid events *}\n\n{if $customPre}\n==========================================================={if $participantCount }===================={/if}\n\n{$customPre_grouptitle}\n==========================================================={if $participantCount }===================={/if}\n\n{foreach from=$customPre item=value key=customName}\n{if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n{$customName}: {$value}\n{/if}\n{/foreach}\n{/if}\n\n{if $customPost}\n==========================================================={if $participantCount }===================={/if}\n\n{$customPost_grouptitle}\n==========================================================={if $participantCount }===================={/if}\n\n{foreach from=$customPost item=value key=customName}\n{if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n{$customName}: {$value}\n{/if}\n{/foreach}\n{/if}\n{if $customProfile}\n\n{foreach from=$customProfile item=value key=customName}\n==========================================================={if $participantCount }===================={/if}\n\n{ts 1=$customName+1}Participant Information - Participant %1{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{foreach from=$value item=val key=field}\n{if $field eq \'additionalCustomPre\' or $field eq \'additionalCustomPost\' }\n{if $field eq \'additionalCustomPre\' }\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{$additionalCustomPre_grouptitle}\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{else}\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{$additionalCustomPost_grouptitle}\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{/if}\n{foreach from=$val item=v key=f}\n{$f}: {$v}\n{/foreach}\n{/if}\n{/foreach}\n{/foreach}\n{/if}\n{if $customGroup}\n{foreach from=$customGroup item=value key=customName}\n=========================================================={if $participantCount }===================={/if}\n\n{$customName}\n=========================================================={if $participantCount }===================={/if}\n\n{foreach from=$value item=v key=n}\n{$n}: {$v}\n{/foreach}\n{/foreach}\n{/if}\n\n\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n\n    {if $event.confirm_email_text AND (not $isOnWaitlist AND not $isRequireApproval)}\n     <p>{$event.confirm_email_text|htmlize}</p>\n    {/if}\n\n    {if $isOnWaitlist}\n     <p>{ts}You have been added to the WAIT LIST for this event.{/ts}</p>\n     {if $isPrimary}\n       <p>{ts}If space becomes available you will receive an email with\na link to a web page where you can complete your registration.{/ts}</p>\n     {/if}\n    {elseif $isRequireApproval}\n     <p>{ts}Your registration has been submitted.{/ts}</p>\n     {if $isPrimary}\n      <p>{ts}Once your registration has been reviewed, you will receive\nan email with a link to a web page where you can complete the\nregistration process.{/ts}</p>\n     {/if}\n    {elseif $is_pay_later}\n     <p>{$pay_later_receipt}</p> {* FIXME: this might be text rather than HTML *}\n    {else}\n     <p>{ts}Please print this confirmation for your records.{/ts}</p>\n    {/if}\n\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Event Information and Location{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       {$event.event_title}<br />\n       {$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n      </td>\n     </tr>\n\n     {if $event.participant_role neq \'Attendee\' and $defaultRole}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Participant Role{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$event.participant_role}\n       </td>\n      </tr>\n     {/if}\n\n     {if $isShowLocation}\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {if $location.address.1.name}\n         {$location.address.1.name}<br />\n        {/if}\n        {if $location.address.1.street_address}\n         {$location.address.1.street_address}<br />\n        {/if}\n        {if $location.address.1.supplemental_address_1}\n         {$location.address.1.supplemental_address_1}<br />\n        {/if}\n        {if $location.address.1.supplemental_address_2}\n         {$location.address.1.supplemental_address_2}<br />\n        {/if}\n        {if $location.address.1.city}\n         {$location.address.1.city} {$location.address.1.postal_code}{if $location.address.1.postal_code_suffix} - {$location.address.1.postal_code_suffix}{/if}<br />\n        {/if}\n       </td>\n      </tr>\n     {/if}\n\n     {if $location.phone.1.phone || $location.email.1.email}\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {ts}Event Contacts:{/ts}\n       </td>\n      </tr>\n      {foreach from=$location.phone item=phone}\n       {if $phone.phone}\n        <tr>\n         <td {$labelStyle}>\n          {if $phone.phone_type}\n           {$phone.phone_type_display}\n          {else}\n           {ts}Phone{/ts}\n          {/if}\n         </td>\n         <td {$valueStyle}>\n          {$phone.phone}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n      {foreach from=$location.email item=eventEmail}\n       {if $eventEmail.email}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Email{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$eventEmail.email}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       {capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n       <a href=\"{$icalFeed}\">{ts}Download iCalendar File{/ts}</a>\n      </td>\n     </tr>\n     {if $email}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Registered Email{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$email}\n       </td>\n      </tr>\n     {/if}\n\n\n     {if $event.is_monetary}\n\n      <tr>\n       <th {$headerStyle}>\n        {$event.fee_label}\n       </th>\n      </tr>\n\n      {if $lineItem}\n       {foreach from=$lineItem item=value key=priceset}\n        {if $value neq \'skip\'}\n         {if $isPrimary}\n          {if $lineItem|@count GT 1} {* Header for multi participant registration cases. *}\n           <tr>\n            <td colspan=\"2\" {$labelStyle}>\n             {ts 1=$priceset+1}Participant %1{/ts}\n            </td>\n           </tr>\n          {/if}\n         {/if}\n         <tr>\n          <td colspan=\"2\" {$valueStyle}>\n           <table> {* FIXME: style this table so that it looks like the text version (justification, etc.) *}\n            <tr>\n             <th>{ts}Item{/ts}</th>\n             <th>{ts}Qty{/ts}</th>\n             <th>{ts}Each{/ts}</th>\n             <th>{ts}Total{/ts}</th>\n	     {if  $participantCount }<th>{ts}Total Participants{/ts}</th>{/if}\n            </tr>\n            {foreach from=$value item=line}\n             <tr>\n              <td>\n               {$line.description|truncate:30:\"...\"}\n              </td>\n              <td>\n               {$line.qty}\n              </td>\n              <td>\n               {$line.unit_price|crmMoney}\n              </td>\n              <td>\n               {$line.line_total|crmMoney}\n              </td>\n	      {if  $participantCount }\n	      <td>\n		{$line.participant_count}\n              </td>\n	      {/if}\n             </tr>\n            {/foreach}\n           </table>\n          </td>\n         </tr>\n        {/if}\n       {/foreach}\n      {/if}\n\n      {if $amount && !$lineItem}\n       {foreach from=$amount item=amnt key=level}\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          {$amnt.amount|crmMoney} {$amnt.label}\n         </td>\n        </tr>\n       {/foreach}\n      {/if}\n\n      {if $isPrimary}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Total Amount{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$totalAmount|crmMoney} {if $hookDiscount.message}({$hookDiscount.message}){/if}\n        </td>\n       </tr>\n       {if $participantCount }\n     <tr>\n       <td {$labelStyle}> \n	 {ts}Total Participants{/ts}</td>   \n       <td {$valueStyle}>\n	 {assign var=\"count\" value= 0}\n	 {foreach from=$lineItem item=pcount}\n	 {foreach from=$pcount item=p_count}\n	 {assign var=\"count\" value=$count+$p_count.participant_count}\n	 {/foreach}\n	 {/foreach}\n	 {$count}\n       </td>\n     </tr>\n     {/if}\n       {if $is_pay_later}\n        <tr>\n         <td colspan=\"2\" {$labelStyle}>\n          {$pay_later_receipt}\n         </td>\n        </tr>\n       {/if}\n\n       {if $register_date}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Registration Date{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$register_date|crmDate}\n         </td>\n        </tr>\n       {/if}\n\n       {if $receive_date}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Transaction Date{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$receive_date|crmDate}\n         </td>\n        </tr>\n       {/if}\n\n       {if $contributionTypeName}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Contribution Type{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$contributionTypeName}\n         </td>\n        </tr>\n       {/if}\n\n       {if $trxn_id}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Transaction #{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$trxn_id}\n         </td>\n        </tr>\n       {/if}\n\n       {if $paidBy}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Paid By{/ts}\n         </td>\n         <td {$valueStyle}>\n         {$paidBy}\n         </td>\n        </tr>\n       {/if}\n\n       {if $checkNumber}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Check Number{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$checkNumber}\n         </td>\n        </tr>\n       {/if}\n\n       {if $contributeMode ne \'notify\' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}\n        <tr>\n         <th {$headerStyle}>\n          {ts}Billing Name and Address{/ts}\n         </th>\n        </tr>\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          {$billingName}<br />\n          {$address|nl2br}\n         </td>\n        </tr>\n       {/if}\n\n       {if $contributeMode eq \'direct\' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}\n        <tr>\n         <th {$headerStyle}>\n          {ts}Credit Card Information{/ts}\n         </th>\n        </tr>\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          {$credit_card_type}<br />\n          {$credit_card_number}<br />\n          {ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n         </td>\n        </tr>\n       {/if}\n\n      {/if}\n\n     {/if} {* End of conditional section for Paid events *}\n\n     {if $customPre}\n      <tr>\n       <th {$headerStyle}>\n        {$customPre_grouptitle}\n       </th>\n      </tr>\n      {foreach from=$customPre item=value key=customName}\n       {if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n        <tr>\n         <td {$labelStyle}>\n          {$customName}\n         </td>\n         <td {$valueStyle}>\n          {$value}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {if $customPost}\n      <tr>\n       <th {$headerStyle}>\n        {$customPost_grouptitle}\n       </th>\n      </tr>\n      {foreach from=$customPost item=value key=customName}\n       {if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n        <tr>\n         <td {$labelStyle}>\n          {$customName}\n         </td>\n         <td {$valueStyle}>\n          {$value}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {if $customProfile}\n      {foreach from=$customProfile item=value key=customName}\n       <tr>\n        <th {$headerStyle}>\n         {ts 1=$customName+1}Participant Information - Participant %1{/ts}\n        </th>\n       <tr>\n       {foreach from=$value item=val key=field}\n        {if $field eq \'additionalCustomPre\' or $field eq \'additionalCustomPost\'}\n         <tr>\n          <td colspan=\"2\" {$labelStyle}>\n           {if $field eq \'additionalCustomPre\'}\n            {$additionalCustomPre_grouptitle}\n           {else}\n            {$additionalCustomPost_grouptitle}\n           {/if}\n          </td>\n         </tr>\n         {foreach from=$val item=v key=f}\n          <tr>\n           <td {$labelStyle}>\n            {$f}\n           </td>\n           <td {$valueStyle}>\n            {$v}\n           </td>\n          </tr>\n         {/foreach}\n        {/if}\n       {/foreach}\n      {/foreach}\n     {/if}\n\n     {if $customGroup}\n      {foreach from=$customGroup item=value key=customName}\n       <tr>\n        <th {$headerStyle}>\n         {$customName}\n        </th>\n       </tr>\n       {foreach from=$value item=v key=n}\n        <tr>\n         <td {$labelStyle}>\n          {$n}\n         </td>\n         <td {$valueStyle}>\n          {$v}\n         </td>\n        </tr>\n       {/foreach}\n      {/foreach}\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,494,0,1),(19,'Events - Registration Confirmation and Receipt (on-line)','{if $isOnWaitlist}{ts}Wait List Confirmation{/ts}{else}{ts}Registration Confirmation{/ts}{/if} - {$title}\n','{if $event.confirm_email_text AND (not $isOnWaitlist AND not $isRequireApproval)}\n{$event.confirm_email_text}\n{/if}\n\n{if $isOnWaitlist}\n==========================================================={if $participantCount }===================={/if}\n\n{ts}You have been added to the WAIT LIST for this event.{/ts}\n\n{if $isPrimary}\n{ts}If space becomes available you will receive an email with\na link to a web page where you can complete your registration.{/ts}\n{/if}\n==========================================================={if $participantCount }===================={/if}\n\n{elseif $isRequireApproval}\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Your registration has been submitted.{/ts}\n\n{if $isPrimary}\n{ts}Once your registration has been reviewed, you will receive\nan email with a link to a web page where you can complete the\nregistration process.{/ts}\n\n{/if}\n==========================================================={if $participantCount }===================={/if}\n\n{elseif $is_pay_later}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$pay_later_receipt}\n==========================================================={if $participantCount }===================={/if}\n\n{else}\n\n{ts}Please print this confirmation for your records.{/ts}\n{/if}\n\n\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Event Information and Location{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$event.event_title}\n{$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n\n{if $event.participant_role neq \'Attendee\' and $defaultRole}\n{ts}Participant Role{/ts}: {$event.participant_role}\n{/if}\n\n{if $isShowLocation}\n{if $location.address.1.name}\n\n{$location.address.1.name}\n{/if}\n{if $location.address.1.street_address}{$location.address.1.street_address}\n{/if}\n{if $location.address.1.supplemental_address_1}{$location.address.1.supplemental_address_1}\n{/if}\n{if $location.address.1.supplemental_address_2}{$location.address.1.supplemental_address_2}\n{/if}\n{if $location.address.1.city}{$location.address.1.city} {$location.address.1.postal_code}{if $location.address.1.postal_code_suffix} - {$location.address.1.postal_code_suffix}{/if}\n{/if}\n\n{/if}{*End of isShowLocation condition*}\n\n{if $location.phone.1.phone || $location.email.1.email}\n\n{ts}Event Contacts:{/ts}\n{foreach from=$location.phone item=phone}\n{if $phone.phone}\n\n{if $phone.phone_type}{$phone.phone_type_display}{else}{ts}Phone{/ts}{/if}: {$phone.phone}{/if}\n{/foreach}\n{foreach from=$location.email item=eventEmail}\n{if $eventEmail.email}\n\n{ts}Email{/ts}: {$eventEmail.email}{/if}{/foreach}\n{/if}\n\n{capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n{ts}Download iCalendar File:{/ts} {$icalFeed}\n{if $email}\n\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Registered Email{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$email}\n{/if}\n{if $event.is_monetary} {* This section for Paid events only.*}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$event.fee_label}\n==========================================================={if $participantCount }===================={/if}\n\n{if $lineItem}{foreach from=$lineItem item=value key=priceset}\n\n{if $value neq \'skip\'}\n{if $isPrimary}\n{if $lineItem|@count GT 1} {* Header for multi participant registration cases. *}\n{ts 1=$priceset+1}Participant %1{/ts} {$part.$priceset.info}\n\n{/if}\n{/if}\n-----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{capture assign=ts_item}{ts}Item{/ts}{/capture}\n{capture assign=ts_qty}{ts}Qty{/ts}{/capture}\n{capture assign=ts_each}{ts}Each{/ts}{/capture}\n{capture assign=ts_total}{ts}Total{/ts}{/capture}\n{if $participantCount }{capture assign=ts_participant_total}{ts}Total Participants{/ts}{/capture}{/if}\n{$ts_item|string_format:\"%-30s\"} {$ts_qty|string_format:\"%5s\"} {$ts_each|string_format:\"%10s\"} {$ts_total|string_format:\"%10s\"} {$ts_participant_total|string_format:\"%10s\"}\n-----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{foreach from=$value item=line}\n{if $participantCount }{capture assign=ts_participant_count}{$line.participant_count}{/capture}{/if}\n{$line.description|truncate:30:\"...\"|string_format:\"%-30s\"} {$line.qty|string_format:\"%5s\"} {$line.unit_price|crmMoney|string_format:\"%10s\"} {$line.line_total|crmMoney|string_format:\"%10s\"}{$ts_participant_count|string_format:\"%10s\"}\n{/foreach}\n{/if}\n{/foreach}\n{/if}\n{if $amount && !$lineItem}\n{foreach from=$amount item=amnt key=level}{$amnt.amount|crmMoney} {$amnt.label}\n{/foreach}\n{/if}\n{if $isPrimary }\n\n{ts}Total Amount{/ts}: {$totalAmount|crmMoney} {if $hookDiscount.message}({$hookDiscount.message}){/if}\n\n{if $participantCount }\n      {assign var=\"count\" value= 0}\n      {foreach from=$lineItem item=pcount}\n      {foreach from=$pcount item=p_count}\n      {assign var=\"count\" value=$count+$p_count.participant_count}\n      {/foreach}\n      {/foreach}\n\n{ts}Total Participants{/ts}: {$count}\n{/if}\n  \n{if $is_pay_later }\n\n==========================================================={if $participantCount }===================={/if}\n\n{$pay_later_receipt}\n==========================================================={if $participantCount }===================={/if}\n\n{/if}\n\n{if $register_date}\n{ts}Registration Date{/ts}: {$register_date|crmDate}\n{/if}\n{if $receive_date}\n{ts}Transaction Date{/ts}: {$receive_date|crmDate}\n{/if}\n{if $contributionTypeName}\n{ts}Contribution Type{/ts}: {$contributionTypeName}\n{/if}\n{if $trxn_id}\n{ts}Transaction #{/ts}: {$trxn_id}\n{/if}\n{if $paidBy}\n{ts}Paid By{/ts}: {$paidBy}\n{/if}\n{if $checkNumber}\n{ts}Check Number{/ts}: {$checkNumber}\n{/if}\n{if $contributeMode ne \'notify\' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}\n\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Billing Name and Address{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$billingName}\n{$address}\n{/if}\n\n{if $contributeMode eq \'direct\' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Credit Card Information{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$credit_card_type}\n{$credit_card_number}\n{ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n{/if}\n{/if}\n{/if} {* End of conditional section for Paid events *}\n\n{if $customPre}\n==========================================================={if $participantCount }===================={/if}\n\n{$customPre_grouptitle}\n==========================================================={if $participantCount }===================={/if}\n\n{foreach from=$customPre item=value key=customName}\n{if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n{$customName}: {$value}\n{/if}\n{/foreach}\n{/if}\n\n{if $customPost}\n==========================================================={if $participantCount }===================={/if}\n\n{$customPost_grouptitle}\n==========================================================={if $participantCount }===================={/if}\n\n{foreach from=$customPost item=value key=customName}\n{if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n{$customName}: {$value}\n{/if}\n{/foreach}\n{/if}\n{if $customProfile}\n\n{foreach from=$customProfile item=value key=customName}\n==========================================================={if $participantCount }===================={/if}\n\n{ts 1=$customName+1}Participant Information - Participant %1{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{foreach from=$value item=val key=field}\n{if $field eq \'additionalCustomPre\' or $field eq \'additionalCustomPost\' }\n{if $field eq \'additionalCustomPre\' }\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{$additionalCustomPre_grouptitle}\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{else}\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{$additionalCustomPost_grouptitle}\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{/if}\n{foreach from=$val item=v key=f}\n{$f}: {$v}\n{/foreach}\n{/if}\n{/foreach}\n{/foreach}\n{/if}\n{if $customGroup}\n{foreach from=$customGroup item=value key=customName}\n=========================================================={if $participantCount }===================={/if}\n\n{$customName}\n=========================================================={if $participantCount }===================={/if}\n\n{foreach from=$value item=v key=n}\n{$n}: {$v}\n{/foreach}\n{/foreach}\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n\n    {if $event.confirm_email_text AND (not $isOnWaitlist AND not $isRequireApproval)}\n     <p>{$event.confirm_email_text|htmlize}</p>\n    {/if}\n\n    {if $isOnWaitlist}\n     <p>{ts}You have been added to the WAIT LIST for this event.{/ts}</p>\n     {if $isPrimary}\n       <p>{ts}If space becomes available you will receive an email with\na link to a web page where you can complete your registration.{/ts}</p>\n     {/if}\n    {elseif $isRequireApproval}\n     <p>{ts}Your registration has been submitted.{/ts}</p>\n     {if $isPrimary}\n      <p>{ts}Once your registration has been reviewed, you will receive\nan email with a link to a web page where you can complete the\nregistration process.{/ts}</p>\n     {/if}\n    {elseif $is_pay_later}\n     <p>{$pay_later_receipt}</p> {* FIXME: this might be text rather than HTML *}\n    {else}\n     <p>{ts}Please print this confirmation for your records.{/ts}</p>\n    {/if}\n\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Event Information and Location{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       {$event.event_title}<br />\n       {$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n      </td>\n     </tr>\n\n     {if $event.participant_role neq \'Attendee\' and $defaultRole}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Participant Role{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$event.participant_role}\n       </td>\n      </tr>\n     {/if}\n\n     {if $isShowLocation}\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {if $location.address.1.name}\n         {$location.address.1.name}<br />\n        {/if}\n        {if $location.address.1.street_address}\n         {$location.address.1.street_address}<br />\n        {/if}\n        {if $location.address.1.supplemental_address_1}\n         {$location.address.1.supplemental_address_1}<br />\n        {/if}\n        {if $location.address.1.supplemental_address_2}\n         {$location.address.1.supplemental_address_2}<br />\n        {/if}\n        {if $location.address.1.city}\n         {$location.address.1.city} {$location.address.1.postal_code}{if $location.address.1.postal_code_suffix} - {$location.address.1.postal_code_suffix}{/if}<br />\n        {/if}\n       </td>\n      </tr>\n     {/if}\n\n     {if $location.phone.1.phone || $location.email.1.email}\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {ts}Event Contacts:{/ts}\n       </td>\n      </tr>\n      {foreach from=$location.phone item=phone}\n       {if $phone.phone}\n        <tr>\n         <td {$labelStyle}>\n          {if $phone.phone_type}\n           {$phone.phone_type_display}\n          {else}\n           {ts}Phone{/ts}\n          {/if}\n         </td>\n         <td {$valueStyle}>\n          {$phone.phone}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n      {foreach from=$location.email item=eventEmail}\n       {if $eventEmail.email}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Email{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$eventEmail.email}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       {capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n       <a href=\"{$icalFeed}\">{ts}Download iCalendar File{/ts}</a>\n      </td>\n     </tr>\n     {if $email}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Registered Email{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$email}\n       </td>\n      </tr>\n     {/if}\n\n\n     {if $event.is_monetary}\n\n      <tr>\n       <th {$headerStyle}>\n        {$event.fee_label}\n       </th>\n      </tr>\n\n      {if $lineItem}\n       {foreach from=$lineItem item=value key=priceset}\n        {if $value neq \'skip\'}\n         {if $isPrimary}\n          {if $lineItem|@count GT 1} {* Header for multi participant registration cases. *}\n           <tr>\n            <td colspan=\"2\" {$labelStyle}>\n             {ts 1=$priceset+1}Participant %1{/ts} {$part.$priceset.info}\n            </td>\n           </tr>\n          {/if}\n         {/if}\n         <tr>\n          <td colspan=\"2\" {$valueStyle}>\n           <table> {* FIXME: style this table so that it looks like the text version (justification, etc.) *}\n            <tr>\n             <th>{ts}Item{/ts}</th>\n             <th>{ts}Qty{/ts}</th>\n             <th>{ts}Each{/ts}</th>\n             <th>{ts}Total{/ts}</th>\n	     {if  $participantCount }<th>{ts}Total Participants{/ts}</th>{/if}\n            </tr>\n            {foreach from=$value item=line}\n             <tr>\n              <td>\n               {$line.description|truncate:30:\"...\"}\n              </td>\n              <td>\n               {$line.qty}\n              </td>\n              <td>\n               {$line.unit_price|crmMoney}\n              </td>\n              <td>\n               {$line.line_total|crmMoney}\n              </td>\n	      {if  $participantCount }<td>{$line.participant_count}</td> {/if}\n             </tr>\n            {/foreach}\n           </table>\n          </td>\n         </tr>\n        {/if}\n       {/foreach}\n      {/if}\n\n      {if $amount && !$lineItem}\n       {foreach from=$amount item=amnt key=level}\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          {$amnt.amount|crmMoney} {$amnt.label}\n         </td>\n        </tr>\n       {/foreach}\n      {/if}\n\n      {if $isPrimary}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Total Amount{/ts}\n        </td>  \n        <td {$valueStyle}>\n         {$totalAmount|crmMoney} {if $hookDiscount.message}({$hookDiscount.message}){/if}\n        </td>\n       </tr>\n       {if $participantCount }\n     <tr>\n       <td {$labelStyle}> \n      {ts}Total Participants{/ts}</td>   \n       <td {$valueStyle}>\n      {assign var=\"count\" value= 0}	 \n      {foreach from=$lineItem item=pcount}\n      {foreach from=$pcount item=p_count}\n      {assign var=\"count\" value=$count+$p_count.participant_count}\n      {/foreach}\n      {/foreach}\n     {$count}\n     </td> </tr>\n      {/if}\n       {if $is_pay_later}\n        <tr>\n         <td colspan=\"2\" {$labelStyle}>\n          {$pay_later_receipt}\n         </td>\n        </tr>\n       {/if}\n\n       {if $register_date}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Registration Date{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$register_date|crmDate}\n         </td>\n        </tr>\n       {/if}\n\n       {if $receive_date}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Transaction Date{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$receive_date|crmDate}\n         </td>\n        </tr>\n       {/if}\n\n       {if $contributionTypeName}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Contribution Type{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$contributionTypeName}\n         </td>\n        </tr>\n       {/if}\n\n       {if $trxn_id}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Transaction #{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$trxn_id}\n         </td>\n        </tr>\n       {/if}\n\n       {if $paidBy}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Paid By{/ts}\n         </td>\n         <td {$valueStyle}>\n         {$paidBy}\n         </td>\n        </tr>\n       {/if}\n\n       {if $checkNumber}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Check Number{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$checkNumber}\n         </td>\n        </tr>\n       {/if}\n\n       {if $contributeMode ne \'notify\' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}\n        <tr>\n         <th {$headerStyle}>\n          {ts}Billing Name and Address{/ts}\n         </th>\n        </tr>\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          {$billingName}<br />\n          {$address|nl2br}\n         </td>\n        </tr>\n       {/if}\n\n       {if $contributeMode eq \'direct\' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}\n        <tr>\n         <th {$headerStyle}>\n          {ts}Credit Card Information{/ts}\n         </th>\n        </tr>\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          {$credit_card_type}<br />\n          {$credit_card_number}<br />\n          {ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n         </td>\n        </tr>\n       {/if}\n\n      {/if}\n\n     {/if} {* End of conditional section for Paid events *}\n\n     {if $customPre}\n      <tr>\n       <th {$headerStyle}>\n        {$customPre_grouptitle}\n       </th>\n      </tr>\n      {foreach from=$customPre item=value key=customName}\n       {if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n        <tr>\n         <td {$labelStyle}>\n          {$customName}\n         </td>\n         <td {$valueStyle}>\n          {$value}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {if $customPost}\n      <tr>\n       <th {$headerStyle}>\n        {$customPost_grouptitle}\n       </th>\n      </tr>\n      {foreach from=$customPost item=value key=customName}\n       {if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n        <tr>\n         <td {$labelStyle}>\n          {$customName}\n         </td>\n         <td {$valueStyle}>\n          {$value}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {if $customProfile}\n      {foreach from=$customProfile item=value key=customName}\n       <tr>\n        <th {$headerStyle}>\n         {ts 1=$customName+1}Participant Information - Participant %1{/ts}\n        </th>\n       <tr>\n       {foreach from=$value item=val key=field}\n        {if $field eq \'additionalCustomPre\' or $field eq \'additionalCustomPost\'}\n         <tr>\n          <td colspan=\"2\" {$labelStyle}>\n           {if $field eq \'additionalCustomPre\'}\n            {$additionalCustomPre_grouptitle}\n           {else}\n            {$additionalCustomPost_grouptitle}\n           {/if}\n          </td>\n         </tr>\n         {foreach from=$val item=v key=f}\n          <tr>\n           <td {$labelStyle}>\n            {$f}\n           </td>\n           <td {$valueStyle}>\n            {$v}\n           </td>\n          </tr>\n         {/foreach}\n        {/if}\n       {/foreach}\n      {/foreach}\n     {/if}\n\n     {if $customGroup}\n      {foreach from=$customGroup item=value key=customName}\n       <tr>\n        <th {$headerStyle}>\n         {$customName}\n        </th>\n       </tr>\n       {foreach from=$value item=v key=n}\n        <tr>\n         <td {$labelStyle}>\n          {$n}\n         </td>\n         <td {$valueStyle}>\n          {$v}\n         </td>\n        </tr>\n       {/foreach}\n      {/foreach}\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,495,1,0),(20,'Events - Registration Confirmation and Receipt (on-line)','{if $isOnWaitlist}{ts}Wait List Confirmation{/ts}{else}{ts}Registration Confirmation{/ts}{/if} - {$title}\n','{if $event.confirm_email_text AND (not $isOnWaitlist AND not $isRequireApproval)}\n{$event.confirm_email_text}\n{/if}\n\n{if $isOnWaitlist}\n==========================================================={if $participantCount }===================={/if}\n\n{ts}You have been added to the WAIT LIST for this event.{/ts}\n\n{if $isPrimary}\n{ts}If space becomes available you will receive an email with\na link to a web page where you can complete your registration.{/ts}\n{/if}\n==========================================================={if $participantCount }===================={/if}\n\n{elseif $isRequireApproval}\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Your registration has been submitted.{/ts}\n\n{if $isPrimary}\n{ts}Once your registration has been reviewed, you will receive\nan email with a link to a web page where you can complete the\nregistration process.{/ts}\n\n{/if}\n==========================================================={if $participantCount }===================={/if}\n\n{elseif $is_pay_later}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$pay_later_receipt}\n==========================================================={if $participantCount }===================={/if}\n\n{else}\n\n{ts}Please print this confirmation for your records.{/ts}\n{/if}\n\n\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Event Information and Location{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$event.event_title}\n{$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n\n{if $event.participant_role neq \'Attendee\' and $defaultRole}\n{ts}Participant Role{/ts}: {$event.participant_role}\n{/if}\n\n{if $isShowLocation}\n{if $location.address.1.name}\n\n{$location.address.1.name}\n{/if}\n{if $location.address.1.street_address}{$location.address.1.street_address}\n{/if}\n{if $location.address.1.supplemental_address_1}{$location.address.1.supplemental_address_1}\n{/if}\n{if $location.address.1.supplemental_address_2}{$location.address.1.supplemental_address_2}\n{/if}\n{if $location.address.1.city}{$location.address.1.city} {$location.address.1.postal_code}{if $location.address.1.postal_code_suffix} - {$location.address.1.postal_code_suffix}{/if}\n{/if}\n\n{/if}{*End of isShowLocation condition*}\n\n{if $location.phone.1.phone || $location.email.1.email}\n\n{ts}Event Contacts:{/ts}\n{foreach from=$location.phone item=phone}\n{if $phone.phone}\n\n{if $phone.phone_type}{$phone.phone_type_display}{else}{ts}Phone{/ts}{/if}: {$phone.phone}{/if}\n{/foreach}\n{foreach from=$location.email item=eventEmail}\n{if $eventEmail.email}\n\n{ts}Email{/ts}: {$eventEmail.email}{/if}{/foreach}\n{/if}\n\n{capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n{ts}Download iCalendar File:{/ts} {$icalFeed}\n{if $email}\n\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Registered Email{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$email}\n{/if}\n{if $event.is_monetary} {* This section for Paid events only.*}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$event.fee_label}\n==========================================================={if $participantCount }===================={/if}\n\n{if $lineItem}{foreach from=$lineItem item=value key=priceset}\n\n{if $value neq \'skip\'}\n{if $isPrimary}\n{if $lineItem|@count GT 1} {* Header for multi participant registration cases. *}\n{ts 1=$priceset+1}Participant %1{/ts} {$part.$priceset.info}\n\n{/if}\n{/if}\n-----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{capture assign=ts_item}{ts}Item{/ts}{/capture}\n{capture assign=ts_qty}{ts}Qty{/ts}{/capture}\n{capture assign=ts_each}{ts}Each{/ts}{/capture}\n{capture assign=ts_total}{ts}Total{/ts}{/capture}\n{if $participantCount }{capture assign=ts_participant_total}{ts}Total Participants{/ts}{/capture}{/if}\n{$ts_item|string_format:\"%-30s\"} {$ts_qty|string_format:\"%5s\"} {$ts_each|string_format:\"%10s\"} {$ts_total|string_format:\"%10s\"} {$ts_participant_total|string_format:\"%10s\"}\n-----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{foreach from=$value item=line}\n{if $participantCount }{capture assign=ts_participant_count}{$line.participant_count}{/capture}{/if}\n{$line.description|truncate:30:\"...\"|string_format:\"%-30s\"} {$line.qty|string_format:\"%5s\"} {$line.unit_price|crmMoney|string_format:\"%10s\"} {$line.line_total|crmMoney|string_format:\"%10s\"}{$ts_participant_count|string_format:\"%10s\"}\n{/foreach}\n{/if}\n{/foreach}\n{/if}\n{if $amount && !$lineItem}\n{foreach from=$amount item=amnt key=level}{$amnt.amount|crmMoney} {$amnt.label}\n{/foreach}\n{/if}\n{if $isPrimary }\n\n{ts}Total Amount{/ts}: {$totalAmount|crmMoney} {if $hookDiscount.message}({$hookDiscount.message}){/if}\n\n{if $participantCount }\n      {assign var=\"count\" value= 0}\n      {foreach from=$lineItem item=pcount}\n      {foreach from=$pcount item=p_count}\n      {assign var=\"count\" value=$count+$p_count.participant_count}\n      {/foreach}\n      {/foreach}\n\n{ts}Total Participants{/ts}: {$count}\n{/if}\n  \n{if $is_pay_later }\n\n==========================================================={if $participantCount }===================={/if}\n\n{$pay_later_receipt}\n==========================================================={if $participantCount }===================={/if}\n\n{/if}\n\n{if $register_date}\n{ts}Registration Date{/ts}: {$register_date|crmDate}\n{/if}\n{if $receive_date}\n{ts}Transaction Date{/ts}: {$receive_date|crmDate}\n{/if}\n{if $contributionTypeName}\n{ts}Contribution Type{/ts}: {$contributionTypeName}\n{/if}\n{if $trxn_id}\n{ts}Transaction #{/ts}: {$trxn_id}\n{/if}\n{if $paidBy}\n{ts}Paid By{/ts}: {$paidBy}\n{/if}\n{if $checkNumber}\n{ts}Check Number{/ts}: {$checkNumber}\n{/if}\n{if $contributeMode ne \'notify\' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}\n\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Billing Name and Address{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$billingName}\n{$address}\n{/if}\n\n{if $contributeMode eq \'direct\' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}\n==========================================================={if $participantCount }===================={/if}\n\n{ts}Credit Card Information{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{$credit_card_type}\n{$credit_card_number}\n{ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n{/if}\n{/if}\n{/if} {* End of conditional section for Paid events *}\n\n{if $customPre}\n==========================================================={if $participantCount }===================={/if}\n\n{$customPre_grouptitle}\n==========================================================={if $participantCount }===================={/if}\n\n{foreach from=$customPre item=value key=customName}\n{if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n{$customName}: {$value}\n{/if}\n{/foreach}\n{/if}\n\n{if $customPost}\n==========================================================={if $participantCount }===================={/if}\n\n{$customPost_grouptitle}\n==========================================================={if $participantCount }===================={/if}\n\n{foreach from=$customPost item=value key=customName}\n{if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n{$customName}: {$value}\n{/if}\n{/foreach}\n{/if}\n{if $customProfile}\n\n{foreach from=$customProfile item=value key=customName}\n==========================================================={if $participantCount }===================={/if}\n\n{ts 1=$customName+1}Participant Information - Participant %1{/ts}\n\n==========================================================={if $participantCount }===================={/if}\n\n{foreach from=$value item=val key=field}\n{if $field eq \'additionalCustomPre\' or $field eq \'additionalCustomPost\' }\n{if $field eq \'additionalCustomPre\' }\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{$additionalCustomPre_grouptitle}\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{else}\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{$additionalCustomPost_grouptitle}\n----------------------------------------------------------{if $participantCount }--------------------{/if}\n\n{/if}\n{foreach from=$val item=v key=f}\n{$f}: {$v}\n{/foreach}\n{/if}\n{/foreach}\n{/foreach}\n{/if}\n{if $customGroup}\n{foreach from=$customGroup item=value key=customName}\n=========================================================={if $participantCount }===================={/if}\n\n{$customName}\n=========================================================={if $participantCount }===================={/if}\n\n{foreach from=$value item=v key=n}\n{$n}: {$v}\n{/foreach}\n{/foreach}\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n\n    {if $event.confirm_email_text AND (not $isOnWaitlist AND not $isRequireApproval)}\n     <p>{$event.confirm_email_text|htmlize}</p>\n    {/if}\n\n    {if $isOnWaitlist}\n     <p>{ts}You have been added to the WAIT LIST for this event.{/ts}</p>\n     {if $isPrimary}\n       <p>{ts}If space becomes available you will receive an email with\na link to a web page where you can complete your registration.{/ts}</p>\n     {/if}\n    {elseif $isRequireApproval}\n     <p>{ts}Your registration has been submitted.{/ts}</p>\n     {if $isPrimary}\n      <p>{ts}Once your registration has been reviewed, you will receive\nan email with a link to a web page where you can complete the\nregistration process.{/ts}</p>\n     {/if}\n    {elseif $is_pay_later}\n     <p>{$pay_later_receipt}</p> {* FIXME: this might be text rather than HTML *}\n    {else}\n     <p>{ts}Please print this confirmation for your records.{/ts}</p>\n    {/if}\n\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Event Information and Location{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       {$event.event_title}<br />\n       {$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n      </td>\n     </tr>\n\n     {if $event.participant_role neq \'Attendee\' and $defaultRole}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Participant Role{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$event.participant_role}\n       </td>\n      </tr>\n     {/if}\n\n     {if $isShowLocation}\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {if $location.address.1.name}\n         {$location.address.1.name}<br />\n        {/if}\n        {if $location.address.1.street_address}\n         {$location.address.1.street_address}<br />\n        {/if}\n        {if $location.address.1.supplemental_address_1}\n         {$location.address.1.supplemental_address_1}<br />\n        {/if}\n        {if $location.address.1.supplemental_address_2}\n         {$location.address.1.supplemental_address_2}<br />\n        {/if}\n        {if $location.address.1.city}\n         {$location.address.1.city} {$location.address.1.postal_code}{if $location.address.1.postal_code_suffix} - {$location.address.1.postal_code_suffix}{/if}<br />\n        {/if}\n       </td>\n      </tr>\n     {/if}\n\n     {if $location.phone.1.phone || $location.email.1.email}\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {ts}Event Contacts:{/ts}\n       </td>\n      </tr>\n      {foreach from=$location.phone item=phone}\n       {if $phone.phone}\n        <tr>\n         <td {$labelStyle}>\n          {if $phone.phone_type}\n           {$phone.phone_type_display}\n          {else}\n           {ts}Phone{/ts}\n          {/if}\n         </td>\n         <td {$valueStyle}>\n          {$phone.phone}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n      {foreach from=$location.email item=eventEmail}\n       {if $eventEmail.email}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Email{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$eventEmail.email}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       {capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n       <a href=\"{$icalFeed}\">{ts}Download iCalendar File{/ts}</a>\n      </td>\n     </tr>\n     {if $email}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Registered Email{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$email}\n       </td>\n      </tr>\n     {/if}\n\n\n     {if $event.is_monetary}\n\n      <tr>\n       <th {$headerStyle}>\n        {$event.fee_label}\n       </th>\n      </tr>\n\n      {if $lineItem}\n       {foreach from=$lineItem item=value key=priceset}\n        {if $value neq \'skip\'}\n         {if $isPrimary}\n          {if $lineItem|@count GT 1} {* Header for multi participant registration cases. *}\n           <tr>\n            <td colspan=\"2\" {$labelStyle}>\n             {ts 1=$priceset+1}Participant %1{/ts} {$part.$priceset.info}\n            </td>\n           </tr>\n          {/if}\n         {/if}\n         <tr>\n          <td colspan=\"2\" {$valueStyle}>\n           <table> {* FIXME: style this table so that it looks like the text version (justification, etc.) *}\n            <tr>\n             <th>{ts}Item{/ts}</th>\n             <th>{ts}Qty{/ts}</th>\n             <th>{ts}Each{/ts}</th>\n             <th>{ts}Total{/ts}</th>\n	     {if  $participantCount }<th>{ts}Total Participants{/ts}</th>{/if}\n            </tr>\n            {foreach from=$value item=line}\n             <tr>\n              <td>\n               {$line.description|truncate:30:\"...\"}\n              </td>\n              <td>\n               {$line.qty}\n              </td>\n              <td>\n               {$line.unit_price|crmMoney}\n              </td>\n              <td>\n               {$line.line_total|crmMoney}\n              </td>\n	      {if  $participantCount }<td>{$line.participant_count}</td> {/if}\n             </tr>\n            {/foreach}\n           </table>\n          </td>\n         </tr>\n        {/if}\n       {/foreach}\n      {/if}\n\n      {if $amount && !$lineItem}\n       {foreach from=$amount item=amnt key=level}\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          {$amnt.amount|crmMoney} {$amnt.label}\n         </td>\n        </tr>\n       {/foreach}\n      {/if}\n\n      {if $isPrimary}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Total Amount{/ts}\n        </td>  \n        <td {$valueStyle}>\n         {$totalAmount|crmMoney} {if $hookDiscount.message}({$hookDiscount.message}){/if}\n        </td>\n       </tr>\n       {if $participantCount }\n     <tr>\n       <td {$labelStyle}> \n      {ts}Total Participants{/ts}</td>   \n       <td {$valueStyle}>\n      {assign var=\"count\" value= 0}	 \n      {foreach from=$lineItem item=pcount}\n      {foreach from=$pcount item=p_count}\n      {assign var=\"count\" value=$count+$p_count.participant_count}\n      {/foreach}\n      {/foreach}\n     {$count}\n     </td> </tr>\n      {/if}\n       {if $is_pay_later}\n        <tr>\n         <td colspan=\"2\" {$labelStyle}>\n          {$pay_later_receipt}\n         </td>\n        </tr>\n       {/if}\n\n       {if $register_date}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Registration Date{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$register_date|crmDate}\n         </td>\n        </tr>\n       {/if}\n\n       {if $receive_date}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Transaction Date{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$receive_date|crmDate}\n         </td>\n        </tr>\n       {/if}\n\n       {if $contributionTypeName}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Contribution Type{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$contributionTypeName}\n         </td>\n        </tr>\n       {/if}\n\n       {if $trxn_id}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Transaction #{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$trxn_id}\n         </td>\n        </tr>\n       {/if}\n\n       {if $paidBy}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Paid By{/ts}\n         </td>\n         <td {$valueStyle}>\n         {$paidBy}\n         </td>\n        </tr>\n       {/if}\n\n       {if $checkNumber}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Check Number{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$checkNumber}\n         </td>\n        </tr>\n       {/if}\n\n       {if $contributeMode ne \'notify\' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}\n        <tr>\n         <th {$headerStyle}>\n          {ts}Billing Name and Address{/ts}\n         </th>\n        </tr>\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          {$billingName}<br />\n          {$address|nl2br}\n         </td>\n        </tr>\n       {/if}\n\n       {if $contributeMode eq \'direct\' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}\n        <tr>\n         <th {$headerStyle}>\n          {ts}Credit Card Information{/ts}\n         </th>\n        </tr>\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          {$credit_card_type}<br />\n          {$credit_card_number}<br />\n          {ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n         </td>\n        </tr>\n       {/if}\n\n      {/if}\n\n     {/if} {* End of conditional section for Paid events *}\n\n     {if $customPre}\n      <tr>\n       <th {$headerStyle}>\n        {$customPre_grouptitle}\n       </th>\n      </tr>\n      {foreach from=$customPre item=value key=customName}\n       {if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n        <tr>\n         <td {$labelStyle}>\n          {$customName}\n         </td>\n         <td {$valueStyle}>\n          {$value}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {if $customPost}\n      <tr>\n       <th {$headerStyle}>\n        {$customPost_grouptitle}\n       </th>\n      </tr>\n      {foreach from=$customPost item=value key=customName}\n       {if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n        <tr>\n         <td {$labelStyle}>\n          {$customName}\n         </td>\n         <td {$valueStyle}>\n          {$value}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {if $customProfile}\n      {foreach from=$customProfile item=value key=customName}\n       <tr>\n        <th {$headerStyle}>\n         {ts 1=$customName+1}Participant Information - Participant %1{/ts}\n        </th>\n       <tr>\n       {foreach from=$value item=val key=field}\n        {if $field eq \'additionalCustomPre\' or $field eq \'additionalCustomPost\'}\n         <tr>\n          <td colspan=\"2\" {$labelStyle}>\n           {if $field eq \'additionalCustomPre\'}\n            {$additionalCustomPre_grouptitle}\n           {else}\n            {$additionalCustomPost_grouptitle}\n           {/if}\n          </td>\n         </tr>\n         {foreach from=$val item=v key=f}\n          <tr>\n           <td {$labelStyle}>\n            {$f}\n           </td>\n           <td {$valueStyle}>\n            {$v}\n           </td>\n          </tr>\n         {/foreach}\n        {/if}\n       {/foreach}\n      {/foreach}\n     {/if}\n\n     {if $customGroup}\n      {foreach from=$customGroup item=value key=customName}\n       <tr>\n        <th {$headerStyle}>\n         {$customName}\n        </th>\n       </tr>\n       {foreach from=$value item=v key=n}\n        <tr>\n         <td {$labelStyle}>\n          {$n}\n         </td>\n         <td {$valueStyle}>\n          {$v}\n         </td>\n        </tr>\n       {/foreach}\n      {/foreach}\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,495,0,1),(21,'Events - Registration Cancellation Notice','{ts 1=$event.event_title}Event Registration Cancelled for %1{/ts}\n','{ts 1=$contact.display_name}Dear %1{/ts},\n\n{ts}Your Event Registration has been cancelled.{/ts}\n\n\n===========================================================\n{ts}Event Information and Location{/ts}\n\n===========================================================\n{$event.event_title}\n{$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n\n{ts}Participant Role{/ts}: {$participant.role}\n\n{if $isShowLocation}\n{if $event.location.address.1.name}\n\n{$event.location.address.1.name}\n{/if}\n{if $event.location.address.1.street_address}{$event.location.address.1.street_address}\n{/if}\n{if $event.location.address.1.supplemental_address_1}{$event.location.address.1.supplemental_address_1}\n{/if}\n{if $event.location.address.1.supplemental_address_2}{$event.location.address.1.supplemental_address_2}\n{/if}\n{if $event.location.address.1.city}{$event.location.address.1.city} {$event.location.address.1.postal_code}{if $event.location.address.1.postal_code_suffix} - {$event.location.address.1.postal_code_suffix}{/if}\n{/if}\n\n{/if}{*End of isShowLocation condition*}\n\n{if $event.location.phone.1.phone || $event.location.email.1.email}\n\n{ts}Event Contacts:{/ts}\n{foreach from=$event.location.phone item=phone}\n{if $phone.phone}\n\n{if $phone.phone_type}{$phone.phone_type_display}{else}{ts}Phone{/ts}{/if}: {$phone.phone}{/if}\n{/foreach}\n{foreach from=$event.location.email item=eventEmail}\n{if $eventEmail.email}\n\n{ts}Email{/ts}: {$eventEmail.email}{/if}{/foreach}\n{/if}\n\n{capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n{ts}Download iCalendar File{/ts}: {$icalFeed}\n{if $contact.email}\n\n===========================================================\n{ts}Registered Email{/ts}\n\n===========================================================\n{$contact.email}\n{/if}\n\n{if $register_date}\n{ts}Registration Date{/ts}: {$participant.register_date|crmDate}\n{/if}\n\n{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions.{/ts}\n\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <p>{ts 1=$contact.display_name}Dear %1{/ts},</p>\n    <p>{ts}Your Event Registration has been cancelled.{/ts}</p>\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Event Information and Location{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       {$event.event_title}<br />\n       {$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Participant Role{/ts}:\n      </td>\n      <td {$valueStyle}>\n       {$participant.role}\n      </td>\n     </tr>\n\n     {if $isShowLocation}\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {if $event.location.address.1.name}\n         {$event.location.address.1.name}<br />\n        {/if}\n        {if $event.location.address.1.street_address}\n         {$event.location.address.1.street_address}<br />\n        {/if}\n        {if $event.location.address.1.supplemental_address_1}\n         {$event.location.address.1.supplemental_address_1}<br />\n        {/if}\n        {if $event.location.address.1.supplemental_address_2}\n         {$event.location.address.1.supplemental_address_2}<br />\n        {/if}\n        {if $event.location.address.1.city}\n         {$event.location.address.1.city} {$event.location.address.1.postal_code}\n         {if $event.location.address.1.postal_code_suffix}\n          - {$event.location.address.1.postal_code_suffix}\n         {/if}\n        {/if}\n       </td>\n      </tr>\n     {/if}\n\n     {if $event.location.phone.1.phone || $event.location.email.1.email}\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {ts}Event Contacts:{/ts}\n       </td>\n      </tr>\n      {foreach from=$event.location.phone item=phone}\n       {if $phone.phone}\n        <tr>\n         <td {$labelStyle}>\n          {if $phone.phone_type}{$phone.phone_type_display}{else}{ts}Phone{/ts}{/if}\n         </td>\n         <td {$valueStyle}>\n          {$phone.phone}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n      {foreach from=$event.location.email item=eventEmail}\n       {if $eventEmail.email}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Email{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$eventEmail.email}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       <a href=\"{$icalFeed}\">{ts}Download iCalendar File{/ts}</a>\n      </td>\n     </tr>\n\n     {if $contact.email}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Registered Email{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$contact.email}\n       </td>\n      </tr>\n     {/if}\n\n     {if $register_date}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Registration Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$participant.register_date|crmDate}\n       </td>\n      </tr>\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n  <tr>\n   <td>\n    <p>{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions.{/ts}</p>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,496,1,0),(22,'Events - Registration Cancellation Notice','{ts 1=$event.event_title}Event Registration Cancelled for %1{/ts}\n','{ts 1=$contact.display_name}Dear %1{/ts},\n\n{ts}Your Event Registration has been cancelled.{/ts}\n\n\n===========================================================\n{ts}Event Information and Location{/ts}\n\n===========================================================\n{$event.event_title}\n{$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n\n{ts}Participant Role{/ts}: {$participant.role}\n\n{if $isShowLocation}\n{if $event.location.address.1.name}\n\n{$event.location.address.1.name}\n{/if}\n{if $event.location.address.1.street_address}{$event.location.address.1.street_address}\n{/if}\n{if $event.location.address.1.supplemental_address_1}{$event.location.address.1.supplemental_address_1}\n{/if}\n{if $event.location.address.1.supplemental_address_2}{$event.location.address.1.supplemental_address_2}\n{/if}\n{if $event.location.address.1.city}{$event.location.address.1.city} {$event.location.address.1.postal_code}{if $event.location.address.1.postal_code_suffix} - {$event.location.address.1.postal_code_suffix}{/if}\n{/if}\n\n{/if}{*End of isShowLocation condition*}\n\n{if $event.location.phone.1.phone || $event.location.email.1.email}\n\n{ts}Event Contacts:{/ts}\n{foreach from=$event.location.phone item=phone}\n{if $phone.phone}\n\n{if $phone.phone_type}{$phone.phone_type_display}{else}{ts}Phone{/ts}{/if}: {$phone.phone}{/if}\n{/foreach}\n{foreach from=$event.location.email item=eventEmail}\n{if $eventEmail.email}\n\n{ts}Email{/ts}: {$eventEmail.email}{/if}{/foreach}\n{/if}\n\n{capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n{ts}Download iCalendar File{/ts}: {$icalFeed}\n{if $contact.email}\n\n===========================================================\n{ts}Registered Email{/ts}\n\n===========================================================\n{$contact.email}\n{/if}\n\n{if $register_date}\n{ts}Registration Date{/ts}: {$participant.register_date|crmDate}\n{/if}\n\n{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions.{/ts}\n\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <p>{ts 1=$contact.display_name}Dear %1{/ts},</p>\n    <p>{ts}Your Event Registration has been cancelled.{/ts}</p>\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Event Information and Location{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       {$event.event_title}<br />\n       {$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Participant Role{/ts}:\n      </td>\n      <td {$valueStyle}>\n       {$participant.role}\n      </td>\n     </tr>\n\n     {if $isShowLocation}\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {if $event.location.address.1.name}\n         {$event.location.address.1.name}<br />\n        {/if}\n        {if $event.location.address.1.street_address}\n         {$event.location.address.1.street_address}<br />\n        {/if}\n        {if $event.location.address.1.supplemental_address_1}\n         {$event.location.address.1.supplemental_address_1}<br />\n        {/if}\n        {if $event.location.address.1.supplemental_address_2}\n         {$event.location.address.1.supplemental_address_2}<br />\n        {/if}\n        {if $event.location.address.1.city}\n         {$event.location.address.1.city} {$event.location.address.1.postal_code}\n         {if $event.location.address.1.postal_code_suffix}\n          - {$event.location.address.1.postal_code_suffix}\n         {/if}\n        {/if}\n       </td>\n      </tr>\n     {/if}\n\n     {if $event.location.phone.1.phone || $event.location.email.1.email}\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {ts}Event Contacts:{/ts}\n       </td>\n      </tr>\n      {foreach from=$event.location.phone item=phone}\n       {if $phone.phone}\n        <tr>\n         <td {$labelStyle}>\n          {if $phone.phone_type}{$phone.phone_type_display}{else}{ts}Phone{/ts}{/if}\n         </td>\n         <td {$valueStyle}>\n          {$phone.phone}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n      {foreach from=$event.location.email item=eventEmail}\n       {if $eventEmail.email}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Email{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$eventEmail.email}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       <a href=\"{$icalFeed}\">{ts}Download iCalendar File{/ts}</a>\n      </td>\n     </tr>\n\n     {if $contact.email}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Registered Email{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$contact.email}\n       </td>\n      </tr>\n     {/if}\n\n     {if $register_date}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Registration Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$participant.register_date|crmDate}\n       </td>\n      </tr>\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n  <tr>\n   <td>\n    <p>{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions.{/ts}</p>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,496,0,1),(23,'Events - Registration Confirmation Invite','{ts 1=$event.event_title}Confirm your registration for %1{/ts}\n','{ts 1=$contact.display_name}Dear %1{/ts},\n{if !$isAdditional and $participant.id}\n\n===========================================================\n{ts}Confirm Your Registration{/ts}\n\n===========================================================\n{capture assign=confirmUrl}{crmURL p=\'civicrm/event/confirm\' q=\"reset=1&participantId=`$participant.id`&cs=`$checksumValue`\" a=true h=0 fe=1}{/capture}\nClick this link to go to a web page where you can confirm your registration online:\n{$confirmUrl}\n{/if}\n\n===========================================================\n{ts}Event Information and Location{/ts}\n\n===========================================================\n{$event.event_title}\n{$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n\n{ts}Participant Role{/ts}: {$participant.role}\n\n{if $isShowLocation}\n{if $event.location.address.1.name}\n\n{$event.location.address.1.name}\n{/if}\n{if $event.location.address.1.street_address}{$event.location.address.1.street_address}\n{/if}\n{if $event.location.address.1.supplemental_address_1}{$event.location.address.1.supplemental_address_1}\n{/if}\n{if $event.location.address.1.supplemental_address_2}{$event.location.address.1.supplemental_address_2}\n{/if}\n{if $event.location.address.1.city}{$event.location.address.1.city} {$event.location.address.1.postal_code}{if $event.location.address.1.postal_code_suffix} - {$event.location.address.1.postal_code_suffix}{/if}\n{/if}\n\n{/if}{*End of isShowLocation condition*}\n\n{if $event.location.phone.1.phone || $event.location.email.1.email}\n\n{ts}Event Contacts:{/ts}\n{foreach from=$event.location.phone item=phone}\n{if $phone.phone}\n\n{if $phone.phone_type}{$phone.phone_type_display}{else}{ts}Phone{/ts}{/if}: {$phone.phone}{/if}\n{/foreach}\n{foreach from=$event.location.email item=eventEmail}\n{if $eventEmail.email}\n\n{ts}Email{/ts}: {$eventEmail.email}{/if}{/foreach}\n{/if}\n\n{capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n{ts}Download iCalendar File{/ts}: {$icalFeed}\n{if $contact.email}\n\n===========================================================\n{ts}Registered Email{/ts}\n\n===========================================================\n{$contact.email}\n{/if}\n\n{if $register_date}\n{ts}Registration Date{/ts}: {$participant.register_date|crmDate}\n{/if}\n\n{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions.{/ts}\n\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <p>{ts 1=$contact.display_name}Dear %1{/ts},</p>\n   </td>\n  </tr>\n  {if !$isAdditional and $participant.id}\n   <tr>\n    <th {$headerStyle}>\n     {ts}Confirm Your Registration{/ts}\n    </th>\n   </tr>\n   <tr>\n    <td colspan=\"2\" {$valueStyle}>\n     {capture assign=confirmUrl}{crmURL p=\'civicrm/event/confirm\' q=\"reset=1&participantId=`$participant.id`&cs=`$checksumValue`\" a=true h=0 fe=1}{/capture}\n     <a href=\"{$confirmUrl}\">Go to a web page where you can confirm your registration online</a>\n    </td>\n   </tr>\n  {/if}\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Event Information and Location{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       {$event.event_title}<br />\n       {$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Participant Role{/ts}:\n      </td>\n      <td {$valueStyle}>\n       {$participant.role}\n      </td>\n     </tr>\n\n     {if $isShowLocation}\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {if $event.location.address.1.name}\n         {$event.location.address.1.name}<br />\n        {/if}\n        {if $event.location.address.1.street_address}\n         {$event.location.address.1.street_address}<br />\n        {/if}\n        {if $event.location.address.1.supplemental_address_1}\n         {$event.location.address.1.supplemental_address_1}<br />\n        {/if}\n        {if $event.location.address.1.supplemental_address_2}\n         {$event.location.address.1.supplemental_address_2}<br />\n        {/if}\n        {if $event.location.address.1.city}\n         {$event.location.address.1.city} {$event.location.address.1.postal_code}\n         {if $event.location.address.1.postal_code_suffix}\n          - {$event.location.address.1.postal_code_suffix}\n         {/if}\n        {/if}\n       </td>\n      </tr>\n     {/if}\n\n     {if $event.location.phone.1.phone || $event.location.email.1.email}\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {ts}Event Contacts:{/ts}\n       </td>\n      </tr>\n      {foreach from=$event.location.phone item=phone}\n       {if $phone.phone}\n        <tr>\n         <td {$labelStyle}>\n          {if $phone.phone_type}{$phone.phone_type_display}{else}{ts}Phone{/ts}{/if}\n         </td>\n         <td {$valueStyle}>\n          {$phone.phone}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n      {foreach from=$event.location.email item=eventEmail}\n       {if $eventEmail.email}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Email{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$eventEmail.email}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       <a href=\"{$icalFeed}\">{ts}Download iCalendar File{/ts}</a>\n      </td>\n     </tr>\n\n     {if $contact.email}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Registered Email{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$contact.email}\n       </td>\n      </tr>\n     {/if}\n\n     {if $register_date}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Registration Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$participant.register_date|crmDate}\n       </td>\n      </tr>\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n  <tr>\n   <td>\n    <p>{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions.{/ts}</p>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,497,1,0),(24,'Events - Registration Confirmation Invite','{ts 1=$event.event_title}Confirm your registration for %1{/ts}\n','{ts 1=$contact.display_name}Dear %1{/ts},\n{if !$isAdditional and $participant.id}\n\n===========================================================\n{ts}Confirm Your Registration{/ts}\n\n===========================================================\n{capture assign=confirmUrl}{crmURL p=\'civicrm/event/confirm\' q=\"reset=1&participantId=`$participant.id`&cs=`$checksumValue`\" a=true h=0 fe=1}{/capture}\nClick this link to go to a web page where you can confirm your registration online:\n{$confirmUrl}\n{/if}\n\n===========================================================\n{ts}Event Information and Location{/ts}\n\n===========================================================\n{$event.event_title}\n{$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n\n{ts}Participant Role{/ts}: {$participant.role}\n\n{if $isShowLocation}\n{if $event.location.address.1.name}\n\n{$event.location.address.1.name}\n{/if}\n{if $event.location.address.1.street_address}{$event.location.address.1.street_address}\n{/if}\n{if $event.location.address.1.supplemental_address_1}{$event.location.address.1.supplemental_address_1}\n{/if}\n{if $event.location.address.1.supplemental_address_2}{$event.location.address.1.supplemental_address_2}\n{/if}\n{if $event.location.address.1.city}{$event.location.address.1.city} {$event.location.address.1.postal_code}{if $event.location.address.1.postal_code_suffix} - {$event.location.address.1.postal_code_suffix}{/if}\n{/if}\n\n{/if}{*End of isShowLocation condition*}\n\n{if $event.location.phone.1.phone || $event.location.email.1.email}\n\n{ts}Event Contacts:{/ts}\n{foreach from=$event.location.phone item=phone}\n{if $phone.phone}\n\n{if $phone.phone_type}{$phone.phone_type_display}{else}{ts}Phone{/ts}{/if}: {$phone.phone}{/if}\n{/foreach}\n{foreach from=$event.location.email item=eventEmail}\n{if $eventEmail.email}\n\n{ts}Email{/ts}: {$eventEmail.email}{/if}{/foreach}\n{/if}\n\n{capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n{ts}Download iCalendar File{/ts}: {$icalFeed}\n{if $contact.email}\n\n===========================================================\n{ts}Registered Email{/ts}\n\n===========================================================\n{$contact.email}\n{/if}\n\n{if $register_date}\n{ts}Registration Date{/ts}: {$participant.register_date|crmDate}\n{/if}\n\n{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions.{/ts}\n\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <p>{ts 1=$contact.display_name}Dear %1{/ts},</p>\n   </td>\n  </tr>\n  {if !$isAdditional and $participant.id}\n   <tr>\n    <th {$headerStyle}>\n     {ts}Confirm Your Registration{/ts}\n    </th>\n   </tr>\n   <tr>\n    <td colspan=\"2\" {$valueStyle}>\n     {capture assign=confirmUrl}{crmURL p=\'civicrm/event/confirm\' q=\"reset=1&participantId=`$participant.id`&cs=`$checksumValue`\" a=true h=0 fe=1}{/capture}\n     <a href=\"{$confirmUrl}\">Go to a web page where you can confirm your registration online</a>\n    </td>\n   </tr>\n  {/if}\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Event Information and Location{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       {$event.event_title}<br />\n       {$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Participant Role{/ts}:\n      </td>\n      <td {$valueStyle}>\n       {$participant.role}\n      </td>\n     </tr>\n\n     {if $isShowLocation}\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {if $event.location.address.1.name}\n         {$event.location.address.1.name}<br />\n        {/if}\n        {if $event.location.address.1.street_address}\n         {$event.location.address.1.street_address}<br />\n        {/if}\n        {if $event.location.address.1.supplemental_address_1}\n         {$event.location.address.1.supplemental_address_1}<br />\n        {/if}\n        {if $event.location.address.1.supplemental_address_2}\n         {$event.location.address.1.supplemental_address_2}<br />\n        {/if}\n        {if $event.location.address.1.city}\n         {$event.location.address.1.city} {$event.location.address.1.postal_code}\n         {if $event.location.address.1.postal_code_suffix}\n          - {$event.location.address.1.postal_code_suffix}\n         {/if}\n        {/if}\n       </td>\n      </tr>\n     {/if}\n\n     {if $event.location.phone.1.phone || $event.location.email.1.email}\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {ts}Event Contacts:{/ts}\n       </td>\n      </tr>\n      {foreach from=$event.location.phone item=phone}\n       {if $phone.phone}\n        <tr>\n         <td {$labelStyle}>\n          {if $phone.phone_type}{$phone.phone_type_display}{else}{ts}Phone{/ts}{/if}\n         </td>\n         <td {$valueStyle}>\n          {$phone.phone}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n      {foreach from=$event.location.email item=eventEmail}\n       {if $eventEmail.email}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Email{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$eventEmail.email}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       <a href=\"{$icalFeed}\">{ts}Download iCalendar File{/ts}</a>\n      </td>\n     </tr>\n\n     {if $contact.email}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Registered Email{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$contact.email}\n       </td>\n      </tr>\n     {/if}\n\n     {if $register_date}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Registration Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$participant.register_date|crmDate}\n       </td>\n      </tr>\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n  <tr>\n   <td>\n    <p>{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions.{/ts}</p>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,497,0,1),(25,'Events - Pending Registration Expiration Notice','{ts 1=$event.event_title}Event registration has expired for %1{/ts}\n','{ts 1=$contact.display_name}Dear %1{/ts},\n\n{ts 1=$event.event_title}Your pending event registration for %1 has expired\nbecause you did not confirm your registration.{/ts}\n\n\n{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions\nor want to inquire about reinstating your registration for this event.{/ts}\n\n===========================================================\n{ts}Event Information and Location{/ts}\n\n===========================================================\n{$event.event_title}\n{$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n\n{ts}Participant Role{/ts}: {$participant.role}\n\n{if $isShowLocation}\n{if $event.location.address.1.name}\n\n{$event.location.address.1.name}\n{/if}\n{if $event.location.address.1.street_address}{$event.location.address.1.street_address}\n{/if}\n{if $event.location.address.1.supplemental_address_1}{$event.location.address.1.supplemental_address_1}\n{/if}\n{if $event.location.address.1.supplemental_address_2}{$event.location.address.1.supplemental_address_2}\n{/if}\n{if $event.location.address.1.city}{$event.location.address.1.city} {$event.location.address.1.postal_code}{if $event.location.address.1.postal_code_suffix} - {$event.location.address.1.postal_code_suffix}{/if}\n{/if}\n\n{/if}{*End of isShowLocation condition*}\n\n{if $event.location.phone.1.phone || $event.location.email.1.email}\n\n{ts}Event Contacts:{/ts}\n{foreach from=$event.location.phone item=phone}\n{if $phone.phone}\n\n{if $phone.phone_type}{$phone.phone_type_display}{else}{ts}Phone{/ts}{/if}: {$phone.phone}{/if}\n{/foreach}\n{foreach from=$event.location.email item=eventEmail}\n{if $eventEmail.email}\n\n{ts}Email{/ts}: {$eventEmail.email}{/if}{/foreach}\n{/if}\n\n{capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n{ts}Download iCalendar File{/ts}: {$icalFeed}\n{if $contact.email}\n\n===========================================================\n{ts}Registered Email{/ts}\n\n===========================================================\n{$contact.email}\n{/if}\n\n{if $register_date}\n{ts}Registration Date{/ts}: {$participant.register_date|crmDate}\n{/if}\n\n{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions.{/ts}\n\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <p>{ts 1=$contact.display_name}Dear %1{/ts},</p>\n    <p>{ts 1=$event.event_title}Your pending event registration for %1 has expired\nbecause you did not confirm your registration.{/ts}</p>\n    <p>{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions\nor want to inquire about reinstating your registration for this event.{/ts}</p>\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Event Information and Location{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       {$event.event_title}<br />\n       {$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Participant Role{/ts}:\n      </td>\n      <td {$valueStyle}>\n       {$participant.role}\n      </td>\n     </tr>\n\n     {if $isShowLocation}\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {if $event.location.address.1.name}\n         {$event.location.address.1.name}<br />\n        {/if}\n        {if $event.location.address.1.street_address}\n         {$event.location.address.1.street_address}<br />\n        {/if}\n        {if $event.location.address.1.supplemental_address_1}\n         {$event.location.address.1.supplemental_address_1}<br />\n        {/if}\n        {if $event.location.address.1.supplemental_address_2}\n         {$event.location.address.1.supplemental_address_2}<br />\n        {/if}\n        {if $event.location.address.1.city}\n         {$event.location.address.1.city} {$event.location.address.1.postal_code}\n         {if $event.location.address.1.postal_code_suffix}\n          - {$event.location.address.1.postal_code_suffix}\n         {/if}\n        {/if}\n       </td>\n      </tr>\n     {/if}\n\n     {if $event.location.phone.1.phone || $event.location.email.1.email}\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {ts}Event Contacts:{/ts}\n       </td>\n      </tr>\n      {foreach from=$event.location.phone item=phone}\n       {if $phone.phone}\n        <tr>\n         <td {$labelStyle}>\n          {if $phone.phone_type}{$phone.phone_type_display}{else}{ts}Phone{/ts}{/if}\n         </td>\n         <td {$valueStyle}>\n          {$phone.phone}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n      {foreach from=$event.location.email item=eventEmail}\n       {if $eventEmail.email}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Email{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$eventEmail.email}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       <a href=\"{$icalFeed}\">{ts}Download iCalendar File{/ts}</a>\n      </td>\n     </tr>\n\n     {if $contact.email}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Registered Email{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$contact.email}\n       </td>\n      </tr>\n     {/if}\n\n     {if $register_date}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Registration Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$participant.register_date|crmDate}\n       </td>\n      </tr>\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n  <tr>\n   <td>\n    <p>{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions.{/ts}</p>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,498,1,0),(26,'Events - Pending Registration Expiration Notice','{ts 1=$event.event_title}Event registration has expired for %1{/ts}\n','{ts 1=$contact.display_name}Dear %1{/ts},\n\n{ts 1=$event.event_title}Your pending event registration for %1 has expired\nbecause you did not confirm your registration.{/ts}\n\n\n{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions\nor want to inquire about reinstating your registration for this event.{/ts}\n\n===========================================================\n{ts}Event Information and Location{/ts}\n\n===========================================================\n{$event.event_title}\n{$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n\n{ts}Participant Role{/ts}: {$participant.role}\n\n{if $isShowLocation}\n{if $event.location.address.1.name}\n\n{$event.location.address.1.name}\n{/if}\n{if $event.location.address.1.street_address}{$event.location.address.1.street_address}\n{/if}\n{if $event.location.address.1.supplemental_address_1}{$event.location.address.1.supplemental_address_1}\n{/if}\n{if $event.location.address.1.supplemental_address_2}{$event.location.address.1.supplemental_address_2}\n{/if}\n{if $event.location.address.1.city}{$event.location.address.1.city} {$event.location.address.1.postal_code}{if $event.location.address.1.postal_code_suffix} - {$event.location.address.1.postal_code_suffix}{/if}\n{/if}\n\n{/if}{*End of isShowLocation condition*}\n\n{if $event.location.phone.1.phone || $event.location.email.1.email}\n\n{ts}Event Contacts:{/ts}\n{foreach from=$event.location.phone item=phone}\n{if $phone.phone}\n\n{if $phone.phone_type}{$phone.phone_type_display}{else}{ts}Phone{/ts}{/if}: {$phone.phone}{/if}\n{/foreach}\n{foreach from=$event.location.email item=eventEmail}\n{if $eventEmail.email}\n\n{ts}Email{/ts}: {$eventEmail.email}{/if}{/foreach}\n{/if}\n\n{capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n{ts}Download iCalendar File{/ts}: {$icalFeed}\n{if $contact.email}\n\n===========================================================\n{ts}Registered Email{/ts}\n\n===========================================================\n{$contact.email}\n{/if}\n\n{if $register_date}\n{ts}Registration Date{/ts}: {$participant.register_date|crmDate}\n{/if}\n\n{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions.{/ts}\n\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <p>{ts 1=$contact.display_name}Dear %1{/ts},</p>\n    <p>{ts 1=$event.event_title}Your pending event registration for %1 has expired\nbecause you did not confirm your registration.{/ts}</p>\n    <p>{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions\nor want to inquire about reinstating your registration for this event.{/ts}</p>\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Event Information and Location{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       {$event.event_title}<br />\n       {$event.event_start_date|crmDate}{if $event.event_end_date}-{if $event.event_end_date|date_format:\"%Y%m%d\" == $event.event_start_date|date_format:\"%Y%m%d\"}{$event.event_end_date|crmDate:0:1}{else}{$event.event_end_date|crmDate}{/if}{/if}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Participant Role{/ts}:\n      </td>\n      <td {$valueStyle}>\n       {$participant.role}\n      </td>\n     </tr>\n\n     {if $isShowLocation}\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {if $event.location.address.1.name}\n         {$event.location.address.1.name}<br />\n        {/if}\n        {if $event.location.address.1.street_address}\n         {$event.location.address.1.street_address}<br />\n        {/if}\n        {if $event.location.address.1.supplemental_address_1}\n         {$event.location.address.1.supplemental_address_1}<br />\n        {/if}\n        {if $event.location.address.1.supplemental_address_2}\n         {$event.location.address.1.supplemental_address_2}<br />\n        {/if}\n        {if $event.location.address.1.city}\n         {$event.location.address.1.city} {$event.location.address.1.postal_code}\n         {if $event.location.address.1.postal_code_suffix}\n          - {$event.location.address.1.postal_code_suffix}\n         {/if}\n        {/if}\n       </td>\n      </tr>\n     {/if}\n\n     {if $event.location.phone.1.phone || $event.location.email.1.email}\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {ts}Event Contacts:{/ts}\n       </td>\n      </tr>\n      {foreach from=$event.location.phone item=phone}\n       {if $phone.phone}\n        <tr>\n         <td {$labelStyle}>\n          {if $phone.phone_type}{$phone.phone_type_display}{else}{ts}Phone{/ts}{/if}\n         </td>\n         <td {$valueStyle}>\n          {$phone.phone}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n      {foreach from=$event.location.email item=eventEmail}\n       {if $eventEmail.email}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Email{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$eventEmail.email}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {capture assign=icalFeed}{crmURL p=\'civicrm/event/ical\' q=\"reset=1&id=`$event.id`\" h=0 a=1 fe=1}{/capture}\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       <a href=\"{$icalFeed}\">{ts}Download iCalendar File{/ts}</a>\n      </td>\n     </tr>\n\n     {if $contact.email}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Registered Email{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$contact.email}\n       </td>\n      </tr>\n     {/if}\n\n     {if $register_date}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Registration Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$participant.register_date|crmDate}\n       </td>\n      </tr>\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n  <tr>\n   <td>\n    <p>{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions.{/ts}</p>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,498,0,1),(27,'Tell-a-Friend Email','{ts 1=$senderContactName 2=$title}%1 wants you to know about %2{/ts}\n','{$senderMessage}\n\n{if $generalLink}{ts}For more information, visit:{/ts}\n>> {$generalLink}\n\n{/if}\n{if $contribute}{ts}To make a contribution, go to:{/ts}\n>> {$pageURL}\n\n{/if}\n{if $event}{ts}To find out more about this event, go to:{/ts}\n>> {$pageURL}\n{/if}\n\n\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <p>{$senderMessage}</p>\n    {if $generalLink}\n     <p><a href=\"{$generalLink}\">{ts}More information{/ts}</a></p>\n    {/if}\n    {if $contribute}\n     <p><a href=\"{$pageURL}\">{ts}Make a contribution{/ts}</a></p>\n    {/if}\n    {if $event}\n     <p><a href=\"{$pageURL}\">{ts}Find out more about this event{/ts}</a></p>\n    {/if}\n   </td>\n  </tr>\n </table>\n</center>\n\n</body>\n</html>\n',1,499,1,0),(28,'Tell-a-Friend Email','{ts 1=$senderContactName 2=$title}%1 wants you to know about %2{/ts}\n','{$senderMessage}\n\n{if $generalLink}{ts}For more information, visit:{/ts}\n>> {$generalLink}\n\n{/if}\n{if $contribute}{ts}To make a contribution, go to:{/ts}\n>> {$pageURL}\n\n{/if}\n{if $event}{ts}To find out more about this event, go to:{/ts}\n>> {$pageURL}\n{/if}\n\n\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <p>{$senderMessage}</p>\n    {if $generalLink}\n     <p><a href=\"{$generalLink}\">{ts}More information{/ts}</a></p>\n    {/if}\n    {if $contribute}\n     <p><a href=\"{$pageURL}\">{ts}Make a contribution{/ts}</a></p>\n    {/if}\n    {if $event}\n     <p><a href=\"{$pageURL}\">{ts}Find out more about this event{/ts}</a></p>\n    {/if}\n   </td>\n  </tr>\n </table>\n</center>\n\n</body>\n</html>\n',1,499,0,1),(29,'Memberships - Signup and Renewal Receipts (off-line)','{if $receiptType EQ \'membership signup\'}\n{ts}Membership Confirmation and Receipt{/ts}\n{elseif $receiptType EQ \'membership renewal\'}\n{ts}Membership Renewal Confirmation and Receipt{/ts}\n{/if}\n','{if $formValues.receipt_text_signup}\n{$formValues.receipt_text_signup}\n{elseif $formValues.receipt_text_renewal}\n{$formValues.receipt_text_renewal}\n{else}{ts}Thanks for your support.{/ts}{/if}\n\n{if ! $cancelled}{ts}Please print this receipt for your records.{/ts}\n\n\n{/if}\n===========================================================\n{ts}Membership Information{/ts}\n\n===========================================================\n{ts}Membership Type{/ts}: {$membership_name}\n{if ! $cancelled}\n{ts}Membership Start Date{/ts}: {$mem_start_date}\n{ts}Membership End Date{/ts}: {$mem_end_date}\n{if $formValues.total_amount}\n===========================================================\n{ts}Membership Fee{/ts}\n\n===========================================================\n{if $formValues.contributionType_name}\n{ts}Contribution Type{/ts}: {$formValues.contributionType_name}\n{/if}\n{ts}Amount{/ts}: {$formValues.total_amount|crmMoney}\n{if $receive_date}\n{ts}Received Date{/ts}: {$receive_date|truncate:10:\'\'|crmDate}\n{/if}\n{if $formValues.paidBy}\n{ts}Paid By{/ts}: {$formValues.paidBy}\n{if $formValues.check_number}\n{ts}Check Number{/ts}: {$formValues.check_number} \n{/if}\n{/if}\n{/if}\n{/if}\n\n{if $isPrimary }\n{if $contributeMode ne \'notify\' and !$isAmountzero and !$is_pay_later  }\n\n===========================================================\n{ts}Billing Name and Address{/ts}\n\n===========================================================\n{$billingName}\n{$address}\n{/if}\n\n{if $contributeMode eq \'direct\' and !$isAmountzero and !$is_pay_later}\n===========================================================\n{ts}Credit Card Information{/ts}\n\n===========================================================\n{$credit_card_type}\n{$credit_card_number}\n{ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n{/if}\n{/if}\n\n{if $customValues}\n===========================================================\n{ts}Membership Options{/ts}\n\n===========================================================\n{foreach from=$customValues item=value key=customName}\n {$customName} : {$value}\n{/foreach}\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    {if $formValues.receipt_text_signup}\n     <p>{$formValues.receipt_text_signup|htmlize}</p>\n    {elseif $formValues.receipt_text_renewal}\n     <p>{$formValues.receipt_text_renewal|htmlize}</p>\n    {else}\n     <p>{ts}Thanks for your support.{/ts}</p>\n    {/if}\n    {if ! $cancelled}\n     <p>{ts}Please print this receipt for your records.{/ts}</p>\n    {/if}\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Membership Information{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Membership Type{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$membership_name}\n      </td>\n     </tr>\n     {if ! $cancelled}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Membership Start Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$mem_start_date}\n       </td>\n      </tr>\n      <tr>\n       <td {$labelStyle}>\n        {ts}Membership End Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$mem_end_date}\n       </td>\n      </tr>\n      {if $formValues.total_amount}\n       <tr>\n        <th {$headerStyle}>\n         {ts}Membership Fee{/ts}\n        </th>\n       </tr>\n       {if $formValues.contributionType_name}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Contribution Type{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$formValues.contributionType_name}\n         </td>\n        </tr>\n       {/if}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Amount{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$formValues.total_amount|crmMoney}\n        </td>\n       </tr>\n       {if $receive_date}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Received Date{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$receive_date|truncate:10:\'\'|crmDate}\n         </td>\n        </tr>\n       {/if}\n       {if $formValues.paidBy}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Paid By{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$formValues.paidBy}\n         </td>\n        </tr>\n        {if $formValues.check_number}\n         <tr>\n          <td {$labelStyle}>\n           {ts}Check Number{/ts}\n          </td>\n          <td {$valueStyle}>\n           {$formValues.check_number}\n          </td>\n         </tr>\n        {/if}\n       {/if}\n      {/if}\n     {/if}\n    </table>\n   </td>\n  </tr>\n\n  {if $isPrimary}\n   <tr>\n    <td>\n     <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n\n      {if $contributeMode ne \'notify\' and !$isAmountzero and !$is_pay_later }\n       <tr>\n        <th {$headerStyle}>\n         {ts}Billing Name and Address{/ts}\n        </th>\n       </tr>\n       <tr>\n        <td {$labelStyle}>\n         {$billingName}<br />\n         {$address}\n        </td>\n       </tr>\n      {/if}\n\n      {if $contributeMode eq \'direct\' and !$isAmountzero and !$is_pay_later}\n       <tr>\n        <th {$headerStyle}>\n         {ts}Credit Card Information{/ts}\n        </th>\n       </tr>\n       <tr>\n        <td {$valueStyle}>\n         {$credit_card_type}<br />\n         {$credit_card_number}\n        </td>\n       </tr>\n       <tr>\n        <td {$labelStyle}>\n         {ts}Expires{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n        </td>\n       </tr>\n      {/if}\n\n     </table>\n    </td>\n   </tr>\n  {/if}\n\n  {if $customValues}\n   <tr>\n    <td>\n     <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n      <tr>\n       <th {$headerStyle}>\n        {ts}Membership Options{/ts}\n       </th>\n      </tr>\n      {foreach from=$customValues item=value key=customName}\n       <tr>\n        <td {$labelStyle}>\n         {$customName}\n        </td>\n        <td {$valueStyle}>\n         {$value}\n        </td>\n       </tr>\n      {/foreach}\n     </table>\n    </td>\n   </tr>\n  {/if}\n\n </table>\n</center>\n\n</body>\n</html>\n',1,500,1,0),(30,'Memberships - Signup and Renewal Receipts (off-line)','{if $receiptType EQ \'membership signup\'}\n{ts}Membership Confirmation and Receipt{/ts}\n{elseif $receiptType EQ \'membership renewal\'}\n{ts}Membership Renewal Confirmation and Receipt{/ts}\n{/if}\n','{if $formValues.receipt_text_signup}\n{$formValues.receipt_text_signup}\n{elseif $formValues.receipt_text_renewal}\n{$formValues.receipt_text_renewal}\n{else}{ts}Thanks for your support.{/ts}{/if}\n\n{if ! $cancelled}{ts}Please print this receipt for your records.{/ts}\n\n\n{/if}\n===========================================================\n{ts}Membership Information{/ts}\n\n===========================================================\n{ts}Membership Type{/ts}: {$membership_name}\n{if ! $cancelled}\n{ts}Membership Start Date{/ts}: {$mem_start_date}\n{ts}Membership End Date{/ts}: {$mem_end_date}\n{if $formValues.total_amount}\n===========================================================\n{ts}Membership Fee{/ts}\n\n===========================================================\n{if $formValues.contributionType_name}\n{ts}Contribution Type{/ts}: {$formValues.contributionType_name}\n{/if}\n{ts}Amount{/ts}: {$formValues.total_amount|crmMoney}\n{if $receive_date}\n{ts}Received Date{/ts}: {$receive_date|truncate:10:\'\'|crmDate}\n{/if}\n{if $formValues.paidBy}\n{ts}Paid By{/ts}: {$formValues.paidBy}\n{if $formValues.check_number}\n{ts}Check Number{/ts}: {$formValues.check_number} \n{/if}\n{/if}\n{/if}\n{/if}\n\n{if $isPrimary }\n{if $contributeMode ne \'notify\' and !$isAmountzero and !$is_pay_later  }\n\n===========================================================\n{ts}Billing Name and Address{/ts}\n\n===========================================================\n{$billingName}\n{$address}\n{/if}\n\n{if $contributeMode eq \'direct\' and !$isAmountzero and !$is_pay_later}\n===========================================================\n{ts}Credit Card Information{/ts}\n\n===========================================================\n{$credit_card_type}\n{$credit_card_number}\n{ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n{/if}\n{/if}\n\n{if $customValues}\n===========================================================\n{ts}Membership Options{/ts}\n\n===========================================================\n{foreach from=$customValues item=value key=customName}\n {$customName} : {$value}\n{/foreach}\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    {if $formValues.receipt_text_signup}\n     <p>{$formValues.receipt_text_signup|htmlize}</p>\n    {elseif $formValues.receipt_text_renewal}\n     <p>{$formValues.receipt_text_renewal|htmlize}</p>\n    {else}\n     <p>{ts}Thanks for your support.{/ts}</p>\n    {/if}\n    {if ! $cancelled}\n     <p>{ts}Please print this receipt for your records.{/ts}</p>\n    {/if}\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Membership Information{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Membership Type{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$membership_name}\n      </td>\n     </tr>\n     {if ! $cancelled}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Membership Start Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$mem_start_date}\n       </td>\n      </tr>\n      <tr>\n       <td {$labelStyle}>\n        {ts}Membership End Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$mem_end_date}\n       </td>\n      </tr>\n      {if $formValues.total_amount}\n       <tr>\n        <th {$headerStyle}>\n         {ts}Membership Fee{/ts}\n        </th>\n       </tr>\n       {if $formValues.contributionType_name}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Contribution Type{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$formValues.contributionType_name}\n         </td>\n        </tr>\n       {/if}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Amount{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$formValues.total_amount|crmMoney}\n        </td>\n       </tr>\n       {if $receive_date}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Received Date{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$receive_date|truncate:10:\'\'|crmDate}\n         </td>\n        </tr>\n       {/if}\n       {if $formValues.paidBy}\n        <tr>\n         <td {$labelStyle}>\n          {ts}Paid By{/ts}\n         </td>\n         <td {$valueStyle}>\n          {$formValues.paidBy}\n         </td>\n        </tr>\n        {if $formValues.check_number}\n         <tr>\n          <td {$labelStyle}>\n           {ts}Check Number{/ts}\n          </td>\n          <td {$valueStyle}>\n           {$formValues.check_number}\n          </td>\n         </tr>\n        {/if}\n       {/if}\n      {/if}\n     {/if}\n    </table>\n   </td>\n  </tr>\n\n  {if $isPrimary}\n   <tr>\n    <td>\n     <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n\n      {if $contributeMode ne \'notify\' and !$isAmountzero and !$is_pay_later }\n       <tr>\n        <th {$headerStyle}>\n         {ts}Billing Name and Address{/ts}\n        </th>\n       </tr>\n       <tr>\n        <td {$labelStyle}>\n         {$billingName}<br />\n         {$address}\n        </td>\n       </tr>\n      {/if}\n\n      {if $contributeMode eq \'direct\' and !$isAmountzero and !$is_pay_later}\n       <tr>\n        <th {$headerStyle}>\n         {ts}Credit Card Information{/ts}\n        </th>\n       </tr>\n       <tr>\n        <td {$valueStyle}>\n         {$credit_card_type}<br />\n         {$credit_card_number}\n        </td>\n       </tr>\n       <tr>\n        <td {$labelStyle}>\n         {ts}Expires{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n        </td>\n       </tr>\n      {/if}\n\n     </table>\n    </td>\n   </tr>\n  {/if}\n\n  {if $customValues}\n   <tr>\n    <td>\n     <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n      <tr>\n       <th {$headerStyle}>\n        {ts}Membership Options{/ts}\n       </th>\n      </tr>\n      {foreach from=$customValues item=value key=customName}\n       <tr>\n        <td {$labelStyle}>\n         {$customName}\n        </td>\n        <td {$valueStyle}>\n         {$value}\n        </td>\n       </tr>\n      {/foreach}\n     </table>\n    </td>\n   </tr>\n  {/if}\n\n </table>\n</center>\n\n</body>\n</html>\n',1,500,0,1),(31,'Memberships - Receipt (on-line)','{if $is_pay_later}{ts}Invoice{/ts}{else}{ts}Receipt{/ts}{/if} - {$title}\n','{if $receipt_text}\n{$receipt_text}\n{/if}\n{if $is_pay_later}\n\n===========================================================\n{$pay_later_receipt}\n===========================================================\n{else}\n\n{ts}Please print this receipt for your records.{/ts}\n{/if}\n\n{if $membership_assign}\n===========================================================\n{ts}Membership Information{/ts}\n\n===========================================================\n{ts}Membership Type{/ts}: {$membership_name}\n{if $mem_start_date}{ts}Membership Start Date{/ts}: {$mem_start_date|crmDate}\n{/if}\n{if $mem_end_date}{ts}Membership End Date{/ts}: {$mem_end_date|crmDate}\n{/if}\n\n{/if}\n{if $amount}\n===========================================================\n{ts}Membership Fee{/ts}\n\n===========================================================\n{if $membership_amount }\n{ts 1=$membership_name}%1 Membership{/ts}: {$membership_amount|crmMoney}\n{if $amount}\n{if ! $is_separate_payment }\n{ts}Contribution Amount{/ts}: {$amount|crmMoney}\n{else}\n{ts}Additional Contribution{/ts}: {$amount|crmMoney}\n{/if}\n{/if}\n-------------------------------------------\n{ts}Total{/ts}: {$amount+$membership_amount|crmMoney}\n{elseif $lineItem and $priceSetID}\n{foreach from=$lineItem item=value key=priceset}\n---------------------------------------------------------\n{capture assign=ts_item}{ts}Item{/ts}{/capture}\n{capture assign=ts_qty}{ts}Qty{/ts}{/capture}\n{capture assign=ts_each}{ts}Each{/ts}{/capture}\n{capture assign=ts_total}{ts}Total{/ts}{/capture}\n{$ts_item|string_format:\"%-30s\"} {$ts_qty|string_format:\"%5s\"} {$ts_each|string_format:\"%10s\"} {$ts_total|string_format:\"%10s\"}\n----------------------------------------------------------\n{foreach from=$value item=line}\n{$line.description|truncate:30:\"...\"|string_format:\"%-30s\"} {$line.qty|string_format:\"%5s\"} {$line.unit_price|crmMoney|string_format:\"%10s\"} {$line.line_total|crmMoney|string_format:\"%10s\"}\n{/foreach}\n{/foreach}\n\n{ts}Total Amount{/ts}: {$amount|crmMoney}\n{else}\n{ts}Amount{/ts}: {$amount|crmMoney} {if $amount_level } - {$amount_level} {/if}\n{/if}\n{elseif $membership_amount}\n===========================================================\n{ts}Membership Fee{/ts}\n\n===========================================================\n{ts 1=$membership_name}%1 Membership{/ts}: {$membership_amount|crmMoney}\n{/if}\n{if $receive_date}\n\n{ts}Date{/ts}: {$receive_date|crmDate}\n{/if}\n{if $is_monetary and $trxn_id}\n{ts}Transaction #{/ts}: {$trxn_id}\n{/if}\n{if $membership_trx_id}\n{ts}Membership Transaction #{/ts}: {$membership_trx_id}\n\n{/if}\n{if $is_recur}\n{if $contributeMode eq \'notify\'}\n{ts}This is a recurring contribution. You can modify or cancel future contributions by logging in to your account at:{/ts}\n\n{$cancelSubscriptionUrl}\n{elseif $contributeMode eq \'directIPN\' and $receiptFromEmail}\n{ts 1=$receiptFromEmail}This is a recurring contribution. To modify or cancel future contributions please contact us at %1.{/ts}\n\n{/if}\n{/if}\n\n{if $honor_block_is_active }\n===========================================================\n{$honor_type}\n===========================================================\n{$honor_prefix} {$honor_first_name} {$honor_last_name}\n{if $honor_email}\n{ts}Honoree Email{/ts}: {$honor_email}\n{/if}\n\n{/if}\n{if $pcpBlock}\n===========================================================\n{ts}Personal Campaign Page{/ts}\n\n===========================================================\n{ts}Display In Honor Roll{/ts}: {if $pcp_display_in_roll}{ts}Yes{/ts}{else}{ts}No{/ts}{/if}\n\n{if $pcp_roll_nickname}{ts}Nick Name{/ts}: {$pcp_roll_nickname}{/if}\n\n{if $pcp_personal_note}{ts}Personal Note{/ts}: {$pcp_personal_note}{/if}\n\n{/if}\n{if $onBehalfName}\n===========================================================\n{ts}On Behalf Of{/ts}\n\n===========================================================\n{$onBehalfName}\n{$onBehalfAddress}\n\n{$onBehalfEmail}\n\n{/if}\n\n{if !( $contributeMode eq \'notify\' OR $contributeMode eq \'directIPN\' ) and $is_monetary}\n{if $is_pay_later}\n===========================================================\n{ts}Registered Email{/ts}\n\n===========================================================\n{$email}\n{elseif $amount GT 0 OR $membership_amount GT 0 }\n===========================================================\n{ts}Billing Name and Address{/ts}\n\n===========================================================\n{$billingName}\n{$address}\n\n{$email}\n{/if} {* End ! is_pay_later condition. *}\n{/if}\n{if $contributeMode eq \'direct\' AND !$is_pay_later AND ( $amount GT 0 OR $membership_amount GT 0 ) }\n\n===========================================================\n{ts}Credit Card Information{/ts}\n\n===========================================================\n{$credit_card_type}\n{$credit_card_number}\n{ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n{/if}\n\n{if $selectPremium }\n===========================================================\n{ts}Premium Information{/ts}\n\n===========================================================\n{$product_name}\n{if $option}\n{ts}Option{/ts}: {$option}\n{/if}\n{if $sku}\n{ts}SKU{/ts}: {$sku}\n{/if}\n{if $start_date}\n{ts}Start Date{/ts}: {$start_date|crmDate}\n{/if}\n{if $end_date}\n{ts}End Date{/ts}: {$end_date|crmDate}\n{/if}\n{if $contact_email OR $contact_phone}\n\n{ts}For information about this premium, contact:{/ts}\n\n{if $contact_email}\n  {$contact_email}\n{/if}\n{if $contact_phone}\n  {$contact_phone}\n{/if}\n{/if}\n{if $is_deductible AND $price}\n\n{ts 1=$price|crmMoney}The value of this premium is %1. This may affect the amount of the tax deduction you can claim. Consult your tax advisor for more information.{/ts}{/if}\n{/if}\n\n{if $customPre}\n===========================================================\n{$customPre_grouptitle}\n\n===========================================================\n{foreach from=$customPre item=customValue key=customName}\n{if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n {$customName}: {$customValue}\n{/if}\n{/foreach}\n{/if}\n\n\n{if $customPost}\n===========================================================\n{$customPost_grouptitle}\n\n===========================================================\n{foreach from=$customPost item=customValue key=customName}\n{if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n {$customName}: {$customValue}\n{/if}\n{/foreach}\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n\n    {if $receipt_text}\n     <p>{$receipt_text|htmlize}</p>\n    {/if}\n\n    {if $is_pay_later}\n     <p>{$pay_later_receipt}</p> {* FIXME: this might be text rather than HTML *}\n    {else}\n     <p>{ts}Please print this confirmation for your records.{/ts}</p>\n    {/if}\n\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n\n     {if $membership_assign}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Membership Information{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td {$labelStyle}>\n        {ts}Membership Type{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$membership_name}\n       </td>\n      </tr>\n      {if $mem_start_date}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Membership Start Date{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$mem_start_date|crmDate}\n        </td>\n       </tr>\n      {/if}\n      {if $mem_end_date}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Membership End Date{/ts}\n        </td>\n        <td {$valueStyle}>\n          {$mem_end_date|crmDate}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n\n     {if $amount}\n\n\n      <tr>\n       <th {$headerStyle}>\n        {ts}Membership Fee{/ts}\n       </th>\n      </tr>\n\n      {if $membership_amount}\n\n       <tr>\n        <td {$labelStyle}>\n         {ts 1=$membership_name}%1 Membership{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$membership_amount|crmMoney}\n        </td>\n       </tr>\n       {if $amount}\n        {if ! $is_separate_payment }\n         <tr>\n          <td {$labelStyle}>\n           {ts}Contribution Amount{/ts}\n          </td>\n          <td {$valueStyle}>\n           {$amount|crmMoney}\n          </td>\n         </tr>\n        {else}\n         <tr>\n          <td {$labelStyle}>\n           {ts}Additional Contribution{/ts}\n          </td>\n          <td {$valueStyle}>\n           {$amount|crmMoney}\n          </td>\n         </tr>\n        {/if}\n       {/if}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Total{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$amount+$membership_amount|crmMoney}\n        </td>\n       </tr>\n\n      {elseif $lineItem and $priceSetID}\n\n       {foreach from=$lineItem item=value key=priceset}\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          <table> {* FIXME: style this table so that it looks like the text version (justification, etc.) *}\n           <tr>\n            <th>{ts}Item{/ts}</th>\n            <th>{ts}Qty{/ts}</th>\n            <th>{ts}Each{/ts}</th>\n            <th>{ts}Total{/ts}</th>\n           </tr>\n           {foreach from=$value item=line}\n            <tr>\n             <td>\n              {$line.description|truncate:30:\"...\"}\n             </td>\n             <td>\n              {$line.qty}\n             </td>\n             <td>\n              {$line.unit_price|crmMoney}\n             </td>\n             <td>\n              {$line.line_total|crmMoney}\n             </td>\n            </tr>\n           {/foreach}\n          </table>\n         </td>\n        </tr>\n       {/foreach}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Total Amount{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$amount|crmMoney}\n        </td>\n       </tr>\n\n      {else}\n\n       <tr>\n        <td {$labelStyle}>\n         {ts}Amount{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$amount|crmMoney} {if $amount_level} - {$amount_level}{/if}\n        </td>\n       </tr>\n\n      {/if}\n\n\n     {elseif $membership_amount}\n\n\n      <tr>\n       <th {$headerStyle}>\n        {ts}Membership Fee{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td {$labelStyle}>\n        {ts 1=$membership_name}%1 Membership{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$membership_amount|crmMoney}\n       </td>\n      </tr>\n\n\n     {/if}\n\n\n     {if $receive_date}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$receive_date|crmDate}\n       </td>\n      </tr>\n     {/if}\n\n     {if $is_monetary and $trxn_id}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Transaction #{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$trxn_id}\n       </td>\n      </tr>\n     {/if}\n\n     {if $membership_trx_id}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Membership Transaction #{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$membership_trx_id}\n       </td>\n      </tr>\n     {/if}\n\n     {if $is_recur}\n      {if $contributeMode eq \'notify\'}\n       <tr>\n        <td {$labelStyle}>\n         {ts 1=$cancelSubscriptionUrl}This is a recurring contribution. You can modify or cancel future contributions by <a href=\"%1\">logging in to your account</a>.{/ts}\n        </td>\n       </tr>\n      {elseif $contributeMode eq \'directIPN\' and $receiptFromEmail}\n       <tr>\n        <td {$labelStyle}>\n         {ts 1=$receiptFromEmail}This is a recurring contribution. To modify or cancel future contributions please contact us at %1.{/ts}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $honor_block_is_active}\n      <tr>\n       <th {$headerStyle}>\n        {$honor_type}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {$honor_prefix} {$honor_first_name} {$honor_last_name}\n       </td>\n      </tr>\n      {if $honor_email}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Honoree Email{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$honor_email}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $pcpBlock}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Personal Campaign Page{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td {$labelStyle}>\n        {ts}Display In Honor Roll{/ts}\n       </td>\n       <td {$valueStyle}>\n        {if $pcp_display_in_roll}{ts}Yes{/ts}{else}{ts}No{/ts}{/if}\n       </td>\n      </tr>\n      {if $pcp_roll_nickname}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Nick Name{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$pcp_roll_nickname}\n        </td>\n       </tr>\n      {/if}\n      {if $pcp_personal_note}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Personal Note{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$pcp_personal_note}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $onBehalfName}\n      <tr>\n       <th {$headerStyle}>\n        {ts}On Behalf Of{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$onBehalfName}<br />\n        {$onBehalfAddress|nl2br}<br />\n        {$onBehalfEmail}\n       </td>\n      </tr>\n     {/if}\n\n     {if ! ($contributeMode eq \'notify\' OR $contributeMode eq \'directIPN\') and $is_monetary}\n      {if $is_pay_later}\n       <tr>\n        <th {$headerStyle}>\n         {ts}Registered Email{/ts}\n        </th>\n       </tr>\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         {$email}\n        </td>\n       </tr>\n      {elseif $amount GT 0 OR $membership_amount GT 0}\n       <tr>\n        <th {$headerStyle}>\n         {ts}Billing Name and Address{/ts}\n        </th>\n       </tr>\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         {$billingName}<br />\n         {$address|nl2br}<br />\n         {$email}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $contributeMode eq \'direct\' AND !$is_pay_later AND ($amount GT 0 OR $membership_amount GT 0)}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Credit Card Information{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$credit_card_type}<br />\n        {$credit_card_number}<br />\n        {ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}<br />\n       </td>\n      </tr>\n     {/if}\n\n     {if $selectPremium}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Premium Information{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {$product_name}\n       </td>\n      </tr>\n      {if $option}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Option{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$option}\n        </td>\n       </tr>\n      {/if}\n      {if $sku}\n       <tr>\n        <td {$labelStyle}>\n         {ts}SKU{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$sku}\n        </td>\n       </tr>\n      {/if}\n      {if $start_date}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Start Date{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$start_date|crmDate}\n        </td>\n       </tr>\n      {/if}\n      {if $end_date}\n       <tr>\n        <td {$labelStyle}>\n         {ts}End Date{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$end_date|crmDate}\n        </td>\n       </tr>\n      {/if}\n      {if $contact_email OR $contact_phone}\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         <p>{ts}For information about this premium, contact:{/ts}</p>\n         {if $contact_email}\n          <p>{$contact_email}</p>\n         {/if}\n         {if $contact_phone}\n          <p>{$contact_phone}</p>\n         {/if}\n        </td>\n       </tr>\n      {/if}\n      {if $is_deductible AND $price}\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          <p>{ts 1=$price|crmMoney}The value of this premium is %1. This may affect the amount of the tax deduction you can claim. Consult your tax advisor for more information.{/ts}</p>\n         </td>\n        </tr>\n      {/if}\n     {/if}\n\n     {if $customPre}\n      <tr>\n       <th {$headerStyle}>\n        {$customPre_grouptitle}\n       </th>\n      </tr>\n      {foreach from=$customPre item=customValue key=customName}\n       {if ($trackingFields and ! in_array($customName, $trackingFields)) or ! $trackingFields}\n        <tr>\n         <td {$labelStyle}>\n          {$customName}\n         </td>\n         <td {$valueStyle}>\n          {$customValue}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {if $customPost}\n      <tr>\n       <th {$headerStyle}>\n        {$customPost_grouptitle}\n       </th>\n      </tr>\n      {foreach from=$customPost item=customValue key=customName}\n       {if ($trackingFields and ! in_array($customName, $trackingFields)) or ! $trackingFields}\n        <tr>\n         <td {$labelStyle}>\n          {$customName}\n         </td>\n         <td {$valueStyle}>\n          {$customValue}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,501,1,0),(32,'Memberships - Receipt (on-line)','{if $is_pay_later}{ts}Invoice{/ts}{else}{ts}Receipt{/ts}{/if} - {$title}\n','{if $receipt_text}\n{$receipt_text}\n{/if}\n{if $is_pay_later}\n\n===========================================================\n{$pay_later_receipt}\n===========================================================\n{else}\n\n{ts}Please print this receipt for your records.{/ts}\n{/if}\n\n{if $membership_assign}\n===========================================================\n{ts}Membership Information{/ts}\n\n===========================================================\n{ts}Membership Type{/ts}: {$membership_name}\n{if $mem_start_date}{ts}Membership Start Date{/ts}: {$mem_start_date|crmDate}\n{/if}\n{if $mem_end_date}{ts}Membership End Date{/ts}: {$mem_end_date|crmDate}\n{/if}\n\n{/if}\n{if $amount}\n===========================================================\n{ts}Membership Fee{/ts}\n\n===========================================================\n{if $membership_amount }\n{ts 1=$membership_name}%1 Membership{/ts}: {$membership_amount|crmMoney}\n{if $amount}\n{if ! $is_separate_payment }\n{ts}Contribution Amount{/ts}: {$amount|crmMoney}\n{else}\n{ts}Additional Contribution{/ts}: {$amount|crmMoney}\n{/if}\n{/if}\n-------------------------------------------\n{ts}Total{/ts}: {$amount+$membership_amount|crmMoney}\n{elseif $lineItem and $priceSetID}\n{foreach from=$lineItem item=value key=priceset}\n---------------------------------------------------------\n{capture assign=ts_item}{ts}Item{/ts}{/capture}\n{capture assign=ts_qty}{ts}Qty{/ts}{/capture}\n{capture assign=ts_each}{ts}Each{/ts}{/capture}\n{capture assign=ts_total}{ts}Total{/ts}{/capture}\n{$ts_item|string_format:\"%-30s\"} {$ts_qty|string_format:\"%5s\"} {$ts_each|string_format:\"%10s\"} {$ts_total|string_format:\"%10s\"}\n----------------------------------------------------------\n{foreach from=$value item=line}\n{$line.description|truncate:30:\"...\"|string_format:\"%-30s\"} {$line.qty|string_format:\"%5s\"} {$line.unit_price|crmMoney|string_format:\"%10s\"} {$line.line_total|crmMoney|string_format:\"%10s\"}\n{/foreach}\n{/foreach}\n\n{ts}Total Amount{/ts}: {$amount|crmMoney}\n{else}\n{ts}Amount{/ts}: {$amount|crmMoney} {if $amount_level } - {$amount_level} {/if}\n{/if}\n{elseif $membership_amount}\n===========================================================\n{ts}Membership Fee{/ts}\n\n===========================================================\n{ts 1=$membership_name}%1 Membership{/ts}: {$membership_amount|crmMoney}\n{/if}\n{if $receive_date}\n\n{ts}Date{/ts}: {$receive_date|crmDate}\n{/if}\n{if $is_monetary and $trxn_id}\n{ts}Transaction #{/ts}: {$trxn_id}\n{/if}\n{if $membership_trx_id}\n{ts}Membership Transaction #{/ts}: {$membership_trx_id}\n\n{/if}\n{if $is_recur}\n{if $contributeMode eq \'notify\'}\n{ts}This is a recurring contribution. You can modify or cancel future contributions by logging in to your account at:{/ts}\n\n{$cancelSubscriptionUrl}\n{elseif $contributeMode eq \'directIPN\' and $receiptFromEmail}\n{ts 1=$receiptFromEmail}This is a recurring contribution. To modify or cancel future contributions please contact us at %1.{/ts}\n\n{/if}\n{/if}\n\n{if $honor_block_is_active }\n===========================================================\n{$honor_type}\n===========================================================\n{$honor_prefix} {$honor_first_name} {$honor_last_name}\n{if $honor_email}\n{ts}Honoree Email{/ts}: {$honor_email}\n{/if}\n\n{/if}\n{if $pcpBlock}\n===========================================================\n{ts}Personal Campaign Page{/ts}\n\n===========================================================\n{ts}Display In Honor Roll{/ts}: {if $pcp_display_in_roll}{ts}Yes{/ts}{else}{ts}No{/ts}{/if}\n\n{if $pcp_roll_nickname}{ts}Nick Name{/ts}: {$pcp_roll_nickname}{/if}\n\n{if $pcp_personal_note}{ts}Personal Note{/ts}: {$pcp_personal_note}{/if}\n\n{/if}\n{if $onBehalfName}\n===========================================================\n{ts}On Behalf Of{/ts}\n\n===========================================================\n{$onBehalfName}\n{$onBehalfAddress}\n\n{$onBehalfEmail}\n\n{/if}\n\n{if !( $contributeMode eq \'notify\' OR $contributeMode eq \'directIPN\' ) and $is_monetary}\n{if $is_pay_later}\n===========================================================\n{ts}Registered Email{/ts}\n\n===========================================================\n{$email}\n{elseif $amount GT 0 OR $membership_amount GT 0 }\n===========================================================\n{ts}Billing Name and Address{/ts}\n\n===========================================================\n{$billingName}\n{$address}\n\n{$email}\n{/if} {* End ! is_pay_later condition. *}\n{/if}\n{if $contributeMode eq \'direct\' AND !$is_pay_later AND ( $amount GT 0 OR $membership_amount GT 0 ) }\n\n===========================================================\n{ts}Credit Card Information{/ts}\n\n===========================================================\n{$credit_card_type}\n{$credit_card_number}\n{ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}\n{/if}\n\n{if $selectPremium }\n===========================================================\n{ts}Premium Information{/ts}\n\n===========================================================\n{$product_name}\n{if $option}\n{ts}Option{/ts}: {$option}\n{/if}\n{if $sku}\n{ts}SKU{/ts}: {$sku}\n{/if}\n{if $start_date}\n{ts}Start Date{/ts}: {$start_date|crmDate}\n{/if}\n{if $end_date}\n{ts}End Date{/ts}: {$end_date|crmDate}\n{/if}\n{if $contact_email OR $contact_phone}\n\n{ts}For information about this premium, contact:{/ts}\n\n{if $contact_email}\n  {$contact_email}\n{/if}\n{if $contact_phone}\n  {$contact_phone}\n{/if}\n{/if}\n{if $is_deductible AND $price}\n\n{ts 1=$price|crmMoney}The value of this premium is %1. This may affect the amount of the tax deduction you can claim. Consult your tax advisor for more information.{/ts}{/if}\n{/if}\n\n{if $customPre}\n===========================================================\n{$customPre_grouptitle}\n\n===========================================================\n{foreach from=$customPre item=customValue key=customName}\n{if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n {$customName}: {$customValue}\n{/if}\n{/foreach}\n{/if}\n\n\n{if $customPost}\n===========================================================\n{$customPost_grouptitle}\n\n===========================================================\n{foreach from=$customPost item=customValue key=customName}\n{if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}\n {$customName}: {$customValue}\n{/if}\n{/foreach}\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n\n    {if $receipt_text}\n     <p>{$receipt_text|htmlize}</p>\n    {/if}\n\n    {if $is_pay_later}\n     <p>{$pay_later_receipt}</p> {* FIXME: this might be text rather than HTML *}\n    {else}\n     <p>{ts}Please print this confirmation for your records.{/ts}</p>\n    {/if}\n\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n\n     {if $membership_assign}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Membership Information{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td {$labelStyle}>\n        {ts}Membership Type{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$membership_name}\n       </td>\n      </tr>\n      {if $mem_start_date}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Membership Start Date{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$mem_start_date|crmDate}\n        </td>\n       </tr>\n      {/if}\n      {if $mem_end_date}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Membership End Date{/ts}\n        </td>\n        <td {$valueStyle}>\n          {$mem_end_date|crmDate}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n\n     {if $amount}\n\n\n      <tr>\n       <th {$headerStyle}>\n        {ts}Membership Fee{/ts}\n       </th>\n      </tr>\n\n      {if $membership_amount}\n\n       <tr>\n        <td {$labelStyle}>\n         {ts 1=$membership_name}%1 Membership{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$membership_amount|crmMoney}\n        </td>\n       </tr>\n       {if $amount}\n        {if ! $is_separate_payment }\n         <tr>\n          <td {$labelStyle}>\n           {ts}Contribution Amount{/ts}\n          </td>\n          <td {$valueStyle}>\n           {$amount|crmMoney}\n          </td>\n         </tr>\n        {else}\n         <tr>\n          <td {$labelStyle}>\n           {ts}Additional Contribution{/ts}\n          </td>\n          <td {$valueStyle}>\n           {$amount|crmMoney}\n          </td>\n         </tr>\n        {/if}\n       {/if}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Total{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$amount+$membership_amount|crmMoney}\n        </td>\n       </tr>\n\n      {elseif $lineItem and $priceSetID}\n\n       {foreach from=$lineItem item=value key=priceset}\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          <table> {* FIXME: style this table so that it looks like the text version (justification, etc.) *}\n           <tr>\n            <th>{ts}Item{/ts}</th>\n            <th>{ts}Qty{/ts}</th>\n            <th>{ts}Each{/ts}</th>\n            <th>{ts}Total{/ts}</th>\n           </tr>\n           {foreach from=$value item=line}\n            <tr>\n             <td>\n              {$line.description|truncate:30:\"...\"}\n             </td>\n             <td>\n              {$line.qty}\n             </td>\n             <td>\n              {$line.unit_price|crmMoney}\n             </td>\n             <td>\n              {$line.line_total|crmMoney}\n             </td>\n            </tr>\n           {/foreach}\n          </table>\n         </td>\n        </tr>\n       {/foreach}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Total Amount{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$amount|crmMoney}\n        </td>\n       </tr>\n\n      {else}\n\n       <tr>\n        <td {$labelStyle}>\n         {ts}Amount{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$amount|crmMoney} {if $amount_level} - {$amount_level}{/if}\n        </td>\n       </tr>\n\n      {/if}\n\n\n     {elseif $membership_amount}\n\n\n      <tr>\n       <th {$headerStyle}>\n        {ts}Membership Fee{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td {$labelStyle}>\n        {ts 1=$membership_name}%1 Membership{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$membership_amount|crmMoney}\n       </td>\n      </tr>\n\n\n     {/if}\n\n\n     {if $receive_date}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Date{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$receive_date|crmDate}\n       </td>\n      </tr>\n     {/if}\n\n     {if $is_monetary and $trxn_id}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Transaction #{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$trxn_id}\n       </td>\n      </tr>\n     {/if}\n\n     {if $membership_trx_id}\n      <tr>\n       <td {$labelStyle}>\n        {ts}Membership Transaction #{/ts}\n       </td>\n       <td {$valueStyle}>\n        {$membership_trx_id}\n       </td>\n      </tr>\n     {/if}\n\n     {if $is_recur}\n      {if $contributeMode eq \'notify\'}\n       <tr>\n        <td {$labelStyle}>\n         {ts 1=$cancelSubscriptionUrl}This is a recurring contribution. You can modify or cancel future contributions by <a href=\"%1\">logging in to your account</a>.{/ts}\n        </td>\n       </tr>\n      {elseif $contributeMode eq \'directIPN\' and $receiptFromEmail}\n       <tr>\n        <td {$labelStyle}>\n         {ts 1=$receiptFromEmail}This is a recurring contribution. To modify or cancel future contributions please contact us at %1.{/ts}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $honor_block_is_active}\n      <tr>\n       <th {$headerStyle}>\n        {$honor_type}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {$honor_prefix} {$honor_first_name} {$honor_last_name}\n       </td>\n      </tr>\n      {if $honor_email}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Honoree Email{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$honor_email}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $pcpBlock}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Personal Campaign Page{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td {$labelStyle}>\n        {ts}Display In Honor Roll{/ts}\n       </td>\n       <td {$valueStyle}>\n        {if $pcp_display_in_roll}{ts}Yes{/ts}{else}{ts}No{/ts}{/if}\n       </td>\n      </tr>\n      {if $pcp_roll_nickname}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Nick Name{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$pcp_roll_nickname}\n        </td>\n       </tr>\n      {/if}\n      {if $pcp_personal_note}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Personal Note{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$pcp_personal_note}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $onBehalfName}\n      <tr>\n       <th {$headerStyle}>\n        {ts}On Behalf Of{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$onBehalfName}<br />\n        {$onBehalfAddress|nl2br}<br />\n        {$onBehalfEmail}\n       </td>\n      </tr>\n     {/if}\n\n     {if ! ($contributeMode eq \'notify\' OR $contributeMode eq \'directIPN\') and $is_monetary}\n      {if $is_pay_later}\n       <tr>\n        <th {$headerStyle}>\n         {ts}Registered Email{/ts}\n        </th>\n       </tr>\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         {$email}\n        </td>\n       </tr>\n      {elseif $amount GT 0 OR $membership_amount GT 0}\n       <tr>\n        <th {$headerStyle}>\n         {ts}Billing Name and Address{/ts}\n        </th>\n       </tr>\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         {$billingName}<br />\n         {$address|nl2br}<br />\n         {$email}\n        </td>\n       </tr>\n      {/if}\n     {/if}\n\n     {if $contributeMode eq \'direct\' AND !$is_pay_later AND ($amount GT 0 OR $membership_amount GT 0)}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Credit Card Information{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        {$credit_card_type}<br />\n        {$credit_card_number}<br />\n        {ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:\'\'|crmDate}<br />\n       </td>\n      </tr>\n     {/if}\n\n     {if $selectPremium}\n      <tr>\n       <th {$headerStyle}>\n        {ts}Premium Information{/ts}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$labelStyle}>\n        {$product_name}\n       </td>\n      </tr>\n      {if $option}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Option{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$option}\n        </td>\n       </tr>\n      {/if}\n      {if $sku}\n       <tr>\n        <td {$labelStyle}>\n         {ts}SKU{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$sku}\n        </td>\n       </tr>\n      {/if}\n      {if $start_date}\n       <tr>\n        <td {$labelStyle}>\n         {ts}Start Date{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$start_date|crmDate}\n        </td>\n       </tr>\n      {/if}\n      {if $end_date}\n       <tr>\n        <td {$labelStyle}>\n         {ts}End Date{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$end_date|crmDate}\n        </td>\n       </tr>\n      {/if}\n      {if $contact_email OR $contact_phone}\n       <tr>\n        <td colspan=\"2\" {$valueStyle}>\n         <p>{ts}For information about this premium, contact:{/ts}</p>\n         {if $contact_email}\n          <p>{$contact_email}</p>\n         {/if}\n         {if $contact_phone}\n          <p>{$contact_phone}</p>\n         {/if}\n        </td>\n       </tr>\n      {/if}\n      {if $is_deductible AND $price}\n        <tr>\n         <td colspan=\"2\" {$valueStyle}>\n          <p>{ts 1=$price|crmMoney}The value of this premium is %1. This may affect the amount of the tax deduction you can claim. Consult your tax advisor for more information.{/ts}</p>\n         </td>\n        </tr>\n      {/if}\n     {/if}\n\n     {if $customPre}\n      <tr>\n       <th {$headerStyle}>\n        {$customPre_grouptitle}\n       </th>\n      </tr>\n      {foreach from=$customPre item=customValue key=customName}\n       {if ($trackingFields and ! in_array($customName, $trackingFields)) or ! $trackingFields}\n        <tr>\n         <td {$labelStyle}>\n          {$customName}\n         </td>\n         <td {$valueStyle}>\n          {$customValue}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n     {if $customPost}\n      <tr>\n       <th {$headerStyle}>\n        {$customPost_grouptitle}\n       </th>\n      </tr>\n      {foreach from=$customPost item=customValue key=customName}\n       {if ($trackingFields and ! in_array($customName, $trackingFields)) or ! $trackingFields}\n        <tr>\n         <td {$labelStyle}>\n          {$customName}\n         </td>\n         <td {$valueStyle}>\n          {$customValue}\n         </td>\n        </tr>\n       {/if}\n      {/foreach}\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,501,0,1),(33,'Test-drive - Receipt Header','[TEST] \n','***********************************************************\n\n{ts}Test-drive Email / Receipt{/ts} \n\n{ts}This is a test-drive email. No live financial transaction has occurred.{/ts}\n\n***********************************************************\n','<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left\">\n  <tr>\n   <td>\n    <p>{ts}Test-drive Email / Receipt{/ts}</p>\n    <p>{ts}This is a test-drive email. No live financial transaction has occurred.{/ts}</p>\n   </td>\n  </tr>\n </table>\n</center>\n',1,502,1,0),(34,'Test-drive - Receipt Header','[TEST] \n','***********************************************************\n\n{ts}Test-drive Email / Receipt{/ts} \n\n{ts}This is a test-drive email. No live financial transaction has occurred.{/ts}\n\n***********************************************************\n','<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left\">\n  <tr>\n   <td>\n    <p>{ts}Test-drive Email / Receipt{/ts}</p>\n    <p>{ts}This is a test-drive email. No live financial transaction has occurred.{/ts}</p>\n   </td>\n  </tr>\n </table>\n</center>\n',1,502,0,1),(35,'Pledges - Acknowledgement','{ts}Thank you for your Pledge{/ts}\n','{ts 1=$contact.display_name}Dear %1{/ts},\n\n{ts}Thank you for your generous pledge. Please print this acknowledgment for your records.{/ts}\n\n===========================================================\n{ts}Pledge Information{/ts}\n\n===========================================================\n{ts}Pledge Received{/ts}: {$create_date|truncate:10:\'\'|crmDate}\n{ts}Total Pledge Amount{/ts}: {$total_pledge_amount|crmMoney}\n\n===========================================================\n{ts}Payment Schedule{/ts}\n\n===========================================================\n{ts 1=$scheduled_amount|crmMoney 2=$frequency_interval 3=$frequency_unit 4=$installments}%1 every %2 %3 for %4 installments.{/ts}\n\n{if $frequency_day}\n\n{ts 1=$frequency_day 2=$frequency_unit}Payments are due on day %1 of the %2.{/ts}\n{/if}\n\n{if $payments}\n{assign var=\"count\" value=\"1\"}\n{foreach from=$payments item=payment}\n\n{ts 1=$count}Payment %1{/ts}: {$payment.amount|crmMoney} {if $payment.status eq 1}{ts}paid{/ts} {$payment.receive_date|truncate:10:\'\'|crmDate}{else}{ts}due{/ts} {$payment.due_date|truncate:10:\'\'|crmDate}{/if}\n{assign var=\"count\" value=`$count+1`}\n{/foreach}\n{/if}\n\n\n{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions\nor need to modify your payment schedule.{/ts}\n\n{if $honor_block_is_active}\n===========================================================\n{$honor_type}\n===========================================================\n{$honor_prefix} {$honor_first_name} {$honor_last_name}\n{if $honor_email}\n{ts}Honoree Email{/ts}: {$honor_email}\n{/if}\n{/if}\n\n{if $customGroup}\n{foreach from=$customGroup item=value key=customName}\n===========================================================\n{$customName}\n===========================================================\n{foreach from=$value item=v key=n}\n{$n}: {$v}\n{/foreach}\n{/foreach}\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <p>{ts 1=$contact.display_name}dear %1{/ts},</p>\n    <p>{ts}thank you for your generous pledge. please print this acknowledgment for your records.{/ts}</p>\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Pledge Information{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Pledge Received{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$create_date|truncate:10:\'\'|crmDate}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Total Pledge Amount{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$total_pledge_amount|crmMoney}\n      </td>\n     </tr>\n     <tr>\n      <th {$headerStyle}>\n       {ts}Payment Schedule{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       <p>{ts 1=$scheduled_amount|crmMoney 2=$frequency_interval 3=$frequency_unit 4=$installments}%1 every %2 %3 for %4 installments.{/ts}</p>\n\n       {if $frequency_day}\n        <p>{ts 1=$frequency_day 2=$frequency_unit}Payments are due on day %1 of the %2.{/ts}</p>\n       {/if}\n      </td>\n     </tr>\n\n     {if $payments}\n      {assign var=\"count\" value=\"1\"}\n      {foreach from=$payments item=payment}\n       <tr>\n        <td {$labelStyle}>\n         {ts 1=$count}Payment %1{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$payment.amount|crmMoney} {if $payment.status eq 1}{ts}paid{/ts} {$payment.receive_date|truncate:10:\'\'|crmDate}{else}{ts}due{/ts} {$payment.due_date|truncate:10:\'\'|crmDate}{/if}\n        </td>\n       </tr>\n       {assign var=\"count\" value=`$count+1`}\n      {/foreach}\n     {/if}\n\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       <p>{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions\nor need to modify your payment schedule.{/ts}</p>\n      </td>\n     </tr>\n     {if $honor_block_is_active}\n      <tr>\n       <th {$headerStyle}>\n        {$honor_type}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        <p>{$honor_prefix} {$honor_first_name} {$honor_last_name}</p>\n        {if $honor_email}\n         <p>{ts}Honoree Email{/ts}: {$honor_email}</p>\n        {/if}\n       </td>\n      </tr>\n     {/if}\n\n     {if $customGroup}\n      {foreach from=$customGroup item=value key=customName}\n       <tr>\n        <th {$headerStyle}>\n         {$customName}\n        </th>\n       </tr>\n       {foreach from=$value item=v key=n}\n        <tr>\n         <td {$labelStyle}>\n          {$n}\n         </td>\n         <td {$valueStyle}>\n          {$v}\n         </td>\n        </tr>\n       {/foreach}\n      {/foreach}\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,503,1,0),(36,'Pledges - Acknowledgement','{ts}Thank you for your Pledge{/ts}\n','{ts 1=$contact.display_name}Dear %1{/ts},\n\n{ts}Thank you for your generous pledge. Please print this acknowledgment for your records.{/ts}\n\n===========================================================\n{ts}Pledge Information{/ts}\n\n===========================================================\n{ts}Pledge Received{/ts}: {$create_date|truncate:10:\'\'|crmDate}\n{ts}Total Pledge Amount{/ts}: {$total_pledge_amount|crmMoney}\n\n===========================================================\n{ts}Payment Schedule{/ts}\n\n===========================================================\n{ts 1=$scheduled_amount|crmMoney 2=$frequency_interval 3=$frequency_unit 4=$installments}%1 every %2 %3 for %4 installments.{/ts}\n\n{if $frequency_day}\n\n{ts 1=$frequency_day 2=$frequency_unit}Payments are due on day %1 of the %2.{/ts}\n{/if}\n\n{if $payments}\n{assign var=\"count\" value=\"1\"}\n{foreach from=$payments item=payment}\n\n{ts 1=$count}Payment %1{/ts}: {$payment.amount|crmMoney} {if $payment.status eq 1}{ts}paid{/ts} {$payment.receive_date|truncate:10:\'\'|crmDate}{else}{ts}due{/ts} {$payment.due_date|truncate:10:\'\'|crmDate}{/if}\n{assign var=\"count\" value=`$count+1`}\n{/foreach}\n{/if}\n\n\n{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions\nor need to modify your payment schedule.{/ts}\n\n{if $honor_block_is_active}\n===========================================================\n{$honor_type}\n===========================================================\n{$honor_prefix} {$honor_first_name} {$honor_last_name}\n{if $honor_email}\n{ts}Honoree Email{/ts}: {$honor_email}\n{/if}\n{/if}\n\n{if $customGroup}\n{foreach from=$customGroup item=value key=customName}\n===========================================================\n{$customName}\n===========================================================\n{foreach from=$value item=v key=n}\n{$n}: {$v}\n{/foreach}\n{/foreach}\n{/if}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <p>{ts 1=$contact.display_name}dear %1{/ts},</p>\n    <p>{ts}thank you for your generous pledge. please print this acknowledgment for your records.{/ts}</p>\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Pledge Information{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Pledge Received{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$create_date|truncate:10:\'\'|crmDate}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Total Pledge Amount{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$total_pledge_amount|crmMoney}\n      </td>\n     </tr>\n     <tr>\n      <th {$headerStyle}>\n       {ts}Payment Schedule{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       <p>{ts 1=$scheduled_amount|crmMoney 2=$frequency_interval 3=$frequency_unit 4=$installments}%1 every %2 %3 for %4 installments.{/ts}</p>\n\n       {if $frequency_day}\n        <p>{ts 1=$frequency_day 2=$frequency_unit}Payments are due on day %1 of the %2.{/ts}</p>\n       {/if}\n      </td>\n     </tr>\n\n     {if $payments}\n      {assign var=\"count\" value=\"1\"}\n      {foreach from=$payments item=payment}\n       <tr>\n        <td {$labelStyle}>\n         {ts 1=$count}Payment %1{/ts}\n        </td>\n        <td {$valueStyle}>\n         {$payment.amount|crmMoney} {if $payment.status eq 1}{ts}paid{/ts} {$payment.receive_date|truncate:10:\'\'|crmDate}{else}{ts}due{/ts} {$payment.due_date|truncate:10:\'\'|crmDate}{/if}\n        </td>\n       </tr>\n       {assign var=\"count\" value=`$count+1`}\n      {/foreach}\n     {/if}\n\n     <tr>\n      <td colspan=\"2\" {$valueStyle}>\n       <p>{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions\nor need to modify your payment schedule.{/ts}</p>\n      </td>\n     </tr>\n     {if $honor_block_is_active}\n      <tr>\n       <th {$headerStyle}>\n        {$honor_type}\n       </th>\n      </tr>\n      <tr>\n       <td colspan=\"2\" {$valueStyle}>\n        <p>{$honor_prefix} {$honor_first_name} {$honor_last_name}</p>\n        {if $honor_email}\n         <p>{ts}Honoree Email{/ts}: {$honor_email}</p>\n        {/if}\n       </td>\n      </tr>\n     {/if}\n\n     {if $customGroup}\n      {foreach from=$customGroup item=value key=customName}\n       <tr>\n        <th {$headerStyle}>\n         {$customName}\n        </th>\n       </tr>\n       {foreach from=$value item=v key=n}\n        <tr>\n         <td {$labelStyle}>\n          {$n}\n         </td>\n         <td {$valueStyle}>\n          {$v}\n         </td>\n        </tr>\n       {/foreach}\n      {/foreach}\n     {/if}\n\n    </table>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,503,0,1),(37,'Pledges - Payment Reminder','{ts}Pledge Payment Reminder{/ts}\n','{ts 1=$contact.display_name}Dear %1{/ts},\n\n{ts 1=$next_payment|truncate:10:\'\'|crmDate}This is a reminder that the next payment on your pledge is due on %1.{/ts}\n\n===========================================================\n{ts}Payment Due{/ts}\n\n===========================================================\n{ts}Amount Due{/ts}: {$amount_due|crmMoney}\n{ts}Due Date{/ts}: {$scheduled_payment_date|truncate:10:\'\'|crmDate}\n\n{if $contribution_page_id}\n{capture assign=contributionUrl}{crmURL p=\'civicrm/contribute/transact\' q=\"reset=1&id=`$contribution_page_id`&cid=`$contact.contact_id`&pledgeId=`$pledge_id`&cs=`$checksumValue`\" a=true h=0}{/capture}\nClick this link to go to a web page where you can make your payment online:\n{$contributionUrl}\n{else}\n{ts}Please mail your payment to{/ts}:\n{$domain.address}\n{/if}\n\n===========================================================\n{ts}Pledge Information{/ts}\n\n===========================================================\n{ts}Pledge Received{/ts}: {$create_date|truncate:10:\'\'|crmDate}\n{ts}Total Pledge Amount{/ts}: {$amount|crmMoney}\n{ts}Total Paid{/ts}: {$amount_paid|crmMoney}\n\n{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions\nor need to modify your payment schedule.{/ts}\n\n\n{ts}Thank your for your generous support.{/ts}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <p>{ts 1=$contact.display_name}Dear %1{/ts},</p>\n    <p>{ts 1=$next_payment|truncate:10:\'\'|crmDate}This is a reminder that the next payment on your pledge is due on %1.{/ts}</p>\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Payment Due{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Amount Due{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$amount_due|crmMoney}\n      </td>\n     </tr>\n    </table>\n   </td>\n  </tr>\n\n  <tr>\n   <td>\n    {if $contribution_page_id}\n     {capture assign=contributionUrl}{crmURL p=\'civicrm/contribute/transact\' q=\"reset=1&id=`$contribution_page_id`&cid=`$contact.contact_id`&pledgeId=`$pledge_id`&cs=`$checksumValue`\" a=true h=0}{/capture}\n     <p><a href=\"{$contributionUrl}\">{ts}Go to a web page where you can make your payment online{/ts}</a></p>\n    {else}\n     <p>{ts}Please mail your payment to{/ts}: {$domain.address}</p>\n    {/if}\n   </td>\n  </tr>\n\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Pledge Information{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Pledge Received{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$create_date|truncate:10:\'\'|crmDate}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Total Pledge Amount{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$amount|crmMoney}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Total Paid{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$amount_paid|crmMoney}\n      </td>\n     </tr>\n    </table>\n   </td>\n  </tr>\n\n  <tr>\n   <td>\n    <p>{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions\nor need to modify your payment schedule.{/ts}</p>\n    <p>{ts}Thank your for your generous support.{/ts}</p>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,504,1,0),(38,'Pledges - Payment Reminder','{ts}Pledge Payment Reminder{/ts}\n','{ts 1=$contact.display_name}Dear %1{/ts},\n\n{ts 1=$next_payment|truncate:10:\'\'|crmDate}This is a reminder that the next payment on your pledge is due on %1.{/ts}\n\n===========================================================\n{ts}Payment Due{/ts}\n\n===========================================================\n{ts}Amount Due{/ts}: {$amount_due|crmMoney}\n{ts}Due Date{/ts}: {$scheduled_payment_date|truncate:10:\'\'|crmDate}\n\n{if $contribution_page_id}\n{capture assign=contributionUrl}{crmURL p=\'civicrm/contribute/transact\' q=\"reset=1&id=`$contribution_page_id`&cid=`$contact.contact_id`&pledgeId=`$pledge_id`&cs=`$checksumValue`\" a=true h=0}{/capture}\nClick this link to go to a web page where you can make your payment online:\n{$contributionUrl}\n{else}\n{ts}Please mail your payment to{/ts}:\n{$domain.address}\n{/if}\n\n===========================================================\n{ts}Pledge Information{/ts}\n\n===========================================================\n{ts}Pledge Received{/ts}: {$create_date|truncate:10:\'\'|crmDate}\n{ts}Total Pledge Amount{/ts}: {$amount|crmMoney}\n{ts}Total Paid{/ts}: {$amount_paid|crmMoney}\n\n{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions\nor need to modify your payment schedule.{/ts}\n\n\n{ts}Thank your for your generous support.{/ts}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <p>{ts 1=$contact.display_name}Dear %1{/ts},</p>\n    <p>{ts 1=$next_payment|truncate:10:\'\'|crmDate}This is a reminder that the next payment on your pledge is due on %1.{/ts}</p>\n   </td>\n  </tr>\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Payment Due{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Amount Due{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$amount_due|crmMoney}\n      </td>\n     </tr>\n    </table>\n   </td>\n  </tr>\n\n  <tr>\n   <td>\n    {if $contribution_page_id}\n     {capture assign=contributionUrl}{crmURL p=\'civicrm/contribute/transact\' q=\"reset=1&id=`$contribution_page_id`&cid=`$contact.contact_id`&pledgeId=`$pledge_id`&cs=`$checksumValue`\" a=true h=0}{/capture}\n     <p><a href=\"{$contributionUrl}\">{ts}Go to a web page where you can make your payment online{/ts}</a></p>\n    {else}\n     <p>{ts}Please mail your payment to{/ts}: {$domain.address}</p>\n    {/if}\n   </td>\n  </tr>\n\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <th {$headerStyle}>\n       {ts}Pledge Information{/ts}\n      </th>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Pledge Received{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$create_date|truncate:10:\'\'|crmDate}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Total Pledge Amount{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$amount|crmMoney}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Total Paid{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$amount_paid|crmMoney}\n      </td>\n     </tr>\n    </table>\n   </td>\n  </tr>\n\n  <tr>\n   <td>\n    <p>{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions\nor need to modify your payment schedule.{/ts}</p>\n    <p>{ts}Thank your for your generous support.{/ts}</p>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,504,0,1),(39,'Profiles - Admin Notification','{$grouptitle} {ts 1=$displayName}Submitted by %1{/ts}\n','{ts}Submitted For:{/ts} {$displayName}\n{ts}Date:{/ts} {$currentDate}\n{ts}Contact Summary:{/ts} {$contactLink}\n\n===========================================================\n{$grouptitle}\n\n===========================================================\n{foreach from=$values item=value key=valueName}\n{$valueName}: {$value}\n{/foreach}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <td {$labelStyle}>\n       {ts}Submitted For{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$displayName}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Date{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$currentDate}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Contact Summary{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$contactLink}\n      </td>\n     </tr>\n\n     <tr>\n      <th {$headerStyle}>\n       {$grouptitle}\n      </th>\n     </tr>\n\n     {foreach from=$values item=value key=valueName}\n      <tr>\n       <td {$labelStyle}>\n        {$valueName}\n       </td>\n       <td {$valueStyle}>\n        {$value}\n       </td>\n      </tr>\n     {/foreach}\n    </table>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,505,1,0),(40,'Profiles - Admin Notification','{$grouptitle} {ts 1=$displayName}Submitted by %1{/ts}\n','{ts}Submitted For:{/ts} {$displayName}\n{ts}Date:{/ts} {$currentDate}\n{ts}Contact Summary:{/ts} {$contactLink}\n\n===========================================================\n{$grouptitle}\n\n===========================================================\n{foreach from=$values item=value key=valueName}\n{$valueName}: {$value}\n{/foreach}\n','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n <title></title>\n</head>\n<body>\n\n{capture assign=headerStyle}colspan=\"2\" style=\"text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;\"{/capture}\n{capture assign=labelStyle }style=\"padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;\"{/capture}\n{capture assign=valueStyle }style=\"padding: 4px; border-bottom: 1px solid #999;\"{/capture}\n\n<center>\n <table width=\"620\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"crm-event_receipt\" style=\"font-family: Arial, Verdana, sans-serif; text-align: left;\">\n\n  <!-- BEGIN HEADER -->\n  <!-- You can add table row(s) here with logo or other header elements -->\n  <!-- END HEADER -->\n\n  <!-- BEGIN CONTENT -->\n\n  <tr>\n   <td>\n    <table style=\"border: 1px solid #999; margin: 1em 0em 1em; border-collapse: collapse; width:100%;\">\n     <tr>\n      <td {$labelStyle}>\n       {ts}Submitted For{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$displayName}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Date{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$currentDate}\n      </td>\n     </tr>\n     <tr>\n      <td {$labelStyle}>\n       {ts}Contact Summary{/ts}\n      </td>\n      <td {$valueStyle}>\n       {$contactLink}\n      </td>\n     </tr>\n\n     <tr>\n      <th {$headerStyle}>\n       {$grouptitle}\n      </th>\n     </tr>\n\n     {foreach from=$values item=value key=valueName}\n      <tr>\n       <td {$labelStyle}>\n        {$valueName}\n       </td>\n       <td {$valueStyle}>\n        {$value}\n       </td>\n      </tr>\n     {/foreach}\n    </table>\n   </td>\n  </tr>\n\n </table>\n</center>\n\n</body>\n</html>\n',1,505,0,1);
/*!40000 ALTER TABLE `civicrm_msg_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_navigation`
--

DROP TABLE IF EXISTS `civicrm_navigation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_navigation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this navigation item for',
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Navigation Title',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Internal Name',
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'url in case of custom navigation link',
  `permission` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Permission for menu item',
  `permission_operator` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Permission Operator',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent navigation item, used for grouping',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this navigation item active?',
  `has_separator` tinyint(4) DEFAULT NULL COMMENT 'If separator needs to be added after this menu item',
  `weight` int(11) DEFAULT NULL COMMENT 'Ordering of the navigation items in various blocks.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_navigation_domain_id` (`domain_id`),
  KEY `FK_civicrm_navigation_parent_id` (`parent_id`),
  CONSTRAINT `FK_civicrm_navigation_domain_id` FOREIGN KEY (`domain_id`) REFERENCES `civicrm_domain` (`id`),
  CONSTRAINT `FK_civicrm_navigation_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `civicrm_navigation` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_navigation`
--

LOCK TABLES `civicrm_navigation` WRITE;
/*!40000 ALTER TABLE `civicrm_navigation` DISABLE KEYS */;
INSERT INTO `civicrm_navigation` VALUES (1,1,'Custom Search','Search...',NULL,NULL,'AND',NULL,1,0,1),(4,1,'Full-text Search','Full-text Search','civicrm/contact/search/custom&csid=15&reset=1',NULL,'AND',1,1,0,5),(5,1,'Search Builder','Search Builder','civicrm/contact/search/builder&reset=1',NULL,'AND',1,1,1,6),(6,1,'Find Cases','Find Cases','civicrm/case/search&reset=1','access my cases and activities,access all cases and activities','OR',1,1,NULL,3),(12,1,'Find Activities','Find Activities','civicrm/activity/search&reset=1','view all activities','AND',1,1,1,3),(17,1,'Proximity Search','Proximity Search','civicrm/contact/search/custom&reset=1&csid=6',NULL,'',1,1,NULL,6),(24,1,'Import Contacts','Import Contacts','civicrm/import/contact&reset=1','import contacts','AND',201,1,0,1),(25,1,'Import Activities','Import Activities','civicrm/import/activity&reset=1','import contacts','',201,1,1,2),(26,1,'New Group','New Group','civicrm/group/add&reset=1','edit groups','',201,1,NULL,3),(27,1,'Manage Groups','Manage Groups','civicrm/group&reset=1','edit groups','AND',201,1,0,5),(28,1,'New Tag','New Tag','civicrm/admin/tag&reset=1&action=add','administer CiviCRM','AND',201,1,1,4),(29,1,'Manage Tags','Manage Tags (Categories)','civicrm/admin/tag&reset=1','administer CiviCRM,administer Tagsets','OR',201,1,0,6),(77,1,'Administer','Administer',NULL,'profile create','AND',NULL,1,0,3),(78,1,'Administration Console','Administration Console','civicrm/admin&reset=1','administer CiviCRM','',77,1,NULL,1),(79,1,'Customize','Customize',NULL,'administer CiviCRM','',77,1,NULL,2),(80,1,'Custom Data','Custom Data','civicrm/admin/custom/group&reset=1','administer CiviCRM','',79,1,NULL,1),(81,1,'CiviCRM Profile','CiviCRM Profile','civicrm/admin/uf/group&reset=1','administer CiviCRM','',79,1,NULL,2),(82,1,'Navigation Menu','Navigation Menu','civicrm/admin/menu&reset=1','administer CiviCRM','',79,1,NULL,3),(83,1,'Manage Custom Searches','Manage Custom Searches','civicrm/admin/options/custom_search&reset=1&group=custom_search','administer CiviCRM','',79,1,NULL,4),(85,1,'Configure','Configure',NULL,'administer CiviCRM','',77,1,NULL,3),(86,1,'Configuration Checklist','Configuration Checklist','civicrm/admin/configtask&reset=1','administer CiviCRM','',85,1,NULL,1),(87,1,'Global Settings','Global Settings','civicrm/admin/setting&reset=1','administer CiviCRM','',85,1,NULL,2),(88,1,'Enable CiviCRM Components','Enable Components','civicrm/admin/setting/component&reset=1','administer CiviCRM','',87,1,NULL,1),(89,1,'Site Preferences (screen and form configuration)','Site Preferences','civicrm/admin/setting/preferences/display&reset=1','administer CiviCRM','',87,1,NULL,2),(90,1,'Directories','Directories','civicrm/admin/setting/path&reset=1','administer CiviCRM','',87,1,NULL,3),(91,1,'Resource URLs','Resource URLs','civicrm/admin/setting/url&reset=1','administer CiviCRM','',87,1,NULL,4),(92,1,'Outbound Email (SMTP/Sendmail)','Outbound Email','civicrm/admin/setting/smtp&reset=1','administer CiviCRM','',87,1,NULL,5),(93,1,'Mapping and Geocoding','Mapping and Geocoding','civicrm/admin/setting/mapping&reset=1','administer CiviCRM','',87,1,NULL,6),(95,1,'Localization','Localization','civicrm/admin/setting/localization&reset=1','administer CiviCRM','',87,1,NULL,8),(96,1,'Address Settings','Address Settings','civicrm/admin/setting/preferences/address&reset=1','administer CiviCRM','',87,1,NULL,9),(97,1,'Search Settings','Search Settings','civicrm/admin/setting/search&reset=1','administer CiviCRM','',87,1,NULL,10),(98,1,'Date Formats','Date Formats','civicrm/admin/setting/date&reset=1','administer CiviCRM','',87,1,NULL,11),(99,1,'CMS Integration','CMS Integration','civicrm/admin/setting/uf&reset=1','administer CiviCRM','',87,1,NULL,12),(100,1,'Miscellaneous (version check, reCAPTCHA...)','Miscellaneous','civicrm/admin/setting/misc&reset=1','administer CiviCRM','',87,1,NULL,13),(101,1,'Safe File Extensions','Safe File Extensions','civicrm/admin/options/safe_file_extension&group=safe_file_extension&reset=1','administer CiviCRM','',87,1,NULL,14),(102,1,'Debugging','Debugging','civicrm/admin/setting/debug&reset=1','administer CiviCRM','',87,1,NULL,15),(103,1,'Import/Export Mappings','Import/Export Mappings','civicrm/admin/mapping&reset=1','administer CiviCRM','',85,1,NULL,3),(104,1,'Message Templates','Message Templates','civicrm/admin/messageTemplates&reset=1','administer CiviCRM','',85,1,NULL,4),(105,1,'Domain Information','Domain Information','civicrm/admin/domain&action=update&reset=1','administer CiviCRM','',85,1,NULL,5),(106,1,'FROM Email Addresses','FROM Email Addresses','civicrm/admin/options/from_email_address&group=from_email_address&reset=1','administer CiviCRM','',85,1,NULL,6),(107,1,'Update Directory Path and URL','Update Directory Path and URL','civicrm/admin/setting/updateConfigBackend&reset=1','administer CiviCRM','',85,1,NULL,7),(108,1,'Manage','Manage',NULL,'administer CiviCRM','',77,1,NULL,4),(109,1,'Find and Merge Duplicate Contacts','Find and Merge Duplicate Contacts','civicrm/contact/deduperules&reset=1','administer CiviCRM','',108,1,NULL,1),(110,1,'Access Control','Access Control','civicrm/admin/access&reset=1','administer CiviCRM','',108,1,NULL,2),(111,1,'Synchronize Users to Contacts','Synchronize Users to Contacts','civicrm/admin/synchUser&reset=1','administer CiviCRM','',108,1,NULL,3),(112,1,'Option Lists','Option Lists',NULL,'administer CiviCRM','',77,1,NULL,5),(113,1,'Activity Types','Activity Types','civicrm/admin/options/activity_type&reset=1&group=activity_type','administer CiviCRM','',112,1,NULL,1),(114,1,'Relationship Types','Relationship Types','civicrm/admin/reltype&reset=1','administer CiviCRM','',112,1,NULL,2),(115,1,'Tags (Categories)','Tags (Categories)','civicrm/admin/tag&reset=1','administer CiviCRM','',112,1,1,3),(116,1,'Gender Options','Gender Options','civicrm/admin/options/gender&reset=1&group=gender','administer CiviCRM','',112,1,NULL,4),(117,1,'Individual Prefixes (Ms, Mr...)','Individual Prefixes (Ms, Mr...)','civicrm/admin/options/individual_prefix&group=individual_prefix&reset=1','administer CiviCRM','',112,1,NULL,5),(118,1,'Individual Suffixes (Jr, Sr...)','Individual Suffixes (Jr, Sr...)','civicrm/admin/options/individual_suffix&group=individual_suffix&reset=1','administer CiviCRM','',112,1,1,6),(119,1,'Addressee Formats','Addressee Formats','civicrm/admin/options/addressee&group=addressee&reset=1','administer CiviCRM','',112,1,NULL,7),(120,1,'Email Greetings','Email Greetings','civicrm/admin/options/email_greeting&group=email_greeting&reset=1','administer CiviCRM','',112,1,NULL,8),(121,1,'Postal Greetings','Postal Greetings','civicrm/admin/options/postal_greeting&group=postal_greeting&reset=1','administer CiviCRM','',112,1,1,9),(122,1,'Instant Messenger Services','Instant Messenger Services','civicrm/admin/options/instant_messenger_service&group=instant_messenger_service&reset=1','administer CiviCRM','',112,1,NULL,10),(123,1,'Location Types (Home, Work...)','Location Types (Home, Work...)','civicrm/admin/locationType&reset=1','administer CiviCRM','',112,1,NULL,11),(124,1,'Mobile Phone Providers','Mobile Phone Providers','civicrm/admin/options/mobile_provider&group=mobile_provider&reset=1','administer CiviCRM','',112,1,NULL,12),(125,1,'Phone Types','Phone Types','civicrm/admin/options/phone_type&group=phone_type&reset=1','administer CiviCRM','',112,1,NULL,13),(126,1,'Preferred Communication Methods','Preferred Communication Methods','civicrm/admin/options/preferred_communication_method&group=preferred_communication_method&reset=1','administer CiviCRM','',112,1,NULL,14),(127,1,'Contact Types','Contact Types','civicrm/admin/options/subtype&reset=1','administer CiviCRM','',112,1,NULL,15),(128,1,'CiviCase','CiviCase',NULL,'administer CiviCase',NULL,77,1,NULL,6),(129,1,'Case Types','Case Types','civicrm/admin/options/case_type&group=case_type&reset=1','administer CiviCase',NULL,128,1,NULL,1),(130,1,'Redaction Rules','Redaction Rules','civicrm/admin/options/redaction_rule&group=redaction_rule&reset=1','administer CiviCase',NULL,128,1,NULL,2),(131,1,'Case Statuses','Case Statuses','civicrm/admin/options/case_status&group=case_status&reset=1','administer CiviCase',NULL,128,1,NULL,3),(162,1,'CiviReport','CiviReport',NULL,'access CiviReport,administer CiviCRM','AND',77,1,NULL,12),(163,1,'Reports Listing','Reports Listing','civicrm/report/list&reset=1','access CiviReport','',162,1,NULL,1),(164,1,'Create Reports from Templates','Create Reports from Templates','civicrm/admin/report/template/list&reset=1','administer Reports','',162,1,NULL,2),(165,1,'Manage Templates','Manage Templates','civicrm/admin/report/options/report_template&reset=1','administer Reports','',162,1,NULL,3),(166,1,'Register Report','Register Report','civicrm/admin/report/register&reset=1','administer Reports','',162,1,NULL,4),(172,1,'Reports','Reports',NULL,'access CiviReport','',NULL,1,NULL,2),(173,1,'Reports Listing','Reports Listing','civicrm/report/list&reset=1','access CiviReport','',172,1,1,1),(174,1,'Create Reports from Templates','Create Reports from Templates','civicrm/admin/report/template/list&reset=1','administer Reports','',172,1,1,2),(175,1,'Constituent Report (Summary)','Constituent Report (Summary)','civicrm/report/instance/1&reset=1','view all contacts','',172,1,0,3),(176,1,'Constituent Report (Detail)','Constituent Report (Detail)','civicrm/report/instance/2&reset=1','view all contacts','',172,1,0,4),(190,1,'Activity Report ','Activity Report ','civicrm/report/instance/16&reset=1','view all activities','',172,1,0,18),(191,1,'Relationship Report','Relationship Report','civicrm/report/instance/17&reset=1','view all contacts','AND',172,1,0,19),(199,1,'All Activities, Last 7 Days','All Activities, Last 7 Days','civicrm/report/instance/23&reset=1','access all cases and activities','AND',172,1,0,25),(200,1,'Emails Received, Last 7 Days','Emails Received, Last 7 Days','civicrm/report/instance/24&reset=1','access my cases and activities','AND',172,1,0,26),(201,1,'Manage','Manage',NULL,NULL,'AND',NULL,1,0,2),(202,1,'Manage Users','Manage Users','admin/user/user','administer CiviCRM','AND',201,1,0,7),(203,1,'Merge Duplicate Contacts','Merge Duplicate Contacts','civicrm/contact/deduperules&reset=1','administer CiviCRM','AND',201,1,0,8),(204,1,'Birthday Search','CRM_Contact_Form_Search_Custom_BirthdayByMonth','civicrm/contact/search/custom?reset=1&csid=16',NULL,'AND',1,1,0,7),(205,1,'Case Dashboard','Case Dashboard','civicrm/case?reset=1','access CiviCRM,access all cases and activities','AND',201,1,0,9),(206,1,'Include/Exclude Group/Tag','Include-Exclude Group-Tag','civicrm/contact/search/custom?csid=4&reset=1','access CiviCRM,view all contacts','AND',1,1,0,8),(208,1,'Word Replacements','Word Replacements','civicrm/admin/options/wordreplacements&reset=1','administer CiviCRM','',112,1,NULL,16),(210,1,'Home','Home','civicrm/dashboard&reset=1',NULL,'',NULL,1,NULL,0),(211,1,'Website Types','Website Types','civicrm/admin/options/website_type&group=website_type&reset=1','administer CiviCRM','',112,1,NULL,17),(212,1,'Import/Export Mappings','Import/Export Mappings','civicrm/admin/mapping?reset=1','access CiviCRM,administer CiviCRM','AND',201,1,0,10),(213,1,'BOE/3rd Party Import','BOE Import','importData','access CiviCRM,export print production files','AND',201,1,0,0),(214,1,'Site Maintenance','Site Maintenance','admin/settings/site-maintenance','access CiviCRM,administer site configuration','AND',201,1,1,0),(234,1,'Mailings','Mailings',NULL,'access CiviMail,create mailings,approve mailings,schedule mailings','OR',NULL,1,0,3),(235,1,'New Mailing','New Mailing','civicrm/mailing/send&reset=1','create mailings,schedule mailings','OR',234,1,0,1),(236,1,'Draft and Unscheduled Mailings','Draft and Unscheduled Mailings','civicrm/mailing/browse/unscheduled&reset=1&scheduled=false','access CiviMail,create mailings,schedule mailings','OR',234,1,0,2),(237,1,'Scheduled and Sent Mailings','Scheduled and Sent Mailings','civicrm/mailing/browse/scheduled&reset=1&scheduled=true','access CiviMail,approve mailings,create mailings,schedule mailings','OR',234,1,0,3),(238,1,'Archived Mailings','Archived Mailings','civicrm/mailing/browse/archived&reset=1','create mailings,schedule mailings','OR',234,1,0,4),(239,1,'Message Templates','Message Templates','civicrm/admin/messageTemplates&reset=1','create mailings,schedule mailings','OR',234,1,1,5),(240,1,'Mail Bounce Report','Mail Bounce Report ','civicrm/report/instance/27&reset=1','access CiviMail','',234,1,NULL,29),(241,1,'Mail Summary Report','Mail Summary Report','civicrm/report/instance/28&reset=1','access CiviMail','',234,1,NULL,30),(242,1,'Mail Opened Report','Mail Opened Report','civicrm/report/instance/29&reset=1','access CiviMail','',234,1,NULL,31),(243,1,'Mail Clickthrough Report','Mail Clickthrough Report','civicrm/report/instance/30&reset=1','access CiviMail','',234,1,NULL,32),(244,1,'District Stats','District Stats','civicrm/dashlet/districtstats','access CiviCRM','OR',172,1,0,0);
/*!40000 ALTER TABLE `civicrm_navigation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_note`
--

DROP TABLE IF EXISTS `civicrm_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_note` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Note ID',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of table where item being referenced is stored.',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to the referenced item.',
  `note` text COLLATE utf8_unicode_ci COMMENT 'Note and/or Comment.',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID creator',
  `modified_date` date DEFAULT NULL COMMENT 'When was this note last modified/edited',
  `subject` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'subject of note description',
  `privacy` int(10) NOT NULL COMMENT 'Foreign Key to Note Privacy Level (which is an option value pair and hence an implicit FK)',
  PRIMARY KEY (`id`),
  KEY `index_entity` (`entity_table`,`entity_id`),
  KEY `FK_civicrm_note_contact_id` (`contact_id`),
  CONSTRAINT `FK_civicrm_note_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_note`
--

LOCK TABLES `civicrm_note` WRITE;
/*!40000 ALTER TABLE `civicrm_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_openid`
--

DROP TABLE IF EXISTS `civicrm_openid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_openid` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique OpenID ID',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `location_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Location does this email belong to.',
  `openid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'the OpenID (or OpenID-style http://username.domain/) unique identifier for this contact mainly used for logging in to CiviCRM',
  `allowed_to_login` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this user is allowed to login',
  `is_primary` tinyint(4) DEFAULT '0' COMMENT 'Is this the primary email for this contact and location.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_openid` (`openid`),
  KEY `index_location_type` (`location_type_id`),
  KEY `FK_civicrm_openid_contact_id` (`contact_id`),
  CONSTRAINT `FK_civicrm_openid_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_openid`
--

LOCK TABLES `civicrm_openid` WRITE;
/*!40000 ALTER TABLE `civicrm_openid` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_openid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_openid_associations`
--

DROP TABLE IF EXISTS `civicrm_openid_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_openid_associations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `server_url` blob,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `secret` blob,
  `issued` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `assoc_type` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `server_url_handle_index` (`server_url`(166),`handle`(166))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_openid_associations`
--

LOCK TABLES `civicrm_openid_associations` WRITE;
/*!40000 ALTER TABLE `civicrm_openid_associations` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_openid_associations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_openid_nonces`
--

DROP TABLE IF EXISTS `civicrm_openid_nonces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_openid_nonces` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `server_url` blob,
  `timestamp` int(11) DEFAULT NULL,
  `salt` char(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nonce_index` (`server_url`(255),`timestamp`,`salt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_openid_nonces`
--

LOCK TABLES `civicrm_openid_nonces` WRITE;
/*!40000 ALTER TABLE `civicrm_openid_nonces` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_openid_nonces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_option_group`
--

DROP TABLE IF EXISTS `civicrm_option_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_option_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Group ID',
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Option group name. Used as selection key by class properties which lookup options in civicrm_option_value.',
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Option label.',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Option group description.',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'Is this a predefined system option group (i.e. it can not be deleted)?',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this option group active?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_option_group`
--

LOCK TABLES `civicrm_option_group` WRITE;
/*!40000 ALTER TABLE `civicrm_option_group` DISABLE KEYS */;
INSERT INTO `civicrm_option_group` VALUES (1,'preferred_communication_method',NULL,'Preferred Communication Method',0,1),(2,'activity_type',NULL,'Activity Type',0,1),(3,'gender',NULL,'Gender',0,1),(4,'instant_messenger_service',NULL,'Instant Messenger (IM) screen-names',0,1),(5,'mobile_provider',NULL,'Mobile Phone Providers',0,1),(6,'individual_prefix',NULL,'Individual contact prefixes',0,1),(7,'individual_suffix',NULL,'Individual contact suffixes',0,1),(8,'acl_role',NULL,'ACL Role',0,1),(9,'accept_creditcard',NULL,'Accepted Credit Cards',0,1),(10,'payment_instrument',NULL,'Payment Instruments',0,1),(11,'contribution_status',NULL,'Contribution Status',0,1),(12,'pcp_status',NULL,'PCP Status',0,1),(13,'participant_role',NULL,'Participant Role',0,1),(14,'event_type',NULL,'Event Type',0,1),(15,'contact_view_options',NULL,'Contact View Options',0,1),(16,'contact_edit_options',NULL,'Contact Edit Options',0,1),(17,'advanced_search_options',NULL,'Advanced Search Options',0,1),(18,'user_dashboard_options',NULL,'User Dashboard Options',0,1),(19,'address_options',NULL,'Addressing Options',0,1),(20,'group_type',NULL,'Group Type',0,1),(21,'grant_status',NULL,'Grant status',0,1),(22,'grant_type',NULL,'Grant Type',0,1),(23,'honor_type',NULL,'Honor Type',0,1),(24,'custom_search',NULL,'Custom Search',0,1),(25,'activity_status',NULL,'Activity Status',0,1),(26,'case_type',NULL,'Case Type',0,1),(27,'case_status',NULL,'Case Status',0,1),(28,'participant_listing',NULL,'Participant Listing',0,1),(29,'safe_file_extension',NULL,'Safe File Extension',0,1),(30,'from_email_address',NULL,'From Email Address',0,1),(31,'mapping_type',NULL,'Mapping Type',0,1),(32,'wysiwyg_editor',NULL,'WYSIWYG Editor',0,1),(33,'recur_frequency_units',NULL,'Recurring Frequency Units',0,1),(34,'phone_type',NULL,'Phone Type',0,1),(35,'custom_data_type',NULL,'Custom Data Type',0,1),(36,'visibility',NULL,'Visibility',0,1),(37,'mail_protocol',NULL,'Mail Protocol',0,1),(38,'priority',NULL,'Priority',0,1),(39,'redaction_rule',NULL,'Redaction Rule',0,1),(40,'report_template',NULL,'Report Template',0,1),(41,'email_greeting',NULL,'Email Greeting Type',0,1),(42,'postal_greeting',NULL,'Postal Greeting Type',0,1),(43,'addressee',NULL,'Addressee Type',0,1),(44,'contact_autocomplete_options',NULL,'Autocomplete Contact Search',0,1),(45,'account_type',NULL,'Account type',0,1),(46,'website_type',NULL,'Website Type',0,1),(47,'tag_used_for',NULL,'Tag Used For',0,1),(48,'currencies_enabled',NULL,'List of currencies enabled for this site',0,1),(49,'languages','Languages','List of Languages',0,1),(50,'encounter_medium','Encounter Medium','Encounter medium for case activities (e.g. In Person, By Phone, etc.)',0,1),(51,'msg_tpl_workflow_case','Message Template Workflow for Cases','Message Template Workflow for Cases',0,1),(52,'msg_tpl_workflow_contribution','Message Template Workflow for Contributions','Message Template Workflow for Contributions',0,1),(53,'msg_tpl_workflow_event','Message Template Workflow for Events','Message Template Workflow for Events',0,1),(54,'msg_tpl_workflow_friend','Message Template Workflow for Tell-a-Friend','Message Template Workflow for Tell-a-Friend',0,1),(55,'msg_tpl_workflow_membership','Message Template Workflow for Memberships','Message Template Workflow for Memberships',0,1),(56,'msg_tpl_workflow_meta','Message Template Workflow for Meta Templates','Message Template Workflow for Meta Templates',0,1),(57,'msg_tpl_workflow_pledge','Message Template Workflow for Pledges','Message Template Workflow for Pledges',0,1),(58,'msg_tpl_workflow_uf','Message Template Workflow for Profiles','Message Template Workflow for Profiles',0,1),(59,'civicrm_contribution_page.amount.1',NULL,'Contribution Page Amount: 1',0,1),(60,'civicrm_event.amount.1',NULL,NULL,0,1),(61,'civicrm_event.amount.2',NULL,NULL,0,1),(63,'ethnicity_20100309194038','Ethnicity',NULL,0,1),(64,'voter_registration_status_20100309194635','Voter Registration Status',NULL,0,1),(66,'organization_category_20100310195946','Organization Category',NULL,0,1),(67,'individual_category_20100310200438','Individual Category',NULL,0,1),(68,'place_of_inquiry_20100310212213','Place of Inquiry',NULL,0,1),(69,'activity_category_20100310212428','Activity Category',NULL,0,1),(70,'voter_registration_status_23_20100517095534','Voter Registration Status',NULL,NULL,1),(71,'place_of_inquiry_43_20100517100229','Place of Inquiry',NULL,NULL,1),(72,'event_badge',NULL,'event_badge',0,1),(73,'record_type_20100906230753','Record Type',NULL,NULL,1),(74,'note_privacy',NULL,'Privacy levels for notes',0,1),(75,'campaign_type',NULL,'Campaign Type',NULL,1),(76,'campaign_status',NULL,'Campaign Status',NULL,1),(77,'system_extensions',NULL,NULL,NULL,1),(78,'directory_preferences',NULL,'Directory Preferences',NULL,1),(79,'url_preferences',NULL,'URL Preferences',NULL,1),(80,'mail_approval_status',NULL,'CiviMail Approval Status',0,1);
/*!40000 ALTER TABLE `civicrm_option_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_option_value`
--

DROP TABLE IF EXISTS `civicrm_option_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_option_value` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option ID',
  `option_group_id` int(10) unsigned NOT NULL COMMENT 'Group which this option belongs to.',
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Option string as displayed to users - e.g. the label in an HTML OPTION tag.',
  `value` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Stores a fixed (non-translated) name for this option value. Lookup functions should use the name as the key for the option value row.',
  `grouping` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Use to sort and/or set display properties for sub-set(s) of options within an option group. EXAMPLE: Use for college_interest field, to differentiate partners from non-partners.',
  `filter` int(10) unsigned DEFAULT NULL COMMENT 'Bitwise logic can be used to create subsets of options within an option_group for different uses.',
  `is_default` tinyint(4) DEFAULT '0' COMMENT 'Is this the default option for the group?',
  `weight` int(10) unsigned NOT NULL COMMENT 'Controls display sort order.',
  `description` text COLLATE utf8_unicode_ci,
  `is_optgroup` tinyint(4) DEFAULT '0' COMMENT 'Is this row simply a display header? Expected usage is to render these as OPTGROUP tags within a SELECT field list of options?',
  `is_reserved` tinyint(4) DEFAULT '0' COMMENT 'Is this a predefined system object?',
  `is_active` tinyint(4) DEFAULT '1' COMMENT 'Is this option active?',
  `component_id` int(10) unsigned DEFAULT NULL COMMENT 'Component that this option value belongs/caters to.',
  `domain_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Domain is this option value for',
  `visibility_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_option_group_id_value` (`value`(255),`option_group_id`),
  KEY `index_option_group_id_name` (`option_group_id`,`name`),
  KEY `FK_civicrm_option_value_component_id` (`component_id`),
  KEY `FK_civicrm_option_value_domain_id` (`domain_id`),
  CONSTRAINT `FK_civicrm_option_value_component_id` FOREIGN KEY (`component_id`) REFERENCES `civicrm_component` (`id`),
  CONSTRAINT `FK_civicrm_option_value_domain_id` FOREIGN KEY (`domain_id`) REFERENCES `civicrm_domain` (`id`),
  CONSTRAINT `FK_civicrm_option_value_option_group_id` FOREIGN KEY (`option_group_id`) REFERENCES `civicrm_option_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1115 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_option_value`
--

LOCK TABLES `civicrm_option_value` WRITE;
/*!40000 ALTER TABLE `civicrm_option_value` DISABLE KEYS */;
INSERT INTO `civicrm_option_value` VALUES (6,2,'Meeting','1','Meeting',NULL,0,NULL,1,NULL,0,1,1,NULL,NULL,NULL),(7,2,'Phone Call (outgoing)','2','Phone Call',NULL,0,0,2,'<br />',0,1,1,NULL,NULL,NULL),(8,2,'Send an Email','3','Email',NULL,1,0,3,'<p>\r\n	Send an email from the system.</p>',0,1,1,NULL,NULL,NULL),(9,2,'Text Message (SMS)','4','SMS',NULL,1,NULL,4,'Text message (SMS) sent.',0,1,1,NULL,NULL,NULL),(10,2,'Event Registration','5','Event Registration',NULL,1,NULL,5,'Online or offline event registration.',0,1,1,1,NULL,NULL),(11,2,'Contribution','6','Contribution',NULL,1,NULL,6,'Online or offline contribution.',0,1,1,2,NULL,NULL),(12,2,'Membership Signup','7','Membership Signup',NULL,1,NULL,7,'Online or offline membership signup.',0,1,1,3,NULL,NULL),(13,2,'Membership Renewal','8','Membership Renewal',NULL,1,NULL,8,'Online or offline membership renewal.',0,1,1,3,NULL,NULL),(14,2,'Tell a Friend','9','Tell a Friend',NULL,1,NULL,9,'Send information about a contribution campaign or event to a friend.',0,1,1,NULL,NULL,NULL),(15,2,'Pledge Acknowledgment','10','Pledge Acknowledgment',NULL,1,NULL,10,'Send Pledge Acknowledgment.',0,1,1,6,NULL,NULL),(16,2,'Pledge Reminder','11','Pledge Reminder',NULL,1,NULL,11,'Send Pledge Reminder.',0,1,1,6,NULL,NULL),(17,2,'Inbound Email','12','Inbound Email',NULL,1,NULL,12,'Inbound Email.',0,1,1,NULL,NULL,NULL),(18,2,'Open Case','13','Open Case',NULL,0,0,13,'',0,0,1,7,NULL,NULL),(19,2,'Follow up','14','Follow up',NULL,0,0,14,'',0,0,1,7,NULL,NULL),(20,2,'Change Case Type','15','Change Case Type',NULL,0,0,15,'',0,0,1,7,NULL,NULL),(21,2,'Change Case Status','16','Change Case Status',NULL,0,0,16,'',0,0,1,7,NULL,NULL),(22,2,'Membership Renewal Reminder','17','Membership Renewal Reminder',NULL,1,NULL,17,'offline membership renewal reminder.',0,1,1,3,NULL,NULL),(23,2,'Change Case Start Date','18','Change Case Start Date',NULL,0,0,18,'',0,0,1,7,NULL,NULL),(24,2,'Bulk Email','19','Bulk Email',NULL,1,NULL,19,'Bulk Email Sent.',0,1,1,NULL,NULL,NULL),(25,2,'Assign Case Role','20','Assign Case Role',NULL,0,0,20,'',0,0,1,7,NULL,NULL),(26,2,'Remove Case Role','21','Remove Case Role',NULL,0,0,21,'',0,0,1,7,NULL,NULL),(27,2,'Print PDF Letter','56','Print PDF Letter',NULL,0,NULL,42,'Print PDF Letter.',0,1,1,NULL,NULL,NULL),(28,2,'Merge Case','23','Merge Case',NULL,0,NULL,23,'',0,1,1,7,NULL,NULL),(29,2,'Reassigned Case','24','Reassigned Case',NULL,0,NULL,24,'',0,1,1,7,NULL,NULL),(30,2,'Link Cases','25','Link Cases',NULL,0,NULL,25,'',0,1,1,7,NULL,NULL),(31,2,'Change Case Tags','26','Change Case Tags',NULL,0,0,26,'',0,1,1,7,NULL,NULL),(32,3,'Female','1','Female',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(33,3,'Male','2','Male',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(34,3,'Transgender','3','Transgender',NULL,0,NULL,3,NULL,0,0,0,NULL,NULL,NULL),(35,4,'Yahoo','1','Yahoo',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(36,4,'MSN','2','Msn',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(37,4,'AIM','3','Aim',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(38,4,'GTalk','4','Gtalk',NULL,0,NULL,4,NULL,0,0,1,NULL,NULL,NULL),(39,4,'Jabber','5','Jabber',NULL,0,NULL,5,NULL,0,0,1,NULL,NULL,NULL),(40,4,'Skype','6','Skype',NULL,0,NULL,6,NULL,0,0,1,NULL,NULL,NULL),(41,5,'Sprint','1','Sprint',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(42,5,'Verizon','2','Verizon',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(43,5,'Cingular','3','Cingular',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(44,6,'Mrs.','1','Mrs.',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(45,6,'Ms.','2','Ms.',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(46,6,'Mr.','3','Mr.',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(47,6,'Dr.','4','Dr.',NULL,0,NULL,4,NULL,0,0,1,NULL,NULL,NULL),(48,7,'Jr.','1','Jr.',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(49,7,'Sr.','2','Sr.',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(50,7,'II','3','II',NULL,0,NULL,4,NULL,0,0,1,NULL,NULL,NULL),(51,7,'III','4','III',NULL,0,NULL,5,NULL,0,0,1,NULL,NULL,NULL),(52,7,'IV','5','IV',NULL,0,NULL,6,NULL,0,0,1,NULL,NULL,NULL),(53,7,'V','6','V',NULL,0,NULL,7,NULL,0,0,1,NULL,NULL,NULL),(56,8,'Administrator','1','Admin',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(57,8,'Authenticated','2','Auth',NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(58,9,'Visa','1','Visa',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(59,9,'MasterCard','2','MasterCard',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(60,9,'Amex','3','Amex',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(61,9,'Discover','4','Discover',NULL,0,NULL,4,NULL,0,0,1,NULL,NULL,NULL),(62,10,'Credit Card','1','Credit Card',NULL,0,NULL,1,NULL,0,1,1,NULL,NULL,NULL),(63,10,'Debit Card','2','Debit Card',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(64,10,'Cash','3','Cash',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(65,10,'Check','4','Check',NULL,0,NULL,4,NULL,0,0,1,NULL,NULL,NULL),(66,10,'EFT','5','EFT',NULL,0,NULL,5,NULL,0,0,1,NULL,NULL,NULL),(67,11,'Completed','1','Completed',NULL,0,NULL,1,NULL,0,1,1,NULL,NULL,NULL),(68,11,'Pending','2','Pending',NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(69,11,'Cancelled','3','Cancelled',NULL,0,NULL,3,NULL,0,1,1,NULL,NULL,NULL),(70,11,'Failed','4','Failed',NULL,0,NULL,4,NULL,0,1,1,NULL,NULL,NULL),(71,11,'In Progress','5','In Progress',NULL,0,NULL,5,NULL,0,1,1,NULL,NULL,NULL),(72,11,'Overdue','6','Overdue',NULL,0,NULL,6,NULL,0,1,1,NULL,NULL,NULL),(73,12,'Waiting Review','1','Waiting Review',NULL,0,NULL,1,NULL,0,1,1,NULL,NULL,NULL),(74,12,'Approved','2','Approved',NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(75,12,'Not Approved','3','Not Approved',NULL,0,NULL,3,NULL,0,1,1,NULL,NULL,NULL),(76,13,'Attendee','1','Attendee',NULL,1,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(77,13,'Volunteer','2','Volunteer',NULL,1,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(78,13,'Host','3','Host',NULL,1,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(79,13,'Speaker','4','Speaker',NULL,1,NULL,4,NULL,0,0,1,NULL,NULL,NULL),(80,14,'Conference','1','Conference',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(81,14,'Exhibition','2','Exhibition',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(82,14,'Fundraiser','3','Fundraiser',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(83,14,'Meeting','4','Meeting',NULL,0,NULL,4,NULL,0,0,1,NULL,NULL,NULL),(84,14,'Performance','5','Performance',NULL,0,NULL,5,NULL,0,0,1,NULL,NULL,NULL),(85,14,'Workshop','6','Workshop',NULL,0,NULL,6,NULL,0,0,1,NULL,NULL,NULL),(86,15,'Activities','1','activity',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(87,15,'Relationships','2','rel',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(88,15,'Groups','3','group',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(89,15,'Notes','4','note',NULL,0,NULL,4,NULL,0,0,1,NULL,NULL,NULL),(90,15,'Tags','5','tag',NULL,0,NULL,5,NULL,0,0,1,NULL,NULL,NULL),(91,15,'Change Log','6','log',NULL,0,NULL,6,NULL,0,0,1,NULL,NULL,NULL),(92,15,'Contributions','7','CiviContribute',NULL,0,NULL,7,NULL,0,0,1,NULL,NULL,NULL),(93,15,'Memberships','8','CiviMember',NULL,0,NULL,8,NULL,0,0,1,NULL,NULL,NULL),(94,15,'Events','9','CiviEvent',NULL,0,NULL,9,NULL,0,0,1,NULL,NULL,NULL),(95,15,'Cases','10','CiviCase',NULL,0,NULL,10,NULL,0,0,1,NULL,NULL,NULL),(96,15,'Grants','11','CiviGrant',NULL,0,NULL,11,NULL,0,0,1,NULL,NULL,NULL),(97,15,'Pledges','13','CiviPledge',NULL,0,NULL,13,NULL,0,0,1,NULL,NULL,NULL),(98,16,'Custom Data','1','CustomData',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(99,16,'Address','2','Address',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(100,16,'Communication Preferences','3','CommunicationPreferences',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(101,16,'Notes','4','Notes',NULL,0,NULL,4,NULL,0,0,1,NULL,NULL,NULL),(102,16,'Demographics','5','Demographics',NULL,0,NULL,5,NULL,0,0,1,NULL,NULL,NULL),(103,16,'Tags and Groups','6','TagsAndGroups',NULL,0,NULL,6,NULL,0,0,1,NULL,NULL,NULL),(104,16,'Email','7','Email',NULL,1,NULL,7,NULL,0,0,1,NULL,NULL,NULL),(105,16,'Phone','8','Phone',NULL,1,NULL,8,NULL,0,0,1,NULL,NULL,NULL),(106,16,'Instant Messenger','9','IM',NULL,1,NULL,9,NULL,0,0,1,NULL,NULL,NULL),(107,16,'Open ID','10','OpenID',NULL,1,NULL,10,NULL,0,0,1,NULL,NULL,NULL),(108,16,'Website','11','Website',NULL,1,NULL,11,NULL,0,0,1,NULL,NULL,NULL),(109,17,'Address Fields','1','location',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(110,17,'Custom Fields','2','custom',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(111,17,'Activities','3','activity',NULL,0,NULL,4,NULL,0,0,1,NULL,NULL,NULL),(112,17,'Relationships','4','relationship',NULL,0,NULL,5,NULL,0,0,1,NULL,NULL,NULL),(113,17,'Notes','5','notes',NULL,0,NULL,6,NULL,0,0,1,NULL,NULL,NULL),(114,17,'Change Log','6','changeLog',NULL,0,NULL,7,NULL,0,0,1,NULL,NULL,NULL),(115,17,'Contributions','7','CiviContribute',NULL,0,NULL,8,NULL,0,0,1,NULL,NULL,NULL),(116,17,'Memberships','8','CiviMember',NULL,0,NULL,9,NULL,0,0,1,NULL,NULL,NULL),(117,17,'Events','9','CiviEvent',NULL,0,NULL,10,NULL,0,0,1,NULL,NULL,NULL),(118,17,'Cases','10','CiviCase',NULL,0,NULL,11,NULL,0,0,1,NULL,NULL,NULL),(119,17,'Grants','12','CiviGrant',NULL,0,NULL,14,NULL,0,0,1,NULL,NULL,NULL),(120,17,'Demographics','13','demographics',NULL,0,NULL,15,NULL,0,0,1,NULL,NULL,NULL),(121,17,'Pledges','15','CiviPledge',NULL,0,NULL,17,NULL,0,0,1,NULL,NULL,NULL),(122,17,'Contact Type','16','contactType',NULL,0,NULL,18,NULL,0,0,1,NULL,NULL,NULL),(123,17,'Groups','17','groups',NULL,0,NULL,19,NULL,0,0,1,NULL,NULL,NULL),(124,17,'Tags','18','tags',NULL,0,NULL,20,NULL,0,0,1,NULL,NULL,NULL),(125,18,'Groups','1','Groups',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(126,18,'Contributions','2','CiviContribute',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(127,18,'Memberships','3','CiviMember',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(128,18,'Events','4','CiviEvent',NULL,0,NULL,4,NULL,0,0,1,NULL,NULL,NULL),(129,18,'My Contacts / Organizations','5','Permissioned Orgs',NULL,0,NULL,5,NULL,0,0,1,NULL,NULL,NULL),(130,18,'Pledges','7','CiviPledge',NULL,0,NULL,7,NULL,0,0,1,NULL,NULL,NULL),(131,18,'Personal Campaign Pages','8','PCP',NULL,0,NULL,8,NULL,0,0,1,NULL,NULL,NULL),(132,44,'Email Address','2','email',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(133,44,'Phone','3','phone',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(134,44,'Street Address','4','street_address',NULL,0,NULL,4,NULL,0,0,1,NULL,NULL,NULL),(135,44,'City','5','city',NULL,0,NULL,5,NULL,0,0,1,NULL,NULL,NULL),(136,44,'State/Province','6','state_province',NULL,0,NULL,6,NULL,0,0,1,NULL,NULL,NULL),(137,44,'Country','7','country',NULL,0,NULL,7,NULL,0,0,1,NULL,NULL,NULL),(138,19,'Street Address','1','street_address',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(139,19,'Addt\'l Address 1','2','supplemental_address_1',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(140,19,'Addt\'l Address 2','3','supplemental_address_2',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(141,19,'City','4','city',NULL,0,NULL,4,NULL,0,0,1,NULL,NULL,NULL),(142,19,'Zip / Postal Code','5','postal_code',NULL,0,NULL,5,NULL,0,0,1,NULL,NULL,NULL),(143,19,'Postal Code Suffix','6','postal_code_suffix',NULL,0,NULL,6,NULL,0,0,1,NULL,NULL,NULL),(144,19,'County','7','county',NULL,0,NULL,7,NULL,0,0,1,NULL,NULL,NULL),(145,19,'State / Province','8','state_province',NULL,0,NULL,8,NULL,0,0,1,NULL,NULL,NULL),(146,19,'Country','9','country',NULL,0,NULL,9,NULL,0,0,1,NULL,NULL,NULL),(147,19,'Latitude','10','geo_code_1',NULL,0,NULL,10,NULL,0,0,1,NULL,NULL,NULL),(148,19,'Longitude','11','geo_code_2',NULL,0,NULL,11,NULL,0,0,1,NULL,NULL,NULL),(149,19,'Address Name','12','address_name',NULL,0,NULL,12,NULL,0,0,1,NULL,NULL,NULL),(150,19,'Street Address Parsing','13','street_address_parsing',NULL,0,NULL,13,NULL,0,0,1,NULL,NULL,NULL),(151,20,'Access Control','1',NULL,NULL,0,NULL,1,NULL,0,1,1,NULL,NULL,NULL),(152,20,'Mailing List','2',NULL,NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(153,21,'Pending','1','Pending',NULL,0,1,1,NULL,0,0,1,NULL,NULL,NULL),(154,21,'Granted','2','Granted',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(155,21,'Rejected','3','Rejected',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(156,23,'In Honor of','1','In Honor of',NULL,0,1,1,NULL,0,1,1,NULL,NULL,NULL),(157,23,'In Memory of','2','In Memory of',NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(158,24,'CRM_Contact_Form_Search_Custom_Sample','1','CRM_Contact_Form_Search_Custom_Sample',NULL,0,NULL,1,'Household Name and State',0,0,1,NULL,NULL,NULL),(159,24,'CRM_Contact_Form_Search_Custom_ContributionAggregate','2','CRM_Contact_Form_Search_Custom_ContributionAggregate',NULL,0,NULL,2,'Contribution Aggregate',0,0,1,NULL,NULL,NULL),(160,24,'CRM_Contact_Form_Search_Custom_Basic','3','CRM_Contact_Form_Search_Custom_Basic',NULL,0,NULL,3,'Basic Search',0,0,1,NULL,NULL,NULL),(161,24,'CRM_Contact_Form_Search_Custom_Group','4','CRM_Contact_Form_Search_Custom_Group',NULL,0,NULL,4,'Include / Exclude Contacts in a Group / Tag',0,0,1,NULL,NULL,NULL),(162,24,'CRM_Contact_Form_Search_Custom_PostalMailing','5','CRM_Contact_Form_Search_Custom_PostalMailing',NULL,0,NULL,5,'Postal Mailing',0,0,1,NULL,NULL,NULL),(163,24,'CRM_Contact_Form_Search_Custom_Proximity','6','CRM_Contact_Form_Search_Custom_Proximity',NULL,0,NULL,6,'Proximity Search',0,0,1,NULL,NULL,NULL),(164,24,'CRM_Contact_Form_Search_Custom_EventAggregate','7','CRM_Contact_Form_Search_Custom_EventAggregate',NULL,0,NULL,7,'Event Aggregate',0,0,1,NULL,NULL,NULL),(165,24,'CRM_Contact_Form_Search_Custom_ActivitySearch','8','CRM_Contact_Form_Search_Custom_ActivitySearch',NULL,0,NULL,8,'Activity Search',0,0,1,NULL,NULL,NULL),(166,24,'CRM_Contact_Form_Search_Custom_PriceSet','9','CRM_Contact_Form_Search_Custom_PriceSet',NULL,0,NULL,9,'Price Set Details for Event Participants',0,0,1,NULL,NULL,NULL),(167,24,'CRM_Contact_Form_Search_Custom_ZipCodeRange','10','CRM_Contact_Form_Search_Custom_ZipCodeRange',NULL,0,NULL,10,'Zip Code Range',0,0,1,NULL,NULL,NULL),(168,24,'CRM_Contact_Form_Search_Custom_DateAdded','11','CRM_Contact_Form_Search_Custom_DateAdded',NULL,0,NULL,11,'Date Added to CiviCRM',0,0,1,NULL,NULL,NULL),(169,24,'CRM_Contact_Form_Search_Custom_MultipleValues','12','CRM_Contact_Form_Search_Custom_MultipleValues',NULL,0,NULL,12,'Custom Group Multiple Values Listing',0,0,1,NULL,NULL,NULL),(170,24,'CRM_Contact_Form_Search_Custom_ContribSYBNT','13','CRM_Contact_Form_Search_Custom_ContribSYBNT',NULL,0,NULL,13,'Contributions made in Year X and not Year Y',0,0,1,NULL,NULL,NULL),(171,24,'CRM_Contact_Form_Search_Custom_TagContributions','14','CRM_Contact_Form_Search_Custom_TagContributions',NULL,0,NULL,14,'Find Contribution Amounts by Tag',0,0,1,NULL,NULL,NULL),(172,24,'CRM_Contact_Form_Search_Custom_FullText','15','CRM_Contact_Form_Search_Custom_FullText',NULL,0,NULL,15,'Full-text Search',0,0,1,NULL,NULL,NULL),(173,40,'Constituent Report (Summary)','contact/summary','CRM_Report_Form_Contact_Summary',NULL,0,NULL,1,'Provides a list of address and telephone information for constituent records in your system.',0,0,1,NULL,NULL,NULL),(174,40,'Constituent Report (Detail)','contact/detail','CRM_Report_Form_Contact_Detail',NULL,0,0,2,'Provides contact-related information on activities.',0,0,1,NULL,NULL,NULL),(175,40,'Activity Report','activity','CRM_Report_Form_Activity',NULL,0,NULL,3,'Provides a list of constituent activity including activity statistics for one/all contacts during a given date range(required)',0,0,1,NULL,NULL,NULL),(176,40,'Walk / Phone List Report','walklist','CRM_Report_Form_Walklist',NULL,0,NULL,4,'Provides a detailed report for your walk/phonelist for targetted contacts',0,0,0,NULL,NULL,NULL),(177,40,'Current Employer Report','contact/currentEmployer','CRM_Report_Form_Contact_CurrentEmployer',NULL,0,NULL,5,'Provides detail list of employer employee relationships along with employment details Ex Join Date',0,0,0,NULL,NULL,NULL),(178,40,'Donor Report (Summary)','contribute/summary','CRM_Report_Form_Contribute_Summary',NULL,0,NULL,6,'Shows contribution statistics by month / week / year .. country / state .. type.',0,0,0,2,NULL,NULL),(179,40,'Donor Report (Detail)','contribute/detail','CRM_Report_Form_Contribute_Detail',NULL,0,NULL,7,'Lists detailed contribution(s) for one / all contacts. Contribution summary report points to this report for specific details.',0,0,0,2,NULL,NULL),(180,40,'Donation Summary Report (Repeat)','contribute/repeat','CRM_Report_Form_Contribute_Repeat',NULL,0,NULL,8,'Given two date ranges, shows contacts (and their contributions) who contributed in both the date ranges with percentage increase / decrease.',0,0,0,2,NULL,NULL),(181,40,'Donation Summary Report (Organization)','contribute/organizationSummary','CRM_Report_Form_Contribute_OrganizationSummary',NULL,0,NULL,9,'Displays a detailed contribution report for Organization relationships with contributors, as to if contribution done was  from an employee of some organization or from that Organization itself.',0,0,0,2,NULL,NULL),(182,40,'Donation Summary Report (Household)','contribute/householdSummary','CRM_Report_Form_Contribute_HouseholdSummary',NULL,0,NULL,10,'Provides a detailed report for Contributions made by contributors(Or Household itself) who are having a relationship with household (For ex a Contributor is Head of Household for some household or is a member of.)',0,0,0,2,NULL,NULL),(183,40,'Top Donors Report','contribute/topDonor','CRM_Report_Form_Contribute_TopDonor',NULL,0,NULL,11,'Provides a list of the top donors during a time period you define. You can include as many donors as you want (for example, top 100 of your donors).',0,0,0,2,NULL,NULL),(184,40,'SYBUNT Report','contribute/sybunt','CRM_Report_Form_Contribute_Sybunt',NULL,0,NULL,12,'Some year(s) but not this year. Provides a list of constituents who donated at some time in the history of your organization but did not donate during the time period you specify.',0,0,0,2,NULL,NULL),(185,40,'LYBUNT Report','contribute/lybunt','CRM_Report_Form_Contribute_Lybunt',NULL,0,NULL,13,'Last year but not this year. Provides a list of constituents who donated last year but did not donate during the time period you specify as the current year.',0,0,0,2,NULL,NULL),(186,40,'Soft Credit Report','contribute/softcredit','CRM_Report_Form_Contribute_SoftCredit',NULL,0,NULL,14,'Soft Credit details.',0,0,0,2,NULL,NULL),(187,40,'Membership Report (Summary)','member/summary','CRM_Report_Form_Member_Summary',NULL,0,NULL,15,'Provides a summary of memberships by type and join date.',0,0,0,3,NULL,NULL),(188,40,'Membership Report (Detail)','member/detail','CRM_Report_Form_Member_Detail',NULL,0,NULL,16,'Provides a list of members along with their membership status and membership details (Join Date, Start Date, End Date).',0,0,0,3,NULL,NULL),(189,40,'Membership Report (Lapsed)','member/lapse','CRM_Report_Form_Member_Lapse',NULL,0,NULL,17,'Provides a list of memberships that lapsed or will lapse before the date you specify.',0,0,0,3,NULL,NULL),(190,40,'Event Participant Report (List)','event/participantListing','CRM_Report_Form_Event_ParticipantListing',NULL,0,NULL,18,'Provides lists of participants for an event.',0,0,0,1,NULL,NULL),(191,40,'Event Income Report (Summary)','event/summary','CRM_Report_Form_Event_Summary',NULL,0,NULL,19,'Provides an overview of event income. You can include key information such as event ID, registration, attendance, and income generated to help you determine the success of an event.',0,0,0,1,NULL,NULL),(192,40,'Event Income Report (Detail)','event/income','CRM_Report_Form_Event_Income',NULL,0,NULL,20,'Helps you to analyze the income generated by an event. The report can include details by participant type, status and payment method.',0,0,0,1,NULL,NULL),(193,40,'Pledge Report','pledge/summary','CRM_Report_Form_Pledge_Summary',NULL,0,NULL,21,'Pledge Report',0,0,0,6,NULL,NULL),(194,40,'Pledged But not Paid Report','pledge/pbnp','CRM_Report_Form_Pledge_Pbnp',NULL,0,NULL,22,'Pledged but not Paid Report',0,0,0,6,NULL,NULL),(195,40,'Relationship Report','contact/relationship','CRM_Report_Form_Contact_Relationship',NULL,0,NULL,23,'Relationship Report',0,0,1,NULL,NULL,NULL),(196,40,'Case Summary Report','case/summary','CRM_Report_Form_Case_Summary',NULL,0,NULL,24,'Provides a summary of cases and their duration by date range, status, staff member and / or case role.',0,0,1,7,NULL,NULL),(197,40,'Case Time Spent Report','case/timespent','CRM_Report_Form_Case_TimeSpent',NULL,0,NULL,25,'Aggregates time spent on case and / or or non-case activities by activity type and contact.',0,0,1,7,NULL,NULL),(198,40,'Contact Demographics Report','case/demographics','CRM_Report_Form_Case_Demographics',NULL,0,NULL,26,'Demographic breakdown for case clients (and or non-case contacts) in your database. Includes custom contact fields.',0,0,1,7,NULL,NULL),(199,40,'Database Log Report','contact/log','CRM_Report_Form_Contact_Log',NULL,0,NULL,27,'Log of contact and activity records created or updated in a given date range.',0,0,1,NULL,NULL,NULL),(200,40,'Activity Report (Summary)','activitySummary','CRM_Report_Form_ActivitySummary',NULL,0,NULL,28,'Shows activity statistics by type / date',0,0,1,NULL,NULL,NULL),(201,25,'Scheduled','1','Scheduled',NULL,0,1,1,NULL,0,1,1,NULL,NULL,NULL),(202,25,'Completed','2','Completed',NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(203,25,'Cancelled','3','Cancelled',NULL,0,NULL,3,NULL,0,1,1,NULL,NULL,NULL),(204,25,'Left Message','4','Left Message',NULL,0,NULL,4,NULL,0,0,1,NULL,NULL,NULL),(205,25,'Unreachable','5','Unreachable',NULL,0,NULL,5,NULL,0,0,1,NULL,NULL,NULL),(206,25,'Not Required','6','Not Required',NULL,0,NULL,6,NULL,0,0,1,NULL,NULL,NULL),(207,27,'Ongoing','1','Open','Opened',0,1,1,NULL,0,1,1,NULL,NULL,NULL),(208,27,'Resolved','2','Closed','Closed',0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(209,27,'Urgent','3','Urgent','Opened',0,NULL,3,NULL,0,1,1,NULL,NULL,NULL),(210,28,'Name Only','1','Name Only',NULL,0,0,1,'CRM_Event_Page_ParticipantListing_Name',0,1,1,NULL,NULL,NULL),(211,28,'Name and Email','2','Name and Email',NULL,0,0,2,'CRM_Event_Page_ParticipantListing_NameAndEmail',0,1,1,NULL,NULL,NULL),(212,28,'Name, Status and Register Date','3','Name, Status and Register Date',NULL,0,0,3,'CRM_Event_Page_ParticipantListing_NameStatusAndDate',0,1,1,NULL,NULL,NULL),(213,29,'jpg','1',NULL,NULL,0,0,1,NULL,0,0,1,NULL,NULL,NULL),(214,29,'jpeg','2',NULL,NULL,0,0,2,NULL,0,0,1,NULL,NULL,NULL),(215,29,'png','3',NULL,NULL,0,0,3,NULL,0,0,1,NULL,NULL,NULL),(216,29,'gif','4',NULL,NULL,0,0,4,NULL,0,0,1,NULL,NULL,NULL),(217,29,'txt','5',NULL,NULL,0,0,5,NULL,0,0,1,NULL,NULL,NULL),(218,29,'pdf','6',NULL,NULL,0,0,6,NULL,0,0,1,NULL,NULL,NULL),(219,29,'doc','7',NULL,NULL,0,0,7,NULL,0,0,1,NULL,NULL,NULL),(220,29,'xls','8',NULL,NULL,0,0,8,NULL,0,0,1,NULL,NULL,NULL),(221,29,'rtf','9',NULL,NULL,0,0,9,NULL,0,0,1,NULL,NULL,NULL),(222,29,'csv','10',NULL,NULL,0,0,10,NULL,0,0,1,NULL,NULL,NULL),(223,29,'ppt','11',NULL,NULL,0,0,11,NULL,0,0,1,NULL,NULL,NULL),(224,29,'docx','12',NULL,NULL,0,0,12,NULL,0,0,1,NULL,NULL,NULL),(225,29,'xlsx','13',NULL,NULL,0,0,13,NULL,0,0,1,NULL,NULL,NULL),(226,32,'TinyMCE','1',NULL,NULL,0,NULL,1,NULL,0,1,1,NULL,NULL,NULL),(227,32,'CKEditor','2',NULL,NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(228,31,'Search Builder','1','Search Builder',NULL,0,0,1,NULL,0,1,1,NULL,NULL,NULL),(229,31,'Import Contact','2','Import Contact',NULL,0,0,2,NULL,0,1,1,NULL,NULL,NULL),(230,31,'Import Activity','3','Import Activity',NULL,0,0,3,NULL,0,1,1,NULL,NULL,NULL),(231,31,'Import Contribution','4','Import Contribution',NULL,0,0,4,NULL,0,1,1,NULL,NULL,NULL),(232,31,'Import Membership','5','Import Membership',NULL,0,0,5,NULL,0,1,1,NULL,NULL,NULL),(233,31,'Import Participant','6','Import Participant',NULL,0,0,6,NULL,0,1,1,NULL,NULL,NULL),(234,31,'Export Contact','7','Export Contact',NULL,0,0,7,NULL,0,1,1,NULL,NULL,NULL),(235,31,'Export Contribution','8','Export Contribution',NULL,0,0,8,NULL,0,1,1,NULL,NULL,NULL),(236,31,'Export Membership','9','Export Membership',NULL,0,0,9,NULL,0,1,1,NULL,NULL,NULL),(237,31,'Export Participant','10','Export Participant',NULL,0,0,10,NULL,0,1,1,NULL,NULL,NULL),(238,31,'Export Pledge','11','Export Pledge',NULL,0,0,11,NULL,0,1,1,NULL,NULL,NULL),(239,31,'Export Case','12','Export Case',NULL,0,0,12,NULL,0,1,1,NULL,NULL,NULL),(240,31,'Export Grant','13','Export Grant',NULL,0,0,13,NULL,0,1,1,NULL,NULL,NULL),(241,31,'Export Activity','14','Export Activity',NULL,0,0,14,NULL,0,1,1,NULL,NULL,NULL),(242,33,'day','day','day',NULL,0,NULL,1,NULL,0,1,1,NULL,NULL,NULL),(243,33,'week','week','week',NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(244,33,'month','month','month',NULL,0,NULL,3,NULL,0,1,1,NULL,NULL,NULL),(245,33,'year','year','year',NULL,0,NULL,4,NULL,0,1,1,NULL,NULL,NULL),(246,34,'Phone','1','Phone',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(247,34,'Mobile','2','Mobile',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(248,34,'Fax','3','Fax',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(249,34,'Pager','4','Pager',NULL,0,NULL,4,NULL,0,0,1,NULL,NULL,NULL),(250,34,'Voicemail','5','Voicemail',NULL,0,NULL,5,NULL,0,0,1,NULL,NULL,NULL),(251,35,'Participant Role','1','ParticipantRole',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(252,35,'Participant Event Name','2','ParticipantEventName',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(253,35,'Participant Event Type','3','ParticipantEventType',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(254,36,'Public','1','public',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(255,36,'Admin','2','admin',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(256,37,'IMAP','1','IMAP',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(257,37,'Maildir','2','Maildir',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(258,37,'POP3','3','POP3',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(259,37,'Localdir','4','Localdir',NULL,0,NULL,4,NULL,0,0,1,NULL,NULL,NULL),(260,38,'Urgent','1','Urgent',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(261,38,'Normal','2','Normal',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(262,38,'Low','3','Low',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(263,39,'Vancouver','city_',NULL,NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(264,39,'/(19|20)(\\d{2})-(\\d{1,2})-(\\d{1,2})/','date_',NULL,NULL,1,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(265,41,'Dear {contact.first_name}','1','Dear {contact.first_name}',NULL,1,0,4,NULL,0,0,1,NULL,NULL,NULL),(266,41,'Dear {contact.individual_prefix} {contact.first_name} {contact.last_name}','2','Dear {contact.individual_prefix} {contact.first_name} {contact.last_name}',NULL,1,0,3,NULL,0,0,1,NULL,NULL,NULL),(267,41,'Dear {contact.individual_prefix} {contact.last_name}','3','Dear {contact.individual_prefix} {contact.last_name}',NULL,1,1,1,NULL,0,0,1,NULL,NULL,NULL),(268,41,'Customized','4','Customized',NULL,0,0,2,NULL,0,1,1,NULL,NULL,NULL),(269,41,'Dear {contact.household_name}','5','Dear {contact.househols_name}',NULL,2,1,5,NULL,0,0,1,NULL,NULL,NULL),(270,42,'Dear {contact.first_name}','1','Dear {contact.first_name}',NULL,1,0,3,NULL,0,0,1,NULL,NULL,NULL),(271,42,'Dear {contact.individual_prefix} {contact.first_name} {contact.last_name}','2','Dear {contact.individual_prefix} {contact.first_name} {contact.last_name}',NULL,1,0,4,NULL,0,0,1,NULL,NULL,NULL),(272,42,'Dear {contact.individual_prefix} {contact.last_name}','3','Dear {contact.individual_prefix} {contact.last_name}',NULL,1,1,1,'',0,0,1,NULL,NULL,NULL),(273,42,'Customized','4','Customized',NULL,0,0,2,NULL,0,1,1,NULL,NULL,NULL),(274,42,'Dear {contact.household_name}','5','Dear {contact.household_name}',NULL,2,1,5,NULL,0,0,1,NULL,NULL,NULL),(275,43,'{contact.individual_prefix}{ } {contact.first_name}{ }{contact.middle_name}{ }{contact.last_name}{ }{contact.individual_suffix}','1','}{contact.individual_prefix}{ } {contact.first_name}{ }{contact.middle_name}{ }{contact.last_name}{ }{contact.individual_suffix}',NULL,1,1,1,NULL,0,0,1,NULL,NULL,NULL),(276,43,'{contact.household_name}','2','{contact.household_name}',NULL,2,0,2,NULL,0,0,1,NULL,NULL,NULL),(277,43,'{contact.organization_name}','3','{contact.organization_name}',NULL,3,1,3,NULL,0,0,1,NULL,NULL,NULL),(278,43,'Customized','4','Customized',NULL,0,0,4,NULL,0,1,1,NULL,NULL,NULL),(279,45,'Asset','1','Asset',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(280,45,'Liability','2','Liability',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(281,45,'Income','3','Income',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(282,45,'Expense','4','Expense',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(283,46,'Home','1','Home',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(284,46,'Work','2','Work',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(285,46,'Facebook','3','Facebook',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(286,46,'Twitter','4','Twitter',NULL,0,NULL,4,NULL,0,0,1,NULL,NULL,NULL),(287,46,'MySpace','5','MySpace',NULL,0,NULL,5,NULL,0,0,1,NULL,NULL,NULL),(288,47,'Contacts','civicrm_contact','Contacts',NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(289,47,'Activities','civicrm_activity','Activities',NULL,0,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(290,47,'Cases','civicrm_case','Cases',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(291,48,'USD ($)','USD','USD',NULL,0,1,1,NULL,0,0,1,NULL,NULL,NULL),(292,30,'\"Bluebird Mailer\" <bluebird.admin@nysenate.gov>','1','\"FIXME\" <info@FIXME.ORG>',NULL,0,1,1,NULL,0,0,1,NULL,1,NULL),(293,22,'Emergency','1','Emergency',NULL,0,1,1,NULL,0,0,1,NULL,1,NULL),(294,22,'Family Support','2','Family Support',NULL,0,NULL,2,NULL,0,0,1,NULL,1,NULL),(295,22,'General Protection','3','General Protection',NULL,0,NULL,3,NULL,0,0,1,NULL,1,NULL),(296,22,'Impunity','4','Impunity',NULL,0,NULL,4,NULL,0,0,1,NULL,1,NULL),(297,49,'Abkhaz','ab','ab_GE',NULL,NULL,0,1,NULL,0,0,1,NULL,NULL,NULL),(298,49,'Afar','aa','aa_ET',NULL,NULL,0,2,NULL,0,0,1,NULL,NULL,NULL),(299,49,'Afrikaans','af','af_ZA',NULL,NULL,0,3,NULL,0,0,1,NULL,NULL,NULL),(300,49,'Akan','ak','ak_GH',NULL,NULL,0,4,NULL,0,0,1,NULL,NULL,NULL),(301,49,'Albanian','sq','sq_AL',NULL,NULL,0,5,NULL,0,0,1,NULL,NULL,NULL),(302,49,'Amharic','am','am_ET',NULL,NULL,0,6,NULL,0,0,1,NULL,NULL,NULL),(303,49,'Arabic','ar','ar_EG',NULL,NULL,0,7,NULL,0,0,1,NULL,NULL,NULL),(304,49,'Aragonese','an','an_ES',NULL,NULL,0,8,NULL,0,0,1,NULL,NULL,NULL),(305,49,'Armenian','hy','hy_AM',NULL,NULL,0,9,NULL,0,0,1,NULL,NULL,NULL),(306,49,'Assamese','as','as_IN',NULL,NULL,0,10,NULL,0,0,1,NULL,NULL,NULL),(307,49,'Avaric','av','av_RU',NULL,NULL,0,11,NULL,0,0,1,NULL,NULL,NULL),(308,49,'Avestan','ae','ae_XX',NULL,NULL,0,12,NULL,0,0,1,NULL,NULL,NULL),(309,49,'Aymara','ay','ay_BO',NULL,NULL,0,13,NULL,0,0,1,NULL,NULL,NULL),(310,49,'Azerbaijani','az','az_AZ',NULL,NULL,0,14,NULL,0,0,1,NULL,NULL,NULL),(311,49,'Bambara','bm','bm_ML',NULL,NULL,0,15,NULL,0,0,1,NULL,NULL,NULL),(312,49,'Bashkir','ba','ba_RU',NULL,NULL,0,16,NULL,0,0,1,NULL,NULL,NULL),(313,49,'Basque','eu','eu_ES',NULL,NULL,0,17,NULL,0,0,1,NULL,NULL,NULL),(314,49,'Belarusian','be','be_BY',NULL,NULL,0,18,NULL,0,0,1,NULL,NULL,NULL),(315,49,'Bengali','bn','bn_BD',NULL,NULL,0,19,NULL,0,0,1,NULL,NULL,NULL),(316,49,'Bihari','bh','bh_IN',NULL,NULL,0,20,NULL,0,0,1,NULL,NULL,NULL),(317,49,'Bislama','bi','bi_VU',NULL,NULL,0,21,NULL,0,0,1,NULL,NULL,NULL),(318,49,'Bosnian','bs','bs_BA',NULL,NULL,0,22,NULL,0,0,1,NULL,NULL,NULL),(319,49,'Breton','br','br_FR',NULL,NULL,0,23,NULL,0,0,1,NULL,NULL,NULL),(320,49,'Bulgarian','bg','bg_BG',NULL,NULL,0,24,NULL,0,0,1,NULL,NULL,NULL),(321,49,'Burmese','my','my_MM',NULL,NULL,0,25,NULL,0,0,1,NULL,NULL,NULL),(322,49,'Catalan; Valencian','ca','ca_ES',NULL,NULL,0,26,NULL,0,0,1,NULL,NULL,NULL),(323,49,'Chamorro','ch','ch_GU',NULL,NULL,0,27,NULL,0,0,1,NULL,NULL,NULL),(324,49,'Chechen','ce','ce_RU',NULL,NULL,0,28,NULL,0,0,1,NULL,NULL,NULL),(325,49,'Chichewa; Chewa; Nyanja','ny','ny_MW',NULL,NULL,0,29,NULL,0,0,1,NULL,NULL,NULL),(326,49,'Chinese (China/Mandarin)','zh','zh_CN',NULL,NULL,0,30,NULL,0,0,1,NULL,NULL,NULL),(327,49,'Chuvash','cv','cv_RU',NULL,NULL,0,31,NULL,0,0,1,NULL,NULL,NULL),(328,49,'Cornish','kw','kw_GB',NULL,NULL,0,32,NULL,0,0,1,NULL,NULL,NULL),(329,49,'Corsican','co','co_FR',NULL,NULL,0,33,NULL,0,0,1,NULL,NULL,NULL),(330,49,'Cree','cr','cr_CA',NULL,NULL,0,34,NULL,0,0,1,NULL,NULL,NULL),(331,49,'Croatian','hr','hr_HR',NULL,NULL,0,35,NULL,0,0,1,NULL,NULL,NULL),(332,49,'Czech','cs','cs_CZ',NULL,NULL,0,36,NULL,0,0,1,NULL,NULL,NULL),(333,49,'Danish','da','da_DK',NULL,NULL,0,37,NULL,0,0,1,NULL,NULL,NULL),(334,49,'Divehi; Dhivehi; Maldivian;','dv','dv_MV',NULL,NULL,0,38,NULL,0,0,1,NULL,NULL,NULL),(335,49,'Dutch','nl','nl_NL',NULL,NULL,0,39,NULL,0,0,1,NULL,NULL,NULL),(336,49,'Dzongkha','dz','dz_BT',NULL,NULL,0,40,NULL,0,0,1,NULL,NULL,NULL),(337,49,'English (United States)','en','en_US',NULL,NULL,1,41,NULL,0,0,1,NULL,NULL,NULL),(338,49,'Esperanto','eo','eo_XX',NULL,NULL,0,42,NULL,0,0,1,NULL,NULL,NULL),(339,49,'Estonian','et','et_EE',NULL,NULL,0,43,NULL,0,0,1,NULL,NULL,NULL),(340,49,'Ewe','ee','ee_GH',NULL,NULL,0,44,NULL,0,0,1,NULL,NULL,NULL),(341,49,'Faroese','fo','fo_FO',NULL,NULL,0,45,NULL,0,0,1,NULL,NULL,NULL),(342,49,'Fijian','fj','fj_FJ',NULL,NULL,0,46,NULL,0,0,1,NULL,NULL,NULL),(343,49,'Finnish','fi','fi_FI',NULL,NULL,0,47,NULL,0,0,1,NULL,NULL,NULL),(344,49,'French (France)','fr','fr_FR',NULL,NULL,0,48,NULL,0,0,1,NULL,NULL,NULL),(345,49,'Fula; Fulah; Pulaar; Pular','ff','ff_SN',NULL,NULL,0,49,NULL,0,0,1,NULL,NULL,NULL),(346,49,'Galician','gl','gl_ES',NULL,NULL,0,50,NULL,0,0,1,NULL,NULL,NULL),(347,49,'Georgian','ka','ka_GE',NULL,NULL,0,51,NULL,0,0,1,NULL,NULL,NULL),(348,49,'German','de','de_DE',NULL,NULL,0,52,NULL,0,0,1,NULL,NULL,NULL),(349,49,'Greek, Modern','el','el_GR',NULL,NULL,0,53,NULL,0,0,1,NULL,NULL,NULL),(350,49,'GuaranÃ­','gn','gn_PY',NULL,NULL,0,54,NULL,0,0,1,NULL,NULL,NULL),(351,49,'Gujarati','gu','gu_IN',NULL,NULL,0,55,NULL,0,0,1,NULL,NULL,NULL),(352,49,'Haitian; Haitian Creole','ht','ht_HT',NULL,NULL,0,56,NULL,0,0,1,NULL,NULL,NULL),(353,49,'Hausa','ha','ha_NG',NULL,NULL,0,57,NULL,0,0,1,NULL,NULL,NULL),(354,49,'Hebrew (modern)','he','he_IL',NULL,NULL,0,58,NULL,0,0,1,NULL,NULL,NULL),(355,49,'Herero','hz','hz_NA',NULL,NULL,0,59,NULL,0,0,1,NULL,NULL,NULL),(356,49,'Hindi','hi','hi_IN',NULL,NULL,0,60,NULL,0,0,1,NULL,NULL,NULL),(357,49,'Hiri Motu','ho','ho_PG',NULL,NULL,0,61,NULL,0,0,1,NULL,NULL,NULL),(358,49,'Hungarian','hu','hu_HU',NULL,NULL,0,62,NULL,0,0,1,NULL,NULL,NULL),(359,49,'Interlingua','ia','ia_XX',NULL,NULL,0,63,NULL,0,0,1,NULL,NULL,NULL),(360,49,'Indonesian','id','id_ID',NULL,NULL,0,64,NULL,0,0,1,NULL,NULL,NULL),(361,49,'Interlingue','ie','ie_XX',NULL,NULL,0,65,NULL,0,0,1,NULL,NULL,NULL),(362,49,'Irish','ga','ga_IE',NULL,NULL,0,66,NULL,0,0,1,NULL,NULL,NULL),(363,49,'Igbo','ig','ig_NG',NULL,NULL,0,67,NULL,0,0,1,NULL,NULL,NULL),(364,49,'Inupiaq','ik','ik_US',NULL,NULL,0,68,NULL,0,0,1,NULL,NULL,NULL),(365,49,'Ido','io','io_XX',NULL,NULL,0,69,NULL,0,0,1,NULL,NULL,NULL),(366,49,'Icelandic','is','is_IS',NULL,NULL,0,70,NULL,0,0,1,NULL,NULL,NULL),(367,49,'Italian','it','it_IT',NULL,NULL,0,71,NULL,0,0,1,NULL,NULL,NULL),(368,49,'Inuktitut','iu','iu_CA',NULL,NULL,0,72,NULL,0,0,1,NULL,NULL,NULL),(369,49,'Japanese','ja','ja_JP',NULL,NULL,0,73,NULL,0,0,1,NULL,NULL,NULL),(370,49,'Javanese','jv','jv_ID',NULL,NULL,0,74,NULL,0,0,1,NULL,NULL,NULL),(371,49,'Kalaallisut, Greenlandic','kl','kl_GL',NULL,NULL,0,75,NULL,0,0,1,NULL,NULL,NULL),(372,49,'Kannada','kn','kn_IN',NULL,NULL,0,76,NULL,0,0,1,NULL,NULL,NULL),(373,49,'Kanuri','kr','kr_NE',NULL,NULL,0,77,NULL,0,0,1,NULL,NULL,NULL),(374,49,'Kashmiri','ks','ks_IN',NULL,NULL,0,78,NULL,0,0,1,NULL,NULL,NULL),(375,49,'Kazakh','kk','kk_KZ',NULL,NULL,0,79,NULL,0,0,1,NULL,NULL,NULL),(376,49,'Khmer','km','km_KH',NULL,NULL,0,80,NULL,0,0,1,NULL,NULL,NULL),(377,49,'Kikuyu, Gikuyu','ki','ki_KE',NULL,NULL,0,81,NULL,0,0,1,NULL,NULL,NULL),(378,49,'Kinyarwanda','rw','rw_RW',NULL,NULL,0,82,NULL,0,0,1,NULL,NULL,NULL),(379,49,'Kirghiz, Kyrgyz','ky','ky_KG',NULL,NULL,0,83,NULL,0,0,1,NULL,NULL,NULL),(380,49,'Komi','kv','kv_RU',NULL,NULL,0,84,NULL,0,0,1,NULL,NULL,NULL),(381,49,'Kongo','kg','kg_CD',NULL,NULL,0,85,NULL,0,0,1,NULL,NULL,NULL),(382,49,'Korean','ko','ko_KR',NULL,NULL,0,86,NULL,0,0,1,NULL,NULL,NULL),(383,49,'Kurdish','ku','ku_IQ',NULL,NULL,0,87,NULL,0,0,1,NULL,NULL,NULL),(384,49,'Kwanyama, Kuanyama','kj','kj_NA',NULL,NULL,0,88,NULL,0,0,1,NULL,NULL,NULL),(385,49,'Latin','la','la_VA',NULL,NULL,0,89,NULL,0,0,1,NULL,NULL,NULL),(386,49,'Luxembourgish, Letzeburgesch','lb','lb_LU',NULL,NULL,0,90,NULL,0,0,1,NULL,NULL,NULL),(387,49,'Luganda','lg','lg_UG',NULL,NULL,0,91,NULL,0,0,1,NULL,NULL,NULL),(388,49,'Limburgish, Limburgan, Limburger','li','li_NL',NULL,NULL,0,92,NULL,0,0,1,NULL,NULL,NULL),(389,49,'Lingala','ln','ln_CD',NULL,NULL,0,93,NULL,0,0,1,NULL,NULL,NULL),(390,49,'Lao','lo','lo_LA',NULL,NULL,0,94,NULL,0,0,1,NULL,NULL,NULL),(391,49,'Lithuanian','lt','lt_LT',NULL,NULL,0,95,NULL,0,0,1,NULL,NULL,NULL),(392,49,'Luba-Katanga','lu','lu_CD',NULL,NULL,0,96,NULL,0,0,1,NULL,NULL,NULL),(393,49,'Latvian','lv','lv_LV',NULL,NULL,0,97,NULL,0,0,1,NULL,NULL,NULL),(394,49,'Manx','gv','gv_IM',NULL,NULL,0,98,NULL,0,0,1,NULL,NULL,NULL),(395,49,'Macedonian','mk','mk_MK',NULL,NULL,0,99,NULL,0,0,1,NULL,NULL,NULL),(396,49,'Malagasy','mg','mg_MG',NULL,NULL,0,100,NULL,0,0,1,NULL,NULL,NULL),(397,49,'Malay','ms','ms_MY',NULL,NULL,0,101,NULL,0,0,1,NULL,NULL,NULL),(398,49,'Malayalam','ml','ml_IN',NULL,NULL,0,102,NULL,0,0,1,NULL,NULL,NULL),(399,49,'Maltese','mt','mt_MT',NULL,NULL,0,103,NULL,0,0,1,NULL,NULL,NULL),(400,49,'MÄori','mi','mi_NZ',NULL,NULL,0,104,NULL,0,0,1,NULL,NULL,NULL),(401,49,'Marathi','mr','mr_IN',NULL,NULL,0,105,NULL,0,0,1,NULL,NULL,NULL),(402,49,'Marshallese','mh','mh_MH',NULL,NULL,0,106,NULL,0,0,1,NULL,NULL,NULL),(403,49,'Mongolian','mn','mn_MN',NULL,NULL,0,107,NULL,0,0,1,NULL,NULL,NULL),(404,49,'Nauru','na','na_NR',NULL,NULL,0,108,NULL,0,0,1,NULL,NULL,NULL),(405,49,'Navajo, Navaho','nv','nv_US',NULL,NULL,0,109,NULL,0,0,1,NULL,NULL,NULL),(406,49,'Norwegian BokmÃ¥l','nb','nb_NO',NULL,NULL,0,110,NULL,0,0,1,NULL,NULL,NULL),(407,49,'North Ndebele','nd','nd_ZW',NULL,NULL,0,111,NULL,0,0,1,NULL,NULL,NULL),(408,49,'Nepali','ne','ne_NP',NULL,NULL,0,112,NULL,0,0,1,NULL,NULL,NULL),(409,49,'Ndonga','ng','ng_NA',NULL,NULL,0,113,NULL,0,0,1,NULL,NULL,NULL),(410,49,'Norwegian Nynorsk','nn','nn_NO',NULL,NULL,0,114,NULL,0,0,1,NULL,NULL,NULL),(411,49,'Norwegian','no','no_NO',NULL,NULL,0,115,NULL,0,0,1,NULL,NULL,NULL),(412,49,'Nuosu','ii','ii_CN',NULL,NULL,0,116,NULL,0,0,1,NULL,NULL,NULL),(413,49,'South Ndebele','nr','nr_ZA',NULL,NULL,0,117,NULL,0,0,1,NULL,NULL,NULL),(414,49,'Occitan (after 1500)','oc','oc_FR',NULL,NULL,0,118,NULL,0,0,1,NULL,NULL,NULL),(415,49,'Ojibwa','oj','oj_CA',NULL,NULL,0,119,NULL,0,0,1,NULL,NULL,NULL),(416,49,'Old Church Slavonic, Church Slavic, Church Slavonic, Old Bulgarian, Old Slavonic','cu','cu_BG',NULL,NULL,0,120,NULL,0,0,1,NULL,NULL,NULL),(417,49,'Oromo','om','om_ET',NULL,NULL,0,121,NULL,0,0,1,NULL,NULL,NULL),(418,49,'Oriya','or','or_IN',NULL,NULL,0,122,NULL,0,0,1,NULL,NULL,NULL),(419,49,'Ossetian, Ossetic','os','os_GE',NULL,NULL,0,123,NULL,0,0,1,NULL,NULL,NULL),(420,49,'Panjabi, Punjabi','pa','pa_IN',NULL,NULL,0,124,NULL,0,0,1,NULL,NULL,NULL),(421,49,'PÄli','pi','pi_KH',NULL,NULL,0,125,NULL,0,0,1,NULL,NULL,NULL),(422,49,'Persian','fa','fa_IR',NULL,NULL,0,126,NULL,0,0,1,NULL,NULL,NULL),(423,49,'Polish','pl','pl_PL',NULL,NULL,0,127,NULL,0,0,1,NULL,NULL,NULL),(424,49,'Pashto, Pushto','ps','ps_AF',NULL,NULL,0,128,NULL,0,0,1,NULL,NULL,NULL),(425,49,'Portuguese (Portugal)','pt','pt_PT',NULL,NULL,0,129,NULL,0,0,1,NULL,NULL,NULL),(426,49,'Quechua','qu','qu_PE',NULL,NULL,0,130,NULL,0,0,1,NULL,NULL,NULL),(427,49,'Romansh','rm','rm_CH',NULL,NULL,0,131,NULL,0,0,1,NULL,NULL,NULL),(428,49,'Kirundi','rn','rn_BI',NULL,NULL,0,132,NULL,0,0,1,NULL,NULL,NULL),(429,49,'Romanian, Moldavian, Moldovan','ro','ro_RO',NULL,NULL,0,133,NULL,0,0,1,NULL,NULL,NULL),(430,49,'Russian','ru','ru_RU',NULL,NULL,0,134,NULL,0,0,1,NULL,NULL,NULL),(431,49,'Sanskrit','sa','sa_IN',NULL,NULL,0,135,NULL,0,0,1,NULL,NULL,NULL),(432,49,'Sardinian','sc','sc_IT',NULL,NULL,0,136,NULL,0,0,1,NULL,NULL,NULL),(433,49,'Sindhi','sd','sd_IN',NULL,NULL,0,137,NULL,0,0,1,NULL,NULL,NULL),(434,49,'Northern Sami','se','se_NO',NULL,NULL,0,138,NULL,0,0,1,NULL,NULL,NULL),(435,49,'Samoan','sm','sm_WS',NULL,NULL,0,139,NULL,0,0,1,NULL,NULL,NULL),(436,49,'Sango','sg','sg_CF',NULL,NULL,0,140,NULL,0,0,1,NULL,NULL,NULL),(437,49,'Serbian','sr','sr_RS',NULL,NULL,0,141,NULL,0,0,1,NULL,NULL,NULL),(438,49,'Scottish Gaelic; Gaelic','gd','gd_GB',NULL,NULL,0,142,NULL,0,0,1,NULL,NULL,NULL),(439,49,'Shona','sn','sn_ZW',NULL,NULL,0,143,NULL,0,0,1,NULL,NULL,NULL),(440,49,'Sinhala, Sinhalese','si','si_LK',NULL,NULL,0,144,NULL,0,0,1,NULL,NULL,NULL),(441,49,'Slovak','sk','sk_SK',NULL,NULL,0,145,NULL,0,0,1,NULL,NULL,NULL),(442,49,'Slovene','sl','sl_SI',NULL,NULL,0,146,NULL,0,0,1,NULL,NULL,NULL),(443,49,'Somali','so','so_SO',NULL,NULL,0,147,NULL,0,0,1,NULL,NULL,NULL),(444,49,'Southern Sotho','st','st_ZA',NULL,NULL,0,148,NULL,0,0,1,NULL,NULL,NULL),(445,49,'Spanish; Castilian (Spain)','es','es_ES',NULL,NULL,0,149,NULL,0,0,1,NULL,NULL,NULL),(446,49,'Sundanese','su','su_ID',NULL,NULL,0,150,NULL,0,0,1,NULL,NULL,NULL),(447,49,'Swahili','sw','sw_TZ',NULL,NULL,0,151,NULL,0,0,1,NULL,NULL,NULL),(448,49,'Swati','ss','ss_ZA',NULL,NULL,0,152,NULL,0,0,1,NULL,NULL,NULL),(449,49,'Swedish','sv','sv_SE',NULL,NULL,0,153,NULL,0,0,1,NULL,NULL,NULL),(450,49,'Tamil','ta','ta_IN',NULL,NULL,0,154,NULL,0,0,1,NULL,NULL,NULL),(451,49,'Telugu','te','te_IN',NULL,NULL,0,155,NULL,0,0,1,NULL,NULL,NULL),(452,49,'Tajik','tg','tg_TJ',NULL,NULL,0,156,NULL,0,0,1,NULL,NULL,NULL),(453,49,'Thai','th','th_TH',NULL,NULL,0,157,NULL,0,0,1,NULL,NULL,NULL),(454,49,'Tigrinya','ti','ti_ET',NULL,NULL,0,158,NULL,0,0,1,NULL,NULL,NULL),(455,49,'Tibetan Standard, Tibetan, Central','bo','bo_CN',NULL,NULL,0,159,NULL,0,0,1,NULL,NULL,NULL),(456,49,'Turkmen','tk','tk_TM',NULL,NULL,0,160,NULL,0,0,1,NULL,NULL,NULL),(457,49,'Tagalog','tl','tl_PH',NULL,NULL,0,161,NULL,0,0,1,NULL,NULL,NULL),(458,49,'Tswana','tn','tn_ZA',NULL,NULL,0,162,NULL,0,0,1,NULL,NULL,NULL),(459,49,'Tonga (Tonga Islands)','to','to_TO',NULL,NULL,0,163,NULL,0,0,1,NULL,NULL,NULL),(460,49,'Turkish','tr','tr_TR',NULL,NULL,0,164,NULL,0,0,1,NULL,NULL,NULL),(461,49,'Tsonga','ts','ts_ZA',NULL,NULL,0,165,NULL,0,0,1,NULL,NULL,NULL),(462,49,'Tatar','tt','tt_RU',NULL,NULL,0,166,NULL,0,0,1,NULL,NULL,NULL),(463,49,'Twi','tw','tw_GH',NULL,NULL,0,167,NULL,0,0,1,NULL,NULL,NULL),(464,49,'Tahitian','ty','ty_PF',NULL,NULL,0,168,NULL,0,0,1,NULL,NULL,NULL),(465,49,'Uighur, Uyghur','ug','ug_CN',NULL,NULL,0,169,NULL,0,0,1,NULL,NULL,NULL),(466,49,'Ukrainian','uk','uk_UA',NULL,NULL,0,170,NULL,0,0,1,NULL,NULL,NULL),(467,49,'Urdu','ur','ur_PK',NULL,NULL,0,171,NULL,0,0,1,NULL,NULL,NULL),(468,49,'Uzbek','uz','uz_UZ',NULL,NULL,0,172,NULL,0,0,1,NULL,NULL,NULL),(469,49,'Venda','ve','ve_ZA',NULL,NULL,0,173,NULL,0,0,1,NULL,NULL,NULL),(470,49,'Vietnamese','vi','vi_VN',NULL,NULL,0,174,NULL,0,0,1,NULL,NULL,NULL),(471,49,'VolapÃ¼k','vo','vo_XX',NULL,NULL,0,175,NULL,0,0,1,NULL,NULL,NULL),(472,49,'Walloon','wa','wa_BE',NULL,NULL,0,176,NULL,0,0,1,NULL,NULL,NULL),(473,49,'Welsh','cy','cy_GB',NULL,NULL,0,177,NULL,0,0,1,NULL,NULL,NULL),(474,49,'Wolof','wo','wo_SN',NULL,NULL,0,178,NULL,0,0,1,NULL,NULL,NULL),(475,49,'Western Frisian','fy','fy_NL',NULL,NULL,0,179,NULL,0,0,1,NULL,NULL,NULL),(476,49,'Xhosa','xh','xh_ZA',NULL,NULL,0,180,NULL,0,0,1,NULL,NULL,NULL),(477,49,'Yiddish','yi','yi_US',NULL,NULL,0,181,NULL,0,0,1,NULL,NULL,NULL),(478,49,'Yoruba','yo','yo_NG',NULL,NULL,0,182,NULL,0,0,1,NULL,NULL,NULL),(479,49,'Zhuang, Chuang','za','za_CN',NULL,NULL,0,183,NULL,0,0,1,NULL,NULL,NULL),(480,49,'Zulu','zu','zu_ZA',NULL,NULL,0,184,NULL,0,0,1,NULL,NULL,NULL),(481,50,'In Person','1','in_person',NULL,0,0,1,NULL,0,1,1,NULL,NULL,NULL),(482,50,'Phone','2','phone',NULL,0,1,2,NULL,0,1,1,NULL,NULL,NULL),(483,50,'Email','3','email',NULL,0,0,3,NULL,0,1,1,NULL,NULL,NULL),(484,50,'Fax','4','fax',NULL,0,0,4,NULL,0,1,1,NULL,NULL,NULL),(485,50,'Letter Mail','5','letter_mail',NULL,0,0,5,NULL,0,1,1,NULL,NULL,NULL),(486,51,'Cases - Send Copy of an Activity','1','case_activity',NULL,NULL,0,1,NULL,0,0,1,NULL,NULL,NULL),(487,52,'Contributions - Duplicate Organization Alert','1','contribution_dupalert',NULL,NULL,0,1,NULL,0,0,1,NULL,NULL,NULL),(488,52,'Contributions - Receipt (off-line)','2','contribution_offline_receipt',NULL,NULL,0,2,NULL,0,0,1,NULL,NULL,NULL),(489,52,'Contributions - Receipt (on-line)','3','contribution_online_receipt',NULL,NULL,0,3,NULL,0,0,1,NULL,NULL,NULL),(490,52,'Contributions - Recurring Start and End Notification','4','contribution_recurring_notify',NULL,NULL,0,4,NULL,0,0,1,NULL,NULL,NULL),(491,52,'Personal Campaign Pages - Admin Notification','5','pcp_notify',NULL,NULL,0,5,NULL,0,0,1,NULL,NULL,NULL),(492,52,'Personal Campaign Pages - Supporter Status Change Notification','6','pcp_status_change',NULL,NULL,0,6,NULL,0,0,1,NULL,NULL,NULL),(493,52,'Personal Campaign Pages - Supporter Welcome','7','pcp_supporter_notify',NULL,NULL,0,7,NULL,0,0,1,NULL,NULL,NULL),(494,53,'Events - Registration Confirmation and Receipt (off-line)','1','event_offline_receipt',NULL,NULL,0,1,NULL,0,0,1,NULL,NULL,NULL),(495,53,'Events - Registration Confirmation and Receipt (on-line)','2','event_online_receipt',NULL,NULL,0,2,NULL,0,0,1,NULL,NULL,NULL),(496,53,'Events - Registration Cancellation Notice','3','participant_cancelled',NULL,NULL,0,3,NULL,0,0,1,NULL,NULL,NULL),(497,53,'Events - Registration Confirmation Invite','4','participant_confirm',NULL,NULL,0,4,NULL,0,0,1,NULL,NULL,NULL),(498,53,'Events - Pending Registration Expiration Notice','5','participant_expired',NULL,NULL,0,5,NULL,0,0,1,NULL,NULL,NULL),(499,54,'Tell-a-Friend Email','1','friend',NULL,NULL,0,1,NULL,0,0,1,NULL,NULL,NULL),(500,55,'Memberships - Signup and Renewal Receipts (off-line)','1','membership_offline_receipt',NULL,NULL,0,1,NULL,0,0,1,NULL,NULL,NULL),(501,55,'Memberships - Receipt (on-line)','2','membership_online_receipt',NULL,NULL,0,2,NULL,0,0,1,NULL,NULL,NULL),(502,56,'Test-drive - Receipt Header','1','test_preview',NULL,NULL,0,1,NULL,0,0,1,NULL,NULL,NULL),(503,57,'Pledges - Acknowledgement','1','pledge_acknowledge',NULL,NULL,0,1,NULL,0,0,1,NULL,NULL,NULL),(504,57,'Pledges - Payment Reminder','2','pledge_reminder',NULL,NULL,0,2,NULL,0,0,1,NULL,NULL,NULL),(505,58,'Profiles - Admin Notification','1','uf_notify',NULL,NULL,0,1,NULL,0,0,1,NULL,NULL,NULL),(507,1,'Email','2',NULL,NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(508,1,'Postal Mail','3',NULL,NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(509,1,'SMS','4',NULL,NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(510,1,'Fax','5',NULL,NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(511,1,'Phone','1',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(512,2,'Accept Invitation','51','Accept Invitation',NULL,0,0,38,NULL,0,0,1,7,NULL,NULL),(513,2,'Assembly Support','47','Assembly Support',NULL,0,0,35,NULL,0,0,1,7,NULL,NULL),(514,2,'Close Case','17','Close Case',NULL,0,0,28,NULL,0,0,1,7,NULL,NULL),(515,2,'Constituent Event Participation','54','Constituent Event Participation',NULL,0,0,14,NULL,0,0,1,NULL,NULL,NULL),(516,2,'Coordination with Event Organizer','53','Coordination with Event Organizer',NULL,0,0,40,'<br />',0,0,1,7,NULL,NULL),(517,2,'Email (incoming)','39','Email Received',NULL,0,0,7,'<p>\r\n	Record receipt of an email from an external source.</p>',0,0,1,NULL,NULL,NULL),(518,2,'Email (outgoing)','38','Email Sent',NULL,0,0,6,'<p>\r\n	Record emails sent from external email software.</p>',0,0,1,NULL,NULL,NULL),(519,2,'Executive Support','48','Executive Support',NULL,0,0,36,NULL,0,0,1,7,NULL,NULL),(520,2,'Fax (incoming)','41','Fax Received',NULL,0,0,9,NULL,0,0,1,NULL,NULL,NULL),(521,2,'Fax (outgoing)','40','Fax Sent',NULL,0,0,8,NULL,0,0,1,NULL,NULL,NULL),(522,2,'In Person','42','In Person',NULL,0,0,10,NULL,0,0,1,NULL,NULL,NULL),(523,2,'Letter (incoming)','37','Letter Received',NULL,0,0,4,NULL,0,0,1,NULL,NULL,NULL),(524,2,'Letter (outgoing)','36','Letter Sent',NULL,0,0,3,NULL,0,0,1,NULL,NULL,NULL),(525,2,'Local Government Contact','45','Local Government Contact',NULL,0,0,33,NULL,0,0,1,7,NULL,NULL),(526,2,'Other','43','Other',NULL,0,0,16,NULL,0,0,1,NULL,NULL,NULL),(527,2,'Phone Call (incoming)','35','Phone Call Received',NULL,0,0,2,NULL,0,0,1,NULL,NULL,NULL),(528,2,'Receive Event Invitation','50','Receive Event Invitation',NULL,0,0,12,NULL,0,0,1,NULL,NULL,NULL),(529,2,'Record SSN','55','Record SSN',NULL,0,0,41,'<br />',0,0,1,7,NULL,NULL),(530,2,'Reject Invitation','52','Reject Invitation',NULL,0,0,39,NULL,0,0,1,7,NULL,NULL),(531,2,'Senate Support','46','Senate Support',NULL,0,0,34,NULL,0,0,1,7,NULL,NULL),(532,2,'State Agency Support','44','State Agency Support',NULL,0,0,32,NULL,0,0,1,7,NULL,NULL),(533,2,'Supervisor Review','49','Supervisor Review',NULL,0,0,37,NULL,0,0,1,7,NULL,NULL),(534,3,'Other','4','Other',NULL,0,0,4,'<br />',0,0,1,NULL,NULL,NULL),(535,4,'ICQ','7','ICQ',NULL,0,0,7,NULL,0,0,1,NULL,0,NULL),(536,4,'IRC','8','IRC',NULL,0,0,8,NULL,0,0,1,NULL,0,NULL),(537,4,'Sametime','9','Sametime',NULL,0,0,9,NULL,0,0,1,NULL,0,NULL),(538,6,'Fr.','6','Fr.',NULL,0,0,6,NULL,0,0,1,NULL,0,NULL),(539,6,'Hon.','7','Hon.',NULL,0,0,7,NULL,0,0,1,NULL,0,NULL),(540,6,'Rev.','5','Rev.',NULL,0,0,5,NULL,0,0,1,NULL,0,NULL),(541,8,'Analytics User','8','Analytics User',NULL,0,0,7,NULL,0,0,1,NULL,0,NULL),(542,8,'Conference Services','11','Conference Services',NULL,0,0,10,NULL,0,0,1,NULL,0,NULL),(543,8,'Data Entry','4','Data Entry',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(544,8,'Office Administrator','7','Office Administrator',NULL,0,0,6,NULL,0,0,1,NULL,0,NULL),(545,8,'Office Manager','6','Office Manager',NULL,0,0,5,NULL,0,0,1,NULL,0,NULL),(546,8,'Print Production','9','Print Production',NULL,0,0,8,NULL,0,0,1,NULL,0,NULL),(547,8,'SOS','10','SOS',NULL,0,0,9,NULL,0,0,1,NULL,0,NULL),(548,8,'Staff','5','Staff',NULL,0,0,4,NULL,0,0,1,NULL,0,NULL),(549,8,'Volunteer','3','Volunteer',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(550,20,'Access Control','1',NULL,NULL,0,NULL,1,NULL,0,1,1,NULL,NULL,NULL),(551,20,'Mailing List','2',NULL,NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(552,20,'Access Control','1',NULL,NULL,0,0,1,NULL,0,1,1,NULL,0,NULL),(553,25,'Draft','7','Draft',NULL,0,0,7,NULL,0,0,1,NULL,NULL,NULL),(554,26,'Event Invitation','8','Event Invitation',NULL,0,0,4,'<p>\r\n	Invitation to attend or participate in a constituent event. Use activities unless the request is for more involved participation.</p>',0,0,1,NULL,0,NULL),(555,26,'General Complaint','4','General Complaint',NULL,0,0,1,'<p>\r\n	General complaint about government, government service, or private organizations.</p>',0,0,1,NULL,0,NULL),(556,26,'Government Service Problem - Local','9','Government Service Problem - Local',NULL,0,0,5,'<p>\r\n	Problem with a local government entity.</p>',0,0,1,NULL,0,NULL),(557,26,'Government Service Problem - State','10','Government Service Problem - State',NULL,0,0,6,'<p>\r\n	Problem with a state government entity.</p>',0,0,1,NULL,0,NULL),(558,26,'Request for Assistance','7','Request for Assistance',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(559,26,'Request for Information','3','Request for Information',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(560,27,'Assigned','5','Assigned',NULL,0,0,5,NULL,0,0,1,NULL,0,NULL),(561,27,'Not Started','4','Not Started',NULL,0,0,4,NULL,0,0,1,NULL,0,NULL),(562,27,'Unassigned','6','Unassigned',NULL,0,0,6,NULL,0,0,1,NULL,0,NULL),(563,29,'jpg','1',NULL,NULL,0,0,1,NULL,0,0,1,NULL,NULL,NULL),(564,29,'jpeg','2',NULL,NULL,0,0,2,NULL,0,0,1,NULL,NULL,NULL),(565,29,'png','3',NULL,NULL,0,0,3,NULL,0,0,1,NULL,NULL,NULL),(566,29,'gif','4',NULL,NULL,0,0,4,NULL,0,0,1,NULL,NULL,NULL),(567,29,'txt','5',NULL,NULL,0,0,5,NULL,0,0,1,NULL,NULL,NULL),(568,29,'pdf','6',NULL,NULL,0,0,6,NULL,0,0,1,NULL,NULL,NULL),(569,29,'doc','7',NULL,NULL,0,0,7,NULL,0,0,1,NULL,NULL,NULL),(570,29,'xls','8',NULL,NULL,0,0,8,NULL,0,0,1,NULL,NULL,NULL),(571,29,'rtf','9',NULL,NULL,0,0,9,NULL,0,0,1,NULL,NULL,NULL),(572,29,'csv','10',NULL,NULL,0,0,10,NULL,0,0,1,NULL,NULL,NULL),(573,29,'ppt','11',NULL,NULL,0,0,11,NULL,0,0,1,NULL,NULL,NULL),(574,29,'docx','12',NULL,NULL,0,0,12,NULL,0,0,1,NULL,NULL,NULL),(575,29,'xlsx','13',NULL,NULL,0,0,13,NULL,0,0,1,NULL,NULL,NULL),(576,29,'jpg','1',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(577,32,'TinyMCE','1',NULL,NULL,0,NULL,1,NULL,0,1,1,NULL,NULL,NULL),(578,32,'CKEditor','2',NULL,NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(579,32,'TinyMCE','1',NULL,NULL,0,0,1,NULL,0,1,1,NULL,0,NULL),(580,34,'Google Voice','6','Google Voice',NULL,0,0,8,NULL,0,0,1,NULL,0,NULL),(581,34,'Secondary Mobile','9','Secondary Mobile',NULL,0,0,4,NULL,0,0,1,NULL,0,NULL),(582,34,'Secondary Phone','8','Secondary Phone',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(583,34,'Skype','7','Skype',NULL,0,0,9,NULL,0,0,1,NULL,0,NULL),(584,39,'Vancouver','city_',NULL,NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(585,39,'/(19|20)(d{2})-(d{1,2})-(d{1,2})/','date_',NULL,NULL,1,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(586,39,'Vancouver','city_',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(587,46,'Image','3','Image',NULL,0,NULL,3,NULL,0,0,1,NULL,NULL,NULL),(592,51,'Facebook','4','Facebook',NULL,0,0,4,NULL,0,0,1,NULL,0,NULL),(593,51,'Home','1','Home',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(594,51,'Image','3','Image',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(595,51,'MySpace','6','MySpace',NULL,0,0,6,NULL,0,0,1,NULL,0,NULL),(596,51,'Twitter','5','Twitter',NULL,0,0,5,NULL,0,0,1,NULL,0,NULL),(597,51,'Work','2','Work',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(598,52,'Activities','civicrm_activity','Activities',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(599,52,'Cases','civicrm_case','Cases',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(600,52,'Contacts','civicrm_contact','Contacts',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(601,53,'Asset','1','Asset',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(602,53,'Email','3','email',NULL,0,0,3,NULL,0,1,1,NULL,0,NULL),(603,53,'Expense','4','Expense',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(604,53,'Fax','4','fax',NULL,0,0,4,NULL,0,1,1,NULL,0,NULL),(605,53,'In Person','1','in_person',NULL,0,0,1,NULL,0,1,1,NULL,0,NULL),(606,53,'Income','3','Income',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(607,53,'Letter Mail','5','letter_mail',NULL,0,0,5,NULL,0,1,1,NULL,0,NULL),(608,53,'Liability','2','Liability',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(609,53,'Phone','2','phone',NULL,0,1,2,NULL,0,1,1,NULL,0,NULL),(610,54,'Cases - Send Copy of an Activity','1','case_activity',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(611,54,'Facebook','4','Facebook',NULL,0,0,4,NULL,0,0,1,NULL,0,NULL),(612,54,'Home','1','Home',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(613,54,'Image','3','Image',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(614,54,'MySpace','6','MySpace',NULL,0,0,6,NULL,0,0,1,NULL,0,NULL),(615,54,'Twitter','5','Twitter',NULL,0,0,5,NULL,0,0,1,NULL,0,NULL),(616,54,'Work','2','Work',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(617,55,'Activities','civicrm_activity','Activities',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(618,55,'Cases','civicrm_case','Cases',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(619,55,'Contacts','civicrm_contact','Contacts',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(620,55,'Contributions - Duplicate Organization Alert','1','contribution_dupalert',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(621,55,'Contributions - Receipt (off-line)','2','contribution_offline_receipt',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(622,55,'Contributions - Receipt (on-line)','3','contribution_online_receipt',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(623,55,'Contributions - Recurring Start and End Notification','4','contribution_recurring_notify',NULL,0,0,4,NULL,0,0,1,NULL,0,NULL),(624,55,'Personal Campaign Pages - Admin Notification','5','pcp_notify',NULL,0,0,5,NULL,0,0,1,NULL,0,NULL),(625,55,'Personal Campaign Pages - Supporter Status Change Notification','6','pcp_status_change',NULL,0,0,6,NULL,0,0,1,NULL,0,NULL),(626,55,'Personal Campaign Pages - Supporter Welcome','7','pcp_supporter_notify',NULL,0,0,7,NULL,0,0,1,NULL,0,NULL),(627,56,'Asset','1','Asset',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(628,56,'Email','3','email',NULL,0,0,3,NULL,0,1,1,NULL,0,NULL),(629,56,'Events - Registration Confirmation and Receipt (off-line)','1','event_offline_receipt',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(630,56,'Events - Registration Confirmation and Receipt (on-line)','2','event_online_receipt',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(631,56,'Expense','4','Expense',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(632,56,'Fax','4','fax',NULL,0,0,4,NULL,0,1,1,NULL,0,NULL),(633,56,'In Person','1','in_person',NULL,0,0,1,NULL,0,1,1,NULL,0,NULL),(634,56,'Income','3','Income',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(635,56,'Letter Mail','5','letter_mail',NULL,0,0,5,NULL,0,1,1,NULL,0,NULL),(636,56,'Liability','2','Liability',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(637,56,'Events - Registration Cancellation Notice','3','participant_cancelled',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(638,56,'Events - Registration Confirmation Invite','4','participant_confirm',NULL,0,0,4,NULL,0,0,1,NULL,0,NULL),(639,56,'Events - Pending Registration Expiration Notice','5','participant_expired',NULL,0,0,5,NULL,0,0,1,NULL,0,NULL),(640,56,'Phone','2','phone',NULL,0,1,2,NULL,0,1,1,NULL,0,NULL),(641,57,'Cases - Send Copy of an Activity','1','case_activity',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(642,57,'Facebook','4','Facebook',NULL,0,0,4,NULL,0,0,1,NULL,0,NULL),(643,57,'Tell-a-Friend Email','1','friend',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(644,57,'Home','1','Home',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(645,57,'Image','3','Image',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(646,57,'MySpace','6','MySpace',NULL,0,0,6,NULL,0,0,1,NULL,0,NULL),(647,57,'Twitter','5','Twitter',NULL,0,0,5,NULL,0,0,1,NULL,0,NULL),(648,57,'Work','2','Work',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(649,58,'Activities','civicrm_activity','Activities',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(650,58,'Cases','civicrm_case','Cases',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(651,58,'Contacts','civicrm_contact','Contacts',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(652,58,'Contributions - Duplicate Organization Alert','1','contribution_dupalert',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(653,58,'Contributions - Receipt (off-line)','2','contribution_offline_receipt',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(654,58,'Contributions - Receipt (on-line)','3','contribution_online_receipt',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(655,58,'Contributions - Recurring Start and End Notification','4','contribution_recurring_notify',NULL,0,0,4,NULL,0,0,1,NULL,0,NULL),(656,58,'Memberships - Signup and Renewal Receipts (off-line)','1','membership_offline_receipt',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(657,58,'Memberships - Receipt (on-line)','2','membership_online_receipt',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(658,58,'Personal Campaign Pages - Admin Notification','5','pcp_notify',NULL,0,0,5,NULL,0,0,1,NULL,0,NULL),(659,58,'Personal Campaign Pages - Supporter Status Change Notification','6','pcp_status_change',NULL,0,0,6,NULL,0,0,1,NULL,0,NULL),(660,58,'Personal Campaign Pages - Supporter Welcome','7','pcp_supporter_notify',NULL,0,0,7,NULL,0,0,1,NULL,0,NULL),(661,59,'Friend','1.00',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(662,59,'Asset','1','Asset',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(663,59,'Email','3','email',NULL,0,0,3,NULL,0,1,1,NULL,0,NULL),(664,59,'Events - Registration Confirmation and Receipt (off-line)','1','event_offline_receipt',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(665,59,'Events - Registration Confirmation and Receipt (on-line)','2','event_online_receipt',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(666,59,'Expense','4','Expense',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(667,59,'Fax','4','fax',NULL,0,0,4,NULL,0,1,1,NULL,0,NULL),(668,59,'In Person','1','in_person',NULL,0,0,1,NULL,0,1,1,NULL,0,NULL),(669,59,'Income','3','Income',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(670,59,'Letter Mail','5','letter_mail',NULL,0,0,5,NULL,0,1,1,NULL,0,NULL),(671,59,'Liability','2','Liability',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(672,59,'Events - Registration Cancellation Notice','3','participant_cancelled',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(673,59,'Events - Registration Confirmation Invite','4','participant_confirm',NULL,0,0,4,NULL,0,0,1,NULL,0,NULL),(674,59,'Events - Pending Registration Expiration Notice','5','participant_expired',NULL,0,0,5,NULL,0,0,1,NULL,0,NULL),(675,59,'Phone','2','phone',NULL,0,1,2,NULL,0,1,1,NULL,0,NULL),(676,59,'Test-drive - Receipt Header','1','test_preview',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(677,60,'Single','50',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(678,60,'Cases - Send Copy of an Activity','1','case_activity',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(679,60,'Facebook','4','Facebook',NULL,0,0,4,NULL,0,0,1,NULL,0,NULL),(680,60,'Tell-a-Friend Email','1','friend',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(681,60,'Home','1','Home',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(682,60,'Image','3','Image',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(683,60,'MySpace','6','MySpace',NULL,0,0,6,NULL,0,0,1,NULL,0,NULL),(684,60,'Pledges - Acknowledgement','1','pledge_acknowledge',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(685,60,'Pledges - Payment Reminder','2','pledge_reminder',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(686,60,'Twitter','5','Twitter',NULL,0,0,5,NULL,0,0,1,NULL,0,NULL),(687,60,'Work','2','Work',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(688,61,'Bass','25',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(689,61,'Activities','civicrm_activity','Activities',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(690,61,'Cases','civicrm_case','Cases',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(691,61,'Contacts','civicrm_contact','Contacts',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(692,61,'Contributions - Duplicate Organization Alert','1','contribution_dupalert',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(693,61,'Contributions - Receipt (off-line)','2','contribution_offline_receipt',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(694,61,'Contributions - Receipt (on-line)','3','contribution_online_receipt',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(695,61,'Contributions - Recurring Start and End Notification','4','contribution_recurring_notify',NULL,0,0,4,NULL,0,0,1,NULL,0,NULL),(696,61,'Memberships - Signup and Renewal Receipts (off-line)','1','membership_offline_receipt',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(697,61,'Memberships - Receipt (on-line)','2','membership_online_receipt',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(698,61,'Personal Campaign Pages - Admin Notification','5','pcp_notify',NULL,0,0,5,NULL,0,0,1,NULL,0,NULL),(699,61,'Personal Campaign Pages - Supporter Status Change Notification','6','pcp_status_change',NULL,0,0,6,NULL,0,0,1,NULL,0,NULL),(700,61,'Personal Campaign Pages - Supporter Welcome','7','pcp_supporter_notify',NULL,0,0,7,NULL,0,0,1,NULL,0,NULL),(701,61,'Profiles - Admin Notification','1','uf_notify',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(703,63,'American Indian or Alaska Native','american_indian_alaska_native',NULL,NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(704,63,'Asian Indian','asian_indian','Asian_Indian',NULL,0,0,4,NULL,0,0,1,NULL,0,NULL),(705,63,'Black, African American','black_african_american','Black_African_American',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(706,63,'Chinese','chinese','Chinese',NULL,0,0,5,NULL,0,0,1,NULL,0,NULL),(707,63,'Cuban','cuban','Cuban',NULL,0,0,17,NULL,0,0,1,NULL,0,NULL),(708,63,'Dominican','dominican','Dominican',NULL,0,0,18,NULL,0,0,1,NULL,0,NULL),(709,63,'Filipino','filipino','Filipino',NULL,0,0,6,NULL,0,0,1,NULL,0,NULL),(710,63,'Guamanian or Chamorro','guamanian_chamorro','Guamanian_or_Chamorro',NULL,0,0,12,NULL,0,0,1,NULL,0,NULL),(711,63,'Japanese','japanese','Japanese',NULL,0,0,7,NULL,0,0,1,NULL,0,NULL),(712,63,'Korean','korean','Korean',NULL,0,0,8,NULL,0,0,1,NULL,0,NULL),(713,63,'Native Hawaiian','native_hawaiian','Native_Hawaiian',NULL,0,0,11,NULL,0,0,1,NULL,0,NULL),(714,63,'Other Asian','other_asian','Other_Asian',NULL,0,0,10,NULL,0,0,1,NULL,0,NULL),(715,63,'Other Hispanic/Latino/Spanish','other_hispanic_latino_spanish','Other_Hispanic_Latino_Spanish',NULL,0,0,19,NULL,0,0,1,NULL,0,NULL),(716,63,'Other Pacific Islander','other_pacific_islander','Other_Pacific_Islander',NULL,0,0,14,NULL,0,0,1,NULL,0,NULL),(717,63,'Puerto Rican','puerto_rican','Puerto_Rican',NULL,0,0,16,NULL,0,0,1,NULL,0,NULL),(718,63,'Samoan','samoan','Samoan',NULL,0,0,13,NULL,0,0,1,NULL,0,NULL),(719,63,'Vietnamese','vietnamese','Vietnamese',NULL,0,0,9,NULL,0,0,1,NULL,0,NULL),(720,63,'White','white','White',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(740,66,'Business','business','Business',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(741,66,'Church','church','Church',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(742,66,'Community Group','community_group','Community_Group',NULL,0,0,4,NULL,0,0,1,NULL,0,NULL),(743,66,'Government','government','Government',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(744,66,'Homeowners Association','homeowners_association','Homeowners_Association',NULL,0,0,7,NULL,0,0,1,NULL,0,NULL),(745,66,'Hospital','hospital','Hospital',NULL,0,0,6,NULL,0,0,1,NULL,0,NULL),(746,66,'Interest Group','interest_group','Interest_Group',NULL,0,0,8,NULL,0,0,1,NULL,0,NULL),(747,66,'Not-for-Profit','not_for_profit','Not_for_Profit',NULL,0,0,9,NULL,0,0,1,NULL,0,NULL),(748,66,'Senior Center','senior_center','Senior_Center',NULL,0,0,5,NULL,0,0,1,NULL,0,NULL),(749,67,'Agency Staff','agency_staff','Agency_Staff',NULL,0,0,6,NULL,0,0,1,NULL,0,NULL),(750,67,'Committee Staff','committee_staff','Committee_Staff',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(751,67,'Communications Staff','communications_staff','Communications_Staff',NULL,0,0,5,NULL,0,0,1,NULL,0,NULL),(752,67,'District Staff','district_staff','District_Staff',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(753,67,'Elected Official','elected_official','Elected_Official',NULL,0,0,8,NULL,0,0,1,NULL,0,NULL),(754,67,'Former Elected Official','former_elected_official','Former_Elected_Official',NULL,0,0,9,NULL,0,0,1,NULL,0,NULL),(755,67,'Non-district Individuals','non_district_individuals','Non_district_Individuals',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(756,67,'Press & Media Contacts','press_media_contacts','Press__Media_Contacts',NULL,0,0,7,NULL,0,0,1,NULL,0,NULL),(757,67,'Support Staff','support_staff','Support_Staff',NULL,0,0,4,NULL,0,0,1,NULL,0,NULL),(766,69,'Legislative Reception Invitation','Legislative Reception Invitation',NULL,NULL,0,0,7,NULL,0,0,1,NULL,0,NULL),(767,69,'Budget Position','Budget Position','Budget_Position',NULL,0,0,2,NULL,0,0,1,NULL,0,NULL),(768,69,'Event Invitation','Event Invitation','Event_Invitation',NULL,0,0,6,NULL,0,0,1,NULL,0,NULL),(769,69,'Legislative Position','Legislative Position','Legislative_Position',NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(770,69,'Petition Signed','Petition Signed','Petition_Signed',NULL,0,0,9,NULL,0,0,1,NULL,0,NULL),(771,69,'Referral','Referral','Referral',NULL,0,0,5,NULL,0,0,1,NULL,0,NULL),(772,69,'Request Agency Support','Request Agency Support','Request_Agency_Support',NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(773,69,'Request Information','Request Information','Request_Information',NULL,0,0,4,NULL,0,0,1,NULL,0,NULL),(774,69,'Request Meeting','Request Meeting','Request_Meeting',NULL,0,0,8,NULL,0,0,1,NULL,0,NULL),(781,20,'Access Control','1',NULL,NULL,0,NULL,1,NULL,0,1,1,NULL,NULL,NULL),(782,20,'Mailing List','2',NULL,NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(783,20,'Access Control','1',NULL,NULL,0,0,1,NULL,0,1,1,NULL,0,NULL),(785,29,'jpg','1',NULL,NULL,0,0,1,NULL,0,0,1,NULL,NULL,NULL),(786,29,'jpeg','2',NULL,NULL,0,0,2,NULL,0,0,1,NULL,NULL,NULL),(787,29,'png','3',NULL,NULL,0,0,3,NULL,0,0,1,NULL,NULL,NULL),(788,29,'gif','4',NULL,NULL,0,0,4,NULL,0,0,1,NULL,NULL,NULL),(789,29,'txt','5',NULL,NULL,0,0,5,NULL,0,0,1,NULL,NULL,NULL),(790,29,'pdf','6',NULL,NULL,0,0,6,NULL,0,0,1,NULL,NULL,NULL),(791,29,'doc','7',NULL,NULL,0,0,7,NULL,0,0,1,NULL,NULL,NULL),(792,29,'xls','8',NULL,NULL,0,0,8,NULL,0,0,1,NULL,NULL,NULL),(793,29,'rtf','9',NULL,NULL,0,0,9,NULL,0,0,1,NULL,NULL,NULL),(794,29,'csv','10',NULL,NULL,0,0,10,NULL,0,0,1,NULL,NULL,NULL),(795,29,'ppt','11',NULL,NULL,0,0,11,NULL,0,0,1,NULL,NULL,NULL),(796,29,'docx','12',NULL,NULL,0,0,12,NULL,0,0,1,NULL,NULL,NULL),(797,29,'xlsx','13',NULL,NULL,0,0,13,NULL,0,0,1,NULL,NULL,NULL),(798,29,'jpg','1',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(799,32,'TinyMCE','1',NULL,NULL,0,NULL,1,NULL,0,1,1,NULL,NULL,NULL),(800,32,'CKEditor','2',NULL,NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(801,32,'TinyMCE','1',NULL,NULL,0,0,1,NULL,0,1,1,NULL,0,NULL),(802,39,'Vancouver','city_',NULL,NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(803,39,'/(19|20)(d{2})-(d{1,2})-(d{1,2})/','date_',NULL,NULL,1,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(804,39,'Vancouver','city_',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(805,59,'Friend','1.00',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(806,60,'Single','50',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(807,61,'Bass','25',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(809,63,'American Indian or Alaska Native','american_indian_alaska_native',NULL,NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(810,69,'Legislative Reception Invitation','Legislative Reception Invitation',NULL,NULL,0,0,7,NULL,0,0,1,NULL,0,NULL),(817,20,'Access Control','1',NULL,NULL,0,NULL,1,NULL,0,1,1,NULL,NULL,NULL),(818,20,'Mailing List','2',NULL,NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(819,20,'Access Control','1',NULL,NULL,0,0,1,NULL,0,1,1,NULL,0,NULL),(821,29,'jpg','1',NULL,NULL,0,0,1,NULL,0,0,1,NULL,NULL,NULL),(822,29,'jpeg','2',NULL,NULL,0,0,2,NULL,0,0,1,NULL,NULL,NULL),(823,29,'png','3',NULL,NULL,0,0,3,NULL,0,0,1,NULL,NULL,NULL),(824,29,'gif','4',NULL,NULL,0,0,4,NULL,0,0,1,NULL,NULL,NULL),(825,29,'txt','5',NULL,NULL,0,0,5,NULL,0,0,1,NULL,NULL,NULL),(826,29,'pdf','6',NULL,NULL,0,0,6,NULL,0,0,1,NULL,NULL,NULL),(827,29,'doc','7',NULL,NULL,0,0,7,NULL,0,0,1,NULL,NULL,NULL),(828,29,'xls','8',NULL,NULL,0,0,8,NULL,0,0,1,NULL,NULL,NULL),(829,29,'rtf','9',NULL,NULL,0,0,9,NULL,0,0,1,NULL,NULL,NULL),(830,29,'csv','10',NULL,NULL,0,0,10,NULL,0,0,1,NULL,NULL,NULL),(831,29,'ppt','11',NULL,NULL,0,0,11,NULL,0,0,1,NULL,NULL,NULL),(832,29,'docx','12',NULL,NULL,0,0,12,NULL,0,0,1,NULL,NULL,NULL),(833,29,'xlsx','13',NULL,NULL,0,0,13,NULL,0,0,1,NULL,NULL,NULL),(834,29,'jpg','1',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(835,32,'TinyMCE','1',NULL,NULL,0,NULL,1,NULL,0,1,1,NULL,NULL,NULL),(836,32,'CKEditor','2',NULL,NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(837,32,'TinyMCE','1',NULL,NULL,0,0,1,NULL,0,1,1,NULL,0,NULL),(838,39,'Vancouver','city_',NULL,NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(839,39,'/(19|20)(d{2})-(d{1,2})-(d{1,2})/','date_',NULL,NULL,1,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(840,39,'Vancouver','city_',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(841,59,'Friend','1.00',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(842,60,'Single','50',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(843,61,'Bass','25',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(845,63,'American Indian or Alaska Native','american_indian_alaska_native',NULL,NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(846,69,'Legislative Reception Invitation','Legislative Reception Invitation',NULL,NULL,0,0,7,NULL,0,0,1,NULL,0,NULL),(853,20,'Access Control','1',NULL,NULL,0,NULL,1,NULL,0,1,1,NULL,NULL,NULL),(854,20,'Mailing List','2',NULL,NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(855,20,'Access Control','1',NULL,NULL,0,0,1,NULL,0,1,1,NULL,0,NULL),(857,29,'jpg','1',NULL,NULL,0,0,1,NULL,0,0,1,NULL,NULL,NULL),(858,29,'jpeg','2',NULL,NULL,0,0,2,NULL,0,0,1,NULL,NULL,NULL),(859,29,'png','3',NULL,NULL,0,0,3,NULL,0,0,1,NULL,NULL,NULL),(860,29,'gif','4',NULL,NULL,0,0,4,NULL,0,0,1,NULL,NULL,NULL),(861,29,'txt','5',NULL,NULL,0,0,5,NULL,0,0,1,NULL,NULL,NULL),(862,29,'pdf','6',NULL,NULL,0,0,6,NULL,0,0,1,NULL,NULL,NULL),(863,29,'doc','7',NULL,NULL,0,0,7,NULL,0,0,1,NULL,NULL,NULL),(864,29,'xls','8',NULL,NULL,0,0,8,NULL,0,0,1,NULL,NULL,NULL),(865,29,'rtf','9',NULL,NULL,0,0,9,NULL,0,0,1,NULL,NULL,NULL),(866,29,'csv','10',NULL,NULL,0,0,10,NULL,0,0,1,NULL,NULL,NULL),(867,29,'ppt','11',NULL,NULL,0,0,11,NULL,0,0,1,NULL,NULL,NULL),(868,29,'docx','12',NULL,NULL,0,0,12,NULL,0,0,1,NULL,NULL,NULL),(869,29,'xlsx','13',NULL,NULL,0,0,13,NULL,0,0,1,NULL,NULL,NULL),(870,29,'jpg','1',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(871,32,'TinyMCE','1',NULL,NULL,0,NULL,1,NULL,0,1,1,NULL,NULL,NULL),(872,32,'CKEditor','2',NULL,NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(873,32,'TinyMCE','1',NULL,NULL,0,0,1,NULL,0,1,1,NULL,0,NULL),(874,39,'Vancouver','city_',NULL,NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(875,39,'/(19|20)(d{2})-(d{1,2})-(d{1,2})/','date_',NULL,NULL,1,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(876,39,'Vancouver','city_',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(877,59,'Friend','1.00',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(878,60,'Single','50',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(879,61,'Bass','25',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(881,63,'American Indian or Alaska Native','american_indian_alaska_native',NULL,NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(882,69,'Legislative Reception Invitation','Legislative Reception Invitation',NULL,NULL,0,0,7,NULL,0,0,1,NULL,0,NULL),(889,20,'Access Control','1',NULL,NULL,0,NULL,1,NULL,0,1,1,NULL,NULL,NULL),(890,20,'Mailing List','2',NULL,NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(891,20,'Access Control','1',NULL,NULL,0,0,1,NULL,0,1,1,NULL,0,NULL),(893,29,'jpg','1',NULL,NULL,0,0,1,NULL,0,0,1,NULL,NULL,NULL),(894,29,'jpeg','2',NULL,NULL,0,0,2,NULL,0,0,1,NULL,NULL,NULL),(895,29,'png','3',NULL,NULL,0,0,3,NULL,0,0,1,NULL,NULL,NULL),(896,29,'gif','4',NULL,NULL,0,0,4,NULL,0,0,1,NULL,NULL,NULL),(897,29,'txt','5',NULL,NULL,0,0,5,NULL,0,0,1,NULL,NULL,NULL),(898,29,'pdf','6',NULL,NULL,0,0,6,NULL,0,0,1,NULL,NULL,NULL),(899,29,'doc','7',NULL,NULL,0,0,7,NULL,0,0,1,NULL,NULL,NULL),(900,29,'xls','8',NULL,NULL,0,0,8,NULL,0,0,1,NULL,NULL,NULL),(901,29,'rtf','9',NULL,NULL,0,0,9,NULL,0,0,1,NULL,NULL,NULL),(902,29,'csv','10',NULL,NULL,0,0,10,NULL,0,0,1,NULL,NULL,NULL),(903,29,'ppt','11',NULL,NULL,0,0,11,NULL,0,0,1,NULL,NULL,NULL),(904,29,'docx','12',NULL,NULL,0,0,12,NULL,0,0,1,NULL,NULL,NULL),(905,29,'xlsx','13',NULL,NULL,0,0,13,NULL,0,0,1,NULL,NULL,NULL),(906,29,'jpg','1',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(907,32,'TinyMCE','1',NULL,NULL,0,NULL,1,NULL,0,1,1,NULL,NULL,NULL),(908,32,'CKEditor','2',NULL,NULL,0,NULL,2,NULL,0,1,1,NULL,NULL,NULL),(909,32,'TinyMCE','1',NULL,NULL,0,0,1,NULL,0,1,1,NULL,0,NULL),(910,39,'Vancouver','city_',NULL,NULL,0,NULL,1,NULL,0,0,1,NULL,NULL,NULL),(911,39,'/(19|20)(d{2})-(d{1,2})-(d{1,2})/','date_',NULL,NULL,1,NULL,2,NULL,0,0,1,NULL,NULL,NULL),(912,39,'Vancouver','city_',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(913,59,'Friend','1.00',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(914,60,'Single','50',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(915,61,'Bass','25',NULL,NULL,0,0,1,NULL,0,0,1,NULL,0,NULL),(917,63,'American Indian or Alaska Native','american_indian_alaska_native',NULL,NULL,0,0,3,NULL,0,0,1,NULL,0,NULL),(918,69,'Legislative Reception Invitation','Legislative Reception Invitation',NULL,NULL,0,0,7,NULL,0,0,1,NULL,0,NULL),(919,64,'BOE','boe','BOE',NULL,NULL,0,1,NULL,0,0,1,NULL,NULL,NULL),(920,64,'DMV','dmv','DMV',NULL,NULL,0,2,NULL,0,0,1,NULL,NULL,NULL),(921,64,'SED','sed','SED',NULL,NULL,0,3,NULL,0,0,1,NULL,NULL,NULL),(922,64,'Other 3rd Party List','other_3rd_party_list','Other_3rd_Party_List',NULL,NULL,0,4,NULL,0,0,1,NULL,NULL,NULL),(923,64,'Questionnaire','questionnaire','Questionnaire',NULL,NULL,0,5,NULL,0,0,1,NULL,NULL,NULL),(924,64,'Email','email','Email',NULL,NULL,0,6,NULL,0,0,1,NULL,NULL,NULL),(925,64,'Albany Office Visit','albany_office_visit','Albany_Office_Visit',NULL,NULL,0,7,NULL,0,0,1,NULL,NULL,NULL),(926,64,'District Office Visit','district_office_visit','District_Office_Visit',NULL,NULL,0,8,NULL,0,0,1,NULL,NULL,NULL),(927,64,'Phone Call','phone_call','Phone_Call',NULL,NULL,0,9,NULL,0,0,1,NULL,NULL,NULL),(928,64,'Lobbyist','lobbyist','Lobbyist',NULL,NULL,0,10,NULL,0,0,1,NULL,NULL,NULL),(929,64,'Petition','petition','Petition',NULL,NULL,0,11,NULL,0,0,1,NULL,NULL,NULL),(930,64,'Website Comment','website_comment','Website_Comment',NULL,NULL,0,12,NULL,0,0,1,NULL,NULL,NULL),(931,64,'Testimony','testimony','Testimony',NULL,NULL,0,13,NULL,0,0,1,NULL,NULL,NULL),(932,64,'Event Attendance','event_attendance','Event_Attendance',NULL,NULL,0,14,NULL,0,0,1,NULL,NULL,NULL),(933,64,'Blast Email','blast_email','Blast_Email',NULL,NULL,0,15,NULL,0,0,1,NULL,NULL,NULL),(934,64,'Other','other','Other',NULL,NULL,0,16,NULL,0,0,1,NULL,NULL,NULL),(935,68,'Legislative Position','legislative_position','Legislative_Position',NULL,NULL,0,1,NULL,0,0,1,NULL,NULL,NULL),(936,68,'Budget Position','budget_position','Budget_Position',NULL,NULL,0,2,NULL,0,0,1,NULL,NULL,NULL),(937,68,'Request Agency Support','request_agency_support','Request_Agency_Support',NULL,NULL,0,3,NULL,0,0,1,NULL,NULL,NULL),(938,68,'Request Information','request_information','Request_Information',NULL,NULL,0,4,NULL,0,0,1,NULL,NULL,NULL),(939,68,'Referral','referral','Referral',NULL,NULL,0,5,NULL,0,0,1,NULL,NULL,NULL),(940,68,'Event Invitation','event_invitation','Event_Invitation',NULL,NULL,0,6,NULL,0,0,1,NULL,NULL,NULL),(941,68,'Legislative Reception Invitation','legislative_reception_invitation',NULL,NULL,NULL,0,7,NULL,0,0,1,NULL,NULL,NULL),(942,68,'Request Meeting','request_meeting','Request_Meeting',NULL,NULL,0,8,NULL,0,0,1,NULL,NULL,NULL),(943,68,'Petition Signed','petition_signed','Petition_Signed',NULL,NULL,0,9,NULL,0,0,1,NULL,NULL,NULL),(944,70,'Registered','registered','Registered',NULL,NULL,0,1,NULL,0,0,1,NULL,NULL,NULL),(945,70,'Former Registered','former_registered','Former_Registered',NULL,NULL,0,2,NULL,0,0,1,NULL,NULL,NULL),(946,70,'Unregistered','unregistered','Unregistered',NULL,NULL,0,3,NULL,0,0,1,NULL,NULL,NULL),(947,71,'Albany Office','albany_office','Albany_Office',NULL,NULL,0,1,NULL,0,0,1,NULL,NULL,NULL),(948,71,'District Office','district_office','District_Office',NULL,NULL,0,2,NULL,0,0,1,NULL,NULL,NULL),(949,71,'Public Hearing','public_hearing','Public_Hearing',NULL,NULL,0,3,NULL,0,0,1,NULL,NULL,NULL),(950,71,'Meeting','meeting','Meeting',NULL,NULL,0,4,NULL,0,0,1,NULL,NULL,NULL),(951,71,'Mobile District Office','mobile_district_office','Mobile_District_Office',NULL,NULL,0,5,NULL,0,0,1,NULL,NULL,NULL),(952,71,'Public Event','public_event','Public_Event',NULL,NULL,0,6,NULL,0,0,1,NULL,NULL,NULL),(953,71,'Town Hall Meeting','town_hall_meeting','Town_Hall_Meeting',NULL,NULL,0,7,NULL,0,0,1,NULL,NULL,NULL),(954,71,'Other','other','Other',NULL,NULL,0,8,NULL,0,0,1,NULL,NULL,NULL),(955,68,'Other','other','Other',NULL,NULL,0,10,NULL,0,0,1,NULL,NULL,NULL),(956,42,'The Family of {contact.household_name}','6','The Family of {contact.household_name}',NULL,2,0,6,'',0,0,1,NULL,NULL,NULL),(957,72,'Name Only','1','CRM_Event_Badge_Simple',NULL,NULL,0,1,'Simple Event Name Badge',0,0,1,NULL,NULL,NULL),(958,72,'Name Tent','2','CRM_Event_Badge_NameTent',NULL,NULL,0,1,'Name Tent',0,0,1,NULL,NULL,NULL),(959,7,'Esq.','9','Esq.',NULL,0,0,8,'<br />',0,0,1,NULL,NULL,NULL),(960,6,'Mr. and Mrs.','8','Mr. and Mrs.',NULL,NULL,0,8,NULL,0,0,1,NULL,NULL,NULL),(961,6,'Dr. and Mrs.','9','Dr. and Mrs.',NULL,NULL,0,9,NULL,0,0,1,NULL,NULL,NULL),(962,6,'The Honorable','10','The Honorable',NULL,NULL,0,10,NULL,0,0,1,NULL,NULL,NULL),(963,6,'The Honorable and Mrs.','11','The Honorable and Mrs.',NULL,NULL,0,11,NULL,0,0,1,NULL,NULL,NULL),(964,6,'Miss','12','Miss',NULL,NULL,0,12,NULL,0,0,1,NULL,NULL,NULL),(965,6,'Reverend','13','Reverend',NULL,NULL,0,13,NULL,0,0,1,NULL,NULL,NULL),(966,6,'Reverend and Mrs.','14','Reverend and Mrs.',NULL,NULL,0,14,NULL,0,0,1,NULL,NULL,NULL),(967,6,'The Honorable','15','The Honorable',NULL,NULL,0,15,NULL,0,0,1,NULL,NULL,NULL),(968,6,'The Honorable and Mrs.','16','The Honorable and Mrs.',NULL,NULL,0,16,NULL,0,0,1,NULL,NULL,NULL),(969,6,'General','17','General',NULL,NULL,0,17,NULL,0,0,1,NULL,NULL,NULL),(970,6,'Colonel','18','Colonel',NULL,NULL,0,18,NULL,0,0,1,NULL,NULL,NULL),(971,6,'Captain','19','Captain',NULL,NULL,0,19,NULL,0,0,1,NULL,NULL,NULL),(972,6,'Sister','20','Sister',NULL,NULL,0,20,NULL,0,0,1,NULL,NULL,NULL),(973,6,'The Reverend','21','The Reverend',NULL,NULL,0,21,NULL,0,0,1,NULL,NULL,NULL),(974,6,'First Lieutenant','22','First Lieutenant',NULL,NULL,0,22,NULL,0,0,1,NULL,NULL,NULL),(975,6,'Rear Admiral','23','Rear Admiral',NULL,NULL,0,23,NULL,0,0,1,NULL,NULL,NULL),(976,6,'Major','24','Major',NULL,NULL,0,24,NULL,0,0,1,NULL,NULL,NULL),(977,6,'Cadet','25','Cadet',NULL,NULL,0,25,NULL,0,0,1,NULL,NULL,NULL),(978,6,'Major General','26','Major General',NULL,NULL,0,26,NULL,0,0,1,NULL,NULL,NULL),(979,6,'Professor','27','Professor',NULL,NULL,0,27,NULL,0,0,1,NULL,NULL,NULL),(980,6,'Congressman','28','Congressman',NULL,NULL,0,28,NULL,0,0,1,NULL,NULL,NULL),(981,6,'Congressman and Mrs.','29','Congressman and Mrs.',NULL,NULL,0,29,NULL,0,0,1,NULL,NULL,NULL),(982,6,'LTC and Mrs.','30','LTC and Mrs.',NULL,NULL,0,30,NULL,0,0,1,NULL,NULL,NULL),(983,6,'Colonel and Mrs.','31','Colonel and Mrs.',NULL,NULL,0,31,NULL,0,0,1,NULL,NULL,NULL),(984,6,'Lieutenant Colonel','32','Lieutenant Colonel',NULL,NULL,0,32,NULL,0,0,1,NULL,NULL,NULL),(985,6,'Cantor','33','Cantor',NULL,NULL,0,33,NULL,0,0,1,NULL,NULL,NULL),(986,6,'Cantor and Mrs.','34','Cantor and Mrs.',NULL,NULL,0,34,NULL,0,0,1,NULL,NULL,NULL),(987,6,'Honorable and Mrs.','35','Honorable and Mrs.',NULL,NULL,0,35,NULL,0,0,1,NULL,NULL,NULL),(988,6,'Chancellor','36','Chancellor',NULL,NULL,0,36,NULL,0,0,1,NULL,NULL,NULL),(989,6,'Chancellor and Mrs.','37','Chancellor and Mrs.',NULL,NULL,0,37,NULL,0,0,1,NULL,NULL,NULL),(990,6,'Messrs.','38','Messrs.',NULL,NULL,0,38,NULL,0,0,1,NULL,NULL,NULL),(991,6,'Lieutenant','39','Lieutenant',NULL,NULL,0,39,NULL,0,0,1,NULL,NULL,NULL),(992,6,'Lieutenant Commander','40','Lieutenant Commander',NULL,NULL,0,40,NULL,0,0,1,NULL,NULL,NULL),(993,6,'Captain and Mrs.','41','Captain and Mrs.',NULL,NULL,0,41,NULL,0,0,1,NULL,NULL,NULL),(994,6,'Chief Warrant Officer','42','Chief Warrant Officer',NULL,NULL,0,42,NULL,0,0,1,NULL,NULL,NULL),(995,6,'Ensign','43','Ensign',NULL,NULL,0,43,NULL,0,0,1,NULL,NULL,NULL),(996,6,'Lieutenant Junior Grade','44','Lieutenant Junior Grade',NULL,NULL,0,44,NULL,0,0,1,NULL,NULL,NULL),(997,6,'Commander','45','Commander',NULL,NULL,0,45,NULL,0,0,1,NULL,NULL,NULL),(998,6,'Warrant Officer','46','Warrant Officer',NULL,NULL,0,46,NULL,0,0,1,NULL,NULL,NULL),(999,6,'Second Lieutenant','47','Second Lieutenant',NULL,NULL,0,47,NULL,0,0,1,NULL,NULL,NULL),(1000,6,'Rabbi','48','Rabbi',NULL,NULL,0,48,NULL,0,0,1,NULL,NULL,NULL),(1001,6,'Rear Admiral and Mrs.','49','Rear Admiral and Mrs.',NULL,NULL,0,49,NULL,0,0,1,NULL,NULL,NULL),(1002,6,'Monsignor','50','Monsignor',NULL,NULL,0,50,NULL,0,0,1,NULL,NULL,NULL),(1003,6,'Vice Admiral','51','Vice Admiral',NULL,NULL,0,51,NULL,0,0,1,NULL,NULL,NULL),(1004,6,'Admiral','52','Admiral',NULL,NULL,0,52,NULL,0,0,1,NULL,NULL,NULL),(1005,6,'Lieutenant General','53','Lieutenant General',NULL,NULL,0,53,NULL,0,0,1,NULL,NULL,NULL),(1006,6,'Brigadier General','54','Brigadier General',NULL,NULL,0,54,NULL,0,0,1,NULL,NULL,NULL),(1007,6,'Brother','55','Brother',NULL,NULL,0,55,NULL,0,0,1,NULL,NULL,NULL),(1008,6,'Rabbi and Mrs.','56','Rabbi and Mrs.',NULL,NULL,0,56,NULL,0,0,1,NULL,NULL,NULL),(1009,6,'Most Reverend','57','Most Reverend',NULL,NULL,0,57,NULL,0,0,1,NULL,NULL,NULL),(1010,6,'Dean','58','Dean',NULL,NULL,0,58,NULL,0,0,1,NULL,NULL,NULL),(1011,6,'The Reverend Dr.','59','The Reverend Dr.',NULL,NULL,0,59,NULL,0,0,1,NULL,NULL,NULL),(1012,6,'Pastor','60','Pastor',NULL,NULL,0,60,NULL,0,0,1,NULL,NULL,NULL),(1013,6,'Pastor and Mrs.','61','Pastor and Mrs.',NULL,NULL,0,61,NULL,0,0,1,NULL,NULL,NULL),(1014,6,'Major and Mrs.','62','Major and Mrs.',NULL,NULL,0,62,NULL,0,0,1,NULL,NULL,NULL),(1015,6,'Bishop','63','Bishop',NULL,NULL,0,63,NULL,0,0,1,NULL,NULL,NULL),(1016,6,'Sergeant','64','Sergeant',NULL,NULL,0,64,NULL,0,0,1,NULL,NULL,NULL),(1017,6,'Mr. and Dr.','65','Mr. and Dr.',NULL,NULL,0,65,NULL,0,0,1,NULL,NULL,NULL),(1018,6,'Reverend Mother','66','Reverend Mother',NULL,NULL,0,66,NULL,0,0,1,NULL,NULL,NULL),(1019,6,'The Honorable and Mr.','67','The Honorable and Mr.',NULL,NULL,0,67,NULL,0,0,1,NULL,NULL,NULL),(1020,6,'The Chief Justice','68','The Chief Justice',NULL,NULL,0,68,NULL,0,0,1,NULL,NULL,NULL),(1021,6,'Mr. Justice','69','Mr. Justice',NULL,NULL,0,69,NULL,0,0,1,NULL,NULL,NULL),(1022,6,'Dr. and Dr.','70','Dr. and Dr.',NULL,NULL,0,70,NULL,0,0,1,NULL,NULL,NULL),(1023,6,'Reverend Monsignor','71','Reverend Monsignor',NULL,NULL,0,71,NULL,0,0,1,NULL,NULL,NULL),(1024,6,'Adjutant','72','Adjutant',NULL,NULL,0,72,NULL,0,0,1,NULL,NULL,NULL),(1025,6,'Administrative Major','73','Administrative Major',NULL,NULL,0,73,NULL,0,0,1,NULL,NULL,NULL),(1026,6,'Ambassador and Mrs.','74','Ambassador and Mrs.',NULL,NULL,0,74,NULL,0,0,1,NULL,NULL,NULL),(1027,6,'Professor and Mrs.','75','Professor and Mrs.',NULL,NULL,0,75,NULL,0,0,1,NULL,NULL,NULL),(1028,24,'CRM_Contact_Form_Search_Custom_BirthdayByMonth','16','CRM_Contact_Form_Search_Custom_BirthdayByMonth',NULL,0,0,16,'Birthday by Month Search',0,0,1,NULL,NULL,NULL),(1029,64,'Letter','letter','Letter',NULL,NULL,0,17,NULL,0,0,1,NULL,NULL,NULL),(1030,64,'Fax','fax','Fax',NULL,NULL,0,18,NULL,0,0,1,NULL,NULL,NULL),(1031,72,'With Logo','3','CRM_Event_Badge_Logo',NULL,NULL,0,1,'You can set your own background image',0,0,1,NULL,NULL,NULL),(1032,16,'Website','12','Website',NULL,1,NULL,12,NULL,0,0,1,NULL,NULL,NULL),(1033,7,'I','10','I',NULL,0,0,3,NULL,0,0,1,NULL,NULL,NULL),(1034,7,'M.D.','11','M.D.',NULL,0,0,9,NULL,0,0,1,NULL,NULL,NULL),(1035,7,'Ph.D.','12','Ph.D.',NULL,0,0,10,NULL,0,0,1,NULL,NULL,NULL),(1036,7,'CAC','13','CAC',NULL,0,0,11,NULL,0,0,1,NULL,NULL,NULL),(1037,7,'D.D.S.','14','D.D.S.',NULL,0,0,12,NULL,0,0,1,NULL,NULL,NULL),(1038,7,'R.N.','15','R.N.',NULL,0,0,13,NULL,0,0,1,NULL,NULL,NULL),(1039,7,'D.C.','16','D.C.',NULL,0,0,14,NULL,0,0,1,NULL,NULL,NULL),(1040,7,'CPA','17','CPA',NULL,0,0,15,NULL,0,0,1,NULL,NULL,NULL),(1041,7,'P.E.','18','P.E.',NULL,0,0,16,NULL,0,0,1,NULL,NULL,NULL),(1042,7,'D.V.M.','19','D.V.M.',NULL,0,0,17,NULL,0,0,1,NULL,NULL,NULL),(1043,41,'Dear {contact.nick_name}','7','Dear {contact.nick_name}',NULL,1,0,6,NULL,0,0,1,NULL,NULL,NULL),(1044,42,'Dear {contact.nick_name}','7','Dear {contact.nick_name}',NULL,1,0,7,NULL,0,0,1,NULL,NULL,NULL),(1045,43,'The {contact.household_name}','5','The {contact.household_name}',NULL,2,1,5,NULL,0,0,1,NULL,NULL,NULL),(1046,73,'Board of Election','1','Board_of_Election',NULL,NULL,0,1,NULL,0,0,1,NULL,NULL,NULL),(1047,73,'Added Registered Voter','2','Added_Registered_Voter',NULL,NULL,0,2,NULL,0,0,1,NULL,NULL,NULL),(1048,73,'Added Non-Registered Voter','3','Added_Non_Registered_Voter',NULL,NULL,0,3,NULL,0,0,1,NULL,NULL,NULL),(1049,73,'Out-of-District','4','Out_of_District',NULL,NULL,0,4,NULL,0,0,1,NULL,NULL,NULL),(1050,73,'Incomplete','5','Incomplete',NULL,NULL,0,5,NULL,0,0,1,NULL,NULL,NULL),(1051,73,'Business (Home)','6','Business__Home_',NULL,NULL,0,6,NULL,0,0,1,NULL,NULL,NULL),(1052,73,'Business','7','Business',NULL,NULL,0,7,NULL,0,0,1,NULL,NULL,NULL),(1053,73,'Soft Delete','0','Soft_Delete',NULL,NULL,0,8,NULL,0,0,1,NULL,NULL,NULL),(1054,42,'Dear Friends','8','Dear Friends',NULL,2,0,8,NULL,0,0,1,NULL,NULL,NULL),(1055,42,'Dear {contact.nick_name}','9','Dear {contact.nick_name}',NULL,2,0,9,NULL,0,0,1,NULL,NULL,NULL),(1056,42,'Dear Friend','10','Dear Friend',NULL,1,0,10,NULL,0,0,1,NULL,NULL,NULL),(1057,41,'The Family of {contact.household_name}','6','The Family of {contact.household_name}',NULL,2,0,7,NULL,0,0,1,NULL,NULL,NULL),(1058,41,'Dear Friends','8','Dear Friends',NULL,2,0,8,NULL,0,0,1,NULL,NULL,NULL),(1059,41,'Dear Friend','10','Dear Friend',NULL,1,0,9,NULL,0,0,1,NULL,NULL,NULL),(1060,40,'Bookkeeping Transactions Report','contribute/bookkeeping','CRM_Report_Form_Contribute_Bookkeeping',NULL,0,0,29,'Shows Bookkeeping Transactions Report',0,0,1,2,NULL,NULL),(1061,40,'Grant Report (Detail)','grant/detail','CRM_Report_Form_Grant_Detail',NULL,0,0,30,'Grant Report Detail',0,0,1,5,NULL,NULL),(1062,40,'Participant list Count Report','event/participantlist','CRM_Report_Form_Event_ParticipantListCount',NULL,0,0,31,'Shows the Participant list with Participant Count.',0,0,1,1,NULL,NULL),(1063,40,'Income Count Summary Report','event/incomesummary','CRM_Report_Form_Event_IncomeCountSummary',NULL,0,0,32,'Shows the Income Summary of events with Count.',0,0,1,1,NULL,NULL),(1064,64,'Satellite Office','Satellite Office','Satellite_Office',NULL,NULL,0,19,NULL,0,0,1,NULL,NULL,NULL),(1065,71,'Satellite Office','Satellite Office','Satellite_Office',NULL,NULL,0,8,NULL,0,0,1,NULL,NULL,NULL),(1066,46,'Main','6','Main',NULL,0,NULL,6,NULL,0,0,1,NULL,NULL,NULL),(1067,74,'None','0','',NULL,0,1,1,NULL,0,1,1,NULL,NULL,NULL),(1068,74,'Author Only','1','',NULL,0,0,2,NULL,0,1,1,NULL,NULL,NULL),(1069,75,'Direct Mail','1','Direct Mail',NULL,NULL,0,1,NULL,0,0,1,NULL,NULL,NULL),(1070,75,'Referral Program','2','Referral Program',NULL,NULL,0,2,NULL,0,0,1,NULL,NULL,NULL),(1071,75,'Constituent Engagement','3','Constituent Engagement',NULL,NULL,0,3,NULL,0,0,1,NULL,NULL,NULL),(1072,76,'Planned','1','Planned',NULL,NULL,0,1,NULL,0,0,1,NULL,NULL,NULL),(1073,76,'In Progress','2','In Progress',NULL,NULL,0,2,NULL,0,0,1,NULL,NULL,NULL),(1074,76,'Completed','3','Completed',NULL,NULL,0,3,NULL,0,0,1,NULL,NULL,NULL),(1075,76,'Cancelled','4','Cancelled',NULL,NULL,0,4,NULL,0,0,1,NULL,NULL,NULL),(1076,2,'Survey','57','Survey',NULL,NULL,0,43,NULL,0,0,1,9,NULL,NULL),(1077,2,'Canvass','58','Canvass',NULL,NULL,0,44,NULL,0,0,1,9,NULL,NULL),(1078,2,'PhoneBank','59','PhoneBank',NULL,NULL,0,45,NULL,0,0,1,9,NULL,NULL),(1079,2,'WalkList','60','WalkList',NULL,NULL,0,46,NULL,0,0,1,9,NULL,NULL),(1080,2,'Petition','61','Petition',NULL,NULL,0,47,NULL,0,0,1,9,NULL,NULL),(1081,78,'Temporary Files','upload/','uploadDir',NULL,NULL,0,1,NULL,0,0,1,NULL,1,NULL),(1082,78,'Images','images/','imageUploadDir',NULL,NULL,0,2,NULL,0,0,1,NULL,1,NULL),(1083,78,'Custom Files','custom/','customFileUploadDir',NULL,NULL,0,3,NULL,0,0,1,NULL,1,NULL),(1084,78,'Custom Templates','/opt/bluebird_prod/civicrm/custom/templates','customTemplateDir',NULL,NULL,0,4,NULL,0,0,1,NULL,1,NULL),(1085,78,'Custom PHP','/opt/bluebird_prod/civicrm/custom/php','customPHPPathDir',NULL,NULL,0,5,NULL,0,0,1,NULL,1,NULL),(1086,78,'Custom Extensions','','extensionsDir',NULL,NULL,0,6,NULL,0,0,1,NULL,1,NULL),(1087,79,'CiviCRM Resource URL','sites/all/modules/civicrm/','userFrameworkResourceURL',NULL,NULL,0,1,NULL,0,0,1,NULL,1,NULL),(1088,79,'Image Upload URL','sites/default/files/civicrm/images/','imageUploadURL',NULL,NULL,0,2,NULL,0,0,1,NULL,1,NULL),(1089,79,'Custom CiviCRM CSS URL','','customCSSURL',NULL,NULL,0,3,NULL,0,0,1,NULL,1,NULL),(1090,40,'Case Detail Report','case/detail','CRM_Report_Form_Case_Detail',NULL,0,0,33,'Case Details',0,0,1,7,NULL,NULL),(1091,32,'Joomla Default Editor','3',NULL,NULL,0,NULL,3,NULL,0,1,1,NULL,1,NULL),(1092,40,'Mail Bounce Report','Mailing/bounce','CRM_Report_Form_Mailing_Bounce',NULL,0,NULL,34,'Bounce Report for mailings',0,0,1,4,NULL,NULL),(1093,40,'Mail Summary Report','Mailing/summary','CRM_Report_Form_Mailing_Summary',NULL,0,NULL,35,'Summary statistics for mailings',0,0,1,4,NULL,NULL),(1094,40,'Mail Opened Report','Mailing/opened','CRM_Report_Form_Mailing_Opened',NULL,0,NULL,36,'Display contacts who opened emails from a mailing',0,0,1,4,NULL,NULL),(1095,40,'Mail Clickthrough Report','Mailing/clicks','CRM_Report_Form_Mailing_Clicks',NULL,0,NULL,37,'Display clicks from each mailing',0,0,1,4,NULL,NULL),(1096,49,'Chinese (Taiwan)','zh','zh_TW',NULL,NULL,0,185,NULL,0,0,1,NULL,NULL,NULL),(1097,49,'English (Australia)','en','en_AU',NULL,NULL,0,186,NULL,0,0,1,NULL,NULL,NULL),(1098,49,'English (Canada)','en','en_CA',NULL,NULL,0,187,NULL,0,0,1,NULL,NULL,NULL),(1099,49,'English (United Kingdom)','en','en_GB',NULL,NULL,0,188,NULL,0,0,1,NULL,NULL,NULL),(1100,49,'French (Canada)','fr','fr_CA',NULL,NULL,0,189,NULL,0,0,1,NULL,NULL,NULL),(1101,49,'Portuguese (Brazil)','pt','pt_BR',NULL,NULL,0,190,NULL,0,0,1,NULL,NULL,NULL),(1102,49,'Spanish; Castilian (Mexico)','es','es_MX',NULL,NULL,0,191,NULL,0,0,1,NULL,NULL,NULL),(1103,40,'Contact Logging Report (Summary)','logging/contact/summary','CRM_Report_Form_Contact_LoggingSummary',NULL,NULL,0,192,'Contact modification report for the logging infrastructure (summary).',0,0,0,NULL,NULL,NULL),(1104,40,'Contact Logging Report (Detail)','logging/contact/detail','CRM_Report_Form_Contact_LoggingDetail',NULL,NULL,0,193,'Contact modification report for the logging infrastructure (detail).',0,0,0,NULL,NULL,NULL),(1105,80,'Approved','1','Approved',NULL,NULL,1,1,NULL,0,0,1,4,NULL,NULL),(1106,80,'Rejected','2','Rejected',NULL,NULL,0,2,NULL,0,0,1,4,NULL,NULL),(1107,80,'None','3','None',NULL,NULL,0,3,NULL,0,0,1,4,NULL,NULL),(1108,40,'Grant Report (Statistics)','grant/statistics','CRM_Report_Form_Grant_Statistics',NULL,0,0,194,'Shows statistics for Grants',0,0,1,5,NULL,NULL),(1109,49,'Cantonese','zh','zh_CT',NULL,NULL,0,192,NULL,0,0,1,NULL,NULL,NULL),(1110,67,'Community Leader','community_leader','Community_Leader',NULL,NULL,0,10,NULL,0,0,1,NULL,NULL,NULL),(1111,67,'Intern/Volunteer','intern_volunteer','Intern_Volunteer',NULL,NULL,0,11,NULL,0,0,1,NULL,NULL,NULL),(1112,64,'Business Card','business_card','Business_Card',NULL,NULL,0,20,NULL,0,0,1,NULL,NULL,NULL),(1113,66,'School','school','School',NULL,NULL,0,10,NULL,0,0,1,NULL,NULL,NULL),(1114,6,'Sheriff','76','Sheriff',NULL,0,0,76,NULL,0,0,1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `civicrm_option_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_participant`
--

DROP TABLE IF EXISTS `civicrm_participant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_participant` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Participant Id',
  `contact_id` int(10) unsigned DEFAULT '0' COMMENT 'FK to Contact ID',
  `event_id` int(10) unsigned DEFAULT '0' COMMENT 'FK to Event ID',
  `status_id` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'Participant status ID. FK to civicrm_participant_status_type. Default of 1 should map to status = Registered.',
  `role_id` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Participant role ID. Implicit FK to civicrm_option_value where option_group = participant_role.',
  `register_date` datetime DEFAULT NULL COMMENT 'When did contact register for event?',
  `source` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Source of this event registration.',
  `fee_level` text COLLATE utf8_unicode_ci COMMENT 'Populate with the label (text) associated with a fee level for paid events with multiple levels. Note that we store the label value and not the key',
  `is_test` tinyint(4) DEFAULT '0',
  `is_pay_later` tinyint(4) DEFAULT '0',
  `fee_amount` decimal(20,2) DEFAULT NULL COMMENT 'actual processor fee if known - may be 0.',
  `registered_by_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Participant ID',
  `discount_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Discount ID',
  `fee_currency` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '3 character string, value derived from config setting.',
  PRIMARY KEY (`id`),
  KEY `index_status_id` (`status_id`),
  KEY `index_role_id` (`role_id`),
  KEY `FK_civicrm_participant_contact_id` (`contact_id`),
  KEY `FK_civicrm_participant_event_id` (`event_id`),
  KEY `FK_civicrm_participant_registered_by_id` (`registered_by_id`),
  KEY `FK_civicrm_participant_discount_id` (`discount_id`),
  CONSTRAINT `FK_civicrm_participant_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_participant_discount_id` FOREIGN KEY (`discount_id`) REFERENCES `civicrm_discount` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_participant_event_id` FOREIGN KEY (`event_id`) REFERENCES `civicrm_event` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_participant_registered_by_id` FOREIGN KEY (`registered_by_id`) REFERENCES `civicrm_participant` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_participant_status_id` FOREIGN KEY (`status_id`) REFERENCES `civicrm_participant_status_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_participant`
--

LOCK TABLES `civicrm_participant` WRITE;
/*!40000 ALTER TABLE `civicrm_participant` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_participant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_participant_payment`
--

DROP TABLE IF EXISTS `civicrm_participant_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_participant_payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Participant Payment Id',
  `participant_id` int(10) unsigned NOT NULL COMMENT 'Participant Id (FK)',
  `contribution_id` int(10) unsigned NOT NULL COMMENT 'FK to contribution table.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_contribution_participant` (`contribution_id`,`participant_id`),
  KEY `FK_civicrm_participant_payment_participant_id` (`participant_id`),
  CONSTRAINT `FK_civicrm_participant_payment_contribution_id` FOREIGN KEY (`contribution_id`) REFERENCES `civicrm_contribution` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_participant_payment_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `civicrm_participant` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_participant_payment`
--

LOCK TABLES `civicrm_participant_payment` WRITE;
/*!40000 ALTER TABLE `civicrm_participant_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_participant_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_participant_status_type`
--

DROP TABLE IF EXISTS `civicrm_participant_status_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_participant_status_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique participant status type id',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'non-localized name of the status type',
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'localized label for display of this status type',
  `class` enum('Positive','Pending','Waiting','Negative') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'the general group of status type this one belongs to',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'whether this is a status type required by the system',
  `is_active` tinyint(4) DEFAULT '1' COMMENT 'whether this status type is active',
  `is_counted` tinyint(4) DEFAULT NULL COMMENT 'whether this status type is counted against event size limit',
  `weight` int(10) unsigned NOT NULL COMMENT 'controls sort order',
  `visibility_id` int(10) unsigned DEFAULT NULL COMMENT 'whether the status type is visible to the public, an implicit foreign key to option_value.value related to the `visibility` option_group',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_participant_status_type`
--

LOCK TABLES `civicrm_participant_status_type` WRITE;
/*!40000 ALTER TABLE `civicrm_participant_status_type` DISABLE KEYS */;
INSERT INTO `civicrm_participant_status_type` VALUES (1,'Registered','Registered','Positive',1,1,1,1,1),(2,'Attended','Attended','Positive',0,1,1,2,2),(3,'No-show','No-show','Negative',0,1,0,3,2),(4,'Cancelled','Cancelled','Negative',1,1,0,4,2),(5,'Pending from pay later','Pending from pay later','Pending',1,1,1,5,2),(6,'Pending from incomplete transaction','Pending from incomplete transaction','Pending',1,1,0,6,2),(7,'On waitlist','On waitlist','Waiting',1,0,0,7,2),(8,'Awaiting approval','Awaiting approval','Waiting',1,0,1,8,2),(9,'Pending from waitlist','Pending from waitlist','Pending',1,0,1,9,2),(10,'Pending from approval','Pending from approval','Pending',1,0,1,10,2),(11,'Rejected','Rejected','Negative',1,0,0,11,2),(12,'Expired','Expired','Negative',1,1,0,12,2);
/*!40000 ALTER TABLE `civicrm_participant_status_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_payment_processor`
--

DROP TABLE IF EXISTS `civicrm_payment_processor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_payment_processor` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Payment Processor ID',
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this match entry for',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Payment Processor Name.',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Payment Processor Description.',
  `payment_processor_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Payment Processor Type.',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this processor active?',
  `is_default` tinyint(4) DEFAULT NULL COMMENT 'Is this processor the default?',
  `is_test` tinyint(4) DEFAULT NULL COMMENT 'Is this processor for a test site?',
  `user_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `signature` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_site` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_api` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_recur` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_button` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `class_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_mode` int(10) unsigned NOT NULL COMMENT 'Billing Mode',
  `is_recur` tinyint(4) DEFAULT NULL COMMENT 'Can process recurring contributions',
  `payment_type` int(10) unsigned DEFAULT '1' COMMENT 'Payment Type: Credit or Debit',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name_test_domain_id` (`name`,`is_test`,`domain_id`),
  KEY `FK_civicrm_payment_processor_domain_id` (`domain_id`),
  CONSTRAINT `FK_civicrm_payment_processor_domain_id` FOREIGN KEY (`domain_id`) REFERENCES `civicrm_domain` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_payment_processor`
--

LOCK TABLES `civicrm_payment_processor` WRITE;
/*!40000 ALTER TABLE `civicrm_payment_processor` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_payment_processor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_payment_processor_type`
--

DROP TABLE IF EXISTS `civicrm_payment_processor_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_payment_processor_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Payment Processor Type ID',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Payment Processor Name.',
  `title` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Payment Processor Name.',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Payment Processor Description.',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this processor active?',
  `is_default` tinyint(4) DEFAULT NULL COMMENT 'Is this processor the default?',
  `user_name_label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `signature_label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject_label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `class_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_site_default` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_api_default` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_recur_default` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_button_default` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_site_test_default` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_api_test_default` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_recur_test_default` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_button_test_default` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_mode` int(10) unsigned NOT NULL COMMENT 'Billing Mode',
  `is_recur` tinyint(4) DEFAULT NULL COMMENT 'Can process recurring contributions',
  `payment_type` int(10) unsigned DEFAULT '1' COMMENT 'Payment Type: Credit or Debit',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_payment_processor_type`
--

LOCK TABLES `civicrm_payment_processor_type` WRITE;
/*!40000 ALTER TABLE `civicrm_payment_processor_type` DISABLE KEYS */;
INSERT INTO `civicrm_payment_processor_type` VALUES (1,'PayPal_Standard','PayPal - Website Payments Standard',NULL,1,0,'Merchant Account Email',NULL,NULL,NULL,'Payment_PayPalImpl','https://www.paypal.com/',NULL,'https://www.paypal.com/',NULL,'https://www.sandbox.paypal.com/',NULL,'https://www.sandbox.paypal.com/',NULL,4,1,1),(2,'PayPal','PayPal - Website Payments Pro',NULL,1,0,'User Name','Password','Signature',NULL,'Payment_PayPalImpl','https://www.paypal.com/','https://api-3t.paypal.com/','https://www.paypal.com/','https://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif','https://www.sandbox.paypal.com/','https://api-3t.sandbox.paypal.com/','https://www.sandbox.paypal.com/','https://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif',3,1,1),(3,'PayPal_Express','PayPal - Express',NULL,1,0,'User Name','Password','Signature',NULL,'Payment_PayPalImpl','https://www.paypal.com/','https://api-3t.paypal.com/',NULL,'https://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif','https://www.sandbox.paypal.com/','https://api-3t.sandbox.paypal.com/',NULL,'https://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif',2,NULL,1),(4,'Google_Checkout','Google Checkout',NULL,1,0,'Merchant ID','Key',NULL,NULL,'Payment_Google','https://checkout.google.com/',NULL,NULL,'https://checkout.google.com/buttons/checkout.gif?merchant_id=YOURMERCHANTIDHERE&w=160&h=43&style=white&variant=text&loc=en_US','https://sandbox.google.com/checkout/',NULL,NULL,'https://sandbox.google.com/checkout/buttons/checkout.gif?merchant_id=YOURMERCHANTIDHERE&w=160&h=43&style=white&variant=text&loc=en_US',4,NULL,1),(5,'Moneris','Moneris',NULL,1,0,'User Name','Password','Store ID',NULL,'Payment_Moneris','https://www3.moneris.com/',NULL,NULL,NULL,'https://esqa.moneris.com/',NULL,NULL,NULL,1,1,1),(6,'AuthNet','Authorize.Net',NULL,1,0,'API Login','Payment Key','MD5 Hash',NULL,'Payment_AuthorizeNet','https://secure.authorize.net/gateway/transact.dll',NULL,'https://api.authorize.net/xml/v1/request.api',NULL,'https://test.authorize.net/gateway/transact.dll',NULL,'https://apitest.authorize.net/xml/v1/request.api',NULL,1,1,1),(7,'PayJunction','PayJunction',NULL,1,0,'User Name','Password',NULL,NULL,'Payment_PayJunction','https://payjunction.com/quick_link',NULL,NULL,NULL,'https://www.payjunctionlabs.com/quick_link',NULL,NULL,NULL,1,1,1),(8,'eWAY','eWAY (Single Currency)',NULL,1,0,'Customer ID',NULL,NULL,NULL,'Payment_eWAY','https://www.eway.com.au/gateway_cvn/xmlpayment.asp',NULL,NULL,NULL,'https://www.eway.com.au/gateway_cvn/xmltest/testpage.asp',NULL,NULL,NULL,1,0,1),(9,'Payment_Express','DPS Payment Express',NULL,1,0,'User ID','Key','Mac Key - pxaccess only',NULL,'Payment_PaymentExpress','https://www.paymentexpress.com/pleaseenteraurl',NULL,NULL,NULL,'https://www.paymentexpress.com/pleaseenteratesturl',NULL,NULL,NULL,4,0,1),(10,'ClickAndPledge','Click and Pledge',NULL,1,0,'Customer ID',NULL,NULL,NULL,'Payment_ClickAndPledge','http://www.clickandpledge.com/',NULL,NULL,NULL,'http://www.clickandpledge.com/',NULL,NULL,NULL,4,0,1),(11,'Dummy','Dummy Payment Processor',NULL,1,1,'User Name',NULL,NULL,NULL,'Payment_Dummy',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,1),(12,'Elavon','Elavon Payment Processor','Elavon / Nova Virtual Merchant',1,0,'SSL Merchant ID ','SSL User ID','SSL PIN',NULL,'Payment_Elavon','https://www.myvirtualmerchant.com/VirtualMerchant/processxml.do',NULL,NULL,NULL,'https://www.myvirtualmerchant.com/VirtualMerchant/processxml.do',NULL,NULL,NULL,1,0,1),(13,'Realex','Realex Payment',NULL,1,0,'Merchant ID','Password',NULL,'Account','Payment_Realex','https://epage.payandshop.com/epage.cgi',NULL,NULL,NULL,'https://epage.payandshop.com/epage-remote.cgi',NULL,NULL,NULL,1,0,1),(14,'PayflowPro','PayflowPro',NULL,1,0,'Vendor ID','Password','Partner (merchant)','User','Payment_PayflowPro','https://Payflowpro.paypal.com',NULL,NULL,NULL,'https://pilot-Payflowpro.paypal.com',NULL,NULL,NULL,1,0,1),(15,'FirstData','FirstData (aka linkpoint)','FirstData (aka linkpoint)',1,0,'Store name','certificate path',NULL,NULL,'Payment_FirstData','https://secure.linkpt.net',NULL,NULL,NULL,'https://staging.linkpt.net',NULL,NULL,NULL,1,NULL,1);
/*!40000 ALTER TABLE `civicrm_payment_processor_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_pcp`
--

DROP TABLE IF EXISTS `civicrm_pcp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_pcp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Personal Campaign Page ID',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to Contact ID',
  `status_id` int(10) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `intro_text` text COLLATE utf8_unicode_ci,
  `page_text` text COLLATE utf8_unicode_ci,
  `donate_link_text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contribution_page_id` int(10) unsigned NOT NULL COMMENT 'The Contribution Page which triggered this pcp',
  `is_thermometer` int(10) unsigned DEFAULT '0',
  `is_honor_roll` int(10) unsigned DEFAULT '0',
  `goal_amount` decimal(20,2) DEFAULT NULL COMMENT 'Goal amount of this Personal Campaign Page.',
  `currency` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `referer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT '0' COMMENT 'Is Personal Campaign Page enabled/active?',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_pcp_contact_id` (`contact_id`),
  KEY `FK_civicrm_pcp_contribution_page_id` (`contribution_page_id`),
  CONSTRAINT `FK_civicrm_pcp_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_pcp_contribution_page_id` FOREIGN KEY (`contribution_page_id`) REFERENCES `civicrm_contribution_page` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_pcp`
--

LOCK TABLES `civicrm_pcp` WRITE;
/*!40000 ALTER TABLE `civicrm_pcp` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_pcp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_pcp_block`
--

DROP TABLE IF EXISTS `civicrm_pcp_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_pcp_block` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'PCP block Id',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_contribution_page.id',
  `supporter_profile_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_uf_group.id. Does Personal Campaign Page require manual activation by administrator? (is inactive by default after setup)?',
  `is_approval_needed` tinyint(4) DEFAULT NULL COMMENT 'Does Personal Campaign Page require manual activation by administrator? (is inactive by default after setup)?',
  `is_tellfriend_enabled` tinyint(4) DEFAULT NULL COMMENT 'Does Personal Campaign Page allow using tell a friend?',
  `tellfriend_limit` int(10) unsigned DEFAULT NULL COMMENT 'Maximum recipient fields allowed in tell a friend',
  `link_text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Link text for PCP.',
  `is_active` tinyint(4) DEFAULT '1' COMMENT 'Is Personal Campaign Page Block enabled/active?',
  `notify_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'If set, notification is automatically emailed to this email-address on create/update Personal Campaign Page',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_pcp_block_entity_id` (`entity_id`),
  KEY `FK_civicrm_pcp_block_supporter_profile_id` (`supporter_profile_id`),
  CONSTRAINT `FK_civicrm_pcp_block_entity_id` FOREIGN KEY (`entity_id`) REFERENCES `civicrm_contribution_page` (`id`),
  CONSTRAINT `FK_civicrm_pcp_block_supporter_profile_id` FOREIGN KEY (`supporter_profile_id`) REFERENCES `civicrm_uf_group` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_pcp_block`
--

LOCK TABLES `civicrm_pcp_block` WRITE;
/*!40000 ALTER TABLE `civicrm_pcp_block` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_pcp_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_persistent`
--

DROP TABLE IF EXISTS `civicrm_persistent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_persistent` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Persistent Record Id',
  `context` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Context for which name data pair is to be stored',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of Context',
  `data` longtext COLLATE utf8_unicode_ci COMMENT 'data associated with name',
  `is_config` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Config Settings',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_persistent`
--

LOCK TABLES `civicrm_persistent` WRITE;
/*!40000 ALTER TABLE `civicrm_persistent` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_persistent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_phone`
--

DROP TABLE IF EXISTS `civicrm_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_phone` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Phone ID',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `location_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Location does this phone belong to.',
  `is_primary` tinyint(4) DEFAULT '0' COMMENT 'Is this the primary phone for this contact and location.',
  `is_billing` tinyint(4) DEFAULT '0' COMMENT 'Is this the billing?',
  `mobile_provider_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Mobile Provider does this phone belong to.',
  `phone` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Complete phone number.',
  `phone_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which type of phone does this number belongs.',
  PRIMARY KEY (`id`),
  KEY `index_location_type` (`location_type_id`),
  KEY `index_is_primary` (`is_primary`),
  KEY `index_is_billing` (`is_billing`),
  KEY `UI_mobile_provider_id` (`mobile_provider_id`),
  KEY `FK_civicrm_phone_contact_id` (`contact_id`),
  CONSTRAINT `FK_civicrm_phone_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_phone`
--

LOCK TABLES `civicrm_phone` WRITE;
/*!40000 ALTER TABLE `civicrm_phone` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_pledge`
--

DROP TABLE IF EXISTS `civicrm_pledge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_pledge` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Pledge ID',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to civicrm_contact.id .',
  `contribution_type_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contribution Type. This is propagated to contribution record when pledge payments are made.',
  `contribution_page_id` int(10) unsigned DEFAULT NULL COMMENT 'The Contribution Page which triggered this contribution',
  `amount` decimal(20,2) NOT NULL COMMENT 'Total pledged amount.',
  `original_installment_amount` decimal(20,2) NOT NULL COMMENT 'Original amount for each of the installments.',
  `currency` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `frequency_unit` enum('day','week','month','year') COLLATE utf8_unicode_ci DEFAULT 'month' COMMENT 'Time units for recurrence of pledge payments.',
  `frequency_interval` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'Number of time units for recurrence of pledge payments.',
  `frequency_day` int(10) unsigned NOT NULL DEFAULT '3' COMMENT 'Day in the period when the pledge payment is due e.g. 1st of month, 15th etc. Use this to set the scheduled dates for pledge payments.',
  `installments` int(10) unsigned DEFAULT '1' COMMENT 'Total number of payments to be made.',
  `start_date` datetime NOT NULL COMMENT 'The date the first scheduled pledge occurs.',
  `create_date` datetime NOT NULL COMMENT 'When this pledge record was created.',
  `acknowledge_date` datetime DEFAULT NULL COMMENT 'When a pledge acknowledgement message was sent to the contributor.',
  `modified_date` datetime DEFAULT NULL COMMENT 'Last updated date for this pledge record.',
  `cancel_date` datetime DEFAULT NULL COMMENT 'Date this pledge was cancelled by contributor.',
  `end_date` datetime DEFAULT NULL COMMENT 'Date this pledge finished successfully (total pledge payments equal to or greater than pledged amount).',
  `honor_contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to contact ID. Used when pledge is made in honor of another contact. This is propagated to contribution records when pledge payments are made.',
  `honor_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Implicit FK to civicrm_option_value.',
  `max_reminders` int(10) unsigned DEFAULT '1' COMMENT 'The maximum number of payment reminders to send for any given payment.',
  `initial_reminder_day` int(10) unsigned DEFAULT '5' COMMENT 'Send initial reminder this many days prior to the payment due date.',
  `additional_reminder_day` int(10) unsigned DEFAULT '5' COMMENT 'Send additional reminder this many days after last one sent, up to maximum number of reminders.',
  `status_id` int(10) unsigned DEFAULT NULL COMMENT 'Implicit foreign key to civicrm_option_values in the contribution_status option group.',
  `is_test` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_status` (`status_id`),
  KEY `FK_civicrm_pledge_contact_id` (`contact_id`),
  KEY `FK_civicrm_pledge_contribution_type_id` (`contribution_type_id`),
  KEY `FK_civicrm_pledge_contribution_page_id` (`contribution_page_id`),
  KEY `FK_civicrm_pledge_honor_contact_id` (`honor_contact_id`),
  CONSTRAINT `FK_civicrm_pledge_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_pledge_contribution_page_id` FOREIGN KEY (`contribution_page_id`) REFERENCES `civicrm_contribution_page` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_pledge_contribution_type_id` FOREIGN KEY (`contribution_type_id`) REFERENCES `civicrm_contribution_type` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_pledge_honor_contact_id` FOREIGN KEY (`honor_contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_pledge`
--

LOCK TABLES `civicrm_pledge` WRITE;
/*!40000 ALTER TABLE `civicrm_pledge` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_pledge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_pledge_block`
--

DROP TABLE IF EXISTS `civicrm_pledge_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_pledge_block` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Pledge ID',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'physical tablename for entity being joined to pledge, e.g. civicrm_contact',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'FK to entity table specified in entity_table column.',
  `pledge_frequency_unit` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Delimited list of supported frequency units',
  `is_pledge_interval` tinyint(4) DEFAULT '0' COMMENT 'Is frequency interval exposed on the contribution form.',
  `max_reminders` int(10) unsigned DEFAULT '1' COMMENT 'The maximum number of payment reminders to send for any given payment.',
  `initial_reminder_day` int(10) unsigned DEFAULT '5' COMMENT 'Send initial reminder this many days prior to the payment due date.',
  `additional_reminder_day` int(10) unsigned DEFAULT '5' COMMENT 'Send additional reminder this many days after last one sent, up to maximum number of reminders.',
  PRIMARY KEY (`id`),
  KEY `index_entity` (`entity_table`,`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_pledge_block`
--

LOCK TABLES `civicrm_pledge_block` WRITE;
/*!40000 ALTER TABLE `civicrm_pledge_block` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_pledge_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_pledge_payment`
--

DROP TABLE IF EXISTS `civicrm_pledge_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_pledge_payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pledge_id` int(10) unsigned NOT NULL COMMENT 'FK to Pledge table',
  `contribution_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to contribution table.',
  `scheduled_amount` decimal(20,2) NOT NULL COMMENT 'Pledged amount for this payment (the actual contribution amount might be different).',
  `actual_amount` decimal(20,2) DEFAULT NULL COMMENT 'Actual amount that is paid as the Pledged installment amount.',
  `currency` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `scheduled_date` datetime NOT NULL COMMENT 'The date the pledge payment is supposed to happen.',
  `reminder_date` datetime DEFAULT NULL COMMENT 'The date that the most recent payment reminder was sent.',
  `reminder_count` int(10) unsigned DEFAULT '0' COMMENT 'The number of payment reminders sent.',
  `status_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_contribution_pledge` (`contribution_id`,`pledge_id`),
  KEY `index_status` (`status_id`),
  KEY `FK_civicrm_pledge_payment_pledge_id` (`pledge_id`),
  CONSTRAINT `FK_civicrm_pledge_payment_contribution_id` FOREIGN KEY (`contribution_id`) REFERENCES `civicrm_contribution` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_pledge_payment_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `civicrm_pledge` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_pledge_payment`
--

LOCK TABLES `civicrm_pledge_payment` WRITE;
/*!40000 ALTER TABLE `civicrm_pledge_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_pledge_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_preferences`
--

DROP TABLE IF EXISTS `civicrm_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_preferences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this menu item for',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `is_domain` tinyint(4) DEFAULT NULL COMMENT 'Is this the record for the domain setting?',
  `contact_view_options` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'What tabs are displayed in the contact summary',
  `contact_edit_options` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'What tabs are displayed in the contact edit',
  `advanced_search_options` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'What tabs are displayed in the advanced search screen',
  `user_dashboard_options` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'What tabs are displayed in the contact edit',
  `address_options` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'What fields are displayed from the address table',
  `address_format` text COLLATE utf8_unicode_ci COMMENT 'Format to display the address',
  `mailing_format` text COLLATE utf8_unicode_ci COMMENT 'Format to display a mailing label',
  `display_name_format` text COLLATE utf8_unicode_ci COMMENT 'Format to display contact display name',
  `sort_name_format` text COLLATE utf8_unicode_ci COMMENT 'Format to display contact sort name',
  `address_standardization_provider` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'object name of provider for address standarization',
  `address_standardization_userid` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'user id for provider login',
  `address_standardization_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'url of address standardization service',
  `editor_id` int(10) unsigned DEFAULT NULL COMMENT 'ID of the editor',
  `mailing_backend` text COLLATE utf8_unicode_ci COMMENT 'Smtp Backend configuration.',
  `navigation` text COLLATE utf8_unicode_ci COMMENT 'Store navigation for the Contact',
  `contact_autocomplete_options` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'What Autocomplete has to return',
  PRIMARY KEY (`id`),
  KEY `index_contact_view_options` (`contact_view_options`),
  KEY `index_contact_edit_options` (`contact_edit_options`),
  KEY `index_advanced_search_options` (`advanced_search_options`),
  KEY `index_user_dashboard_options` (`user_dashboard_options`),
  KEY `index_address_options` (`address_options`),
  KEY `FK_civicrm_preferences_domain_id` (`domain_id`),
  KEY `FK_civicrm_preferences_contact_id` (`contact_id`),
  CONSTRAINT `FK_civicrm_preferences_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_preferences_domain_id` FOREIGN KEY (`domain_id`) REFERENCES `civicrm_domain` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_preferences`
--

LOCK TABLES `civicrm_preferences` WRITE;
/*!40000 ALTER TABLE `civicrm_preferences` DISABLE KEYS */;
INSERT INTO `civicrm_preferences` VALUES (1,1,NULL,1,'12345610','12345678912','1234561013161718','15','1234568913','{contact.address_name}\n{contact.supplemental_address_2}\n{contact.street_address}\n{contact.supplemental_address_1}\n{contact.city}{, }{contact.state_province}{ }{contact.postal_code}\n{contact.country}','{contact.addressee}\n{contact.supplemental_address_2}\n{contact.street_address}\n{contact.supplemental_address_1}\n{contact.city}{, }{contact.state_province}{ }{contact.postal_code}','{contact.individual_prefix}{ }{contact.first_name}{ }{contact.middle_name}{ }{contact.last_name}{, }{contact.individual_suffix}','{contact.last_name}{, }{contact.first_name}{ }{contact.middle_name}{, }{contact.individual_suffix}','SAGE','SQ0lzOepSH3qnh2r4kN1QeRCMAAan2u','http://sage.nysenate.gov/api/xml/validate/extended?',2,'a:9:{s:5:\"qfKey\";s:37:\"842832eeff4a43a1e7c5a7de762a10d6_7866\";s:15:\"outBound_option\";s:1:\"0\";s:13:\"sendmail_path\";s:0:\"\";s:13:\"sendmail_args\";s:0:\"\";s:10:\"smtpServer\";s:26:\"senapps.senate.state.ny.us\";s:8:\"smtpPort\";s:2:\"25\";s:8:\"smtpAuth\";s:1:\"0\";s:12:\"smtpUsername\";s:0:\"\";s:12:\"smtpPassword\";s:0:\"\";}',NULL,'125'),(2,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `civicrm_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_preferences_date`
--

DROP TABLE IF EXISTS `civicrm_preferences_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_preferences_date` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The meta name for this date (fixed in code)',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Description of this date type.',
  `start` int(11) NOT NULL COMMENT 'The start offset relative to current year',
  `end` int(11) NOT NULL COMMENT 'The end offset relative to current year, can be negative',
  `date_format` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The date type',
  `time_format` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'time format',
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_preferences_date`
--

LOCK TABLES `civicrm_preferences_date` WRITE;
/*!40000 ALTER TABLE `civicrm_preferences_date` DISABLE KEYS */;
INSERT INTO `civicrm_preferences_date` VALUES (1,'activityDate','Date for activities including contributions: receive, receipt, cancel. membership: join, start, renew. case: start, end.',20,10,'',''),(2,'activityDateTime','Date and time for activity: scheduled. participant: registered.',20,10,'','1'),(3,'birth','Birth and deceased dates. Only year, month and day fields are supported.',120,0,'',''),(4,'creditCard','Month and year only for credit card expiration.',0,10,'M Y',''),(5,'custom','Uses date range passed in by form field. Can pass in a posix date part parameter. Start and end offsets defined here are ignored.',20,20,'',''),(6,'mailing','Date and time. Used for scheduling mailings.',0,1,'',''),(7,'searchDate','Used in search forms.',100,0,'','');
/*!40000 ALTER TABLE `civicrm_preferences_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_premiums`
--

DROP TABLE IF EXISTS `civicrm_premiums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_premiums` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_table` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Joins these premium settings to another object. Always civicrm_contribution_page for now.',
  `entity_id` int(10) unsigned NOT NULL,
  `premiums_active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Is the Premiums feature enabled for this page?',
  `premiums_intro_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Title for Premiums section.',
  `premiums_intro_text` text COLLATE utf8_unicode_ci COMMENT 'Displayed in <div> at top of Premiums section of page. Text and HTML allowed.',
  `premiums_contact_email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'This email address is included in receipts if it is populated and a premium has been selected.',
  `premiums_contact_phone` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'This phone number is included in receipts if it is populated and a premium has been selected.',
  `premiums_display_min_contribution` tinyint(4) NOT NULL COMMENT 'Boolean. Should we automatically display minimum contribution amount text after the premium descriptions.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_premiums`
--

LOCK TABLES `civicrm_premiums` WRITE;
/*!40000 ALTER TABLE `civicrm_premiums` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_premiums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_premiums_product`
--

DROP TABLE IF EXISTS `civicrm_premiums_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_premiums_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Contribution ID',
  `premiums_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to premiums settings record.',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to each product object.',
  `weight` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_premiums_product_premiums_id` (`premiums_id`),
  KEY `FK_civicrm_premiums_product_product_id` (`product_id`),
  CONSTRAINT `FK_civicrm_premiums_product_premiums_id` FOREIGN KEY (`premiums_id`) REFERENCES `civicrm_premiums` (`id`),
  CONSTRAINT `FK_civicrm_premiums_product_product_id` FOREIGN KEY (`product_id`) REFERENCES `civicrm_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_premiums_product`
--

LOCK TABLES `civicrm_premiums_product` WRITE;
/*!40000 ALTER TABLE `civicrm_premiums_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_premiums_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_price_field`
--

DROP TABLE IF EXISTS `civicrm_price_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_price_field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Price Field',
  `price_set_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_price_set',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Variable name/programmatic handle for this field.',
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Text for form field label (also friendly name for administering this field).',
  `html_type` enum('Text','Select','Radio','CheckBox') COLLATE utf8_unicode_ci NOT NULL,
  `is_enter_qty` tinyint(4) DEFAULT '0' COMMENT 'Enter a quantity for this field?',
  `help_pre` text COLLATE utf8_unicode_ci COMMENT 'Description and/or help text to display before this field.',
  `help_post` text COLLATE utf8_unicode_ci COMMENT 'Description and/or help text to display after this field.',
  `weight` int(11) DEFAULT '1' COMMENT 'Order in which the fields should appear',
  `is_display_amounts` tinyint(4) DEFAULT '1' COMMENT 'Should the price be displayed next to the label for each option?',
  `options_per_line` int(10) unsigned DEFAULT '1' COMMENT 'number of options per line for checkbox and radio',
  `is_active` tinyint(4) DEFAULT '1' COMMENT 'Is this price field active',
  `is_required` tinyint(4) DEFAULT '1' COMMENT 'Is this price field required (value must be > 1)',
  `active_on` datetime DEFAULT NULL COMMENT 'If non-zero, do not show this field before the date specified',
  `expire_on` datetime DEFAULT NULL COMMENT 'If non-zero, do not show this field after the date specified',
  `javascript` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Optional scripting attributes for field',
  `visibility_id` int(10) unsigned DEFAULT '1' COMMENT 'Implicit FK to civicrm_option_group with name = ''visibility''',
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`),
  KEY `FK_civicrm_price_field_price_set_id` (`price_set_id`),
  CONSTRAINT `FK_civicrm_price_field_price_set_id` FOREIGN KEY (`price_set_id`) REFERENCES `civicrm_price_set` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_price_field`
--

LOCK TABLES `civicrm_price_field` WRITE;
/*!40000 ALTER TABLE `civicrm_price_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_price_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_price_field_value`
--

DROP TABLE IF EXISTS `civicrm_price_field_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_price_field_value` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Price Field Value',
  `price_field_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_price_field',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Price field option name',
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Price field option label',
  `description` text COLLATE utf8_unicode_ci COMMENT 'Price field option description.',
  `amount` varchar(512) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Price field option amount',
  `count` int(10) unsigned DEFAULT NULL COMMENT 'Number of participants per field option',
  `max_value` int(10) unsigned DEFAULT NULL COMMENT 'Max number of participants per field options',
  `weight` int(11) DEFAULT '1' COMMENT 'Order in which the field options should appear',
  `is_default` tinyint(4) DEFAULT '0' COMMENT 'Is this default price field option',
  `is_active` tinyint(4) DEFAULT '1' COMMENT 'Is this price field option active',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_price_field_value_price_field_id` (`price_field_id`),
  CONSTRAINT `FK_civicrm_price_field_value_price_field_id` FOREIGN KEY (`price_field_id`) REFERENCES `civicrm_price_field` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_price_field_value`
--

LOCK TABLES `civicrm_price_field_value` WRITE;
/*!40000 ALTER TABLE `civicrm_price_field_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_price_field_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_price_set`
--

DROP TABLE IF EXISTS `civicrm_price_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_price_set` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Price Set',
  `domain_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Domain is this price-set for',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Variable name/programmatic handle for this set of price fields.',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Displayed title for the Price Set.',
  `is_active` tinyint(4) DEFAULT '1' COMMENT 'Is this price set active',
  `help_pre` text COLLATE utf8_unicode_ci COMMENT 'Description and/or help text to display before fields in form.',
  `help_post` text COLLATE utf8_unicode_ci COMMENT 'Description and/or help text to display after fields in form.',
  `javascript` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Optional Javascript script function(s) included on the form with this price_set. Can be used for conditional',
  `extends` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'What components are using this price set?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name` (`name`),
  UNIQUE KEY `UI_title` (`title`),
  KEY `FK_civicrm_price_set_domain_id` (`domain_id`),
  CONSTRAINT `FK_civicrm_price_set_domain_id` FOREIGN KEY (`domain_id`) REFERENCES `civicrm_domain` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_price_set`
--

LOCK TABLES `civicrm_price_set` WRITE;
/*!40000 ALTER TABLE `civicrm_price_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_price_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_price_set_entity`
--

DROP TABLE IF EXISTS `civicrm_price_set_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_price_set_entity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Price Set Entity',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Table which uses this price set',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Item in table',
  `price_set_id` int(10) unsigned NOT NULL COMMENT 'price set being used',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_entity` (`entity_table`,`entity_id`),
  KEY `FK_civicrm_price_set_entity_price_set_id` (`price_set_id`),
  CONSTRAINT `FK_civicrm_price_set_entity_price_set_id` FOREIGN KEY (`price_set_id`) REFERENCES `civicrm_price_set` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_price_set_entity`
--

LOCK TABLES `civicrm_price_set_entity` WRITE;
/*!40000 ALTER TABLE `civicrm_price_set_entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_price_set_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_product`
--

DROP TABLE IF EXISTS `civicrm_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Required product/premium name',
  `description` text COLLATE utf8_unicode_ci COMMENT 'Optional description of the product/premium.',
  `sku` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Optional product sku or code.',
  `options` text COLLATE utf8_unicode_ci COMMENT 'Store comma-delimited list of color, size, etc. options for the product.',
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Full or relative URL to uploaded image - fullsize.',
  `thumbnail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Full or relative URL to image thumbnail.',
  `price` decimal(20,2) DEFAULT NULL COMMENT 'Sell price or market value for premiums. For tax-deductible contributions, this will be stored as non_deductible_amount in the contribution record.',
  `currency` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `min_contribution` decimal(20,2) DEFAULT NULL COMMENT 'Minimum contribution required to be eligible to select this premium.',
  `cost` decimal(20,2) DEFAULT NULL COMMENT 'Actual cost of this product. Useful to determine net return from sale or using this as an incentive.',
  `is_active` tinyint(4) NOT NULL COMMENT 'Disabling premium removes it from the premiums_premium join table below.',
  `period_type` enum('rolling','fixed') COLLATE utf8_unicode_ci DEFAULT 'rolling' COMMENT 'Rolling means we set start/end based on current day, fixed means we set start/end for current year or month\n(e.g. 1 year + fixed -> we would set start/end for 1/1/06 thru 12/31/06 for any premium chosen in 2006) ',
  `fixed_period_start_day` int(11) DEFAULT '101' COMMENT 'Month and day (MMDD) that fixed period type subscription or membership starts.',
  `duration_unit` enum('day','month','week','year') COLLATE utf8_unicode_ci DEFAULT 'year',
  `duration_interval` int(11) DEFAULT NULL COMMENT 'Number of units for total duration of subscription, service, membership (e.g. 12 Months).',
  `frequency_unit` enum('day','month','week','year') COLLATE utf8_unicode_ci DEFAULT 'month' COMMENT 'Frequency unit and interval allow option to store actual delivery frequency for a subscription or service.',
  `frequency_interval` int(11) DEFAULT NULL COMMENT 'Number of units for delivery frequency of subscription, service, membership (e.g. every 3 Months).',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_product`
--

LOCK TABLES `civicrm_product` WRITE;
/*!40000 ALTER TABLE `civicrm_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_project`
--

DROP TABLE IF EXISTS `civicrm_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_project` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Project ID',
  `title` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Project name.',
  `description` text COLLATE utf8_unicode_ci COMMENT 'Optional verbose description of the project. May be used for display - HTML allowed.',
  `logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Full or relative URL to optional uploaded logo image for project.',
  `owner_entity_table` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of table where project owner being referenced is stored (e.g. civicrm_contact or civicrm_group).',
  `owner_entity_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to project owner (contact, group, etc.).',
  `start_date` datetime DEFAULT NULL COMMENT 'Project start date.',
  `end_date` datetime DEFAULT NULL COMMENT 'Project end date.',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this record active? For Projects: can tasks be created for it, does it appear on project listings, etc.',
  `status_id` int(10) unsigned DEFAULT NULL COMMENT 'Configurable status value (e.g. Planned, Active, Closed...). FK to civicrm_option_value.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_project_owner` (`id`,`owner_entity_table`,`owner_entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_project`
--

LOCK TABLES `civicrm_project` WRITE;
/*!40000 ALTER TABLE `civicrm_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_relationship`
--

DROP TABLE IF EXISTS `civicrm_relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_relationship` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Relationship ID',
  `contact_id_a` int(10) unsigned NOT NULL COMMENT 'id of the first contact',
  `contact_id_b` int(10) unsigned NOT NULL COMMENT 'id of the second contact',
  `relationship_type_id` int(10) unsigned NOT NULL COMMENT 'id of the relationship',
  `start_date` date DEFAULT NULL COMMENT 'date when the relationship started',
  `end_date` date DEFAULT NULL COMMENT 'date when the relationship ended',
  `is_active` tinyint(4) DEFAULT '1' COMMENT 'is the relationship active ?',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Optional verbose description for the relationship.',
  `is_permission_a_b` tinyint(4) DEFAULT '0' COMMENT 'is contact a has permission to view / edit contact and\n  related data for contact b ?',
  `is_permission_b_a` tinyint(4) DEFAULT '0' COMMENT 'is contact b has permission to view / edit contact and\n  related data for contact a ?',
  `case_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_case',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_relationship_contact_id_a` (`contact_id_a`),
  KEY `FK_civicrm_relationship_contact_id_b` (`contact_id_b`),
  KEY `FK_civicrm_relationship_relationship_type_id` (`relationship_type_id`),
  KEY `FK_civicrm_relationship_case_id` (`case_id`),
  CONSTRAINT `FK_civicrm_relationship_case_id` FOREIGN KEY (`case_id`) REFERENCES `civicrm_case` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_relationship_contact_id_a` FOREIGN KEY (`contact_id_a`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_relationship_contact_id_b` FOREIGN KEY (`contact_id_b`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_relationship_relationship_type_id` FOREIGN KEY (`relationship_type_id`) REFERENCES `civicrm_relationship_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_relationship`
--

LOCK TABLES `civicrm_relationship` WRITE;
/*!40000 ALTER TABLE `civicrm_relationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_relationship_type`
--

DROP TABLE IF EXISTS `civicrm_relationship_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_relationship_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `name_a_b` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'name for relationship of contact_a to contact_b.',
  `label_a_b` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'label for relationship of contact_a to contact_b.',
  `name_b_a` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Optional name for relationship of contact_b to contact_a.',
  `label_b_a` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Optional label for relationship of contact_b to contact_a.',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Optional verbose description of the relationship type.',
  `contact_type_a` enum('Individual','Organization','Household') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'If defined, contact_a in a relationship of this type must be a specific contact_type.',
  `contact_type_b` enum('Individual','Organization','Household') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'If defined, contact_b in a relationship of this type must be a specific contact_type.',
  `contact_sub_type_a` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'If defined, contact_sub_type_a in a relationship of this type must be a specific contact_sub_type.',
  `contact_sub_type_b` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'If defined, contact_sub_type_b in a relationship of this type must be a specific contact_sub_type.',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'Is this relationship type a predefined system type (can not be changed or de-activated)?',
  `is_active` tinyint(4) DEFAULT '1' COMMENT 'Is this relationship type currently active (i.e. can be used when creating or editing relationships)?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name_a_b` (`name_a_b`),
  UNIQUE KEY `UI_name_b_a` (`name_b_a`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_relationship_type`
--

LOCK TABLES `civicrm_relationship_type` WRITE;
/*!40000 ALTER TABLE `civicrm_relationship_type` DISABLE KEYS */;
INSERT INTO `civicrm_relationship_type` VALUES (1,'Child of','Child of','Parent of','Parent of','Parent/child relationship.','Individual','Individual',NULL,NULL,0,1),(2,'Spouse of','Spouse of','Spouse of','Spouse of','Spousal relationship.','Individual','Individual',NULL,NULL,0,1),(3,'Sibling of','Sibling of','Sibling of','Sibling of','Sibling relationship.','Individual','Individual',NULL,NULL,0,1),(4,'Employee of','Employee of','Employer of','Employer of','Employment relationship.','Individual','Organization',NULL,NULL,1,1),(5,'Volunteer for','Volunteer for','Volunteer is','Volunteer is','Volunteer relationship.','Individual','Organization',NULL,NULL,0,1),(6,'Head of Household for','Head of Household for','Head of Household is','Head of Household is','Head of household.','Individual','Household',NULL,NULL,1,1),(7,'Household Member of','Household Member of','Household Member is','Household Member is','Household membership.','Individual','Household',NULL,NULL,1,1),(8,'Case Coordinator is','Case Coordinator is','Case Coordinator','Case Coordinator','Case Coordinator','Individual','Individual',NULL,NULL,0,1),(9,'Supervised by','Supervised by','Supervisor','Supervisor','Immediate workplace supervisor','Individual','Individual',NULL,NULL,0,1),(10,'Domestic Partner of','Domestic Partner of','Domestic Partner of','Domestic Partner of',NULL,'Individual','Individual',NULL,NULL,NULL,1),(11,'Family Relation to','Family Relation to','Family Relation to','Family Relation to',NULL,'Individual','Individual',NULL,NULL,NULL,1),(12,'Organization of','Organization of','Participant in','Participant in',NULL,'Organization','Individual',NULL,NULL,NULL,1),(13,'Case Manager','Case Manager is','Case Manager','Case Manager',NULL,NULL,'Individual',NULL,NULL,NULL,1),(14,'Non-District Staff','Non-District Staff is','Non-District Staff','Non-District Staff',NULL,NULL,'Individual',NULL,NULL,NULL,1),(15,'Support Staff','Support Staff is','Support Staff','Support Staff',NULL,NULL,'Individual',NULL,NULL,NULL,1),(16,'Agency Staff is','Agency Staff is','Agency Staff','Agency Staff',NULL,NULL,'Individual',NULL,NULL,NULL,1),(17,'Owner is','Owner is','Owner of','Owner of',NULL,'Organization','Individual',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `civicrm_relationship_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_report_instance`
--

DROP TABLE IF EXISTS `civicrm_report_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_report_instance` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Report Instance ID',
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this instance for',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Report Instance Title.',
  `report_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'FK to civicrm_option_value for the report template',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Report Instance description.',
  `permission` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'permission required to be able to run this instance',
  `form_values` text COLLATE utf8_unicode_ci COMMENT 'Submitted form values for this report',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this entry active?',
  `email_subject` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Subject of email',
  `email_to` text COLLATE utf8_unicode_ci COMMENT 'comma-separated list of email addresses to send the report to',
  `email_cc` text COLLATE utf8_unicode_ci COMMENT 'comma-separated list of email addresses to send the report to',
  `header` text COLLATE utf8_unicode_ci COMMENT 'comma-separated list of email addresses to send the report to',
  `footer` text COLLATE utf8_unicode_ci COMMENT 'comma-separated list of email addresses to send the report to',
  `navigation_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to navigation ID',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_report_instance_domain_id` (`domain_id`),
  KEY `FK_civicrm_report_instance_navigation_id` (`navigation_id`),
  CONSTRAINT `FK_civicrm_report_instance_domain_id` FOREIGN KEY (`domain_id`) REFERENCES `civicrm_domain` (`id`),
  CONSTRAINT `FK_civicrm_report_instance_navigation_id` FOREIGN KEY (`navigation_id`) REFERENCES `civicrm_navigation` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_report_instance`
--

LOCK TABLES `civicrm_report_instance` WRITE;
/*!40000 ALTER TABLE `civicrm_report_instance` DISABLE KEYS */;
INSERT INTO `civicrm_report_instance` VALUES (1,1,'Constituent Report (Summary)','contact/summary','Provides a list of address and telephone information for constituent records in your system.','view all contacts','a:59:{s:6:\"fields\";a:5:{s:12:\"display_name\";s:1:\"1\";s:14:\"street_address\";s:1:\"1\";s:4:\"city\";s:1:\"1\";s:11:\"postal_code\";s:1:\"1\";s:17:\"state_province_id\";s:1:\"1\";}s:12:\"sort_name_op\";s:3:\"has\";s:15:\"sort_name_value\";s:0:\"\";s:9:\"source_op\";s:3:\"has\";s:12:\"source_value\";s:0:\"\";s:6:\"id_min\";s:0:\"\";s:6:\"id_max\";s:0:\"\";s:5:\"id_op\";s:3:\"lte\";s:8:\"id_value\";s:0:\"\";s:13:\"country_id_op\";s:2:\"in\";s:16:\"country_id_value\";a:0:{}s:20:\"state_province_id_op\";s:2:\"in\";s:23:\"state_province_id_value\";a:0:{}s:6:\"gid_op\";s:2:\"in\";s:9:\"gid_value\";a:0:{}s:8:\"tagid_op\";s:2:\"in\";s:11:\"tagid_value\";a:0:{}s:12:\"custom_16_op\";s:3:\"has\";s:15:\"custom_16_value\";s:0:\"\";s:12:\"custom_17_op\";s:2:\"eq\";s:15:\"custom_17_value\";s:0:\"\";s:12:\"custom_18_op\";s:2:\"eq\";s:15:\"custom_18_value\";s:0:\"\";s:12:\"custom_19_op\";s:2:\"eq\";s:15:\"custom_19_value\";s:0:\"\";s:12:\"custom_20_op\";s:3:\"has\";s:15:\"custom_20_value\";s:0:\"\";s:12:\"custom_23_op\";s:2:\"in\";s:15:\"custom_23_value\";a:0:{}s:18:\"custom_24_relative\";s:1:\"0\";s:14:\"custom_24_from\";s:0:\"\";s:12:\"custom_24_to\";s:0:\"\";s:12:\"custom_33_op\";s:3:\"has\";s:15:\"custom_33_value\";s:0:\"\";s:12:\"custom_34_op\";s:3:\"has\";s:15:\"custom_34_value\";s:0:\"\";s:12:\"custom_35_op\";s:3:\"has\";s:15:\"custom_35_value\";s:0:\"\";s:12:\"custom_42_op\";s:2:\"in\";s:15:\"custom_42_value\";a:0:{}s:12:\"custom_45_op\";s:3:\"has\";s:15:\"custom_45_value\";s:0:\"\";s:12:\"custom_31_op\";s:2:\"in\";s:15:\"custom_31_value\";a:0:{}s:12:\"custom_59_op\";s:2:\"in\";s:15:\"custom_59_value\";a:0:{}s:12:\"custom_25_op\";s:3:\"has\";s:15:\"custom_25_value\";s:0:\"\";s:12:\"custom_26_op\";s:3:\"has\";s:15:\"custom_26_value\";s:0:\"\";s:12:\"custom_41_op\";s:2:\"in\";s:15:\"custom_41_value\";a:0:{}s:11:\"description\";s:92:\"Provides a list of address and telephone information for constituent records in your system.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:17:\"view all contacts\";s:6:\"groups\";s:0:\"\";s:9:\"domain_id\";i:1;}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',175),(2,1,'Constituent Report (Detail)','contact/detail','Provides contact-related information on constituent details and activities.','view all contacts','a:18:{s:6:\"fields\";a:2:{s:12:\"display_name\";s:1:\"1\";s:10:\"country_id\";s:1:\"1\";}s:6:\"id_min\";s:0:\"\";s:6:\"id_max\";s:0:\"\";s:5:\"id_op\";s:3:\"lte\";s:8:\"id_value\";s:0:\"\";s:15:\"display_name_op\";s:3:\"has\";s:18:\"display_name_value\";s:0:\"\";s:6:\"gid_op\";s:2:\"in\";s:9:\"gid_value\";a:0:{}s:6:\"tid_op\";s:2:\"in\";s:9:\"tid_value\";a:0:{}s:11:\"description\";s:75:\"Provides contact-related information on constituent details and activities.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:17:\"view all contacts\";s:6:\"groups\";s:0:\"\";s:9:\"domain_id\";i:1;}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',176),(3,1,'Donor Report (Summary)','contribute/summary','Shows contribution statistics by month / week / year .. country / state .. type.','access CiviContribute','a:38:{s:6:\"fields\";a:1:{s:12:\"total_amount\";s:1:\"1\";}s:13:\"country_id_op\";s:2:\"in\";s:16:\"country_id_value\";a:0:{}s:20:\"state_province_id_op\";s:2:\"in\";s:23:\"state_province_id_value\";a:0:{}s:21:\"receive_date_relative\";s:1:\"0\";s:17:\"receive_date_from\";s:0:\"\";s:15:\"receive_date_to\";s:0:\"\";s:25:\"contribution_status_id_op\";s:2:\"in\";s:28:\"contribution_status_id_value\";a:1:{i:0;s:1:\"1\";}s:16:\"total_amount_min\";s:0:\"\";s:16:\"total_amount_max\";s:0:\"\";s:15:\"total_amount_op\";s:3:\"lte\";s:18:\"total_amount_value\";s:0:\"\";s:13:\"total_sum_min\";s:0:\"\";s:13:\"total_sum_max\";s:0:\"\";s:12:\"total_sum_op\";s:3:\"lte\";s:15:\"total_sum_value\";s:0:\"\";s:15:\"total_count_min\";s:0:\"\";s:15:\"total_count_max\";s:0:\"\";s:14:\"total_count_op\";s:3:\"lte\";s:17:\"total_count_value\";s:0:\"\";s:13:\"total_avg_min\";s:0:\"\";s:13:\"total_avg_max\";s:0:\"\";s:12:\"total_avg_op\";s:3:\"lte\";s:15:\"total_avg_value\";s:0:\"\";s:6:\"gid_op\";s:2:\"in\";s:9:\"gid_value\";a:0:{}s:9:\"group_bys\";a:1:{s:12:\"receive_date\";s:1:\"1\";}s:14:\"group_bys_freq\";a:1:{s:12:\"receive_date\";s:5:\"MONTH\";}s:11:\"description\";s:80:\"Shows contribution statistics by month / week / year .. country / state .. type.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:21:\"access CiviContribute\";s:9:\"parent_id\";s:3:\"174\";s:6:\"groups\";s:0:\"\";s:6:\"charts\";s:0:\"\";}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(4,1,'Donor Report (Detail)','contribute/detail','Lists detailed contribution(s) for one / all contacts. Contribution summary report points to this report for specific details.','access CiviContribute','a:31:{s:6:\"fields\";a:6:{s:12:\"display_name\";s:1:\"1\";s:5:\"email\";s:1:\"1\";s:5:\"phone\";s:1:\"1\";s:10:\"country_id\";s:1:\"1\";s:12:\"total_amount\";s:1:\"1\";s:12:\"receive_date\";s:1:\"1\";}s:12:\"sort_name_op\";s:3:\"has\";s:15:\"sort_name_value\";s:0:\"\";s:6:\"id_min\";s:0:\"\";s:6:\"id_max\";s:0:\"\";s:5:\"id_op\";s:3:\"lte\";s:8:\"id_value\";s:0:\"\";s:13:\"country_id_op\";s:2:\"in\";s:16:\"country_id_value\";a:0:{}s:20:\"state_province_id_op\";s:2:\"in\";s:23:\"state_province_id_value\";a:0:{}s:21:\"receive_date_relative\";s:1:\"0\";s:17:\"receive_date_from\";s:0:\"\";s:15:\"receive_date_to\";s:0:\"\";s:25:\"contribution_status_id_op\";s:2:\"in\";s:28:\"contribution_status_id_value\";a:1:{i:0;s:1:\"1\";}s:16:\"total_amount_min\";s:0:\"\";s:16:\"total_amount_max\";s:0:\"\";s:15:\"total_amount_op\";s:3:\"lte\";s:18:\"total_amount_value\";s:0:\"\";s:6:\"gid_op\";s:2:\"in\";s:9:\"gid_value\";a:0:{}s:13:\"ordinality_op\";s:2:\"in\";s:16:\"ordinality_value\";a:0:{}s:11:\"description\";s:126:\"Lists detailed contribution(s) for one / all contacts. Contribution summary report points to this report for specific details.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:21:\"access CiviContribute\";s:9:\"parent_id\";s:3:\"174\";s:6:\"groups\";s:0:\"\";}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(5,1,'Donation Summary Report (Repeat)','contribute/repeat','Given two date ranges, shows contacts (and their contributions) who contributed in both the date ranges with percentage increase / decrease.','access CiviContribute','a:26:{s:6:\"fields\";a:3:{s:12:\"display_name\";s:1:\"1\";s:13:\"total_amount1\";s:1:\"1\";s:13:\"total_amount2\";s:1:\"1\";}s:22:\"receive_date1_relative\";s:13:\"previous.year\";s:18:\"receive_date1_from\";s:0:\"\";s:16:\"receive_date1_to\";s:0:\"\";s:22:\"receive_date2_relative\";s:9:\"this.year\";s:18:\"receive_date2_from\";s:0:\"\";s:16:\"receive_date2_to\";s:0:\"\";s:17:\"total_amount1_min\";s:0:\"\";s:17:\"total_amount1_max\";s:0:\"\";s:16:\"total_amount1_op\";s:3:\"lte\";s:19:\"total_amount1_value\";s:0:\"\";s:17:\"total_amount2_min\";s:0:\"\";s:17:\"total_amount2_max\";s:0:\"\";s:16:\"total_amount2_op\";s:3:\"lte\";s:19:\"total_amount2_value\";s:0:\"\";s:25:\"contribution_status_id_op\";s:2:\"in\";s:28:\"contribution_status_id_value\";a:1:{i:0;s:1:\"1\";}s:6:\"gid_op\";s:2:\"in\";s:9:\"gid_value\";a:0:{}s:9:\"group_bys\";a:1:{s:2:\"id\";s:1:\"1\";}s:11:\"description\";s:140:\"Given two date ranges, shows contacts (and their contributions) who contributed in both the date ranges with percentage increase / decrease.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:21:\"access CiviContribute\";s:6:\"groups\";s:0:\"\";}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(6,1,'SYBUNT Report','contribute/sybunt','Some year(s) but not this year. Provides a list of constituents who donated at some time in the history of your organization but did not donate during the time period you specify.','access CiviContribute','a:15:{s:6:\"fields\";a:3:{s:12:\"display_name\";s:1:\"1\";s:5:\"email\";s:1:\"1\";s:5:\"phone\";s:1:\"1\";}s:12:\"sort_name_op\";s:3:\"has\";s:15:\"sort_name_value\";s:0:\"\";s:6:\"yid_op\";s:2:\"eq\";s:9:\"yid_value\";s:4:\"2009\";s:25:\"contribution_status_id_op\";s:2:\"in\";s:28:\"contribution_status_id_value\";a:1:{i:0;s:1:\"1\";}s:6:\"gid_op\";s:2:\"in\";s:9:\"gid_value\";a:0:{}s:11:\"description\";s:179:\"Some year(s) but not this year. Provides a list of constituents who donated at some time in the history of your organization but did not donate during the time period you specify.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:21:\"access CiviContribute\";s:6:\"charts\";s:0:\"\";}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(7,1,'LYBUNT Report','contribute/lybunt','Last year but not this year. Provides a list of constituents who donated last year but did not donate during the time period you specify as the current year.','access CiviContribute','a:16:{s:6:\"fields\";a:3:{s:12:\"display_name\";s:1:\"1\";s:5:\"email\";s:1:\"1\";s:5:\"phone\";s:1:\"1\";}s:12:\"sort_name_op\";s:3:\"has\";s:15:\"sort_name_value\";s:0:\"\";s:6:\"yid_op\";s:2:\"eq\";s:9:\"yid_value\";s:4:\"2009\";s:25:\"contribution_status_id_op\";s:2:\"in\";s:28:\"contribution_status_id_value\";a:1:{i:0;s:1:\"1\";}s:6:\"gid_op\";s:2:\"in\";s:9:\"gid_value\";a:0:{}s:11:\"description\";s:157:\"Last year but not this year. Provides a list of constituents who donated last year but did not donate during the time period you specify as the current year.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:21:\"access CiviContribute\";s:6:\"groups\";s:0:\"\";s:6:\"charts\";s:0:\"\";}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(8,1,'Soft Credit Report','contribute/softcredit','Soft Credit details.','access CiviContribute','a:21:{s:6:\"fields\";a:5:{s:21:\"display_name_creditor\";s:1:\"1\";s:24:\"display_name_constituent\";s:1:\"1\";s:14:\"email_creditor\";s:1:\"1\";s:14:\"phone_creditor\";s:1:\"1\";s:12:\"total_amount\";s:1:\"1\";}s:5:\"id_op\";s:2:\"in\";s:8:\"id_value\";a:0:{}s:21:\"receive_date_relative\";s:1:\"0\";s:17:\"receive_date_from\";s:0:\"\";s:15:\"receive_date_to\";s:0:\"\";s:25:\"contribution_status_id_op\";s:2:\"in\";s:28:\"contribution_status_id_value\";a:1:{i:0;s:1:\"1\";}s:16:\"total_amount_min\";s:0:\"\";s:16:\"total_amount_max\";s:0:\"\";s:15:\"total_amount_op\";s:3:\"lte\";s:18:\"total_amount_value\";s:0:\"\";s:6:\"gid_op\";s:2:\"in\";s:9:\"gid_value\";a:0:{}s:11:\"description\";s:20:\"Soft Credit details.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:21:\"access CiviContribute\";s:9:\"parent_id\";s:3:\"174\";s:6:\"groups\";s:0:\"\";}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(9,1,'Membership Report (Summary)','member/summary','Provides a summary of memberships by type and join date.','access CiviMember','a:18:{s:6:\"fields\";a:2:{s:18:\"membership_type_id\";s:1:\"1\";s:12:\"total_amount\";s:1:\"1\";}s:18:\"join_date_relative\";s:1:\"0\";s:14:\"join_date_from\";s:0:\"\";s:12:\"join_date_to\";s:0:\"\";s:21:\"membership_type_id_op\";s:2:\"in\";s:24:\"membership_type_id_value\";a:0:{}s:12:\"status_id_op\";s:2:\"in\";s:15:\"status_id_value\";a:0:{}s:25:\"contribution_status_id_op\";s:2:\"in\";s:28:\"contribution_status_id_value\";a:0:{}s:9:\"group_bys\";a:2:{s:9:\"join_date\";s:1:\"1\";s:18:\"membership_type_id\";s:1:\"1\";}s:14:\"group_bys_freq\";a:1:{s:9:\"join_date\";s:5:\"MONTH\";}s:11:\"description\";s:56:\"Provides a summary of memberships by type and join date.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:17:\"access CiviMember\";s:9:\"domain_id\";i:1;}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(10,1,'Membership Report (Detail)','member/detail','Provides a list of members along with their membership status and membership details (Join Date, Start Date, End Date).','access CiviMember','a:27:{s:6:\"fields\";a:5:{s:12:\"display_name\";s:1:\"1\";s:18:\"membership_type_id\";s:1:\"1\";s:21:\"membership_start_date\";s:1:\"1\";s:19:\"membership_end_date\";s:1:\"1\";s:4:\"name\";s:1:\"1\";}s:12:\"sort_name_op\";s:3:\"has\";s:15:\"sort_name_value\";s:0:\"\";s:6:\"id_min\";s:0:\"\";s:6:\"id_max\";s:0:\"\";s:5:\"id_op\";s:3:\"lte\";s:8:\"id_value\";s:0:\"\";s:18:\"join_date_relative\";s:1:\"0\";s:14:\"join_date_from\";s:0:\"\";s:12:\"join_date_to\";s:0:\"\";s:23:\"owner_membership_id_min\";s:0:\"\";s:23:\"owner_membership_id_max\";s:0:\"\";s:22:\"owner_membership_id_op\";s:3:\"lte\";s:25:\"owner_membership_id_value\";s:0:\"\";s:6:\"tid_op\";s:2:\"in\";s:9:\"tid_value\";a:0:{}s:6:\"sid_op\";s:2:\"in\";s:9:\"sid_value\";a:0:{}s:6:\"gid_op\";s:2:\"in\";s:9:\"gid_value\";a:0:{}s:11:\"description\";s:119:\"Provides a list of members along with their membership status and membership details (Join Date, Start Date, End Date).\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:17:\"access CiviMember\";s:9:\"parent_id\";s:3:\"174\";s:6:\"groups\";s:0:\"\";}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(11,1,'Membership Report (Lapsed)','member/lapse','Provides a list of memberships that lapsed or will lapse before the date you specify.','access CiviMember','a:15:{s:6:\"fields\";a:5:{s:12:\"display_name\";s:1:\"1\";s:18:\"membership_type_id\";s:1:\"1\";s:19:\"membership_end_date\";s:1:\"1\";s:4:\"name\";s:1:\"1\";s:10:\"country_id\";s:1:\"1\";}s:6:\"tid_op\";s:2:\"in\";s:9:\"tid_value\";a:0:{}s:28:\"membership_end_date_relative\";s:1:\"0\";s:24:\"membership_end_date_from\";s:0:\"\";s:22:\"membership_end_date_to\";s:0:\"\";s:6:\"gid_op\";s:2:\"in\";s:9:\"gid_value\";a:0:{}s:11:\"description\";s:85:\"Provides a list of memberships that lapsed or will lapse before the date you specify.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:17:\"access CiviMember\";s:9:\"parent_id\";s:3:\"174\";s:6:\"groups\";s:0:\"\";}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(12,1,'Event Participant Report (List)','event/participantListing','Provides lists of participants for an event.','access CiviEvent','a:25:{s:6:\"fields\";a:4:{s:12:\"display_name\";s:1:\"1\";s:8:\"event_id\";s:1:\"1\";s:9:\"status_id\";s:1:\"1\";s:7:\"role_id\";s:1:\"1\";}s:12:\"sort_name_op\";s:3:\"has\";s:15:\"sort_name_value\";s:0:\"\";s:8:\"email_op\";s:3:\"has\";s:11:\"email_value\";s:0:\"\";s:11:\"event_id_op\";s:2:\"in\";s:14:\"event_id_value\";a:0:{}s:6:\"sid_op\";s:2:\"in\";s:9:\"sid_value\";a:0:{}s:6:\"rid_op\";s:2:\"in\";s:9:\"rid_value\";a:0:{}s:34:\"participant_register_date_relative\";s:1:\"0\";s:30:\"participant_register_date_from\";s:1:\" \";s:28:\"participant_register_date_to\";s:1:\" \";s:6:\"eid_op\";s:2:\"in\";s:9:\"eid_value\";a:0:{}s:16:\"blank_column_end\";s:0:\"\";s:11:\"description\";s:44:\"Provides lists of participants for an event.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:16:\"access CiviEvent\";s:9:\"parent_id\";s:0:\"\";s:6:\"groups\";s:0:\"\";s:7:\"options\";N;}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(13,1,'Event Income Report (Summary)','event/summary','Provides an overview of event income. You can include key information such as event ID, registration, attendance, and income generated to help you determine the success of an event.','access CiviEvent','a:18:{s:6:\"fields\";a:2:{s:5:\"title\";s:1:\"1\";s:13:\"event_type_id\";s:1:\"1\";}s:5:\"id_op\";s:2:\"in\";s:8:\"id_value\";a:0:{}s:16:\"event_type_id_op\";s:2:\"in\";s:19:\"event_type_id_value\";a:0:{}s:25:\"event_start_date_relative\";s:1:\"0\";s:21:\"event_start_date_from\";s:1:\" \";s:19:\"event_start_date_to\";s:1:\" \";s:23:\"event_end_date_relative\";s:1:\"0\";s:19:\"event_end_date_from\";s:1:\" \";s:17:\"event_end_date_to\";s:0:\"\";s:11:\"description\";s:181:\"Provides an overview of event income. You can include key information such as event ID, registration, attendance, and income generated to help you determine the success of an event.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:16:\"access CiviEvent\";s:9:\"parent_id\";s:3:\"174\";s:6:\"charts\";s:0:\"\";}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(14,1,'Event Income Report (Detail)','event/income','Helps you to analyze the income generated by an event. The report can include details by participant type, status and payment method.','access CiviEvent','a:7:{s:5:\"id_op\";s:2:\"in\";s:8:\"id_value\";N;s:11:\"description\";s:133:\"Helps you to analyze the income generated by an event. The report can include details by participant type, status and payment method.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:16:\"access CiviEvent\";}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(15,1,'Attendee List','event/participantListing','Provides lists of event attendees.','access CiviEvent','a:25:{s:6:\"fields\";a:4:{s:12:\"display_name\";s:1:\"1\";s:14:\"participant_id\";s:1:\"1\";s:9:\"status_id\";s:1:\"1\";s:7:\"role_id\";s:1:\"1\";}s:12:\"sort_name_op\";s:3:\"has\";s:15:\"sort_name_value\";s:0:\"\";s:8:\"email_op\";s:3:\"has\";s:11:\"email_value\";s:0:\"\";s:11:\"event_id_op\";s:2:\"in\";s:14:\"event_id_value\";a:1:{i:0;s:1:\"1\";}s:6:\"sid_op\";s:2:\"in\";s:9:\"sid_value\";a:0:{}s:6:\"rid_op\";s:2:\"in\";s:9:\"rid_value\";a:0:{}s:34:\"participant_register_date_relative\";s:1:\"0\";s:30:\"participant_register_date_from\";s:0:\"\";s:28:\"participant_register_date_to\";s:0:\"\";s:6:\"eid_op\";s:2:\"in\";s:9:\"eid_value\";a:0:{}s:16:\"blank_column_end\";s:1:\"1\";s:11:\"description\";s:34:\"Provides lists of event attendees.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:16:\"access CiviEvent\";s:9:\"parent_id\";s:3:\"174\";s:6:\"groups\";s:0:\"\";s:7:\"options\";N;}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(16,1,'Activity Report ','activity','Provides a list of constituent activity including activity statistics for one/all contacts during a given date range(required)','view all activities','a:28:{s:6:\"fields\";a:7:{s:14:\"contact_source\";s:1:\"1\";s:16:\"contact_assignee\";s:1:\"1\";s:14:\"contact_target\";s:1:\"1\";s:16:\"activity_type_id\";s:1:\"1\";s:7:\"subject\";s:1:\"1\";s:18:\"activity_date_time\";s:1:\"1\";s:9:\"status_id\";s:1:\"1\";}s:17:\"contact_source_op\";s:3:\"has\";s:20:\"contact_source_value\";s:0:\"\";s:19:\"contact_assignee_op\";s:3:\"has\";s:22:\"contact_assignee_value\";s:0:\"\";s:17:\"contact_target_op\";s:3:\"has\";s:20:\"contact_target_value\";s:0:\"\";s:27:\"activity_date_time_relative\";s:10:\"this.month\";s:23:\"activity_date_time_from\";s:0:\"\";s:21:\"activity_date_time_to\";s:0:\"\";s:10:\"subject_op\";s:3:\"has\";s:13:\"subject_value\";s:0:\"\";s:19:\"activity_type_id_op\";s:2:\"in\";s:22:\"activity_type_id_value\";a:0:{}s:12:\"status_id_op\";s:2:\"in\";s:15:\"status_id_value\";a:0:{}s:12:\"custom_43_op\";s:2:\"in\";s:15:\"custom_43_value\";a:0:{}s:12:\"custom_44_op\";s:2:\"in\";s:15:\"custom_44_value\";a:0:{}s:9:\"group_bys\";a:1:{s:17:\"source_contact_id\";s:1:\"1\";}s:11:\"description\";s:126:\"Provides a list of constituent activity including activity statistics for one/all contacts during a given date range(required)\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:19:\"view all activities\";s:6:\"groups\";s:0:\"\";s:9:\"domain_id\";i:1;}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',190),(17,1,'Relationship Report','contact/relationship','Gives relationship details between two contacts','administer CiviCRM','a:28:{s:6:\"fields\";a:4:{s:14:\"display_name_a\";s:1:\"1\";s:14:\"display_name_b\";s:1:\"1\";s:9:\"label_a_b\";s:1:\"1\";s:9:\"label_b_a\";s:1:\"1\";}s:14:\"sort_name_a_op\";s:3:\"has\";s:17:\"sort_name_a_value\";s:0:\"\";s:14:\"sort_name_b_op\";s:3:\"has\";s:17:\"sort_name_b_value\";s:0:\"\";s:17:\"contact_type_a_op\";s:2:\"in\";s:20:\"contact_type_a_value\";a:0:{}s:17:\"contact_type_b_op\";s:2:\"in\";s:20:\"contact_type_b_value\";a:0:{}s:12:\"is_active_op\";s:2:\"eq\";s:15:\"is_active_value\";s:0:\"\";s:23:\"relationship_type_id_op\";s:2:\"eq\";s:26:\"relationship_type_id_value\";s:0:\"\";s:13:\"country_id_op\";s:2:\"in\";s:16:\"country_id_value\";a:0:{}s:20:\"state_province_id_op\";s:2:\"in\";s:23:\"state_province_id_value\";a:0:{}s:6:\"gid_op\";s:2:\"in\";s:9:\"gid_value\";a:0:{}s:8:\"tagid_op\";s:2:\"in\";s:11:\"tagid_value\";a:0:{}s:11:\"description\";s:47:\"Gives relationship details between two contacts\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:18:\"administer CiviCRM\";s:6:\"groups\";s:0:\"\";s:9:\"domain_id\";i:1;}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',191),(18,1,'Donation Summary Report (Organization)','contribute/organizationSummary','Displays a detailed contribution report for Organization relationships with contributors, as to if contribution done was  from an employee of some organization or from that Organization itself.','access CiviContribute','a:21:{s:6:\"fields\";a:5:{s:17:\"organization_name\";s:1:\"1\";s:12:\"display_name\";s:1:\"1\";s:12:\"total_amount\";s:1:\"1\";s:22:\"contribution_status_id\";s:1:\"1\";s:12:\"receive_date\";s:1:\"1\";}s:20:\"organization_name_op\";s:3:\"has\";s:23:\"organization_name_value\";s:0:\"\";s:23:\"relationship_type_id_op\";s:2:\"eq\";s:26:\"relationship_type_id_value\";s:5:\"4_b_a\";s:21:\"receive_date_relative\";s:1:\"0\";s:17:\"receive_date_from\";s:1:\" \";s:15:\"receive_date_to\";s:1:\" \";s:16:\"total_amount_min\";s:0:\"\";s:16:\"total_amount_max\";s:0:\"\";s:15:\"total_amount_op\";s:3:\"lte\";s:18:\"total_amount_value\";s:0:\"\";s:25:\"contribution_status_id_op\";s:2:\"in\";s:28:\"contribution_status_id_value\";a:1:{i:0;s:1:\"1\";}s:11:\"description\";s:193:\"Displays a detailed contribution report for Organization relationships with contributors, as to if contribution done was  from an employee of some organization or from that Organization itself.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:21:\"access CiviContribute\";s:9:\"parent_id\";s:0:\"\";s:6:\"groups\";s:0:\"\";}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(19,1,'Donation Summary Report (Household)','contribute/householdSummary','Provides a detailed report for Contributions made by contributors(Or Household itself) who are having a relationship with household (For ex a Contributor is Head of Household for some household or is a member of.)','access CiviContribute','a:21:{s:6:\"fields\";a:5:{s:14:\"household_name\";s:1:\"1\";s:12:\"display_name\";s:1:\"1\";s:12:\"total_amount\";s:1:\"1\";s:22:\"contribution_status_id\";s:1:\"1\";s:12:\"receive_date\";s:1:\"1\";}s:17:\"household_name_op\";s:3:\"has\";s:20:\"household_name_value\";s:0:\"\";s:23:\"relationship_type_id_op\";s:2:\"eq\";s:26:\"relationship_type_id_value\";s:5:\"6_b_a\";s:21:\"receive_date_relative\";s:1:\"0\";s:17:\"receive_date_from\";s:1:\" \";s:15:\"receive_date_to\";s:1:\" \";s:16:\"total_amount_min\";s:0:\"\";s:16:\"total_amount_max\";s:0:\"\";s:15:\"total_amount_op\";s:3:\"lte\";s:18:\"total_amount_value\";s:0:\"\";s:25:\"contribution_status_id_op\";s:2:\"in\";s:28:\"contribution_status_id_value\";a:1:{i:0;s:1:\"1\";}s:11:\"description\";s:213:\"Provides a detailed report for Contributions made by contributors(Or Household itself) who are having a relationship with household (For ex a Contributor is Head of Household for some household or is a member of.)\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:21:\"access CiviContribute\";s:9:\"parent_id\";s:0:\"\";s:6:\"groups\";s:0:\"\";}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(20,1,'Top Donors Report','contribute/topDonor','Provides a list of the top donors during a time period you define. You can include as many donors as you want (for example, top 100 of your donors).','access CiviContribute','a:20:{s:6:\"fields\";a:2:{s:12:\"display_name\";s:1:\"1\";s:12:\"total_amount\";s:1:\"1\";}s:21:\"receive_date_relative\";s:9:\"this.year\";s:17:\"receive_date_from\";s:0:\"\";s:15:\"receive_date_to\";s:0:\"\";s:15:\"total_range_min\";s:0:\"\";s:15:\"total_range_max\";s:0:\"\";s:14:\"total_range_op\";s:2:\"eq\";s:17:\"total_range_value\";s:0:\"\";s:23:\"contribution_type_id_op\";s:2:\"in\";s:26:\"contribution_type_id_value\";a:0:{}s:25:\"contribution_status_id_op\";s:2:\"in\";s:28:\"contribution_status_id_value\";a:1:{i:0;s:1:\"1\";}s:6:\"gid_op\";s:2:\"in\";s:9:\"gid_value\";a:0:{}s:11:\"description\";s:148:\"Provides a list of the top donors during a time period you define. You can include as many donors as you want (for example, top 100 of your donors).\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:21:\"access CiviContribute\";s:6:\"groups\";s:0:\"\";}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(21,1,'Pledge Summary Report','pledge/summary','Updates you with your Pledge Summary (if any) such as your pledge status, next payment date, amount, payment due, total amount paid etc.','access CiviPledge','a:25:{s:6:\"fields\";a:4:{s:12:\"display_name\";s:1:\"1\";s:10:\"country_id\";s:1:\"1\";s:6:\"amount\";s:1:\"1\";s:9:\"status_id\";s:1:\"1\";}s:12:\"sort_name_op\";s:3:\"has\";s:15:\"sort_name_value\";s:0:\"\";s:6:\"id_min\";s:0:\"\";s:6:\"id_max\";s:0:\"\";s:5:\"id_op\";s:3:\"lte\";s:8:\"id_value\";s:0:\"\";s:27:\"pledge_create_date_relative\";s:1:\"0\";s:23:\"pledge_create_date_from\";s:0:\"\";s:21:\"pledge_create_date_to\";s:0:\"\";s:17:\"pledge_amount_min\";s:0:\"\";s:17:\"pledge_amount_max\";s:0:\"\";s:16:\"pledge_amount_op\";s:3:\"lte\";s:19:\"pledge_amount_value\";s:0:\"\";s:6:\"sid_op\";s:2:\"in\";s:9:\"sid_value\";a:0:{}s:6:\"gid_op\";s:2:\"in\";s:9:\"gid_value\";a:0:{}s:11:\"description\";s:136:\"Updates you with your Pledge Summary (if any) such as your pledge status, next payment date, amount, payment due, total amount paid etc.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:17:\"access CiviPledge\";s:9:\"parent_id\";s:3:\"174\";s:6:\"groups\";s:0:\"\";}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(22,1,'Pledged But not Paid Report','pledge/pbnp','Pledged but not Paid Report','access CiviPledge','a:15:{s:6:\"fields\";a:6:{s:12:\"display_name\";s:1:\"1\";s:18:\"pledge_create_date\";s:1:\"1\";s:6:\"amount\";s:1:\"1\";s:14:\"scheduled_date\";s:1:\"1\";s:10:\"country_id\";s:1:\"1\";s:5:\"email\";s:1:\"1\";}s:27:\"pledge_create_date_relative\";s:1:\"0\";s:23:\"pledge_create_date_from\";s:0:\"\";s:21:\"pledge_create_date_to\";s:0:\"\";s:23:\"contribution_type_id_op\";s:2:\"in\";s:26:\"contribution_type_id_value\";a:0:{}s:6:\"gid_op\";s:2:\"in\";s:9:\"gid_value\";a:0:{}s:11:\"description\";s:27:\"Pledged but not Paid Report\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:17:\"access CiviPledge\";s:9:\"parent_id\";s:3:\"174\";s:6:\"groups\";s:0:\"\";}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(23,1,'All Activities, Last 7 Days','activity','Lists all activity records created over the last 7 days.','access all cases and activities','a:28:{s:6:\"fields\";a:7:{s:14:\"contact_source\";s:1:\"1\";s:16:\"contact_assignee\";s:1:\"1\";s:14:\"contact_target\";s:1:\"1\";s:16:\"activity_type_id\";s:1:\"1\";s:7:\"subject\";s:1:\"1\";s:18:\"activity_date_time\";s:1:\"1\";s:9:\"status_id\";s:1:\"1\";}s:17:\"contact_source_op\";s:3:\"has\";s:20:\"contact_source_value\";s:0:\"\";s:19:\"contact_assignee_op\";s:3:\"has\";s:22:\"contact_assignee_value\";s:0:\"\";s:17:\"contact_target_op\";s:3:\"has\";s:20:\"contact_target_value\";s:0:\"\";s:27:\"activity_date_time_relative\";s:11:\"ending.week\";s:23:\"activity_date_time_from\";s:0:\"\";s:21:\"activity_date_time_to\";s:0:\"\";s:10:\"subject_op\";s:3:\"has\";s:13:\"subject_value\";s:0:\"\";s:19:\"activity_type_id_op\";s:2:\"in\";s:22:\"activity_type_id_value\";a:0:{}s:12:\"status_id_op\";s:2:\"in\";s:15:\"status_id_value\";a:0:{}s:12:\"custom_43_op\";s:2:\"in\";s:15:\"custom_43_value\";a:0:{}s:12:\"custom_44_op\";s:2:\"in\";s:15:\"custom_44_value\";a:0:{}s:9:\"group_bys\";a:1:{s:18:\"activity_date_time\";s:1:\"1\";}s:11:\"description\";s:56:\"Lists all activity records created over the last 7 days.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:31:\"access all cases and activities\";s:6:\"groups\";s:0:\"\";s:9:\"domain_id\";i:1;}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',199),(24,1,'Emails Received, Last 7 Days','activity','Emails received, either manually entered or retrieved from inbox polling, over the last 7 days.','access all cases and activities','a:28:{s:6:\"fields\";a:6:{s:14:\"contact_source\";s:1:\"1\";s:16:\"contact_assignee\";s:1:\"1\";s:14:\"contact_target\";s:1:\"1\";s:7:\"subject\";s:1:\"1\";s:18:\"activity_date_time\";s:1:\"1\";s:9:\"status_id\";s:1:\"1\";}s:17:\"contact_source_op\";s:3:\"has\";s:20:\"contact_source_value\";s:0:\"\";s:19:\"contact_assignee_op\";s:3:\"has\";s:22:\"contact_assignee_value\";s:0:\"\";s:17:\"contact_target_op\";s:3:\"has\";s:20:\"contact_target_value\";s:0:\"\";s:27:\"activity_date_time_relative\";s:11:\"ending.week\";s:23:\"activity_date_time_from\";s:0:\"\";s:21:\"activity_date_time_to\";s:0:\"\";s:10:\"subject_op\";s:3:\"has\";s:13:\"subject_value\";s:0:\"\";s:19:\"activity_type_id_op\";s:2:\"in\";s:22:\"activity_type_id_value\";a:1:{i:0;s:2:\"12\";}s:12:\"status_id_op\";s:2:\"in\";s:15:\"status_id_value\";a:0:{}s:12:\"custom_43_op\";s:2:\"in\";s:15:\"custom_43_value\";a:0:{}s:12:\"custom_44_op\";s:2:\"in\";s:15:\"custom_44_value\";a:0:{}s:9:\"group_bys\";a:1:{s:18:\"activity_date_time\";s:1:\"1\";}s:11:\"description\";s:95:\"Emails received, either manually entered or retrieved from inbox polling, over the last 7 days.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:31:\"access all cases and activities\";s:6:\"groups\";s:0:\"\";s:9:\"domain_id\";i:1;}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',200),(25,1,'Bookkeeping Transactions Report','contribute/bookkeeping','Shows Bookkeeping Transactions Report','access CiviContribute','a:26:{s:6:\"fields\";a:10:{s:12:\"display_name\";s:1:\"1\";s:12:\"receive_date\";s:1:\"1\";s:12:\"total_amount\";s:1:\"1\";s:20:\"contribution_type_id\";s:1:\"1\";s:7:\"trxn_id\";s:1:\"1\";s:10:\"invoice_id\";s:1:\"1\";s:12:\"check_number\";s:1:\"1\";s:21:\"payment_instrument_id\";s:1:\"1\";s:22:\"contribution_status_id\";s:1:\"1\";s:2:\"id\";s:1:\"1\";}s:12:\"sort_name_op\";s:3:\"has\";s:15:\"sort_name_value\";s:0:\"\";s:6:\"id_min\";s:0:\"\";s:6:\"id_max\";s:0:\"\";s:5:\"id_op\";s:3:\"lte\";s:8:\"id_value\";s:0:\"\";s:21:\"receive_date_relative\";s:1:\"0\";s:17:\"receive_date_from\";s:0:\"\";s:15:\"receive_date_to\";s:0:\"\";s:23:\"contribution_type_id_op\";s:2:\"in\";s:26:\"contribution_type_id_value\";a:0:{}s:25:\"contribution_status_id_op\";s:2:\"in\";s:28:\"contribution_status_id_value\";a:1:{i:0;s:1:\"1\";}s:16:\"total_amount_min\";s:0:\"\";s:16:\"total_amount_max\";s:0:\"\";s:15:\"total_amount_op\";s:3:\"lte\";s:18:\"total_amount_value\";s:0:\"\";s:11:\"description\";s:37:\"Shows Bookkeeping Transactions Report\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:1:\"0\";s:9:\"parent_id\";s:0:\"\";s:6:\"groups\";s:0:\"\";s:9:\"domain_id\";i:1;} ',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(26,1,'Grant Report (Detail)','grant/detail','Grant Report Detail','access CiviGrant','a:37:{s:6:\"fields\";a:2:{s:12:\"display_name\";s:1:\"1\";s:25:\"application_received_date\";s:1:\"1\";}s:15:\"display_name_op\";s:3:\"has\";s:18:\"display_name_value\";s:0:\"\";s:12:\"gender_id_op\";s:2:\"in\";s:15:\"gender_id_value\";a:0:{}s:13:\"country_id_op\";s:2:\"in\";s:16:\"country_id_value\";a:0:{}s:20:\"state_province_id_op\";s:2:\"in\";s:23:\"state_province_id_value\";a:0:{}s:13:\"grant_type_op\";s:2:\"in\";s:16:\"grant_type_value\";a:0:{}s:12:\"status_id_op\";s:2:\"in\";s:15:\"status_id_value\";a:0:{}s:18:\"amount_granted_min\";s:0:\"\";s:18:\"amount_granted_max\";s:0:\"\";s:17:\"amount_granted_op\";s:3:\"lte\";s:20:\"amount_granted_value\";s:0:\"\";s:20:\"amount_requested_min\";s:0:\"\";s:20:\"amount_requested_max\";s:0:\"\";s:19:\"amount_requested_op\";s:3:\"lte\";s:22:\"amount_requested_value\";s:0:\"\";s:34:\"application_received_date_relative\";s:1:\"0\";s:30:\"application_received_date_from\";s:0:\"\";s:28:\"application_received_date_to\";s:0:\"\";s:28:\"money_transfer_date_relative\";s:1:\"0\";s:24:\"money_transfer_date_from\";s:0:\"\";s:22:\"money_transfer_date_to\";s:0:\"\";s:23:\"grant_due_date_relative\";s:1:\"0\";s:19:\"grant_due_date_from\";s:0:\"\";s:17:\"grant_due_date_to\";s:0:\"\";s:11:\"description\";s:19:\"Grant Report Detail\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:16:\"access CiviGrant\";s:6:\"groups\";s:0:\"\";s:9:\"domain_id\";i:1;}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(27,1,'Mail Bounce Report','Mailing/bounce','Bounce Report for mailings','access CiviMail','a:39:{s:6:\"fields\";a:5:{s:2:\"id\";s:1:\"1\";s:10:\"first_name\";s:1:\"1\";s:9:\"last_name\";s:1:\"1\";s:11:\"bounce_name\";s:1:\"1\";s:5:\"email\";s:1:\"1\";}s:12:\"sort_name_op\";s:3:\"has\";s:15:\"sort_name_value\";s:0:\"\";s:9:\"source_op\";s:3:\"has\";s:12:\"source_value\";s:0:\"\";s:6:\"id_min\";s:0:\"\";s:6:\"id_max\";s:0:\"\";s:5:\"id_op\";s:3:\"lte\";s:8:\"id_value\";s:0:\"\";s:15:\"mailing_name_op\";s:2:\"in\";s:18:\"mailing_name_value\";a:0:{}s:19:\"bounce_type_name_op\";s:2:\"eq\";s:22:\"bounce_type_name_value\";s:0:\"\";s:6:\"gid_op\";s:2:\"in\";s:9:\"gid_value\";a:0:{}s:8:\"tagid_op\";s:2:\"in\";s:11:\"tagid_value\";a:0:{}s:11:\"custom_1_op\";s:2:\"in\";s:14:\"custom_1_value\";a:0:{}s:11:\"custom_2_op\";s:2:\"in\";s:14:\"custom_2_value\";a:0:{}s:17:\"custom_3_relative\";s:1:\"0\";s:13:\"custom_3_from\";s:0:\"\";s:11:\"custom_3_to\";s:0:\"\";s:17:\"custom_9_relative\";s:1:\"0\";s:13:\"custom_9_from\";s:0:\"\";s:11:\"custom_9_to\";s:0:\"\";s:12:\"custom_10_op\";s:2:\"in\";s:15:\"custom_10_value\";a:0:{}s:12:\"custom_11_op\";s:3:\"has\";s:15:\"custom_11_value\";s:0:\"\";s:11:\"description\";s:26:\"Bounce Report for mailings\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:15:\"access CiviMail\";s:6:\"groups\";s:0:\"\";s:6:\"charts\";s:0:\"\";s:9:\"domain_id\";i:1;}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(28,1,'Mail Summary Report','Mailing/summary','Summary statistics for mailings','access CiviMail','a:25:{s:6:\"fields\";a:5:{s:4:\"name\";s:1:\"1\";s:11:\"queue_count\";s:1:\"1\";s:15:\"delivered_count\";s:1:\"1\";s:12:\"bounce_count\";s:1:\"1\";s:10:\"open_count\";s:1:\"1\";}s:15:\"is_completed_op\";s:2:\"eq\";s:18:\"is_completed_value\";s:1:\"1\";s:15:\"mailing_name_op\";s:2:\"in\";s:18:\"mailing_name_value\";a:0:{}s:9:\"status_op\";s:3:\"has\";s:12:\"status_value\";s:8:\"Complete\";s:11:\"is_test_min\";s:0:\"\";s:11:\"is_test_max\";s:0:\"\";s:10:\"is_test_op\";s:3:\"lte\";s:13:\"is_test_value\";s:1:\"0\";s:19:\"start_date_relative\";s:9:\"this.year\";s:15:\"start_date_from\";s:0:\"\";s:13:\"start_date_to\";s:0:\"\";s:17:\"end_date_relative\";s:9:\"this.year\";s:13:\"end_date_from\";s:0:\"\";s:11:\"end_date_to\";s:0:\"\";s:11:\"description\";s:31:\"Summary statistics for mailings\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:15:\"access CiviMail\";s:6:\"groups\";s:0:\"\";s:6:\"charts\";s:0:\"\";s:9:\"domain_id\";i:1;}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(29,1,'Mail Opened Report','Mailing/opened','Display contacts who opened emails from a mailing','access CiviMail','a:37:{s:6:\"fields\";a:4:{s:2:\"id\";s:1:\"1\";s:10:\"first_name\";s:1:\"1\";s:9:\"last_name\";s:1:\"1\";s:5:\"email\";s:1:\"1\";}s:12:\"sort_name_op\";s:3:\"has\";s:15:\"sort_name_value\";s:0:\"\";s:9:\"source_op\";s:3:\"has\";s:12:\"source_value\";s:0:\"\";s:6:\"id_min\";s:0:\"\";s:6:\"id_max\";s:0:\"\";s:5:\"id_op\";s:3:\"lte\";s:8:\"id_value\";s:0:\"\";s:15:\"mailing_name_op\";s:2:\"in\";s:18:\"mailing_name_value\";a:0:{}s:6:\"gid_op\";s:2:\"in\";s:9:\"gid_value\";a:0:{}s:8:\"tagid_op\";s:2:\"in\";s:11:\"tagid_value\";a:0:{}s:11:\"custom_1_op\";s:2:\"in\";s:14:\"custom_1_value\";a:0:{}s:11:\"custom_2_op\";s:2:\"in\";s:14:\"custom_2_value\";a:0:{}s:17:\"custom_3_relative\";s:1:\"0\";s:13:\"custom_3_from\";s:0:\"\";s:11:\"custom_3_to\";s:0:\"\";s:17:\"custom_9_relative\";s:1:\"0\";s:13:\"custom_9_from\";s:0:\"\";s:11:\"custom_9_to\";s:0:\"\";s:12:\"custom_10_op\";s:2:\"in\";s:15:\"custom_10_value\";a:0:{}s:12:\"custom_11_op\";s:3:\"has\";s:15:\"custom_11_value\";s:0:\"\";s:11:\"description\";s:49:\"Display contacts who opened emails from a mailing\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:15:\"access CiviMail\";s:6:\"groups\";s:0:\"\";s:6:\"charts\";s:0:\"\";s:9:\"domain_id\";i:1;}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(30,1,'Mail Clickthrough Report','Mailing/clicks','Display clicks from each mailing','access CiviMail','a:37:{s:6:\"fields\";a:5:{s:2:\"id\";s:1:\"1\";s:10:\"first_name\";s:1:\"1\";s:9:\"last_name\";s:1:\"1\";s:5:\"email\";s:1:\"1\";s:3:\"url\";s:1:\"1\";}s:12:\"sort_name_op\";s:3:\"has\";s:15:\"sort_name_value\";s:0:\"\";s:9:\"source_op\";s:3:\"has\";s:12:\"source_value\";s:0:\"\";s:6:\"id_min\";s:0:\"\";s:6:\"id_max\";s:0:\"\";s:5:\"id_op\";s:3:\"lte\";s:8:\"id_value\";s:0:\"\";s:15:\"mailing_name_op\";s:2:\"in\";s:18:\"mailing_name_value\";a:0:{}s:6:\"gid_op\";s:2:\"in\";s:9:\"gid_value\";a:0:{}s:8:\"tagid_op\";s:2:\"in\";s:11:\"tagid_value\";a:0:{}s:11:\"custom_1_op\";s:2:\"in\";s:14:\"custom_1_value\";a:0:{}s:11:\"custom_2_op\";s:2:\"in\";s:14:\"custom_2_value\";a:0:{}s:17:\"custom_3_relative\";s:1:\"0\";s:13:\"custom_3_from\";s:0:\"\";s:11:\"custom_3_to\";s:0:\"\";s:17:\"custom_9_relative\";s:1:\"0\";s:13:\"custom_9_from\";s:0:\"\";s:11:\"custom_9_to\";s:0:\"\";s:12:\"custom_10_op\";s:2:\"in\";s:15:\"custom_10_value\";a:0:{}s:12:\"custom_11_op\";s:3:\"has\";s:15:\"custom_11_value\";s:0:\"\";s:11:\"description\";s:32:\"Display clicks from each mailing\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:15:\"access CiviMail\";s:6:\"groups\";s:0:\"\";s:6:\"charts\";s:0:\"\";s:9:\"domain_id\";i:1;}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL),(31,1,'Grant Report (Statistics)','grant/statistics','Shows statistics for Grants','access CiviGrant','a:45:{s:6:\"fields\";a:3:{s:18:\"summary_statistics\";s:1:\"1\";s:9:\"gender_id\";s:1:\"1\";s:12:\"contact_type\";s:1:\"1\";}s:34:\"application_received_date_relative\";s:1:\"0\";s:30:\"application_received_date_from\";s:0:\"\";s:28:\"application_received_date_to\";s:0:\"\";s:22:\"decision_date_relative\";s:1:\"0\";s:18:\"decision_date_from\";s:0:\"\";s:16:\"decision_date_to\";s:0:\"\";s:28:\"money_transfer_date_relative\";s:1:\"0\";s:24:\"money_transfer_date_from\";s:0:\"\";s:22:\"money_transfer_date_to\";s:0:\"\";s:23:\"grant_due_date_relative\";s:1:\"0\";s:19:\"grant_due_date_from\";s:0:\"\";s:17:\"grant_due_date_to\";s:0:\"\";s:13:\"grant_type_op\";s:2:\"in\";s:16:\"grant_type_value\";a:1:{i:0;s:1:\"1\";}s:12:\"status_id_op\";s:2:\"in\";s:15:\"status_id_value\";a:0:{}s:20:\"amount_requested_min\";s:0:\"\";s:20:\"amount_requested_max\";s:0:\"\";s:19:\"amount_requested_op\";s:3:\"lte\";s:22:\"amount_requested_value\";s:0:\"\";s:18:\"amount_granted_min\";s:0:\"\";s:18:\"amount_granted_max\";s:0:\"\";s:17:\"amount_granted_op\";s:3:\"lte\";s:20:\"amount_granted_value\";s:0:\"\";s:24:\"grant_report_received_op\";s:2:\"eq\";s:27:\"grant_report_received_value\";s:0:\"\";s:13:\"country_id_op\";s:2:\"in\";s:16:\"country_id_value\";a:0:{}s:12:\"region_id_op\";s:2:\"in\";s:15:\"region_id_value\";a:0:{}s:11:\"custom_7_op\";s:2:\"in\";s:14:\"custom_7_value\";a:0:{}s:11:\"custom_9_op\";s:3:\"has\";s:14:\"custom_9_value\";s:0:\"\";s:11:\"custom_8_op\";s:4:\"mhas\";s:14:\"custom_8_value\";a:0:{}s:11:\"description\";s:28:\"Shows statistics for Grants.\";s:13:\"email_subject\";s:0:\"\";s:8:\"email_to\";s:0:\"\";s:8:\"email_cc\";s:0:\"\";s:10:\"permission\";s:16:\"access CiviGrant\";s:9:\"parent_id\";s:0:\"\";s:6:\"groups\";s:0:\"\";s:9:\"domain_id\";i:1;}',NULL,NULL,NULL,NULL,'<html>\n  <head>\n    <title>CiviCRM Report</title>\n    <style type=\"text/css\">@import url(/sites/all/modules/civicrm/css/print.css);</style>\n  </head>\n  <body><div id=\"crm-container\">','<p>New York State Senate :: BlueBird</p></div></body>\n</html>',NULL);
/*!40000 ALTER TABLE `civicrm_report_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_saved_search`
--

DROP TABLE IF EXISTS `civicrm_saved_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_saved_search` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Saved search ID',
  `form_values` text COLLATE utf8_unicode_ci COMMENT 'Submitted form values for this search',
  `mapping_id` int(10) unsigned DEFAULT NULL COMMENT 'Foreign key to civicrm_mapping used for saved search-builder searches.',
  `search_custom_id` int(10) unsigned DEFAULT NULL COMMENT 'Foreign key to civicrm_option value table used for saved custom searches.',
  `where_clause` text COLLATE utf8_unicode_ci COMMENT 'the sql where clause if a saved search acl',
  `select_tables` text COLLATE utf8_unicode_ci COMMENT 'the tables to be included in a select data',
  `where_tables` text COLLATE utf8_unicode_ci COMMENT 'the tables to be included in the count statement',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_saved_search_mapping_id` (`mapping_id`),
  CONSTRAINT `FK_civicrm_saved_search_mapping_id` FOREIGN KEY (`mapping_id`) REFERENCES `civicrm_mapping` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_saved_search`
--

LOCK TABLES `civicrm_saved_search` WRITE;
/*!40000 ALTER TABLE `civicrm_saved_search` DISABLE KEYS */;
INSERT INTO `civicrm_saved_search` VALUES (1,'a:38:{s:5:\"qfKey\";s:37:\"41e6ad12c379c55c9fdf1a0a2acbd39b_1105\";s:12:\"hidden_basic\";s:1:\"1\";s:9:\"sort_name\";s:0:\"\";s:5:\"email\";s:0:\"\";s:14:\"contact_source\";s:0:\"\";s:9:\"job_title\";s:0:\"\";s:7:\"uf_user\";s:0:\"\";s:11:\"uf_group_id\";s:0:\"\";s:7:\"privacy\";a:6:{s:12:\"do_not_phone\";s:0:\"\";s:12:\"do_not_email\";s:0:\"\";s:11:\"do_not_mail\";s:0:\"\";s:10:\"do_not_sms\";s:0:\"\";s:12:\"do_not_trade\";s:0:\"\";s:13:\"do_not_toggle\";s:0:\"\";}s:13:\"email_on_hold\";a:1:{s:7:\"on_hold\";s:0:\"\";}s:30:\"preferred_communication_method\";a:5:{i:1;s:0:\"\";i:2;s:0:\"\";i:3;s:0:\"\";i:4;s:0:\"\";i:5;s:0:\"\";}s:15:\"hidden_location\";s:1:\"1\";s:14:\"street_address\";s:0:\"\";s:15:\"postal_code_low\";s:0:\"\";s:16:\"postal_code_high\";s:0:\"\";s:4:\"city\";s:6:\"Albany\";s:11:\"postal_code\";s:0:\"\";s:14:\"state_province\";a:0:{}s:9:\"custom_46\";s:0:\"\";s:9:\"custom_47\";s:0:\"\";s:9:\"custom_48\";s:0:\"\";s:9:\"custom_49\";s:0:\"\";s:9:\"custom_50\";s:0:\"\";s:9:\"custom_51\";s:0:\"\";s:9:\"custom_52\";s:0:\"\";s:9:\"custom_53\";s:0:\"\";s:9:\"custom_54\";s:0:\"\";s:9:\"custom_55\";s:0:\"\";s:19:\"hidden_demographics\";s:1:\"1\";s:6:\"gender\";s:0:\"\";s:14:\"birth_date_low\";s:0:\"\";s:15:\"birth_date_high\";s:0:\"\";s:17:\"deceased_date_low\";s:0:\"\";s:18:\"deceased_date_high\";s:0:\"\";s:4:\"task\";s:2:\"13\";s:8:\"radio_ts\";s:6:\"ts_all\";s:9:\"mark_x_34\";s:1:\"1\";s:9:\"mark_x_50\";s:1:\"1\";}',NULL,NULL,' ( LOWER(civicrm_address.city) = \'albany\' ) ','a:9:{s:15:\"civicrm_contact\";i:1;s:15:\"civicrm_address\";i:1;s:22:\"civicrm_state_province\";i:1;s:15:\"civicrm_country\";i:1;s:13:\"civicrm_email\";i:1;s:13:\"civicrm_phone\";i:1;s:10:\"civicrm_im\";i:1;s:19:\"civicrm_worldregion\";i:1;s:6:\"gender\";i:1;}','a:2:{s:15:\"civicrm_contact\";i:1;s:15:\"civicrm_address\";i:1;}'),(2,'a:36:{s:5:\"qfKey\";s:37:\"b751a4ac138e965a5c78e53cc21aed24_1530\";s:12:\"hidden_basic\";s:1:\"1\";s:9:\"sort_name\";s:0:\"\";s:5:\"email\";s:0:\"\";s:14:\"contact_source\";s:0:\"\";s:9:\"job_title\";s:0:\"\";s:7:\"uf_user\";s:0:\"\";s:11:\"uf_group_id\";s:0:\"\";s:7:\"privacy\";a:6:{s:12:\"do_not_phone\";s:0:\"\";s:12:\"do_not_email\";s:0:\"\";s:11:\"do_not_mail\";s:0:\"\";s:10:\"do_not_sms\";s:0:\"\";s:12:\"do_not_trade\";s:0:\"\";s:13:\"do_not_toggle\";s:0:\"\";}s:13:\"email_on_hold\";a:1:{s:7:\"on_hold\";s:0:\"\";}s:30:\"preferred_communication_method\";a:5:{i:1;s:0:\"\";i:2;s:0:\"\";i:3;s:0:\"\";i:4;s:0:\"\";i:5;s:0:\"\";}s:15:\"hidden_location\";s:1:\"1\";s:14:\"street_address\";s:0:\"\";s:15:\"postal_code_low\";s:0:\"\";s:16:\"postal_code_high\";s:0:\"\";s:4:\"city\";s:6:\"albany\";s:11:\"postal_code\";s:0:\"\";s:14:\"state_province\";a:0:{}s:9:\"custom_46\";s:0:\"\";s:9:\"custom_47\";s:0:\"\";s:9:\"custom_48\";s:0:\"\";s:9:\"custom_49\";s:0:\"\";s:9:\"custom_50\";s:0:\"\";s:9:\"custom_51\";s:0:\"\";s:9:\"custom_52\";s:0:\"\";s:9:\"custom_53\";s:0:\"\";s:9:\"custom_54\";s:0:\"\";s:9:\"custom_55\";s:0:\"\";s:19:\"hidden_demographics\";s:1:\"1\";s:6:\"gender\";s:0:\"\";s:14:\"birth_date_low\";s:0:\"\";s:15:\"birth_date_high\";s:0:\"\";s:17:\"deceased_date_low\";s:0:\"\";s:18:\"deceased_date_high\";s:0:\"\";s:4:\"task\";s:2:\"13\";s:8:\"radio_ts\";s:6:\"ts_all\";}',NULL,NULL,' ( LOWER(civicrm_address.city) = \'albany\' ) ','a:9:{s:15:\"civicrm_contact\";i:1;s:15:\"civicrm_address\";i:1;s:22:\"civicrm_state_province\";i:1;s:15:\"civicrm_country\";i:1;s:13:\"civicrm_email\";i:1;s:13:\"civicrm_phone\";i:1;s:10:\"civicrm_im\";i:1;s:19:\"civicrm_worldregion\";i:1;s:6:\"gender\";i:1;}','a:2:{s:15:\"civicrm_contact\";i:1;s:15:\"civicrm_address\";i:1;}'),(3,'a:15:{s:5:\"qfKey\";s:37:\"5796bf47b9b2cf2db6803190df874b32_8559\";s:12:\"hidden_basic\";s:1:\"1\";s:12:\"contact_type\";a:1:{s:10:\"Individual\";s:1:\"1\";}s:5:\"group\";a:1:{i:9;s:1:\"1\";}s:9:\"sort_name\";s:0:\"\";s:5:\"email\";s:0:\"\";s:14:\"contact_source\";s:0:\"\";s:9:\"job_title\";s:0:\"\";s:7:\"uf_user\";s:0:\"\";s:11:\"uf_group_id\";s:0:\"\";s:7:\"privacy\";a:6:{s:12:\"do_not_phone\";s:0:\"\";s:12:\"do_not_email\";s:0:\"\";s:11:\"do_not_mail\";s:0:\"\";s:10:\"do_not_sms\";s:0:\"\";s:12:\"do_not_trade\";s:0:\"\";s:13:\"do_not_toggle\";s:0:\"\";}s:13:\"email_on_hold\";a:1:{s:7:\"on_hold\";s:0:\"\";}s:30:\"preferred_communication_method\";a:5:{i:1;s:0:\"\";i:2;s:0:\"\";i:3;s:0:\"\";i:4;s:0:\"\";i:5;s:0:\"\";}s:4:\"task\";s:2:\"13\";s:8:\"radio_ts\";s:6:\"ts_sel\";}',NULL,NULL,' ( contact_a.contact_type IN (\'Individual\') AND `civicrm_group_contact-9`.group_id IN ( 9 ) AND `civicrm_group_contact-9`.status IN (\"Added\") ) ','a:10:{s:15:\"civicrm_contact\";i:1;s:15:\"civicrm_address\";i:1;s:22:\"civicrm_state_province\";i:1;s:15:\"civicrm_country\";i:1;s:13:\"civicrm_email\";i:1;s:13:\"civicrm_phone\";i:1;s:10:\"civicrm_im\";i:1;s:19:\"civicrm_worldregion\";i:1;s:25:\"`civicrm_group_contact-9`\";s:114:\" LEFT JOIN civicrm_group_contact `civicrm_group_contact-9` ON contact_a.id = `civicrm_group_contact-9`.contact_id \";s:6:\"gender\";i:1;}','a:2:{s:15:\"civicrm_contact\";i:1;s:25:\"`civicrm_group_contact-9`\";s:114:\" LEFT JOIN civicrm_group_contact `civicrm_group_contact-9` ON contact_a.id = `civicrm_group_contact-9`.contact_id \";}'),(4,'a:36:{s:5:\"qfKey\";s:37:\"b751a4ac138e965a5c78e53cc21aed24_4564\";s:12:\"hidden_basic\";s:1:\"1\";s:9:\"sort_name\";s:0:\"\";s:5:\"email\";s:0:\"\";s:14:\"contact_source\";s:0:\"\";s:9:\"job_title\";s:0:\"\";s:7:\"uf_user\";s:0:\"\";s:11:\"uf_group_id\";s:0:\"\";s:7:\"privacy\";a:6:{s:12:\"do_not_phone\";s:0:\"\";s:12:\"do_not_email\";s:0:\"\";s:11:\"do_not_mail\";s:0:\"\";s:10:\"do_not_sms\";s:0:\"\";s:12:\"do_not_trade\";s:0:\"\";s:13:\"do_not_toggle\";s:0:\"\";}s:13:\"email_on_hold\";a:1:{s:7:\"on_hold\";s:0:\"\";}s:30:\"preferred_communication_method\";a:5:{i:1;s:0:\"\";i:2;s:0:\"\";i:3;s:0:\"\";i:4;s:0:\"\";i:5;s:0:\"\";}s:15:\"hidden_location\";s:1:\"1\";s:14:\"street_address\";s:0:\"\";s:15:\"postal_code_low\";s:0:\"\";s:16:\"postal_code_high\";s:0:\"\";s:4:\"city\";s:6:\"albany\";s:11:\"postal_code\";s:0:\"\";s:14:\"state_province\";a:0:{}s:9:\"custom_46\";s:0:\"\";s:9:\"custom_47\";s:0:\"\";s:9:\"custom_48\";s:0:\"\";s:9:\"custom_49\";s:0:\"\";s:9:\"custom_50\";s:0:\"\";s:9:\"custom_51\";s:0:\"\";s:9:\"custom_52\";s:0:\"\";s:9:\"custom_53\";s:0:\"\";s:9:\"custom_54\";s:0:\"\";s:9:\"custom_55\";s:0:\"\";s:19:\"hidden_demographics\";s:1:\"1\";s:6:\"gender\";s:0:\"\";s:14:\"birth_date_low\";s:0:\"\";s:15:\"birth_date_high\";s:0:\"\";s:17:\"deceased_date_low\";s:0:\"\";s:18:\"deceased_date_high\";s:0:\"\";s:4:\"task\";s:2:\"13\";s:8:\"radio_ts\";s:6:\"ts_all\";}',NULL,NULL,' ( LOWER(civicrm_address.city) = \'albany\' ) ','a:9:{s:15:\"civicrm_contact\";i:1;s:15:\"civicrm_address\";i:1;s:22:\"civicrm_state_province\";i:1;s:15:\"civicrm_country\";i:1;s:13:\"civicrm_email\";i:1;s:13:\"civicrm_phone\";i:1;s:10:\"civicrm_im\";i:1;s:19:\"civicrm_worldregion\";i:1;s:6:\"gender\";i:1;}','a:2:{s:15:\"civicrm_contact\";i:1;s:15:\"civicrm_address\";i:1;}'),(5,'a:7:{s:5:\"qfKey\";s:37:\"0115d58ba08db0ff037fa76a39374c60_3224\";s:6:\"mapper\";a:4:{i:1;a:1:{i:0;a:2:{i:0;s:10:\"Individual\";i:1;s:11:\"is_deceased\";}}i:2;a:1:{i:0;a:2:{i:0;s:10:\"Individual\";i:1;s:11:\"do_not_mail\";}}i:3;a:1:{i:0;a:2:{i:0;s:9:\"Household\";i:1;s:11:\"do_not_mail\";}}i:4;a:1:{i:0;a:2:{i:0;s:12:\"Organization\";i:1;s:11:\"do_not_mail\";}}}s:8:\"operator\";a:4:{i:1;a:1:{i:0;s:1:\"=\";}i:2;a:1:{i:0;s:1:\"=\";}i:3;a:1:{i:0;s:1:\"=\";}i:4;a:1:{i:0;s:1:\"=\";}}s:5:\"value\";a:4:{i:1;a:1:{i:0;s:1:\"1\";}i:2;a:1:{i:0;s:1:\"1\";}i:3;a:1:{i:0;s:1:\"1\";}i:4;a:1:{i:0;s:1:\"1\";}}s:4:\"task\";s:2:\"13\";s:8:\"radio_ts\";s:6:\"ts_all\";s:11:\"uf_group_id\";s:2:\"11\";}',5,NULL,' (  ( contact_a.is_deceased = 1 AND contact_a.contact_type IN (\'Individual\') )  OR  ( contact_a.do_not_mail = 1 AND contact_a.contact_type IN (\'Individual\') )  OR  ( contact_a.do_not_mail = 1 AND contact_a.contact_type IN (\'Household\') )  OR  ( contact_a.do_not_mail = 1 AND contact_a.contact_type IN (\'Organization\') )  ) ','a:11:{s:15:\"civicrm_contact\";i:1;s:15:\"civicrm_address\";i:1;s:22:\"civicrm_state_province\";i:1;s:15:\"civicrm_country\";i:1;s:13:\"civicrm_email\";i:1;s:13:\"civicrm_phone\";i:1;s:10:\"civicrm_im\";i:1;s:19:\"civicrm_worldregion\";i:1;s:6:\"gender\";i:1;s:17:\"individual_prefix\";i:1;s:17:\"individual_suffix\";i:1;}','a:1:{s:15:\"civicrm_contact\";i:1;}');
/*!40000 ALTER TABLE `civicrm_saved_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_state_province`
--

DROP TABLE IF EXISTS `civicrm_state_province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_state_province` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'State / Province ID',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name of State / Province',
  `abbreviation` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '2-4 Character Abbreviation of State / Province',
  `country_id` int(10) unsigned NOT NULL COMMENT 'ID of Country that State / Province belong',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name_country_id` (`name`,`country_id`),
  KEY `FK_civicrm_state_province_country_id` (`country_id`),
  CONSTRAINT `FK_civicrm_state_province_country_id` FOREIGN KEY (`country_id`) REFERENCES `civicrm_country` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10055 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_state_province`
--

LOCK TABLES `civicrm_state_province` WRITE;
/*!40000 ALTER TABLE `civicrm_state_province` DISABLE KEYS */;
INSERT INTO `civicrm_state_province` VALUES (1000,'Alabama','AL',1228),(1001,'Alaska','AK',1228),(1002,'Arizona','AZ',1228),(1003,'Arkansas','AR',1228),(1004,'California','CA',1228),(1005,'Colorado','CO',1228),(1006,'Connecticut','CT',1228),(1007,'Delaware','DE',1228),(1008,'Florida','FL',1228),(1009,'Georgia','GA',1228),(1010,'Hawaii','HI',1228),(1011,'Idaho','ID',1228),(1012,'Illinois','IL',1228),(1013,'Indiana','IN',1228),(1014,'Iowa','IA',1228),(1015,'Kansas','KS',1228),(1016,'Kentucky','KY',1228),(1017,'Louisiana','LA',1228),(1018,'Maine','ME',1228),(1019,'Maryland','MD',1228),(1020,'Massachusetts','MA',1228),(1021,'Michigan','MI',1228),(1022,'Minnesota','MN',1228),(1023,'Mississippi','MS',1228),(1024,'Missouri','MO',1228),(1025,'Montana','MT',1228),(1026,'Nebraska','NE',1228),(1027,'Nevada','NV',1228),(1028,'New Hampshire','NH',1228),(1029,'New Jersey','NJ',1228),(1030,'New Mexico','NM',1228),(1031,'New York','NY',1228),(1032,'North Carolina','NC',1228),(1033,'North Dakota','ND',1228),(1034,'Ohio','OH',1228),(1035,'Oklahoma','OK',1228),(1036,'Oregon','OR',1228),(1037,'Pennsylvania','PA',1228),(1038,'Rhode Island','RI',1228),(1039,'South Carolina','SC',1228),(1040,'South Dakota','SD',1228),(1041,'Tennessee','TN',1228),(1042,'Texas','TX',1228),(1043,'Utah','UT',1228),(1044,'Vermont','VT',1228),(1045,'Virginia','VA',1228),(1046,'Washington','WA',1228),(1047,'West Virginia','WV',1228),(1048,'Wisconsin','WI',1228),(1049,'Wyoming','WY',1228),(1050,'District of Columbia','DC',1228),(1052,'American Samoa','AS',1228),(1053,'Guam','GU',1228),(1055,'Northern Mariana Islands','MP',1228),(1056,'Puerto Rico','PR',1228),(1057,'Virgin Islands','VI',1228),(1058,'United States Minor Outlying Islands','UM',1228),(1059,'Armed Forces Europe','AE',1228),(1060,'Armed Forces Americas','AA',1228),(1061,'Armed Forces Pacific','AP',1228),(1100,'Alberta','AB',1039),(1101,'British Columbia','BC',1039),(1102,'Manitoba','MB',1039),(1103,'New Brunswick','NB',1039),(1104,'Newfoundland and Labrador','NL',1039),(1105,'Northwest Territories','NT',1039),(1106,'Nova Scotia','NS',1039),(1107,'Nunavut','NU',1039),(1108,'Ontario','ON',1039),(1109,'Prince Edward Island','PE',1039),(1110,'Quebec','QC',1039),(1111,'Saskatchewan','SK',1039),(1112,'Yukon Territory','YT',1039),(1200,'Maharashtra','MM',1101),(1201,'Karnataka','KA',1101),(1202,'Andhra Pradesh','AP',1101),(1203,'Arunachal Pradesh','AR',1101),(1204,'Assam','AS',1101),(1205,'Bihar','BR',1101),(1206,'Chhattisgarh','CH',1101),(1207,'Goa','GA',1101),(1208,'Gujarat','GJ',1101),(1209,'Haryana','HR',1101),(1210,'Himachal Pradesh','HP',1101),(1211,'Jammu and Kashmir','JK',1101),(1212,'Jharkhand','JH',1101),(1213,'Kerala','KL',1101),(1214,'Madhya Pradesh','MP',1101),(1215,'Manipur','MN',1101),(1216,'Meghalaya','ML',1101),(1217,'Mizoram','MZ',1101),(1218,'Nagaland','NL',1101),(1219,'Orissa','OR',1101),(1220,'Punjab','PB',1101),(1221,'Rajasthan','RJ',1101),(1222,'Sikkim','SK',1101),(1223,'Tamil Nadu','TN',1101),(1224,'Tripura','TR',1101),(1225,'Uttaranchal','UL',1101),(1226,'Uttar Pradesh','UP',1101),(1227,'West Bengal','WB',1101),(1228,'Andaman and Nicobar Islands','AN',1101),(1229,'Dadra and Nagar Haveli','DN',1101),(1230,'Daman and Diu','DD',1101),(1231,'Delhi','DL',1101),(1232,'Lakshadweep','LD',1101),(1233,'Pondicherry','PY',1101),(1300,'mazowieckie','MZ',1172),(1301,'pomorskie','PM',1172),(1302,'dolnoÅ›lÄ…skie','DS',1172),(1303,'kujawsko-pomorskie','KP',1172),(1304,'lubelskie','LU',1172),(1305,'lubuskie','LB',1172),(1306,'Å‚Ã³dzkie','LD',1172),(1307,'maÅ‚opolskie','MA',1172),(1308,'opolskie','OP',1172),(1309,'podkarpackie','PK',1172),(1310,'podlaskie','PD',1172),(1311,'Å›lÄ…skie','SL',1172),(1312,'Å›wiÄ™tokrzyskie','SK',1172),(1313,'warmiÅ„sko-mazurskie','WN',1172),(1314,'wielkopolskie','WP',1172),(1315,'zachodniopomorskie','ZP',1172),(1500,'Abu Zaby','AZ',1225),(1501,'\'Ajman','AJ',1225),(1502,'Al Fujayrah','FU',1225),(1503,'Ash Shariqah','SH',1225),(1504,'Dubayy','DU',1225),(1505,'Ra\'s al Khaymah','RK',1225),(1506,'Dac Lac','33',1233),(1507,'Umm al Qaywayn','UQ',1225),(1508,'Badakhshan','BDS',1001),(1509,'Badghis','BDG',1001),(1510,'Baghlan','BGL',1001),(1511,'Balkh','BAL',1001),(1512,'Bamian','BAM',1001),(1513,'Farah','FRA',1001),(1514,'Faryab','FYB',1001),(1515,'Ghazni','GHA',1001),(1516,'Ghowr','GHO',1001),(1517,'Helmand','HEL',1001),(1518,'Herat','HER',1001),(1519,'Jowzjan','JOW',1001),(1520,'Kabul','KAB',1001),(1521,'Kandahar','KAN',1001),(1522,'Kapisa','KAP',1001),(1523,'Khowst','KHO',1001),(1524,'Konar','KNR',1001),(1525,'Kondoz','KDZ',1001),(1526,'Laghman','LAG',1001),(1527,'Lowgar','LOW',1001),(1528,'Nangrahar','NAN',1001),(1529,'Nimruz','NIM',1001),(1530,'Nurestan','NUR',1001),(1531,'Oruzgan','ORU',1001),(1532,'Paktia','PIA',1001),(1533,'Paktika','PKA',1001),(1534,'Parwan','PAR',1001),(1535,'Samangan','SAM',1001),(1536,'Sar-e Pol','SAR',1001),(1537,'Takhar','TAK',1001),(1538,'Wardak','WAR',1001),(1539,'Zabol','ZAB',1001),(1540,'Berat','BR',1002),(1541,'BulqizÃ«','BU',1002),(1542,'DelvinÃ«','DL',1002),(1543,'Devoll','DV',1002),(1544,'DibÃ«r','DI',1002),(1545,'DurrÃ«s','DR',1002),(1546,'Elbasan','EL',1002),(1547,'Fier','FR',1002),(1548,'Gramsh','GR',1002),(1549,'GjirokastÃ«r','GJ',1002),(1550,'Has','HA',1002),(1551,'KavajÃ«','KA',1002),(1552,'KolonjÃ«','ER',1002),(1553,'KorÃ§Ã«','KO',1002),(1554,'KrujÃ«','KR',1002),(1555,'KuÃ§ovÃ«','KC',1002),(1556,'KukÃ«s','KU',1002),(1557,'Kurbin','KB',1002),(1558,'LezhÃ«','LE',1002),(1559,'Librazhd','LB',1002),(1560,'LushnjÃ«','LU',1002),(1561,'MalÃ«si e Madhe','MM',1002),(1562,'MallakastÃ«r','MK',1002),(1563,'Mat','MT',1002),(1564,'MirditÃ«','MR',1002),(1565,'Peqin','PQ',1002),(1566,'PÃ«rmet','PR',1002),(1567,'Pogradec','PG',1002),(1568,'PukÃ«','PU',1002),(1569,'SarandÃ«','SR',1002),(1570,'Skrapar','SK',1002),(1571,'ShkodÃ«r','SH',1002),(1572,'TepelenÃ«','TE',1002),(1573,'TiranÃ«','TR',1002),(1574,'TropojÃ«','TP',1002),(1575,'VlorÃ«','VL',1002),(1576,'Erevan','ER',1011),(1577,'Aragacotn','AG',1011),(1578,'Ararat','AR',1011),(1579,'Armavir','AV',1011),(1580,'Gegarkunik\'','GR',1011),(1581,'Kotayk\'','KT',1011),(1582,'Lory','LO',1011),(1583,'Sirak','SH',1011),(1584,'Syunik\'','SU',1011),(1585,'Tavus','TV',1011),(1586,'Vayoc Jor','VD',1011),(1587,'Bengo','BGO',1006),(1588,'Benguela','BGU',1006),(1589,'Bie','BIE',1006),(1590,'Cabinda','CAB',1006),(1591,'Cuando-Cubango','CCU',1006),(1592,'Cuanza Norte','CNO',1006),(1593,'Cuanza Sul','CUS',1006),(1594,'Cunene','CNN',1006),(1595,'Huambo','HUA',1006),(1596,'Huila','HUI',1006),(1597,'Luanda','LUA',1006),(1598,'Lunda Norte','LNO',1006),(1599,'Lunda Sul','LSU',1006),(1600,'Malange','MAL',1006),(1601,'Moxico','MOX',1006),(1602,'Namibe','NAM',1006),(1603,'Uige','UIG',1006),(1604,'Zaire','ZAI',1006),(1605,'Capital federal','C',1010),(1606,'Buenos Aires','B',1010),(1607,'Catamarca','K',1010),(1608,'Cordoba','X',1010),(1609,'Corrientes','W',1010),(1610,'Chaco','H',1010),(1611,'Chubut','U',1010),(1612,'Entre Rios','E',1010),(1613,'Formosa','P',1010),(1614,'Jujuy','Y',1010),(1615,'La Pampa','L',1010),(1616,'Mendoza','M',1010),(1617,'Misiones','N',1010),(1618,'Neuquen','Q',1010),(1619,'Rio Negro','R',1010),(1620,'Salta','A',1010),(1621,'San Juan','J',1010),(1622,'San Luis','D',1010),(1623,'Santa Cruz','Z',1010),(1624,'Santa Fe','S',1010),(1625,'Santiago del Estero','G',1010),(1626,'Tierra del Fuego','V',1010),(1627,'Tucuman','T',1010),(1628,'Burgenland','1',1014),(1629,'KÃ¤rnten','2',1014),(1630,'Niederosterreich','3',1014),(1631,'Oberosterreich','4',1014),(1632,'Salzburg','5',1014),(1633,'Steiermark','6',1014),(1634,'Tirol','7',1014),(1635,'Vorarlberg','8',1014),(1636,'Wien','9',1014),(1637,'Australian Antarctic Territory','AAT',1008),(1638,'Australian Capital Territory','ACT',1013),(1639,'Northern Territory','NT',1013),(1640,'New South Wales','NSW',1013),(1641,'Queensland','QLD',1013),(1642,'South Australia','SA',1013),(1643,'Tasmania','TAS',1013),(1644,'Victoria','VIC',1013),(1645,'Western Australia','WA',1013),(1646,'Naxcivan','NX',1015),(1647,'Ali Bayramli','AB',1015),(1648,'Baki','BA',1015),(1649,'Ganca','GA',1015),(1650,'Lankaran','LA',1015),(1651,'Mingacevir','MI',1015),(1652,'Naftalan','NA',1015),(1653,'Saki','SA',1015),(1654,'Sumqayit','SM',1015),(1655,'Susa','SS',1015),(1656,'Xankandi','XA',1015),(1657,'Yevlax','YE',1015),(1658,'Abseron','ABS',1015),(1659,'Agcabadi','AGC',1015),(1660,'Agdam','AGM',1015),(1661,'Agdas','AGS',1015),(1662,'Agstafa','AGA',1015),(1663,'Agsu','AGU',1015),(1664,'Astara','AST',1015),(1665,'Babak','BAB',1015),(1666,'Balakan','BAL',1015),(1667,'Barda','BAR',1015),(1668,'Beylagan','BEY',1015),(1669,'Bilasuvar','BIL',1015),(1670,'Cabrayll','CAB',1015),(1671,'Calilabad','CAL',1015),(1672,'Culfa','CUL',1015),(1673,'Daskasan','DAS',1015),(1674,'Davaci','DAV',1015),(1675,'Fuzuli','FUZ',1015),(1676,'Gadabay','GAD',1015),(1677,'Goranboy','GOR',1015),(1678,'Goycay','GOY',1015),(1679,'Haciqabul','HAC',1015),(1680,'Imisli','IMI',1015),(1681,'Ismayilli','ISM',1015),(1682,'Kalbacar','KAL',1015),(1683,'Kurdamir','KUR',1015),(1684,'Lacin','LAC',1015),(1685,'Lerik','LER',1015),(1686,'Masalli','MAS',1015),(1687,'Neftcala','NEF',1015),(1688,'Oguz','OGU',1015),(1689,'Ordubad','ORD',1015),(1690,'Qabala','QAB',1015),(1691,'Qax','QAX',1015),(1692,'Qazax','QAZ',1015),(1693,'Qobustan','QOB',1015),(1694,'Quba','QBA',1015),(1695,'Qubadli','QBI',1015),(1696,'Qusar','QUS',1015),(1697,'Saatli','SAT',1015),(1698,'Sabirabad','SAB',1015),(1699,'Sadarak','SAD',1015),(1700,'Sahbuz','SAH',1015),(1701,'Salyan','SAL',1015),(1702,'Samaxi','SMI',1015),(1703,'Samkir','SKR',1015),(1704,'Samux','SMX',1015),(1705,'Sarur','SAR',1015),(1706,'Siyazan','SIY',1015),(1707,'Tartar','TAR',1015),(1708,'Tovuz','TOV',1015),(1709,'Ucar','UCA',1015),(1710,'Xacmaz','XAC',1015),(1711,'Xanlar','XAN',1015),(1712,'Xizi','XIZ',1015),(1713,'Xocali','XCI',1015),(1714,'Xocavand','XVD',1015),(1715,'Yardimli','YAR',1015),(1716,'Zangilan','ZAN',1015),(1717,'Zaqatala','ZAQ',1015),(1718,'Zardab','ZAR',1015),(1719,'Federacija Bosna i Hercegovina','BIH',1026),(1720,'Republika Srpska','SRP',1026),(1721,'Bagerhat zila','05',1017),(1722,'Bandarban zila','01',1017),(1723,'Barguna zila','02',1017),(1724,'Barisal zila','06',1017),(1725,'Bhola zila','07',1017),(1726,'Bogra zila','03',1017),(1727,'Brahmanbaria zila','04',1017),(1728,'Chandpur zila','09',1017),(1729,'Chittagong zila','10',1017),(1730,'Chuadanga zila','12',1017),(1731,'Comilla zila','08',1017),(1732,'Cox\'s Bazar zila','11',1017),(1733,'Dhaka zila','13',1017),(1734,'Dinajpur zila','14',1017),(1735,'Faridpur zila','15',1017),(1736,'Feni zila','16',1017),(1737,'Gaibandha zila','19',1017),(1738,'Gazipur zila','18',1017),(1739,'Gopalganj zila','17',1017),(1740,'Habiganj zila','20',1017),(1741,'Jaipurhat zila','24',1017),(1742,'Jamalpur zila','21',1017),(1743,'Jessore zila','22',1017),(1744,'Jhalakati zila','25',1017),(1745,'Jhenaidah zila','23',1017),(1746,'Khagrachari zila','29',1017),(1747,'Khulna zila','27',1017),(1748,'Kishorganj zila','26',1017),(1749,'Kurigram zila','28',1017),(1750,'Kushtia zila','30',1017),(1751,'Lakshmipur zila','31',1017),(1752,'Lalmonirhat zila','32',1017),(1753,'Madaripur zila','36',1017),(1754,'Magura zila','37',1017),(1755,'Manikganj zila','33',1017),(1756,'Meherpur zila','39',1017),(1757,'Moulvibazar zila','38',1017),(1758,'Munshiganj zila','35',1017),(1759,'Mymensingh zila','34',1017),(1760,'Naogaon zila','48',1017),(1761,'Narail zila','43',1017),(1762,'Narayanganj zila','40',1017),(1763,'Narsingdi zila','42',1017),(1764,'Natore zila','44',1017),(1765,'Nawabganj zila','45',1017),(1766,'Netrakona zila','41',1017),(1767,'Nilphamari zila','46',1017),(1768,'Noakhali zila','47',1017),(1769,'Pabna zila','49',1017),(1770,'Panchagarh zila','52',1017),(1771,'Patuakhali zila','51',1017),(1772,'Pirojpur zila','50',1017),(1773,'Rajbari zila','53',1017),(1774,'Rajshahi zila','54',1017),(1775,'Rangamati zila','56',1017),(1776,'Rangpur zila','55',1017),(1777,'Satkhira zila','58',1017),(1778,'Shariatpur zila','62',1017),(1779,'Sherpur zila','57',1017),(1780,'Sirajganj zila','59',1017),(1781,'Sunamganj zila','61',1017),(1782,'Sylhet zila','60',1017),(1783,'Tangail zila','63',1017),(1784,'Thakurgaon zila','64',1017),(1785,'Antwerpen','VAN',1020),(1786,'Brabant Wallon','WBR',1020),(1787,'Hainaut','WHT',1020),(1788,'Liege','WLG',1020),(1789,'Limburg','VLI',1020),(1790,'Luxembourg','WLX',1020),(1791,'Namur','WNA',1020),(1792,'Oost-Vlaanderen','VOV',1020),(1793,'Vlaams-Brabant','VBR',1020),(1794,'West-Vlaanderen','VWV',1020),(1795,'Bale','BAL',1034),(1796,'Bam','BAM',1034),(1797,'Banwa','BAN',1034),(1798,'Bazega','BAZ',1034),(1799,'Bougouriba','BGR',1034),(1800,'Boulgou','BLG',1034),(1801,'Boulkiemde','BLK',1034),(1802,'Comoe','COM',1034),(1803,'Ganzourgou','GAN',1034),(1804,'Gnagna','GNA',1034),(1805,'Gourma','GOU',1034),(1806,'Houet','HOU',1034),(1807,'Ioba','IOB',1034),(1808,'Kadiogo','KAD',1034),(1809,'Kenedougou','KEN',1034),(1810,'Komondjari','KMD',1034),(1811,'Kompienga','KMP',1034),(1812,'Kossi','KOS',1034),(1813,'Koulpulogo','KOP',1034),(1814,'Kouritenga','KOT',1034),(1815,'Kourweogo','KOW',1034),(1816,'Leraba','LER',1034),(1817,'Loroum','LOR',1034),(1818,'Mouhoun','MOU',1034),(1819,'Nahouri','NAO',1034),(1820,'Namentenga','NAM',1034),(1821,'Nayala','NAY',1034),(1822,'Noumbiel','NOU',1034),(1823,'Oubritenga','OUB',1034),(1824,'Oudalan','OUD',1034),(1825,'Passore','PAS',1034),(1826,'Poni','PON',1034),(1827,'Sanguie','SNG',1034),(1828,'Sanmatenga','SMT',1034),(1829,'Seno','SEN',1034),(1830,'Siasili','SIS',1034),(1831,'Soum','SOM',1034),(1832,'Sourou','SOR',1034),(1833,'Tapoa','TAP',1034),(1834,'Tui','TUI',1034),(1835,'Yagha','YAG',1034),(1836,'Yatenga','YAT',1034),(1837,'Ziro','ZIR',1034),(1838,'Zondoma','ZON',1034),(1839,'Zoundweogo','ZOU',1034),(1840,'Blagoevgrad','01',1033),(1841,'Burgas','02',1033),(1842,'Dobric','08',1033),(1843,'Gabrovo','07',1033),(1844,'Haskovo','26',1033),(1845,'Jambol','28',1033),(1846,'Kardzali','09',1033),(1847,'Kjstendil','10',1033),(1848,'Lovec','11',1033),(1849,'Montana','12',1033),(1850,'Pazardzik','13',1033),(1851,'Pernik','14',1033),(1852,'Pleven','15',1033),(1853,'Plovdiv','16',1033),(1854,'Razgrad','17',1033),(1855,'Ruse','18',1033),(1856,'Silistra','19',1033),(1857,'Sliven','20',1033),(1858,'Smoljan','21',1033),(1859,'Sofia','23',1033),(1860,'Stara Zagora','24',1033),(1861,'Sumen','27',1033),(1862,'Targoviste','25',1033),(1863,'Varna','03',1033),(1864,'Veliko Tarnovo','04',1033),(1865,'Vidin','05',1033),(1866,'Vraca','06',1033),(1867,'Al Hadd','01',1016),(1868,'Al Manamah','03',1016),(1869,'Al Mintaqah al Gharbiyah','10',1016),(1870,'Al Mintagah al Wusta','07',1016),(1871,'Al Mintaqah ash Shamaliyah','05',1016),(1872,'Al Muharraq','02',1016),(1873,'Ar Rifa','09',1016),(1874,'Jidd Hafs','04',1016),(1875,'Madluat Jamad','12',1016),(1876,'Madluat Isa','08',1016),(1877,'Mintaqat Juzur tawar','11',1016),(1878,'Sitrah','06',1016),(1879,'Bubanza','BB',1036),(1880,'Bujumbura','BJ',1036),(1881,'Bururi','BR',1036),(1882,'Cankuzo','CA',1036),(1883,'Cibitoke','CI',1036),(1884,'Gitega','GI',1036),(1885,'Karuzi','KR',1036),(1886,'Kayanza','KY',1036),(1887,'Makamba','MA',1036),(1888,'Muramvya','MU',1036),(1889,'Mwaro','MW',1036),(1890,'Ngozi','NG',1036),(1891,'Rutana','RT',1036),(1892,'Ruyigi','RY',1036),(1893,'Alibori','AL',1022),(1894,'Atakora','AK',1022),(1895,'Atlantique','AQ',1022),(1896,'Borgou','BO',1022),(1897,'Collines','CO',1022),(1898,'Donga','DO',1022),(1899,'Kouffo','KO',1022),(1900,'Littoral','LI',1022),(1901,'Mono','MO',1022),(1902,'Oueme','OU',1022),(1903,'Plateau','PL',1022),(1904,'Zou','ZO',1022),(1905,'Belait','BE',1032),(1906,'Brunei-Muara','BM',1032),(1907,'Temburong','TE',1032),(1908,'Tutong','TU',1032),(1909,'Cochabamba','C',1025),(1910,'Chuquisaca','H',1025),(1911,'El Beni','B',1025),(1912,'La Paz','L',1025),(1913,'Oruro','O',1025),(1914,'Pando','N',1025),(1915,'Potosi','P',1025),(1916,'Tarija','T',1025),(1917,'Acre','AC',1029),(1918,'Alagoas','AL',1029),(1919,'Amazonas','AM',1029),(1920,'Amapa','AP',1029),(1921,'Bahia','BA',1029),(1922,'Ceara','CE',1029),(1923,'Distrito Federal','DF',1029),(1924,'Espirito Santo','ES',1029),(1925,'Fernando de Noronha','FN',1029),(1926,'Goias','GO',1029),(1927,'Maranhao','MA',1029),(1928,'Minas Gerais','MG',1029),(1929,'Mato Grosso do Sul','MS',1029),(1930,'Mato Grosso','MT',1029),(1931,'Para','PA',1029),(1932,'Paraiba','PB',1029),(1933,'Pernambuco','PE',1029),(1934,'Piaui','PI',1029),(1935,'Parana','PR',1029),(1936,'Rio de Janeiro','RJ',1029),(1937,'Rio Grande do Norte','RN',1029),(1938,'Rondonia','RO',1029),(1939,'Roraima','RR',1029),(1940,'Rio Grande do Sul','RS',1029),(1941,'Santa Catarina','SC',1029),(1942,'Sergipe','SE',1029),(1943,'Sao Paulo','SP',1029),(1944,'Tocantins','TO',1029),(1945,'Acklins and Crooked Islands','AC',1212),(1946,'Bimini','BI',1212),(1947,'Cat Island','CI',1212),(1948,'Exuma','EX',1212),(1955,'Inagua','IN',1212),(1957,'Long Island','LI',1212),(1959,'Mayaguana','MG',1212),(1960,'New Providence','NP',1212),(1962,'Ragged Island','RI',1212),(1966,'Bumthang','33',1024),(1967,'Chhukha','12',1024),(1968,'Dagana','22',1024),(1969,'Gasa','GA',1024),(1970,'Ha','13',1024),(1971,'Lhuentse','44',1024),(1972,'Monggar','42',1024),(1973,'Paro','11',1024),(1974,'Pemagatshel','43',1024),(1975,'Punakha','23',1024),(1976,'Samdrup Jongkha','45',1024),(1977,'Samtee','14',1024),(1978,'Sarpang','31',1024),(1979,'Thimphu','15',1024),(1980,'Trashigang','41',1024),(1981,'Trashi Yangtse','TY',1024),(1982,'Trongsa','32',1024),(1983,'Tsirang','21',1024),(1984,'Wangdue Phodrang','24',1024),(1985,'Zhemgang','34',1024),(1986,'Central','CE',1027),(1987,'Ghanzi','GH',1027),(1988,'Kgalagadi','KG',1027),(1989,'Kgatleng','KL',1027),(1990,'Kweneng','KW',1027),(1991,'Ngamiland','NG',1027),(1992,'North-East','NE',1027),(1993,'North-West','NW',1027),(1994,'South-East','SE',1027),(1995,'Southern','SO',1027),(1996,'BrÃ¨sckaja voblasc\'','BR',1019),(1997,'Homel\'skaja voblasc\'','HO',1019),(1998,'Hrodzenskaja voblasc\'','HR',1019),(1999,'MahilÃ«uskaja voblasc\'','MA',1019),(2000,'Minskaja voblasc\'','MI',1019),(2001,'Vicebskaja voblasc\'','VI',1019),(2002,'Belize','BZ',1021),(2003,'Cayo','CY',1021),(2004,'Corozal','CZL',1021),(2005,'Orange Walk','OW',1021),(2006,'Stann Creek','SC',1021),(2007,'Toledo','TOL',1021),(2008,'Kinshasa','KN',1050),(2011,'Equateur','EQ',1050),(2014,'Kasai-Oriental','KE',1050),(2016,'Maniema','MA',1050),(2017,'Nord-Kivu','NK',1050),(2019,'Sud-Kivu','SK',1050),(2020,'Bangui','BGF',1042),(2021,'Bamingui-Bangoran','BB',1042),(2022,'Basse-Kotto','BK',1042),(2023,'Haute-Kotto','HK',1042),(2024,'Haut-Mbomou','HM',1042),(2025,'Kemo','KG',1042),(2026,'Lobaye','LB',1042),(2027,'Mambere-Kadei','HS',1042),(2028,'Mbomou','MB',1042),(2029,'Nana-Grebizi','KB',1042),(2030,'Nana-Mambere','NM',1042),(2031,'Ombella-Mpoko','MP',1042),(2032,'Ouaka','UK',1042),(2033,'Ouham','AC',1042),(2034,'Ouham-Pende','OP',1042),(2035,'Sangha-Mbaere','SE',1042),(2036,'Vakaga','VR',1042),(2037,'Brazzaville','BZV',1051),(2038,'Bouenza','11',1051),(2039,'Cuvette','8',1051),(2040,'Cuvette-Ouest','15',1051),(2041,'Kouilou','5',1051),(2042,'Lekoumou','2',1051),(2043,'Likouala','7',1051),(2044,'Niari','9',1051),(2045,'Plateaux','14',1051),(2046,'Pool','12',1051),(2047,'Sangha','13',1051),(2048,'Aargau','AG',1205),(2049,'Appenzell Innerrhoden','AI',1205),(2050,'Appenzell Ausserrhoden','AR',1205),(2051,'Bern','BE',1205),(2052,'Basel-Landschaft','BL',1205),(2053,'Basel-Stadt','BS',1205),(2054,'Fribourg','FR',1205),(2055,'Geneva','GE',1205),(2056,'Glarus','GL',1205),(2057,'Graubunden','GR',1205),(2058,'Jura','JU',1205),(2059,'Luzern','LU',1205),(2060,'Neuchatel','NE',1205),(2061,'Nidwalden','NW',1205),(2062,'Obwalden','OW',1205),(2063,'Sankt Gallen','SG',1205),(2064,'Schaffhausen','SH',1205),(2065,'Solothurn','SO',1205),(2066,'Schwyz','SZ',1205),(2067,'Thurgau','TG',1205),(2068,'Ticino','TI',1205),(2069,'Uri','UR',1205),(2070,'Vaud','VD',1205),(2071,'Valais','VS',1205),(2072,'Zug','ZG',1205),(2073,'Zurich','ZH',1205),(2074,'18 Montagnes','06',1054),(2075,'Agnebi','16',1054),(2076,'Bas-Sassandra','09',1054),(2077,'Denguele','10',1054),(2078,'Haut-Sassandra','02',1054),(2079,'Lacs','07',1054),(2080,'Lagunes','01',1054),(2081,'Marahoue','12',1054),(2082,'Moyen-Comoe','05',1054),(2083,'Nzi-Comoe','11',1054),(2084,'Savanes','03',1054),(2085,'Sud-Bandama','15',1054),(2086,'Sud-Comoe','13',1054),(2087,'Vallee du Bandama','04',1054),(2088,'Worodouqou','14',1054),(2089,'Zanzan','08',1054),(2090,'Aisen del General Carlos Ibanez del Campo','AI',1044),(2091,'Antofagasta','AN',1044),(2092,'Araucania','AR',1044),(2093,'Atacama','AT',1044),(2094,'Bio-Bio','BI',1044),(2095,'Coquimbo','CO',1044),(2096,'Libertador General Bernardo O\'Higgins','LI',1044),(2097,'Los Lagos','LL',1044),(2098,'Magallanes','MA',1044),(2099,'Maule','ML',1044),(2100,'Region Metropolitana de Santiago','RM',1044),(2101,'Tarapaca','TA',1044),(2102,'Valparaiso','VS',1044),(2103,'Adamaoua','AD',1038),(2104,'Centre','CE',1038),(2105,'East','ES',1038),(2106,'Far North','EN',1038),(2107,'North','NO',1038),(2108,'South','SW',1038),(2109,'South-West','SW',1038),(2110,'West','OU',1038),(2111,'Beijing','11',1045),(2112,'Chongqing','50',1045),(2113,'Shanghai','31',1045),(2114,'Tianjin','12',1045),(2115,'Anhui','34',1045),(2116,'Fujian','35',1045),(2117,'Gansu','62',1045),(2118,'Guangdong','44',1045),(2119,'Guizhou','52',1045),(2120,'Hainan','46',1045),(2121,'Hebei','13',1045),(2122,'Heilongjiang','23',1045),(2123,'Henan','41',1045),(2124,'Hubei','42',1045),(2125,'Hunan','43',1045),(2126,'Jiangsu','32',1045),(2127,'Jiangxi','36',1045),(2128,'Jilin','22',1045),(2129,'Liaoning','21',1045),(2130,'Qinghai','63',1045),(2131,'Shaanxi','61',1045),(2132,'Shandong','37',1045),(2133,'Shanxi','14',1045),(2134,'Sichuan','51',1045),(2135,'Taiwan','71',1045),(2136,'Yunnan','53',1045),(2137,'Zhejiang','33',1045),(2138,'Guangxi','45',1045),(2139,'Neia Mongol (mn)','15',1045),(2140,'Xinjiang','65',1045),(2141,'Xizang','54',1045),(2142,'Hong Kong','91',1045),(2143,'Macau','92',1045),(2144,'Distrito Capital de BogotÃ¡','DC',1048),(2145,'Amazonea','AMA',1048),(2146,'Antioquia','ANT',1048),(2147,'Arauca','ARA',1048),(2148,'AtlÃ¡ntico','ATL',1048),(2149,'BolÃ­var','BOL',1048),(2150,'BoyacÃ¡','BOY',1048),(2151,'Caldea','CAL',1048),(2152,'CaquetÃ¡','CAQ',1048),(2153,'Casanare','CAS',1048),(2154,'Cauca','CAU',1048),(2155,'Cesar','CES',1048),(2156,'CÃ³rdoba','COR',1048),(2157,'Cundinamarca','CUN',1048),(2158,'ChocÃ³','CHO',1048),(2159,'GuainÃ­a','GUA',1048),(2160,'Guaviare','GUV',1048),(2161,'La Guajira','LAG',1048),(2162,'Magdalena','MAG',1048),(2163,'Meta','MET',1048),(2164,'NariÃ±o','NAR',1048),(2165,'Norte de Santander','NSA',1048),(2166,'Putumayo','PUT',1048),(2167,'Quindio','QUI',1048),(2168,'Risaralda','RIS',1048),(2169,'San AndrÃ©s, Providencia y Santa Catalina','SAP',1048),(2170,'Santander','SAN',1048),(2171,'Sucre','SUC',1048),(2172,'Tolima','TOL',1048),(2173,'Valle del Cauca','VAC',1048),(2174,'VaupÃ©s','VAU',1048),(2175,'Vichada','VID',1048),(2176,'Alajuela','A',1053),(2177,'Cartago','C',1053),(2178,'Guanacaste','G',1053),(2179,'Heredia','H',1053),(2180,'Limon','L',1053),(2181,'Puntarenas','P',1053),(2182,'San Jose','SJ',1053),(2183,'Camagey','09',1056),(2184,'Ciego de `vila','08',1056),(2185,'Cienfuegos','06',1056),(2186,'Ciudad de La Habana','03',1056),(2187,'Granma','12',1056),(2188,'Guantanamo','14',1056),(2189,'Holquin','11',1056),(2190,'La Habana','02',1056),(2191,'Las Tunas','10',1056),(2192,'Matanzas','04',1056),(2193,'Pinar del Rio','01',1056),(2194,'Sancti Spiritus','07',1056),(2195,'Santiago de Cuba','13',1056),(2196,'Villa Clara','05',1056),(2197,'Isla de la Juventud','99',1056),(2198,'Pinar del Roo','PR',1056),(2199,'Ciego de Avila','CA',1056),(2200,'Camagoey','CG',1056),(2201,'Holgun','HO',1056),(2202,'Sancti Spritus','SS',1056),(2203,'Municipio Especial Isla de la Juventud','IJ',1056),(2204,'Boa Vista','BV',1040),(2205,'Brava','BR',1040),(2206,'Calheta de Sao Miguel','CS',1040),(2207,'Fogo','FO',1040),(2208,'Maio','MA',1040),(2209,'Mosteiros','MO',1040),(2210,'Paul','PA',1040),(2211,'Porto Novo','PN',1040),(2212,'Praia','PR',1040),(2213,'Ribeira Grande','RG',1040),(2214,'Sal','SL',1040),(2215,'Sao Domingos','SD',1040),(2216,'Sao Filipe','SF',1040),(2217,'Sao Nicolau','SN',1040),(2218,'Sao Vicente','SV',1040),(2219,'Tarrafal','TA',1040),(2220,'Ammochostos Magusa','04',1057),(2221,'Keryneia','06',1057),(2222,'Larnaka','03',1057),(2223,'Lefkosia','01',1057),(2224,'Lemesos','02',1057),(2225,'Pafos','05',1057),(2226,'JihoÄeskÃ½ kraj','JC',1058),(2227,'JihomoravskÃ½ kraj','JM',1058),(2228,'KarlovarskÃ½ kraj','KA',1058),(2229,'KrÃ¡lovÃ©hradeckÃ½ kraj','KR',1058),(2230,'LibereckÃ½ kraj','LI',1058),(2231,'MoravskoslezskÃ½ kraj','MO',1058),(2232,'OlomouckÃ½ kraj','OL',1058),(2233,'PardubickÃ½ kraj','PA',1058),(2234,'PlzeÅˆskÃ½ kraj','PL',1058),(2235,'Praha, hlavnÃ­ mÄ›sto','PR',1058),(2236,'StÅ™edoÄeskÃ½ kraj','ST',1058),(2237,'ÃšsteckÃ½ kraj','US',1058),(2238,'VysoÄina','VY',1058),(2239,'ZlÃ­nskÃ½ kraj','ZL',1058),(2240,'Baden-Wuerttemberg','BW',1082),(2241,'Bayern','BY',1082),(2242,'Bremen','HB',1082),(2243,'Hamburg','HH',1082),(2244,'Hessen','HE',1082),(2245,'Niedersachsen','NI',1082),(2246,'Nordrhein-Westfalen','NW',1082),(2247,'Rheinland-Pfalz','RP',1082),(2248,'Saarland','SL',1082),(2249,'Schleswig-Holstein','SH',1082),(2250,'Berlin','BR',1082),(2251,'Brandenburg','BB',1082),(2252,'Mecklenburg-Vorpommern','MV',1082),(2253,'Sachsen','SN',1082),(2254,'Sachsen-Anhalt','ST',1082),(2255,'Thueringen','TH',1082),(2256,'Ali Sabiah','AS',1060),(2257,'Dikhil','DI',1060),(2258,'Djibouti','DJ',1060),(2259,'Obock','OB',1060),(2260,'Tadjoura','TA',1060),(2261,'Frederiksberg','147',1059),(2262,'Copenhagen City','101',1059),(2263,'Copenhagen','015',1059),(2264,'Frederiksborg','020',1059),(2265,'Roskilde','025',1059),(2266,'VestsjÃ¦lland','030',1059),(2267,'StorstrÃ¸m','035',1059),(2268,'Bornholm','040',1059),(2269,'Fyn','042',1059),(2270,'South Jutland','050',1059),(2271,'Ribe','055',1059),(2272,'Vejle','060',1059),(2273,'RingkjÃ¸bing','065',1059),(2274,'Ã…rhus','070',1059),(2275,'Viborg','076',1059),(2276,'North Jutland','080',1059),(2277,'Distrito Nacional (Santo Domingo)','01',1062),(2278,'Azua','02',1062),(2279,'Bahoruco','03',1062),(2280,'Barahona','04',1062),(2281,'DajabÃ³n','05',1062),(2282,'Duarte','06',1062),(2283,'El Seybo [El Seibo]','08',1062),(2284,'Espaillat','09',1062),(2285,'Hato Mayor','30',1062),(2286,'Independencia','10',1062),(2287,'La Altagracia','11',1062),(2288,'La Estrelleta [Elias Pina]','07',1062),(2289,'La Romana','12',1062),(2290,'La Vega','13',1062),(2291,'Maroia Trinidad SÃ¡nchez','14',1062),(2292,'MonseÃ±or Nouel','28',1062),(2293,'Monte Cristi','15',1062),(2294,'Monte Plata','29',1062),(2295,'Pedernales','16',1062),(2296,'Peravia','17',1062),(2297,'Puerto Plata','18',1062),(2298,'Salcedo','19',1062),(2299,'SamanÃ¡','20',1062),(2300,'San CristÃ³bal','21',1062),(2301,'San Pedro de MacorÃ­s','23',1062),(2302,'SÃ¡nchez RamÃ­rez','24',1062),(2303,'Santiago','25',1062),(2304,'Santiago RodrÃ­guez','26',1062),(2305,'Valverde','27',1062),(2306,'Adrar','01',1003),(2307,'Ain Defla','44',1003),(2308,'Ain Tmouchent','46',1003),(2309,'Alger','16',1003),(2310,'Annaba','23',1003),(2311,'Batna','05',1003),(2312,'Bechar','08',1003),(2313,'Bejaia','06',1003),(2314,'Biskra','07',1003),(2315,'Blida','09',1003),(2316,'Bordj Bou Arreridj','34',1003),(2317,'Bouira','10',1003),(2318,'Boumerdes','35',1003),(2319,'Chlef','02',1003),(2320,'Constantine','25',1003),(2321,'Djelfa','17',1003),(2322,'El Bayadh','32',1003),(2323,'El Oued','39',1003),(2324,'El Tarf','36',1003),(2325,'Ghardaia','47',1003),(2326,'Guelma','24',1003),(2327,'Illizi','33',1003),(2328,'Jijel','18',1003),(2329,'Khenchela','40',1003),(2330,'Laghouat','03',1003),(2331,'Mascara','29',1003),(2332,'Medea','26',1003),(2333,'Mila','43',1003),(2334,'Mostaganem','27',1003),(2335,'Msila','28',1003),(2336,'Naama','45',1003),(2337,'Oran','31',1003),(2338,'Ouargla','30',1003),(2339,'Oum el Bouaghi','04',1003),(2340,'Relizane','48',1003),(2341,'Saida','20',1003),(2342,'Setif','19',1003),(2343,'Sidi Bel Abbes','22',1003),(2344,'Skikda','21',1003),(2345,'Souk Ahras','41',1003),(2346,'Tamanghasset','11',1003),(2347,'Tebessa','12',1003),(2348,'Tiaret','14',1003),(2349,'Tindouf','37',1003),(2350,'Tipaza','42',1003),(2351,'Tissemsilt','38',1003),(2352,'Tizi Ouzou','15',1003),(2353,'Tlemcen','13',1003),(2354,'Azuay','A',1064),(2355,'Bolivar','B',1064),(2356,'Canar','F',1064),(2357,'Carchi','C',1064),(2358,'Cotopaxi','X',1064),(2359,'Chimborazo','H',1064),(2360,'El Oro','O',1064),(2361,'Esmeraldas','E',1064),(2362,'Galapagos','W',1064),(2363,'Guayas','G',1064),(2364,'Imbabura','I',1064),(2365,'Loja','L',1064),(2366,'Los Rios','R',1064),(2367,'Manabi','M',1064),(2368,'Morona-Santiago','S',1064),(2369,'Napo','N',1064),(2370,'Orellana','D',1064),(2371,'Pastaza','Y',1064),(2372,'Pichincha','P',1064),(2373,'Sucumbios','U',1064),(2374,'Tungurahua','T',1064),(2375,'Zamora-Chinchipe','Z',1064),(2376,'Harjumsa','37',1069),(2377,'Hitumea','39',1069),(2378,'Ida-Virumsa','44',1069),(2379,'Jogevamsa','49',1069),(2380,'Jarvamsa','51',1069),(2381,'Lasnemsa','57',1069),(2382,'Laane-Virumaa','59',1069),(2383,'Polvamea','65',1069),(2384,'Parnumsa','67',1069),(2385,'Raplamsa','70',1069),(2386,'Saaremsa','74',1069),(2387,'Tartumsa','7B',1069),(2388,'Valgamaa','82',1069),(2389,'Viljandimsa','84',1069),(2390,'Vorumaa','86',1069),(2391,'Ad Daqahllyah','DK',1065),(2392,'Al Bahr al Ahmar','BA',1065),(2393,'Al Buhayrah','BH',1065),(2394,'Al Fayym','FYM',1065),(2395,'Al Gharbiyah','GH',1065),(2396,'Al Iskandarlyah','ALX',1065),(2397,'Al Isma illyah','IS',1065),(2398,'Al Jizah','GZ',1065),(2399,'Al Minuflyah','MNF',1065),(2400,'Al Minya','MN',1065),(2401,'Al Qahirah','C',1065),(2402,'Al Qalyublyah','KB',1065),(2403,'Al Wadi al Jadid','WAD',1065),(2404,'Ash Sharqiyah','SHR',1065),(2405,'As Suways','SUZ',1065),(2406,'Aswan','ASN',1065),(2407,'Asyut','AST',1065),(2408,'Bani Suwayf','BNS',1065),(2409,'Bur Sa\'id','PTS',1065),(2410,'Dumyat','DT',1065),(2411,'Janub Sina\'','JS',1065),(2412,'Kafr ash Shaykh','KFS',1065),(2413,'Matruh','MT',1065),(2414,'Qina','KN',1065),(2415,'Shamal Sina\'','SIN',1065),(2416,'Suhaj','SHG',1065),(2417,'Anseba','AN',1068),(2418,'Debub','DU',1068),(2419,'Debubawi Keyih Bahri [Debub-Keih-Bahri]','DK',1068),(2420,'Gash-Barka','GB',1068),(2421,'Maakel [Maekel]','MA',1068),(2422,'Semenawi Keyih Bahri [Semien-Keih-Bahri]','SK',1068),(2423,'Ãlava','VI',1198),(2424,'Albacete','AB',1198),(2425,'Alicante','A',1198),(2426,'AlmerÃ­a','AL',1198),(2427,'Asturias','O',1198),(2428,'Ãvila','AV',1198),(2429,'Badajoz','BA',1198),(2430,'Baleares','PM',1198),(2431,'Barcelona','B',1198),(2432,'Burgos','BU',1198),(2433,'CÃ¡ceres','CC',1198),(2434,'CÃ¡diz','CA',1198),(2435,'Cantabria','S',1198),(2436,'CastellÃ³n','CS',1198),(2437,'Ciudad Real','CR',1198),(2438,'Cuenca','CU',1198),(2439,'Girona [Gerona]','GE',1198),(2440,'Granada','GR',1198),(2441,'Guadalajara','GU',1198),(2442,'GuipÃºzcoa','SS',1198),(2443,'Huelva','H',1198),(2444,'Huesca','HU',1198),(2445,'JaÃ©n','J',1198),(2446,'La CoruÃ±a','C',1198),(2447,'La Rioja','LO',1198),(2448,'Las Palmas','GC',1198),(2449,'LeÃ³n','LE',1198),(2450,'Lleida [LÃ©rida]','L',1198),(2451,'Lugo','LU',1198),(2452,'Madrid','M',1198),(2453,'MÃ¡laga','MA',1198),(2454,'Murcia','MU',1198),(2455,'Navarra','NA',1198),(2456,'Ourense','OR',1198),(2457,'Palencia','P',1198),(2458,'Pontevedra','PO',1198),(2459,'Salamanca','SA',1198),(2460,'Santa Cruz de Tenerife','TF',1198),(2461,'Segovia','SG',1198),(2462,'Sevilla','SE',1198),(2463,'Soria','SO',1198),(2464,'Tarragona','T',1198),(2465,'Teruel','TE',1198),(2466,'Valencia','V',1198),(2467,'Valladolid','VA',1198),(2468,'Vizcaya','BI',1198),(2469,'Zamora','ZA',1198),(2470,'Zaragoza','Z',1198),(2471,'Ceuta','CE',1198),(2472,'Melilla','ML',1198),(2473,'Addis Ababa','AA',1070),(2474,'Dire Dawa','DD',1070),(2475,'Afar','AF',1070),(2476,'Amara','AM',1070),(2477,'Benshangul-Gumaz','BE',1070),(2478,'Gambela Peoples','GA',1070),(2479,'Harari People','HA',1070),(2480,'Oromia','OR',1070),(2481,'Somali','SO',1070),(2482,'Southern Nations, Nationalities and Peoples','SN',1070),(2483,'Tigrai','TI',1070),(2490,'Eastern','E',1074),(2491,'Northern','N',1074),(2492,'Western','W',1074),(2493,'Rotuma','R',1074),(2494,'Chuuk','TRK',1141),(2495,'Kosrae','KSA',1141),(2496,'Pohnpei','PNI',1141),(2497,'Yap','YAP',1141),(2498,'Ain','01',1076),(2499,'Aisne','02',1076),(2500,'Allier','03',1076),(2501,'Alpes-de-Haute-Provence','04',1076),(2502,'Alpes-Maritimes','06',1076),(2503,'ArdÃ¨che','07',1076),(2504,'Ardennes','08',1076),(2505,'AriÃ¨ge','09',1076),(2506,'Aube','10',1076),(2507,'Aude','11',1076),(2508,'Aveyron','12',1076),(2509,'Bas-Rhin','67',1076),(2510,'Bouches-du-RhÃ´ne','13',1076),(2511,'Calvados','14',1076),(2512,'Cantal','15',1076),(2513,'Charente','16',1076),(2514,'Charente-Maritime','17',1076),(2515,'Cher','18',1076),(2516,'CorrÃ¨ze','19',1076),(2517,'Corse-du-Sud','20A',1076),(2518,'CÃ´te-d\'Or','21',1076),(2519,'CÃ´tes-d\'Armor','22',1076),(2520,'Creuse','23',1076),(2521,'Deux-SÃ¨vres','79',1076),(2522,'Dordogne','24',1076),(2523,'Doubs','25',1076),(2524,'DrÃ´me','26',1076),(2525,'Essonne','91',1076),(2526,'Eure','27',1076),(2527,'Eure-et-Loir','28',1076),(2528,'FinistÃ¨re','29',1076),(2529,'Gard','30',1076),(2530,'Gers','32',1076),(2531,'Gironde','33',1076),(2532,'Haut-Rhin','68',1076),(2533,'Haute-Corse','20B',1076),(2534,'Haute-Garonne','31',1076),(2535,'Haute-Loire','43',1076),(2536,'Haute-SaÃ´ne','70',1076),(2537,'Haute-Savoie','74',1076),(2538,'Haute-Vienne','87',1076),(2539,'Hautes-Alpes','05',1076),(2540,'Hautes-PyrÃ©nÃ©es','65',1076),(2541,'Hauts-de-Seine','92',1076),(2542,'HÃ©rault','34',1076),(2543,'Indre','36',1076),(2544,'Ille-et-Vilaine','35',1076),(2545,'Indre-et-Loire','37',1076),(2546,'IsÃ¨re','38',1076),(2547,'Landes','40',1076),(2548,'Loir-et-Cher','41',1076),(2549,'Loire','42',1076),(2550,'Loire-Atlantique','44',1076),(2551,'Loiret','45',1076),(2552,'Lot','46',1076),(2553,'Lot-et-Garonne','47',1076),(2554,'LozÃ¨re','48',1076),(2555,'Maine-et-Loire','49',1076),(2556,'Manche','50',1076),(2557,'Marne','51',1076),(2558,'Mayenne','53',1076),(2559,'Meurthe-et-Moselle','54',1076),(2560,'Meuse','55',1076),(2561,'Morbihan','56',1076),(2562,'Moselle','57',1076),(2563,'NiÃ¨vre','58',1076),(2564,'Nord','59',1076),(2565,'Oise','60',1076),(2566,'Orne','61',1076),(2567,'Paris','75',1076),(2568,'Pas-de-Calais','62',1076),(2569,'Puy-de-DÃ´me','63',1076),(2570,'PyrÃ©nÃ©es-Atlantiques','64',1076),(2571,'PyrÃ©nÃ©es-Orientales','66',1076),(2572,'RhÃ´ne','69',1076),(2573,'SaÃ´ne-et-Loire','71',1076),(2574,'Sarthe','72',1076),(2575,'Savoie','73',1076),(2576,'Seine-et-Marne','77',1076),(2577,'Seine-Maritime','76',1076),(2578,'Seine-Saint-Denis','93',1076),(2579,'Somme','80',1076),(2580,'Tarn','81',1076),(2581,'Tarn-et-Garonne','82',1076),(2582,'Val d\'Oise','95',1076),(2583,'Territoire de Belfort','90',1076),(2584,'Val-de-Marne','94',1076),(2585,'Var','83',1076),(2586,'Vaucluse','84',1076),(2587,'VendÃ©e','85',1076),(2588,'Vienne','86',1076),(2589,'Vosges','88',1076),(2590,'Yonne','89',1076),(2591,'Yvelines','78',1076),(2592,'Aberdeen City','ABE',1226),(2593,'Aberdeenshire','ABD',1226),(2594,'Angus','ANS',1226),(2595,'Co Antrim','ANT',1226),(2597,'Argyll and Bute','AGB',1226),(2598,'Co Armagh','ARM',1226),(2606,'Bedfordshire','BDF',1226),(2612,'Gwent','BGW',1226),(2620,'Bristol, City of','BST',1226),(2622,'Buckinghamshire','BKM',1226),(2626,'Cambridgeshire','CAM',1226),(2634,'Cheshire','CHS',1226),(2635,'Clackmannanshire','CLK',1226),(2639,'Cornwall','CON',1226),(2643,'Cumbria','CMA',1226),(2647,'Derbyshire','DBY',1226),(2648,'Co Londonderry','DRY',1226),(2649,'Devon','DEV',1226),(2651,'Dorset','DOR',1226),(2652,'Co Down','DOW',1226),(2654,'Dumfries and Galloway','DGY',1226),(2655,'Dundee City','DND',1226),(2657,'County Durham','DUR',1226),(2659,'East Ayrshire','EAY',1226),(2660,'East Dunbartonshire','EDU',1226),(2661,'East Lothian','ELN',1226),(2662,'East Renfrewshire','ERW',1226),(2663,'East Riding of Yorkshire','ERY',1226),(2664,'East Sussex','ESX',1226),(2665,'Edinburgh, City of','EDH',1226),(2666,'Na h-Eileanan Siar','ELS',1226),(2668,'Essex','ESS',1226),(2669,'Falkirk','FAL',1226),(2670,'Co Fermanagh','FER',1226),(2671,'Fife','FIF',1226),(2674,'Glasgow City','GLG',1226),(2675,'Gloucestershire','GLS',1226),(2678,'Gwynedd','GWN',1226),(2682,'Hampshire','HAM',1226),(2687,'Herefordshire','HEF',1226),(2688,'Hertfordshire','HRT',1226),(2689,'Highland','HED',1226),(2692,'Inverclyde','IVC',1226),(2694,'Isle of Wight','IOW',1226),(2699,'Kent','KEN',1226),(2705,'Lancashire','LAN',1226),(2709,'Leicestershire','LEC',1226),(2712,'Lincolnshire','LIN',1226),(2723,'Midlothian','MLN',1226),(2726,'Moray','MRY',1226),(2734,'Norfolk','NFK',1226),(2735,'North Ayrshire','NAY',1226),(2738,'North Lanarkshire','NLK',1226),(2742,'North Yorkshire','NYK',1226),(2743,'Northamptonshire','NTH',1226),(2744,'Northumberland','NBL',1226),(2746,'Nottinghamshire','NTT',1226),(2747,'Oldham','OLD',1226),(2748,'Omagh','OMH',1226),(2749,'Orkney Islands','ORR',1226),(2750,'Oxfordshire','OXF',1226),(2752,'Perth and Kinross','PKN',1226),(2757,'Powys','POW',1226),(2761,'Renfrewshire','RFW',1226),(2766,'Rutland','RUT',1226),(2770,'Scottish Borders','SCB',1226),(2773,'Shetland Islands','ZET',1226),(2774,'Shropshire','SHR',1226),(2777,'Somerset','SOM',1226),(2778,'South Ayrshire','SAY',1226),(2779,'South Gloucestershire','SGC',1226),(2780,'South Lanarkshire','SLK',1226),(2785,'Staffordshire','STS',1226),(2786,'Stirling','STG',1226),(2791,'Suffolk','SFK',1226),(2793,'Surrey','SRY',1226),(2804,'Mid Glamorgan','VGL',1226),(2811,'Warwickshire','WAR',1226),(2813,'West Dunbartonshire','WDU',1226),(2814,'West Lothian','WLN',1226),(2815,'West Sussex','WSX',1226),(2818,'Wiltshire','WIL',1226),(2823,'Worcestershire','WOR',1226),(2826,'Ashanti','AH',1083),(2827,'Brong-Ahafo','BA',1083),(2828,'Greater Accra','AA',1083),(2829,'Upper East','UE',1083),(2830,'Upper West','UW',1083),(2831,'Volta','TV',1083),(2832,'Banjul','B',1213),(2833,'Lower River','L',1213),(2834,'MacCarthy Island','M',1213),(2835,'North Bank','N',1213),(2836,'Upper River','U',1213),(2837,'Beyla','BE',1091),(2838,'Boffa','BF',1091),(2839,'Boke','BK',1091),(2840,'Coyah','CO',1091),(2841,'Dabola','DB',1091),(2842,'Dalaba','DL',1091),(2843,'Dinguiraye','DI',1091),(2844,'Dubreka','DU',1091),(2845,'Faranah','FA',1091),(2846,'Forecariah','FO',1091),(2847,'Fria','FR',1091),(2848,'Gaoual','GA',1091),(2849,'Guekedou','GU',1091),(2850,'Kankan','KA',1091),(2851,'Kerouane','KE',1091),(2852,'Kindia','KD',1091),(2853,'Kissidougou','KS',1091),(2854,'Koubia','KB',1091),(2855,'Koundara','KN',1091),(2856,'Kouroussa','KO',1091),(2857,'Labe','LA',1091),(2858,'Lelouma','LE',1091),(2859,'Lola','LO',1091),(2860,'Macenta','MC',1091),(2861,'Mali','ML',1091),(2862,'Mamou','MM',1091),(2863,'Mandiana','MD',1091),(2864,'Nzerekore','NZ',1091),(2865,'Pita','PI',1091),(2866,'Siguiri','SI',1091),(2867,'Telimele','TE',1091),(2868,'Tougue','TO',1091),(2869,'Yomou','YO',1091),(2870,'Region Continental','C',1067),(2871,'Region Insular','I',1067),(2872,'Annobon','AN',1067),(2873,'Bioko Norte','BN',1067),(2874,'Bioko Sur','BS',1067),(2875,'Centro Sur','CS',1067),(2876,'Kie-Ntem','KN',1067),(2877,'Litoral','LI',1067),(2878,'Wele-Nzas','WN',1067),(2879,'AchaÃ¯a','13',1085),(2880,'Aitolia-Akarnania','01',1085),(2881,'Argolis','11',1085),(2882,'Arkadia','12',1085),(2883,'Arta','31',1085),(2884,'Attiki','A1',1085),(2885,'Chalkidiki','64',1085),(2886,'Chania','94',1085),(2887,'Chios','85',1085),(2888,'Dodekanisos','81',1085),(2889,'Drama','52',1085),(2890,'Evros','71',1085),(2891,'Evrytania','05',1085),(2892,'Evvoia','04',1085),(2893,'Florina','63',1085),(2894,'Fokis','07',1085),(2895,'Fthiotis','06',1085),(2896,'Grevena','51',1085),(2897,'Ileia','14',1085),(2898,'Imathia','53',1085),(2899,'Ioannina','33',1085),(2900,'Irakleion','91',1085),(2901,'Karditsa','41',1085),(2902,'Kastoria','56',1085),(2903,'Kavalla','55',1085),(2904,'Kefallinia','23',1085),(2905,'Kerkyra','22',1085),(2906,'Kilkis','57',1085),(2907,'Korinthia','15',1085),(2908,'Kozani','58',1085),(2909,'Kyklades','82',1085),(2910,'Lakonia','16',1085),(2911,'Larisa','42',1085),(2912,'Lasithion','92',1085),(2913,'Lefkas','24',1085),(2914,'Lesvos','83',1085),(2915,'Magnisia','43',1085),(2916,'Messinia','17',1085),(2917,'Pella','59',1085),(2918,'Preveza','34',1085),(2919,'Rethymnon','93',1085),(2920,'Rodopi','73',1085),(2921,'Samos','84',1085),(2922,'Serrai','62',1085),(2923,'Thesprotia','32',1085),(2924,'Thessaloniki','54',1085),(2925,'Trikala','44',1085),(2926,'Voiotia','03',1085),(2927,'Xanthi','72',1085),(2928,'Zakynthos','21',1085),(2929,'Agio Oros','69',1085),(2930,'Alta Verapez','AV',1090),(2931,'Baja Verapez','BV',1090),(2932,'Chimaltenango','CM',1090),(2933,'Chiquimula','CQ',1090),(2934,'El Progreso','PR',1090),(2935,'Escuintla','ES',1090),(2936,'Guatemala','GU',1090),(2937,'Huehuetenango','HU',1090),(2938,'Izabal','IZ',1090),(2939,'Jalapa','JA',1090),(2940,'Jutiapa','JU',1090),(2941,'Peten','PE',1090),(2942,'Quetzaltenango','QZ',1090),(2943,'Quiche','QC',1090),(2944,'Reta.thuleu','RE',1090),(2945,'Sacatepequez','SA',1090),(2946,'San Marcos','SM',1090),(2947,'Santa Rosa','SR',1090),(2948,'Solol6','SO',1090),(2949,'Suchitepequez','SU',1090),(2950,'Totonicapan','TO',1090),(2951,'Zacapa','ZA',1090),(2952,'Bissau','BS',1092),(2953,'Bafata','BA',1092),(2954,'Biombo','BM',1092),(2955,'Bolama','BL',1092),(2956,'Cacheu','CA',1092),(2957,'Gabu','GA',1092),(2958,'Oio','OI',1092),(2959,'Quloara','QU',1092),(2960,'Tombali S','TO',1092),(2961,'Barima-Waini','BA',1093),(2962,'Cuyuni-Mazaruni','CU',1093),(2963,'Demerara-Mahaica','DE',1093),(2964,'East Berbice-Corentyne','EB',1093),(2965,'Essequibo Islands-West Demerara','ES',1093),(2966,'Mahaica-Berbice','MA',1093),(2967,'Pomeroon-Supenaam','PM',1093),(2968,'Potaro-Siparuni','PT',1093),(2969,'Upper Demerara-Berbice','UD',1093),(2970,'Upper Takutu-Upper Essequibo','UT',1093),(2971,'Atlantida','AT',1097),(2972,'Colon','CL',1097),(2973,'Comayagua','CM',1097),(2974,'Copan','CP',1097),(2975,'Cortes','CR',1097),(2976,'Choluteca','CH',1097),(2977,'El Paraiso','EP',1097),(2978,'Francisco Morazan','FM',1097),(2979,'Gracias a Dios','GD',1097),(2980,'Intibuca','IN',1097),(2981,'Islas de la Bahia','IB',1097),(2982,'Lempira','LE',1097),(2983,'Ocotepeque','OC',1097),(2984,'Olancho','OL',1097),(2985,'Santa Barbara','SB',1097),(2986,'Valle','VA',1097),(2987,'Yoro','YO',1097),(2988,'Bjelovarsko-bilogorska zupanija','07',1055),(2989,'Brodsko-posavska zupanija','12',1055),(2990,'Dubrovacko-neretvanska zupanija','19',1055),(2991,'Istarska zupanija','18',1055),(2992,'Karlovacka zupanija','04',1055),(2993,'Koprivnickco-krizevacka zupanija','06',1055),(2994,'Krapinako-zagorska zupanija','02',1055),(2995,'Licko-senjska zupanija','09',1055),(2996,'Medimurska zupanija','20',1055),(2997,'Osjecko-baranjska zupanija','14',1055),(2998,'Pozesko-slavonska zupanija','11',1055),(2999,'Primorsko-goranska zupanija','08',1055),(3000,'Sisacko-moelavacka Iupanija','03',1055),(3001,'Splitako-dalmatinska zupanija','17',1055),(3002,'Sibenako-kninska zupanija','15',1055),(3003,'Varaidinska zupanija','05',1055),(3004,'VirovitiEko-podravska zupanija','10',1055),(3005,'VuRovarako-srijemska zupanija','16',1055),(3006,'Zadaraka','13',1055),(3007,'Zagrebacka zupanija','01',1055),(3008,'Grande-Anse','GA',1094),(3009,'Nord-Est','NE',1094),(3010,'Nord-Ouest','NO',1094),(3011,'Ouest','OU',1094),(3012,'Sud','SD',1094),(3013,'Sud-Est','SE',1094),(3014,'Budapest','BU',1099),(3015,'BÃ¡cs-Kiskun','BK',1099),(3016,'Baranya','BA',1099),(3017,'BÃ©kÃ©s','BE',1099),(3018,'Borsod-AbaÃºj-ZemplÃ©n','BZ',1099),(3019,'CsongrÃ¡d','CS',1099),(3020,'FejÃ©r','FE',1099),(3021,'GyÅ‘r-Moson-Sopron','GS',1099),(3022,'Hajdu-Bihar','HB',1099),(3023,'Heves','HE',1099),(3024,'JÃ¡sz-Nagykun-Szolnok','JN',1099),(3025,'KomÃ¡rom-Esztergom','KE',1099),(3026,'NogrÃ¡d','NO',1099),(3027,'Pest','PE',1099),(3028,'Somogy','SO',1099),(3029,'Szabolcs-SzatmÃ¡r-Bereg','SZ',1099),(3030,'Tolna','TO',1099),(3031,'Vas','VA',1099),(3032,'VeszprÃ©m','VE',1099),(3033,'Zala','ZA',1099),(3034,'BÃ©kÃ©scsaba','BC',1099),(3035,'Debrecen','DE',1099),(3036,'DunaÃºjvÃ¡ros','DU',1099),(3037,'Eger','EG',1099),(3038,'GyÅ‘r','GY',1099),(3039,'HÃ³dmezÅ‘vÃ¡sÃ¡rhely','HV',1099),(3040,'KaposvÃ¡r','KV',1099),(3041,'KecskemÃ©t','KM',1099),(3042,'Miskolc','MI',1099),(3043,'Nagykanizsa','NK',1099),(3044,'NyiregyhÃ¡za','NY',1099),(3045,'PÃ©cs','PS',1099),(3046,'SalgÃ³tarjÃ¡n','ST',1099),(3047,'Sopron','SN',1099),(3048,'Szeged','SD',1099),(3049,'SzÃ©kesfehÃ©rvÃ¡r','SF',1099),(3050,'SzekszÃ¡rd','SS',1099),(3051,'Szolnok','SK',1099),(3052,'Szombathely','SH',1099),(3053,'TatabÃ¡nya','TB',1099),(3054,'Zalaegerszeg','ZE',1099),(3055,'Bali','BA',1102),(3056,'Bangka Belitung','BB',1102),(3057,'Banten','BT',1102),(3058,'Bengkulu','BE',1102),(3059,'Gorontalo','GO',1102),(3060,'Irian Jaya','IJ',1102),(3061,'Jambi','JA',1102),(3062,'Jawa Barat','JB',1102),(3063,'Jawa Tengah','JT',1102),(3064,'Jawa Timur','JI',1102),(3065,'Kalimantan Barat','KB',1102),(3066,'Kalimantan Timur','KT',1102),(3067,'Kalimantan Selatan','KS',1102),(3068,'Kepulauan Riau','KR',1102),(3069,'Lampung','LA',1102),(3070,'Maluku','MA',1102),(3071,'Maluku Utara','MU',1102),(3072,'Nusa Tenggara Barat','NB',1102),(3073,'Nusa Tenggara Timur','NT',1102),(3074,'Papua','PA',1102),(3075,'Riau','RI',1102),(3076,'Sulawesi Selatan','SN',1102),(3077,'Sulawesi Tengah','ST',1102),(3078,'Sulawesi Tenggara','SG',1102),(3079,'Sulawesi Utara','SA',1102),(3080,'Sumatra Barat','SB',1102),(3081,'Sumatra Selatan','SS',1102),(3082,'Sumatera Utara','SU',1102),(3083,'Jakarta Raya','JK',1102),(3084,'Aceh','AC',1102),(3085,'Yogyakarta','YO',1102),(3086,'Cork','C',1105),(3087,'Clare','CE',1105),(3088,'Cavan','CN',1105),(3089,'Carlow','CW',1105),(3090,'Dublin','D',1105),(3091,'Donegal','DL',1105),(3092,'Galway','G',1105),(3093,'Kildare','KE',1105),(3094,'Kilkenny','KK',1105),(3095,'Kerry','KY',1105),(3096,'Longford','LD',1105),(3097,'Louth','LH',1105),(3098,'Limerick','LK',1105),(3099,'Leitrim','LM',1105),(3100,'Laois','LS',1105),(3101,'Meath','MH',1105),(3102,'Monaghan','MN',1105),(3103,'Mayo','MO',1105),(3104,'Offaly','OY',1105),(3105,'Roscommon','RN',1105),(3106,'Sligo','SO',1105),(3107,'Tipperary','TA',1105),(3108,'Waterford','WD',1105),(3109,'Westmeath','WH',1105),(3110,'Wicklow','WW',1105),(3111,'Wexford','WX',1105),(3112,'HaDarom','D',1106),(3113,'HaMerkaz','M',1106),(3114,'HaZafon','Z',1106),(3115,'Haifa','HA',1106),(3116,'Tel-Aviv','TA',1106),(3117,'Jerusalem','JM',1106),(3118,'Al Anbar','AN',1104),(3119,'Al Ba,rah','BA',1104),(3120,'Al Muthanna','MU',1104),(3121,'Al Qadisiyah','QA',1104),(3122,'An Najef','NA',1104),(3123,'Arbil','AR',1104),(3124,'As Sulaymaniyah','SW',1104),(3125,'At Ta\'mim','TS',1104),(3126,'Babil','BB',1104),(3127,'Baghdad','BG',1104),(3128,'Dahuk','DA',1104),(3129,'Dhi Qar','DQ',1104),(3130,'Diyala','DI',1104),(3131,'Karbala\'','KA',1104),(3132,'Maysan','MA',1104),(3133,'Ninawa','NI',1104),(3134,'Salah ad Din','SD',1104),(3135,'Wasit','WA',1104),(3136,'Ardabil','03',1103),(3137,'Azarbayjan-e Gharbi','02',1103),(3138,'Azarbayjan-e Sharqi','01',1103),(3139,'Bushehr','06',1103),(3140,'Chahar Mahall va Bakhtiari','08',1103),(3141,'Esfahan','04',1103),(3142,'Fars','14',1103),(3143,'Gilan','19',1103),(3144,'Golestan','27',1103),(3145,'Hamadan','24',1103),(3146,'Hormozgan','23',1103),(3147,'Iiam','05',1103),(3148,'Kerman','15',1103),(3149,'Kermanshah','17',1103),(3150,'Khorasan','09',1103),(3151,'Khuzestan','10',1103),(3152,'Kohjiluyeh va Buyer Ahmad','18',1103),(3153,'Kordestan','16',1103),(3154,'Lorestan','20',1103),(3155,'Markazi','22',1103),(3156,'Mazandaran','21',1103),(3157,'Qazvin','28',1103),(3158,'Qom','26',1103),(3159,'Semnan','12',1103),(3160,'Sistan va Baluchestan','13',1103),(3161,'Tehran','07',1103),(3162,'Yazd','25',1103),(3163,'Zanjan','11',1103),(3164,'Austurland','7',1100),(3165,'Hofuoborgarsvaeoi utan Reykjavikur','1',1100),(3166,'Norourland eystra','6',1100),(3167,'Norourland vestra','5',1100),(3168,'Reykjavik','0',1100),(3169,'Suourland','8',1100),(3170,'Suournes','2',1100),(3171,'Vestfirolr','4',1100),(3172,'Vesturland','3',1100),(3173,'Agrigento','AG',1107),(3174,'Alessandria','AL',1107),(3175,'Ancona','AN',1107),(3176,'Aosta','AO',1107),(3177,'Arezzo','AR',1107),(3178,'Ascoli Piceno','AP',1107),(3179,'Asti','AT',1107),(3180,'Avellino','AV',1107),(3181,'Bari','BA',1107),(3182,'Belluno','BL',1107),(3183,'Benevento','BN',1107),(3184,'Bergamo','BG',1107),(3185,'Biella','BI',1107),(3186,'Bologna','BO',1107),(3187,'Bolzano','BZ',1107),(3188,'Brescia','BS',1107),(3189,'Brindisi','BR',1107),(3190,'Cagliari','CA',1107),(3191,'Caltanissetta','CL',1107),(3192,'Campobasso','CB',1107),(3193,'Caserta','CE',1107),(3194,'Catania','CT',1107),(3195,'Catanzaro','CZ',1107),(3196,'Chieti','CH',1107),(3197,'Como','CO',1107),(3198,'Cosenza','CS',1107),(3199,'Cremona','CR',1107),(3200,'Crotone','KR',1107),(3201,'Cuneo','CN',1107),(3202,'Enna','EN',1107),(3203,'Ferrara','FE',1107),(3204,'Firenze','FI',1107),(3205,'Foggia','FG',1107),(3206,'ForlÃ¬-Cesena','FC',1107),(3207,'Frosinone','FR',1107),(3208,'Genova','GE',1107),(3209,'Gorizia','GO',1107),(3210,'Grosseto','GR',1107),(3211,'Imperia','IM',1107),(3212,'Isernia','IS',1107),(3213,'L\'Aquila','AQ',1107),(3214,'La Spezia','SP',1107),(3215,'Latina','LT',1107),(3216,'Lecce','LE',1107),(3217,'Lecco','LC',1107),(3218,'Livorno','LI',1107),(3219,'Lodi','LO',1107),(3220,'Lucca','LU',1107),(3221,'Macerata','MC',1107),(3222,'Mantova','MN',1107),(3223,'Massa-Carrara','MS',1107),(3224,'Matera','MT',1107),(3225,'Messina','ME',1107),(3226,'Milano','MI',1107),(3227,'Modena','MO',1107),(3228,'Napoli','NA',1107),(3229,'Novara','NO',1107),(3230,'Nuoro','NU',1107),(3231,'Oristano','OR',1107),(3232,'Padova','PD',1107),(3233,'Palermo','PA',1107),(3234,'Parma','PR',1107),(3235,'Pavia','PV',1107),(3236,'Perugia','PG',1107),(3237,'Pesaro e Urbino','PU',1107),(3238,'Pescara','PE',1107),(3239,'Piacenza','PC',1107),(3240,'Pisa','PI',1107),(3241,'Pistoia','PT',1107),(3242,'Pordenone','PN',1107),(3243,'Potenza','PZ',1107),(3244,'Prato','PO',1107),(3245,'Ragusa','RG',1107),(3246,'Ravenna','RA',1107),(3247,'Reggio Calabria','RC',1107),(3248,'Reggio Emilia','RE',1107),(3249,'Rieti','RI',1107),(3250,'Rimini','RN',1107),(3251,'Roma','RM',1107),(3252,'Rovigo','RO',1107),(3253,'Salerno','SA',1107),(3254,'Sassari','SS',1107),(3255,'Savona','SV',1107),(3256,'Siena','SI',1107),(3257,'Siracusa','SR',1107),(3258,'Sondrio','SO',1107),(3259,'Taranto','TA',1107),(3260,'Teramo','TE',1107),(3261,'Terni','TR',1107),(3262,'Torino','TO',1107),(3263,'Trapani','TP',1107),(3264,'Trento','TN',1107),(3265,'Treviso','TV',1107),(3266,'Trieste','TS',1107),(3267,'Udine','UD',1107),(3268,'Varese','VA',1107),(3269,'Venezia','VE',1107),(3270,'Verbano-Cusio-Ossola','VB',1107),(3271,'Vercelli','VC',1107),(3272,'Verona','VR',1107),(3273,'Vibo Valentia','VV',1107),(3274,'Vicenza','VI',1107),(3275,'Viterbo','VT',1107),(3276,'Aichi','23',1109),(3277,'Akita','05',1109),(3278,'Aomori','02',1109),(3279,'Chiba','12',1109),(3280,'Ehime','38',1109),(3281,'Fukui','18',1109),(3282,'Fukuoka','40',1109),(3283,'Fukusima','07',1109),(3284,'Gifu','21',1109),(3285,'Gunma','10',1109),(3286,'Hiroshima','34',1109),(3287,'Hokkaido','01',1109),(3288,'Hyogo','28',1109),(3289,'Ibaraki','08',1109),(3290,'Ishikawa','17',1109),(3291,'Iwate','03',1109),(3292,'Kagawa','37',1109),(3293,'Kagoshima','46',1109),(3294,'Kanagawa','14',1109),(3295,'Kochi','39',1109),(3296,'Kumamoto','43',1109),(3297,'Kyoto','26',1109),(3298,'Mie','24',1109),(3299,'Miyagi','04',1109),(3300,'Miyazaki','45',1109),(3301,'Nagano','20',1109),(3302,'Nagasaki','42',1109),(3303,'Nara','29',1109),(3304,'Niigata','15',1109),(3305,'Oita','44',1109),(3306,'Okayama','33',1109),(3307,'Okinawa','47',1109),(3308,'Osaka','27',1109),(3309,'Saga','41',1109),(3310,'Saitama','11',1109),(3311,'Shiga','25',1109),(3312,'Shimane','32',1109),(3313,'Shizuoka','22',1109),(3314,'Tochigi','09',1109),(3315,'Tokushima','36',1109),(3316,'Tokyo','13',1109),(3317,'Tottori','31',1109),(3318,'Toyama','16',1109),(3319,'Wakayama','30',1109),(3320,'Yamagata','06',1109),(3321,'Yamaguchi','35',1109),(3322,'Yamanashi','19',1109),(3323,'Clarendon','CN',1108),(3324,'Hanover','HR',1108),(3325,'Kingston','KN',1108),(3326,'Portland','PD',1108),(3327,'Saint Andrew','AW',1108),(3328,'Saint Ann','AN',1108),(3329,'Saint Catherine','CE',1108),(3330,'Saint Elizabeth','EH',1108),(3331,'Saint James','JS',1108),(3332,'Saint Mary','MY',1108),(3333,'Saint Thomas','TS',1108),(3334,'Trelawny','TY',1108),(3335,'Westmoreland','WD',1108),(3336,'Ajln','AJ',1110),(3337,'Al \'Aqaba','AQ',1110),(3338,'Al Balqa\'','BA',1110),(3339,'Al Karak','KA',1110),(3340,'Al Mafraq','MA',1110),(3341,'Amman','AM',1110),(3342,'At Tafilah','AT',1110),(3343,'Az Zarga','AZ',1110),(3344,'Irbid','JR',1110),(3345,'Jarash','JA',1110),(3346,'Ma\'an','MN',1110),(3347,'Madaba','MD',1110),(3348,'Nairobi Municipality','110',1112),(3349,'Coast','300',1112),(3350,'North-Eastern Kaskazini Mashariki','500',1112),(3351,'Rift Valley','700',1112),(3352,'Western Magharibi','900',1112),(3353,'Bishkek','GB',1117),(3354,'Batken','B',1117),(3355,'Chu','C',1117),(3356,'Jalal-Abad','J',1117),(3357,'Naryn','N',1117),(3358,'Osh','O',1117),(3359,'Talas','T',1117),(3360,'Ysyk-Kol','Y',1117),(3361,'Krong Kaeb','23',1037),(3362,'Krong Pailin','24',1037),(3363,'Xrong Preah Sihanouk','18',1037),(3364,'Phnom Penh','12',1037),(3365,'Baat Dambang','2',1037),(3366,'Banteay Mean Chey','1',1037),(3367,'Rampong Chaam','3',1037),(3368,'Kampong Chhnang','4',1037),(3369,'Kampong Spueu','5',1037),(3370,'Kampong Thum','6',1037),(3371,'Kampot','7',1037),(3372,'Kandaal','8',1037),(3373,'Kach Kong','9',1037),(3374,'Krachoh','10',1037),(3375,'Mondol Kiri','11',1037),(3376,'Otdar Mean Chey','22',1037),(3377,'Pousaat','15',1037),(3378,'Preah Vihear','13',1037),(3379,'Prey Veaeng','14',1037),(3380,'Rotanak Kiri','16',1037),(3381,'Siem Reab','17',1037),(3382,'Stueng Traeng','19',1037),(3383,'Svaay Rieng','20',1037),(3384,'Taakaev','21',1037),(3385,'Gilbert Islands','G',1113),(3386,'Line Islands','L',1113),(3387,'Phoenix Islands','P',1113),(3388,'Anjouan Ndzouani','A',1049),(3389,'Grande Comore Ngazidja','G',1049),(3390,'Moheli Moili','M',1049),(3391,'Kaesong-si','KAE',1114),(3392,'Nampo-si','NAM',1114),(3393,'Pyongyang-ai','PYO',1114),(3394,'Chagang-do','CHA',1114),(3395,'Hamgyongbuk-do','HAB',1114),(3396,'Hamgyongnam-do','HAN',1114),(3397,'Hwanghaebuk-do','HWB',1114),(3398,'Hwanghaenam-do','HWN',1114),(3399,'Kangwon-do','KAN',1114),(3400,'Pyonganbuk-do','PYB',1114),(3401,'Pyongannam-do','PYN',1114),(3402,'Yanggang-do','YAN',1114),(3403,'Najin Sonbong-si','NAJ',1114),(3404,'Seoul Teugbyeolsi','11',1115),(3405,'Busan Gwang\'yeogsi','26',1115),(3406,'Daegu Gwang\'yeogsi','27',1115),(3407,'Daejeon Gwang\'yeogsi','30',1115),(3408,'Gwangju Gwang\'yeogsi','29',1115),(3409,'Incheon Gwang\'yeogsi','28',1115),(3410,'Ulsan Gwang\'yeogsi','31',1115),(3411,'Chungcheongbugdo','43',1115),(3412,'Chungcheongnamdo','44',1115),(3413,'Gang\'weondo','42',1115),(3414,'Gyeonggido','41',1115),(3415,'Gyeongsangbugdo','47',1115),(3416,'Gyeongsangnamdo','48',1115),(3417,'Jejudo','49',1115),(3418,'Jeonrabugdo','45',1115),(3419,'Jeonranamdo','46',1115),(3420,'Al Ahmadi','AH',1116),(3421,'Al Farwanlyah','FA',1116),(3422,'Al Jahrah','JA',1116),(3423,'Al Kuwayt','KU',1116),(3424,'Hawalli','HA',1116),(3425,'Almaty','ALA',1111),(3426,'Astana','AST',1111),(3427,'Almaty oblysy','ALM',1111),(3428,'Aqmola oblysy','AKM',1111),(3429,'Aqtobe oblysy','AKT',1111),(3430,'Atyrau oblyfiy','ATY',1111),(3431,'Batys Quzaqstan oblysy','ZAP',1111),(3432,'Mangghystau oblysy','MAN',1111),(3433,'Ongtustik Quzaqstan oblysy','YUZ',1111),(3434,'Pavlodar oblysy','PAV',1111),(3435,'Qaraghandy oblysy','KAR',1111),(3436,'Qostanay oblysy','KUS',1111),(3437,'Qyzylorda oblysy','KZY',1111),(3438,'Shyghys Quzaqstan oblysy','VOS',1111),(3439,'Soltustik Quzaqstan oblysy','SEV',1111),(3440,'Zhambyl oblysy Zhambylskaya oblast\'','ZHA',1111),(3441,'Vientiane','VT',1118),(3442,'Attapu','AT',1118),(3443,'Bokeo','BK',1118),(3444,'Bolikhamxai','BL',1118),(3445,'Champasak','CH',1118),(3446,'Houaphan','HO',1118),(3447,'Khammouan','KH',1118),(3448,'Louang Namtha','LM',1118),(3449,'Louangphabang','LP',1118),(3450,'Oudomxai','OU',1118),(3451,'Phongsali','PH',1118),(3452,'Salavan','SL',1118),(3453,'Savannakhet','SV',1118),(3454,'Xaignabouli','XA',1118),(3455,'Xiasomboun','XN',1118),(3456,'Xekong','XE',1118),(3457,'Xiangkhoang','XI',1118),(3458,'Beirout','BA',1120),(3459,'El Begsa','BI',1120),(3460,'Jabal Loubnane','JL',1120),(3461,'Loubnane ech Chemali','AS',1120),(3462,'Loubnane ej Jnoubi','JA',1120),(3463,'Nabatiye','NA',1120),(3464,'Ampara','52',1199),(3465,'Anuradhapura','71',1199),(3466,'Badulla','81',1199),(3467,'Batticaloa','51',1199),(3468,'Colombo','11',1199),(3469,'Galle','31',1199),(3470,'Gampaha','12',1199),(3471,'Hambantota','33',1199),(3472,'Jaffna','41',1199),(3473,'Kalutara','13',1199),(3474,'Kandy','21',1199),(3475,'Kegalla','92',1199),(3476,'Kilinochchi','42',1199),(3477,'Kurunegala','61',1199),(3478,'Mannar','43',1199),(3479,'Matale','22',1199),(3480,'Matara','32',1199),(3481,'Monaragala','82',1199),(3482,'Mullaittivu','45',1199),(3483,'Nuwara Eliya','23',1199),(3484,'Polonnaruwa','72',1199),(3485,'Puttalum','62',1199),(3486,'Ratnapura','91',1199),(3487,'Trincomalee','53',1199),(3488,'VavunLya','44',1199),(3489,'Bomi','BM',1122),(3490,'Bong','BG',1122),(3491,'Grand Basaa','GB',1122),(3492,'Grand Cape Mount','CM',1122),(3493,'Grand Gedeh','GG',1122),(3494,'Grand Kru','GK',1122),(3495,'Lofa','LO',1122),(3496,'Margibi','MG',1122),(3497,'Maryland','MY',1122),(3498,'Montserrado','MO',1122),(3499,'Nimba','NI',1122),(3500,'Rivercess','RI',1122),(3501,'Sinoe','SI',1122),(3502,'Berea','D',1121),(3503,'Butha-Buthe','B',1121),(3504,'Leribe','C',1121),(3505,'Mafeteng','E',1121),(3506,'Maseru','A',1121),(3507,'Mohale\'s Hoek','F',1121),(3508,'Mokhotlong','J',1121),(3509,'Qacha\'s Nek','H',1121),(3510,'Quthing','G',1121),(3511,'Thaba-Tseka','K',1121),(3512,'Alytaus Apskritis','AL',1125),(3513,'Kauno Apskritis','KU',1125),(3514,'Klaipedos Apskritis','KL',1125),(3515,'Marijampoles Apskritis','MR',1125),(3516,'Panevezio Apskritis','PN',1125),(3517,'Sisuliu Apskritis','SA',1125),(3518,'Taurages Apskritis','TA',1125),(3519,'Telsiu Apskritis','TE',1125),(3520,'Utenos Apskritis','UT',1125),(3521,'Vilniaus Apskritis','VL',1125),(3522,'Diekirch','D',1126),(3523,'GreveNmacher','G',1126),(3524,'Aizkraukles Apripkis','AI',1119),(3525,'Alkanes Apripkis','AL',1119),(3526,'Balvu Apripkis','BL',1119),(3527,'Bauskas Apripkis','BU',1119),(3528,'Cesu Aprikis','CE',1119),(3529,'Daugavpile Apripkis','DA',1119),(3530,'Dobeles Apripkis','DO',1119),(3531,'Gulbenes Aprlpkis','GU',1119),(3532,'Jelgavas Apripkis','JL',1119),(3533,'Jekabpils Apripkis','JK',1119),(3534,'Kraslavas Apripkis','KR',1119),(3535,'Kuldlgas Apripkis','KU',1119),(3536,'Limbazu Apripkis','LM',1119),(3537,'Liepajas Apripkis','LE',1119),(3538,'Ludzas Apripkis','LU',1119),(3539,'Madonas Apripkis','MA',1119),(3540,'Ogres Apripkis','OG',1119),(3541,'Preilu Apripkis','PR',1119),(3542,'Rezaknes Apripkis','RE',1119),(3543,'Rigas Apripkis','RI',1119),(3544,'Saldus Apripkis','SA',1119),(3545,'Talsu Apripkis','TA',1119),(3546,'Tukuma Apriplcis','TU',1119),(3547,'Valkas Apripkis','VK',1119),(3548,'Valmieras Apripkis','VM',1119),(3549,'Ventspils Apripkis','VE',1119),(3550,'Daugavpils','DGV',1119),(3551,'Jelgava','JEL',1119),(3552,'Jurmala','JUR',1119),(3553,'Liepaja','LPX',1119),(3554,'Rezekne','REZ',1119),(3555,'Riga','RIX',1119),(3556,'Ventspils','VEN',1119),(3557,'AjdÄbiyÄ','AJ',1123),(3558,'Al BuÅ£nÄn','BU',1123),(3559,'Al HizÄm al Akhdar','HZ',1123),(3560,'Al Jabal al Akhdar','JA',1123),(3561,'Al JifÄrah','JI',1123),(3562,'Al Jufrah','JU',1123),(3563,'Al Kufrah','KF',1123),(3564,'Al Marj','MJ',1123),(3565,'Al Marqab','MB',1123),(3566,'Al QaÅ£rÅ«n','QT',1123),(3567,'Al Qubbah','QB',1123),(3568,'Al WÄhah','WA',1123),(3569,'An NuqaÅ£ al Khams','NQ',1123),(3570,'Ash ShÄÅ£i\'','SH',1123),(3571,'Az ZÄwiyah','ZA',1123),(3572,'BanghÄzÄ«','BA',1123),(3573,'BanÄ« WalÄ«d','BW',1123),(3574,'Darnah','DR',1123),(3575,'GhadÄmis','GD',1123),(3576,'GharyÄn','GR',1123),(3577,'GhÄt','GT',1123),(3578,'JaghbÅ«b','JB',1123),(3579,'MiÅŸrÄtah','MI',1123),(3580,'Mizdah','MZ',1123),(3581,'Murzuq','MQ',1123),(3582,'NÄlÅ«t','NL',1123),(3583,'SabhÄ','SB',1123),(3584,'ÅžabrÄtah ÅžurmÄn','SS',1123),(3585,'Surt','SR',1123),(3586,'TÄjÅ«rÄ\' wa an NawÄhÄ« al ArbÄh','TN',1123),(3587,'Å¢arÄbulus','TB',1123),(3588,'TarhÅ«nah-MasallÄtah','TM',1123),(3589,'WÄdÄ« al hayÄt','WD',1123),(3590,'Yafran-JÄdÅ«','YJ',1123),(3591,'Agadir','AGD',1146),(3592,'AÃ¯t Baha','BAH',1146),(3593,'AÃ¯t Melloul','MEL',1146),(3594,'Al Haouz','HAO',1146),(3595,'Al HoceÃ¯ma','HOC',1146),(3596,'Assa-Zag','ASZ',1146),(3597,'Azilal','AZI',1146),(3598,'Beni Mellal','BEM',1146),(3599,'Ben Sllmane','BES',1146),(3600,'Berkane','BER',1146),(3601,'Boujdour','BOD',1146),(3602,'Boulemane','BOM',1146),(3603,'Casablanca  [Dar el BeÃ¯da]','CAS',1146),(3604,'Chefchaouene','CHE',1146),(3605,'Chichaoua','CHI',1146),(3606,'El Hajeb','HAJ',1146),(3607,'El Jadida','JDI',1146),(3608,'Errachidia','ERR',1146),(3609,'Essaouira','ESI',1146),(3610,'Es Smara','ESM',1146),(3611,'FÃ¨s','FES',1146),(3612,'Figuig','FIG',1146),(3613,'Guelmim','GUE',1146),(3614,'Ifrane','IFR',1146),(3615,'Jerada','JRA',1146),(3616,'Kelaat Sraghna','KES',1146),(3617,'KÃ©nitra','KEN',1146),(3618,'Khemisaet','KHE',1146),(3619,'Khenifra','KHN',1146),(3620,'Khouribga','KHO',1146),(3621,'LaÃ¢youne (EH)','LAA',1146),(3622,'Larache','LAP',1146),(3623,'Marrakech','MAR',1146),(3624,'MeknsÃ¨s','MEK',1146),(3625,'Nador','NAD',1146),(3626,'Ouarzazate','OUA',1146),(3627,'Oued ed Dahab (EH)','OUD',1146),(3628,'Oujda','OUJ',1146),(3629,'Rabat-SalÃ©','RBA',1146),(3630,'Safi','SAF',1146),(3631,'Sefrou','SEF',1146),(3632,'Settat','SET',1146),(3633,'Sidl Kacem','SIK',1146),(3634,'Tanger','TNG',1146),(3635,'Tan-Tan','TNT',1146),(3636,'Taounate','TAO',1146),(3637,'Taroudannt','TAR',1146),(3638,'Tata','TAT',1146),(3639,'Taza','TAZ',1146),(3640,'TÃ©touan','TET',1146),(3641,'Tiznit','TIZ',1146),(3642,'Gagauzia, Unitate Teritoriala Autonoma','GA',1142),(3643,'Chisinau','CU',1142),(3644,'Stinga Nistrului, unitatea teritoriala din','SN',1142),(3645,'Balti','BA',1142),(3646,'Cahul','CA',1142),(3647,'Edinet','ED',1142),(3648,'Lapusna','LA',1142),(3649,'Orhei','OR',1142),(3650,'Soroca','SO',1142),(3651,'Taraclia','TA',1142),(3652,'Tighina [Bender]','TI',1142),(3653,'Ungheni','UN',1142),(3654,'Antananarivo','T',1129),(3655,'Antsiranana','D',1129),(3656,'Fianarantsoa','F',1129),(3657,'Mahajanga','M',1129),(3658,'Toamasina','A',1129),(3659,'Toliara','U',1129),(3660,'Ailinglapalap','ALL',1135),(3661,'Ailuk','ALK',1135),(3662,'Arno','ARN',1135),(3663,'Aur','AUR',1135),(3664,'Ebon','EBO',1135),(3665,'Eniwetok','ENI',1135),(3666,'Jaluit','JAL',1135),(3667,'Kili','KIL',1135),(3668,'Kwajalein','KWA',1135),(3669,'Lae','LAE',1135),(3670,'Lib','LIB',1135),(3671,'Likiep','LIK',1135),(3672,'Majuro','MAJ',1135),(3673,'Maloelap','MAL',1135),(3674,'Mejit','MEJ',1135),(3675,'Mili','MIL',1135),(3676,'Namorik','NMK',1135),(3677,'Namu','NMU',1135),(3678,'Rongelap','RON',1135),(3679,'Ujae','UJA',1135),(3680,'Ujelang','UJL',1135),(3681,'Utirik','UTI',1135),(3682,'Wotho','WTN',1135),(3683,'Wotje','WTJ',1135),(3684,'Bamako','BK0',1133),(3685,'Gao','7',1133),(3686,'Kayes','1',1133),(3687,'Kidal','8',1133),(3688,'Xoulikoro','2',1133),(3689,'Mopti','5',1133),(3690,'S69ou','4',1133),(3691,'Sikasso','3',1133),(3692,'Tombouctou','6',1133),(3693,'Ayeyarwady','07',1035),(3694,'Bago','02',1035),(3695,'Magway','03',1035),(3696,'Mandalay','04',1035),(3697,'Sagaing','01',1035),(3698,'Tanintharyi','05',1035),(3699,'Yangon','06',1035),(3700,'Chin','14',1035),(3701,'Kachin','11',1035),(3702,'Kayah','12',1035),(3703,'Kayin','13',1035),(3704,'Mon','15',1035),(3705,'Rakhine','16',1035),(3706,'Shan','17',1035),(3707,'Ulaanbaatar','1',1144),(3708,'Arhangay','073',1144),(3709,'Bayanhongor','069',1144),(3710,'Bayan-Olgiy','071',1144),(3711,'Bulgan','067',1144),(3712,'Darhan uul','037',1144),(3713,'Dornod','061',1144),(3714,'Dornogov,','063',1144),(3715,'DundgovL','059',1144),(3716,'Dzavhan','057',1144),(3717,'Govi-Altay','065',1144),(3718,'Govi-Smber','064',1144),(3719,'Hentiy','039',1144),(3720,'Hovd','043',1144),(3721,'Hovsgol','041',1144),(3722,'Omnogovi','053',1144),(3723,'Orhon','035',1144),(3724,'Ovorhangay','055',1144),(3725,'Selenge','049',1144),(3726,'Shbaatar','051',1144),(3727,'Tov','047',1144),(3728,'Uvs','046',1144),(3729,'Nouakchott','NKC',1137),(3730,'Assaba','03',1137),(3731,'Brakna','05',1137),(3732,'Dakhlet Nouadhibou','08',1137),(3733,'Gorgol','04',1137),(3734,'Guidimaka','10',1137),(3735,'Hodh ech Chargui','01',1137),(3736,'Hodh el Charbi','02',1137),(3737,'Inchiri','12',1137),(3738,'Tagant','09',1137),(3739,'Tiris Zemmour','11',1137),(3740,'Trarza','06',1137),(3741,'Beau Bassin-Rose Hill','BR',1138),(3742,'Curepipe','CU',1138),(3743,'Port Louis','PU',1138),(3744,'Quatre Bornes','QB',1138),(3745,'Vacosa-Phoenix','VP',1138),(3746,'Black River','BL',1138),(3747,'Flacq','FL',1138),(3748,'Grand Port','GP',1138),(3749,'Moka','MO',1138),(3750,'Pamplemousses','PA',1138),(3751,'Plaines Wilhems','PW',1138),(3752,'Riviere du Rempart','RP',1138),(3753,'Savanne','SA',1138),(3754,'Agalega Islands','AG',1138),(3755,'Cargados Carajos Shoals','CC',1138),(3756,'Rodrigues Island','RO',1138),(3757,'Male','MLE',1132),(3758,'Alif','02',1132),(3759,'Baa','20',1132),(3760,'Dhaalu','17',1132),(3761,'Faafu','14',1132),(3762,'Gaaf Alif','27',1132),(3763,'Gaefu Dhaalu','28',1132),(3764,'Gnaviyani','29',1132),(3765,'Haa Alif','07',1132),(3766,'Haa Dhaalu','23',1132),(3767,'Kaafu','26',1132),(3768,'Laamu','05',1132),(3769,'Lhaviyani','03',1132),(3770,'Meemu','12',1132),(3771,'Noonu','25',1132),(3772,'Raa','13',1132),(3773,'Seenu','01',1132),(3774,'Shaviyani','24',1132),(3775,'Thaa','08',1132),(3776,'Vaavu','04',1132),(3777,'Balaka','BA',1130),(3778,'Blantyre','BL',1130),(3779,'Chikwawa','CK',1130),(3780,'Chiradzulu','CR',1130),(3781,'Chitipa','CT',1130),(3782,'Dedza','DE',1130),(3783,'Dowa','DO',1130),(3784,'Karonga','KR',1130),(3785,'Kasungu','KS',1130),(3786,'Likoma Island','LK',1130),(3787,'Lilongwe','LI',1130),(3788,'Machinga','MH',1130),(3789,'Mangochi','MG',1130),(3790,'Mchinji','MC',1130),(3791,'Mulanje','MU',1130),(3792,'Mwanza','MW',1130),(3793,'Mzimba','MZ',1130),(3794,'Nkhata Bay','NB',1130),(3795,'Nkhotakota','NK',1130),(3796,'Nsanje','NS',1130),(3797,'Ntcheu','NU',1130),(3798,'Ntchisi','NI',1130),(3799,'Phalomba','PH',1130),(3800,'Rumphi','RU',1130),(3801,'Salima','SA',1130),(3802,'Thyolo','TH',1130),(3803,'Zomba','ZO',1130),(3804,'Aguascalientes','AGU',1140),(3805,'Baja California','BCN',1140),(3806,'Baja California Sur','BCS',1140),(3807,'Campeche','CAM',1140),(3808,'Coahuila','COA',1140),(3809,'Colima','COL',1140),(3810,'Chiapas','CHP',1140),(3811,'Chihuahua','CHH',1140),(3812,'Durango','DUR',1140),(3813,'Guanajuato','GUA',1140),(3814,'Guerrero','GRO',1140),(3815,'Hidalgo','HID',1140),(3816,'Jalisco','JAL',1140),(3817,'Mexico','MEX',1140),(3818,'Michoacin','MIC',1140),(3819,'Morelos','MOR',1140),(3820,'Nayarit','NAY',1140),(3821,'Nuevo Leon','NLE',1140),(3822,'Oaxaca','OAX',1140),(3823,'Puebla','PUE',1140),(3824,'Queretaro','QUE',1140),(3825,'Quintana Roo','ROO',1140),(3826,'San Luis Potosi','SLP',1140),(3827,'Sinaloa','SIN',1140),(3828,'Sonora','SON',1140),(3829,'Tabasco','TAB',1140),(3830,'Tamaulipas','TAM',1140),(3831,'Tlaxcala','TLA',1140),(3832,'Veracruz','VER',1140),(3833,'Yucatan','YUC',1140),(3834,'Zacatecas','ZAC',1140),(3835,'Wilayah Persekutuan Kuala Lumpur','14',1131),(3836,'Wilayah Persekutuan Labuan','15',1131),(3837,'Wilayah Persekutuan Putrajaya','16',1131),(3838,'Johor','01',1131),(3839,'Kedah','02',1131),(3840,'Kelantan','03',1131),(3841,'Melaka','04',1131),(3842,'Negeri Sembilan','05',1131),(3843,'Pahang','06',1131),(3844,'Perak','08',1131),(3845,'Perlis','09',1131),(3846,'Pulau Pinang','07',1131),(3847,'Sabah','12',1131),(3848,'Sarawak','13',1131),(3849,'Selangor','10',1131),(3850,'Terengganu','11',1131),(3851,'Maputo','MPM',1147),(3852,'Cabo Delgado','P',1147),(3853,'Gaza','G',1147),(3854,'Inhambane','I',1147),(3855,'Manica','B',1147),(3856,'Numpula','N',1147),(3857,'Niaaea','A',1147),(3858,'Sofala','S',1147),(3859,'Tete','T',1147),(3860,'Zambezia','Q',1147),(3861,'Caprivi','CA',1148),(3862,'Erongo','ER',1148),(3863,'Hardap','HA',1148),(3864,'Karas','KA',1148),(3865,'Khomas','KH',1148),(3866,'Kunene','KU',1148),(3867,'Ohangwena','OW',1148),(3868,'Okavango','OK',1148),(3869,'Omaheke','OH',1148),(3870,'Omusati','OS',1148),(3871,'Oshana','ON',1148),(3872,'Oshikoto','OT',1148),(3873,'Otjozondjupa','OD',1148),(3874,'Niamey','8',1156),(3875,'Agadez','1',1156),(3876,'Diffa','2',1156),(3877,'Dosso','3',1156),(3878,'Maradi','4',1156),(3879,'Tahoua','S',1156),(3880,'Tillaberi','6',1156),(3881,'Zinder','7',1156),(3882,'Abuja Capital Territory','FC',1157),(3883,'Abia','AB',1157),(3884,'Adamawa','AD',1157),(3885,'Akwa Ibom','AK',1157),(3886,'Anambra','AN',1157),(3887,'Bauchi','BA',1157),(3888,'Bayelsa','BY',1157),(3889,'Benue','BE',1157),(3890,'Borno','BO',1157),(3891,'Cross River','CR',1157),(3892,'Delta','DE',1157),(3893,'Ebonyi','EB',1157),(3894,'Edo','ED',1157),(3895,'Ekiti','EK',1157),(3896,'Enugu','EN',1157),(3897,'Gombe','GO',1157),(3898,'Imo','IM',1157),(3899,'Jigawa','JI',1157),(3900,'Kaduna','KD',1157),(3901,'Kano','KN',1157),(3902,'Katsina','KT',1157),(3903,'Kebbi','KE',1157),(3904,'Kogi','KO',1157),(3905,'Kwara','KW',1157),(3906,'Lagos','LA',1157),(3907,'Nassarawa','NA',1157),(3908,'Niger','NI',1157),(3909,'Ogun','OG',1157),(3910,'Ondo','ON',1157),(3911,'Osun','OS',1157),(3912,'Oyo','OY',1157),(3913,'Rivers','RI',1157),(3914,'Sokoto','SO',1157),(3915,'Taraba','TA',1157),(3916,'Yobe','YO',1157),(3917,'Zamfara','ZA',1157),(3918,'Boaco','BO',1155),(3919,'Carazo','CA',1155),(3920,'Chinandega','CI',1155),(3921,'Chontales','CO',1155),(3922,'Esteli','ES',1155),(3923,'Jinotega','JI',1155),(3924,'Leon','LE',1155),(3925,'Madriz','MD',1155),(3926,'Managua','MN',1155),(3927,'Masaya','MS',1155),(3928,'Matagalpa','MT',1155),(3929,'Nueva Segovia','NS',1155),(3930,'Rio San Juan','SJ',1155),(3931,'Rivas','RI',1155),(3932,'Atlantico Norte','AN',1155),(3933,'Atlantico Sur','AS',1155),(3934,'Drente','DR',1152),(3935,'Flevoland','FL',1152),(3936,'Friesland','FR',1152),(3937,'Gelderland','GL',1152),(3938,'Groningen','GR',1152),(3939,'Noord-Brabant','NB',1152),(3940,'Noord-Holland','NH',1152),(3941,'Overijssel','OV',1152),(3942,'Utrecht','UT',1152),(3943,'Zuid-Holland','ZH',1152),(3944,'Zeeland','ZL',1152),(3945,'Akershus','02',1161),(3946,'Aust-Agder','09',1161),(3947,'Buskerud','06',1161),(3948,'Finumark','20',1161),(3949,'Hedmark','04',1161),(3950,'Hordaland','12',1161),(3951,'Mire og Romsdal','15',1161),(3952,'Nordland','18',1161),(3953,'Nord-Trindelag','17',1161),(3954,'Oppland','05',1161),(3955,'Oslo','03',1161),(3956,'Rogaland','11',1161),(3957,'Sogn og Fjordane','14',1161),(3958,'Sir-Trindelag','16',1161),(3959,'Telemark','06',1161),(3960,'Troms','19',1161),(3961,'Vest-Agder','10',1161),(3962,'Vestfold','07',1161),(3963,'Ostfold','01',1161),(3964,'Jan Mayen','22',1161),(3965,'Svalbard','21',1161),(3966,'Auckland','AUK',1154),(3967,'Bay of Plenty','BOP',1154),(3968,'Canterbury','CAN',1154),(3969,'Gisborne','GIS',1154),(3970,'Hawkes Bay','HKB',1154),(3971,'Manawatu-Wanganui','MWT',1154),(3972,'Marlborough','MBH',1154),(3973,'Nelson','NSN',1154),(3974,'Northland','NTL',1154),(3975,'Otago','OTA',1154),(3976,'Southland','STL',1154),(3977,'Taranaki','TKI',1154),(3978,'Tasman','TAS',1154),(3979,'waikato','WKO',1154),(3980,'Wellington','WGN',1154),(3981,'West Coast','WTC',1154),(3982,'Ad Dakhillyah','DA',1162),(3983,'Al Batinah','BA',1162),(3984,'Al Janblyah','JA',1162),(3985,'Al Wusta','WU',1162),(3986,'Ash Sharqlyah','SH',1162),(3987,'Az Zahirah','ZA',1162),(3988,'Masqat','MA',1162),(3989,'Musandam','MU',1162),(3990,'Bocas del Toro','1',1166),(3991,'Cocle','2',1166),(3992,'Chiriqui','4',1166),(3993,'Darien','5',1166),(3994,'Herrera','6',1166),(3995,'Loa Santoa','7',1166),(3996,'Panama','8',1166),(3997,'Veraguas','9',1166),(3998,'Comarca de San Blas','Q',1166),(3999,'El Callao','CAL',1169),(4000,'Ancash','ANC',1169),(4001,'Apurimac','APU',1169),(4002,'Arequipa','ARE',1169),(4003,'Ayacucho','AYA',1169),(4004,'Cajamarca','CAJ',1169),(4005,'Cuzco','CUS',1169),(4006,'Huancavelica','HUV',1169),(4007,'Huanuco','HUC',1169),(4008,'Ica','ICA',1169),(4009,'Junin','JUN',1169),(4010,'La Libertad','LAL',1169),(4011,'Lambayeque','LAM',1169),(4012,'Lima','LIM',1169),(4013,'Loreto','LOR',1169),(4014,'Madre de Dios','MDD',1169),(4015,'Moquegua','MOQ',1169),(4016,'Pasco','PAS',1169),(4017,'Piura','PIU',1169),(4018,'Puno','PUN',1169),(4019,'San Martin','SAM',1169),(4020,'Tacna','TAC',1169),(4021,'Tumbes','TUM',1169),(4022,'Ucayali','UCA',1169),(4023,'National Capital District (Port Moresby)','NCD',1167),(4024,'Chimbu','CPK',1167),(4025,'Eastern Highlands','EHG',1167),(4026,'East New Britain','EBR',1167),(4027,'East Sepik','ESW',1167),(4028,'Enga','EPW',1167),(4029,'Gulf','GPK',1167),(4030,'Madang','MPM',1167),(4031,'Manus','MRL',1167),(4032,'Milne Bay','MBA',1167),(4033,'Morobe','MPL',1167),(4034,'New Ireland','NIK',1167),(4035,'North Solomons','NSA',1167),(4036,'Santaun','SAN',1167),(4037,'Southern Highlands','SHM',1167),(4038,'Western Highlands','WHM',1167),(4039,'West New Britain','WBK',1167),(4040,'Abra','ABR',1170),(4041,'Agusan del Norte','AGN',1170),(4042,'Agusan del Sur','AGS',1170),(4043,'Aklan','AKL',1170),(4044,'Albay','ALB',1170),(4045,'Antique','ANT',1170),(4046,'Apayao','APA',1170),(4047,'Aurora','AUR',1170),(4048,'Basilan','BAS',1170),(4049,'Batasn','BAN',1170),(4050,'Batanes','BTN',1170),(4051,'Batangas','BTG',1170),(4052,'Benguet','BEN',1170),(4053,'Biliran','BIL',1170),(4054,'Bohol','BOH',1170),(4055,'Bukidnon','BUK',1170),(4056,'Bulacan','BUL',1170),(4057,'Cagayan','CAG',1170),(4058,'Camarines Norte','CAN',1170),(4059,'Camarines Sur','CAS',1170),(4060,'Camiguin','CAM',1170),(4061,'Capiz','CAP',1170),(4062,'Catanduanes','CAT',1170),(4063,'Cavite','CAV',1170),(4064,'Cebu','CEB',1170),(4065,'Compostela Valley','COM',1170),(4066,'Davao','DAV',1170),(4067,'Davao del Sur','DAS',1170),(4068,'Davao Oriental','DAO',1170),(4069,'Eastern Samar','EAS',1170),(4070,'Guimaras','GUI',1170),(4071,'Ifugao','IFU',1170),(4072,'Ilocos Norte','ILN',1170),(4073,'Ilocos Sur','ILS',1170),(4074,'Iloilo','ILI',1170),(4075,'Isabela','ISA',1170),(4076,'Kalinga-Apayso','KAL',1170),(4077,'Laguna','LAG',1170),(4078,'Lanao del Norte','LAN',1170),(4079,'Lanao del Sur','LAS',1170),(4080,'La Union','LUN',1170),(4081,'Leyte','LEY',1170),(4082,'Maguindanao','MAG',1170),(4083,'Marinduque','MAD',1170),(4084,'Masbate','MAS',1170),(4085,'Mindoro Occidental','MDC',1170),(4086,'Mindoro Oriental','MDR',1170),(4087,'Misamis Occidental','MSC',1170),(4088,'Misamis Oriental','MSR',1170),(4089,'Mountain Province','MOU',1170),(4090,'Negroe Occidental','NEC',1170),(4091,'Negros Oriental','NER',1170),(4092,'North Cotabato','NCO',1170),(4093,'Northern Samar','NSA',1170),(4094,'Nueva Ecija','NUE',1170),(4095,'Nueva Vizcaya','NUV',1170),(4096,'Palawan','PLW',1170),(4097,'Pampanga','PAM',1170),(4098,'Pangasinan','PAN',1170),(4099,'Quezon','QUE',1170),(4100,'Quirino','QUI',1170),(4101,'Rizal','RIZ',1170),(4102,'Romblon','ROM',1170),(4103,'Sarangani','SAR',1170),(4104,'Siquijor','SIG',1170),(4105,'Sorsogon','SOR',1170),(4106,'South Cotabato','SCO',1170),(4107,'Southern Leyte','SLE',1170),(4108,'Sultan Kudarat','SUK',1170),(4109,'Sulu','SLU',1170),(4110,'Surigao del Norte','SUN',1170),(4111,'Surigao del Sur','SUR',1170),(4112,'Tarlac','TAR',1170),(4113,'Tawi-Tawi','TAW',1170),(4114,'Western Samar','WSA',1170),(4115,'Zambales','ZMB',1170),(4116,'Zamboanga del Norte','ZAN',1170),(4117,'Zamboanga del Sur','ZAS',1170),(4118,'Zamboanga Sibiguey','ZSI',1170),(4119,'Islamabad','IS',1163),(4120,'Baluchistan (en)','BA',1163),(4121,'North-West Frontier','NW',1163),(4122,'Sind (en)','SD',1163),(4123,'Federally Administered Tribal Aresa','TA',1163),(4124,'Azad Rashmir','JK',1163),(4125,'Northern Areas','NA',1163),(4126,'Aveiro','01',1173),(4127,'Beja','02',1173),(4128,'Braga','03',1173),(4129,'Braganca','04',1173),(4130,'Castelo Branco','05',1173),(4131,'Colmbra','06',1173),(4132,'Ovora','07',1173),(4133,'Faro','08',1173),(4134,'Guarda','09',1173),(4135,'Leiria','10',1173),(4136,'Lisboa','11',1173),(4137,'Portalegre','12',1173),(4138,'Porto','13',1173),(4139,'Santarem','14',1173),(4140,'Setubal','15',1173),(4141,'Viana do Castelo','16',1173),(4142,'Vila Real','17',1173),(4143,'Viseu','18',1173),(4144,'Regiao Autonoma dos Acores','20',1173),(4145,'Regiao Autonoma da Madeira','30',1173),(4146,'Asuncion','ASU',1168),(4147,'Alto Paraguay','16',1168),(4148,'Alto Parana','10',1168),(4149,'Amambay','13',1168),(4150,'Boqueron','19',1168),(4151,'Caeguazu','5',1168),(4152,'Caazapl','6',1168),(4153,'Canindeyu','14',1168),(4154,'Concepcion','1',1168),(4155,'Cordillera','3',1168),(4156,'Guaira','4',1168),(4157,'Itapua','7',1168),(4158,'Miaiones','8',1168),(4159,'Neembucu','12',1168),(4160,'Paraguari','9',1168),(4161,'Presidente Hayes','15',1168),(4162,'San Pedro','2',1168),(4163,'Ad Dawhah','DA',1175),(4164,'Al Ghuwayriyah','GH',1175),(4165,'Al Jumayliyah','JU',1175),(4166,'Al Khawr','KH',1175),(4167,'Al Wakrah','WA',1175),(4168,'Ar Rayyan','RA',1175),(4169,'Jariyan al Batnah','JB',1175),(4170,'Madinat ash Shamal','MS',1175),(4171,'Umm Salal','US',1175),(4172,'Bucuresti','B',1176),(4173,'Alba','AB',1176),(4174,'Arad','AR',1176),(4175,'Arges','AG',1176),(4176,'Bacau','BC',1176),(4177,'Bihor','BH',1176),(4178,'Bistrita-Nasaud','BN',1176),(4179,'Boto\'ani','BT',1176),(4180,'Bra\'ov','BV',1176),(4181,'Braila','BR',1176),(4182,'Buzau','BZ',1176),(4183,'Caras-Severin','CS',1176),(4184,'Ca la ras\'i','CL',1176),(4185,'Cluj','CJ',1176),(4186,'Constant\'a','CT',1176),(4187,'Covasna','CV',1176),(4188,'Dambovit\'a','DB',1176),(4189,'Dolj','DJ',1176),(4190,'Galat\'i','GL',1176),(4191,'Giurgiu','GR',1176),(4192,'Gorj','GJ',1176),(4193,'Harghita','HR',1176),(4194,'Hunedoara','HD',1176),(4195,'Ialomit\'a','IL',1176),(4196,'Ias\'i','IS',1176),(4197,'Ilfov','IF',1176),(4198,'Maramures','MM',1176),(4199,'Mehedint\'i','MH',1176),(4200,'Mures','MS',1176),(4201,'Neamt','NT',1176),(4202,'Olt','OT',1176),(4203,'Prahova','PH',1176),(4204,'Satu Mare','SM',1176),(4205,'Sa laj','SJ',1176),(4206,'Sibiu','SB',1176),(4207,'Suceava','SV',1176),(4208,'Teleorman','TR',1176),(4209,'Timis','TM',1176),(4210,'Tulcea','TL',1176),(4211,'Vaslui','VS',1176),(4212,'Valcea','VL',1176),(4213,'Vrancea','VN',1176),(4214,'Adygeya, Respublika','AD',1177),(4215,'Altay, Respublika','AL',1177),(4216,'Bashkortostan, Respublika','BA',1177),(4217,'Buryatiya, Respublika','BU',1177),(4218,'Chechenskaya Respublika','CE',1177),(4219,'Chuvashskaya Respublika','CU',1177),(4220,'Dagestan, Respublika','DA',1177),(4221,'Ingushskaya Respublika','IN',1177),(4222,'Kabardino-Balkarskaya','KB',1177),(4223,'Kalmykiya, Respublika','KL',1177),(4224,'Karachayevo-Cherkesskaya Respublika','KC',1177),(4225,'Kareliya, Respublika','KR',1177),(4226,'Khakasiya, Respublika','KK',1177),(4227,'Komi, Respublika','KO',1177),(4228,'Mariy El, Respublika','ME',1177),(4229,'Mordoviya, Respublika','MO',1177),(4230,'Sakha, Respublika [Yakutiya]','SA',1177),(4231,'Severnaya Osetiya, Respublika','SE',1177),(4232,'Tatarstan, Respublika','TA',1177),(4233,'Tyva, Respublika [Tuva]','TY',1177),(4234,'Udmurtskaya Respublika','UD',1177),(4235,'Altayskiy kray','ALT',1177),(4236,'Khabarovskiy kray','KHA',1177),(4237,'Krasnodarskiy kray','KDA',1177),(4238,'Krasnoyarskiy kray','KYA',1177),(4239,'Primorskiy kray','PRI',1177),(4240,'Stavropol\'skiy kray','STA',1177),(4241,'Amurskaya oblast\'','AMU',1177),(4242,'Arkhangel\'skaya oblast\'','ARK',1177),(4243,'Astrakhanskaya oblast\'','AST',1177),(4244,'Belgorodskaya oblast\'','BEL',1177),(4245,'Bryanskaya oblast\'','BRY',1177),(4246,'Chelyabinskaya oblast\'','CHE',1177),(4247,'Chitinskaya oblast\'','CHI',1177),(4248,'Irkutskaya oblast\'','IRK',1177),(4249,'Ivanovskaya oblast\'','IVA',1177),(4250,'Kaliningradskaya oblast\'','KGD',1177),(4251,'Kaluzhskaya oblast\'','KLU',1177),(4252,'Kamchatskaya oblast\'','KAM',1177),(4253,'Kemerovskaya oblast\'','KEM',1177),(4254,'Kirovskaya oblast\'','KIR',1177),(4255,'Kostromskaya oblast\'','KOS',1177),(4256,'Kurganskaya oblast\'','KGN',1177),(4257,'Kurskaya oblast\'','KRS',1177),(4258,'Leningradskaya oblast\'','LEN',1177),(4259,'Lipetskaya oblast\'','LIP',1177),(4260,'Magadanskaya oblast\'','MAG',1177),(4261,'Moskovskaya oblast\'','MOS',1177),(4262,'Murmanskaya oblast\'','MUR',1177),(4263,'Nizhegorodskaya oblast\'','NIZ',1177),(4264,'Novgorodskaya oblast\'','NGR',1177),(4265,'Novosibirskaya oblast\'','NVS',1177),(4266,'Omskaya oblast\'','OMS',1177),(4267,'Orenburgskaya oblast\'','ORE',1177),(4268,'Orlovskaya oblast\'','ORL',1177),(4269,'Penzenskaya oblast\'','PNZ',1177),(4270,'Permskaya oblast\'','PER',1177),(4271,'Pskovskaya oblast\'','PSK',1177),(4272,'Rostovskaya oblast\'','ROS',1177),(4273,'Ryazanskaya oblast\'','RYA',1177),(4274,'Sakhalinskaya oblast\'','SAK',1177),(4275,'Samarskaya oblast\'','SAM',1177),(4276,'Saratovskaya oblast\'','SAR',1177),(4277,'Smolenskaya oblast\'','SMO',1177),(4278,'Sverdlovskaya oblast\'','SVE',1177),(4279,'Tambovskaya oblast\'','TAM',1177),(4280,'Tomskaya oblast\'','TOM',1177),(4281,'Tul\'skaya oblast\'','TUL',1177),(4282,'Tverskaya oblast\'','TVE',1177),(4283,'Tyumenskaya oblast\'','TYU',1177),(4284,'Ul\'yanovskaya oblast\'','ULY',1177),(4285,'Vladimirskaya oblast\'','VLA',1177),(4286,'Volgogradskaya oblast\'','VGG',1177),(4287,'Vologodskaya oblast\'','VLG',1177),(4288,'Voronezhskaya oblast\'','VOR',1177),(4289,'Yaroslavskaya oblast\'','YAR',1177),(4290,'Moskva','MOW',1177),(4291,'Sankt-Peterburg','SPE',1177),(4292,'Yevreyskaya avtonomnaya oblast\'','YEV',1177),(4293,'Aginskiy Buryatskiy avtonomnyy','AGB',1177),(4294,'Chukotskiy avtonomnyy okrug','CHU',1177),(4295,'Evenkiyskiy avtonomnyy okrug','EVE',1177),(4296,'Khanty-Mansiyskiy avtonomnyy okrug','KHM',1177),(4297,'Komi-Permyatskiy avtonomnyy okrug','KOP',1177),(4298,'Koryakskiy avtonomnyy okrug','KOR',1177),(4299,'Nenetskiy avtonomnyy okrug','NEN',1177),(4300,'Taymyrskiy (Dolgano-Nenetskiy)','TAY',1177),(4301,'Ust\'-Ordynskiy Buryatskiy','UOB',1177),(4302,'Yamalo-Nenetskiy avtonomnyy okrug','YAN',1177),(4303,'Butare','C',1178),(4304,'Byumba','I',1178),(4305,'Cyangugu','E',1178),(4306,'Gikongoro','D',1178),(4307,'Gisenyi','G',1178),(4308,'Gitarama','B',1178),(4309,'Kibungo','J',1178),(4310,'Kibuye','F',1178),(4311,'Kigali-Rural Kigali y\' Icyaro','K',1178),(4312,'Kigali-Ville Kigali Ngari','L',1178),(4313,'Mutara','M',1178),(4314,'Ruhengeri','H',1178),(4315,'Al Batah','11',1187),(4316,'Al H,udd ash Shamallyah','08',1187),(4317,'Al Jawf','12',1187),(4318,'Al Madinah','03',1187),(4319,'Al Qasim','05',1187),(4320,'Ar Riyad','01',1187),(4321,'Asir','14',1187),(4322,'Ha\'il','06',1187),(4323,'Jlzan','09',1187),(4324,'Makkah','02',1187),(4325,'Najran','10',1187),(4326,'Tabuk','07',1187),(4327,'Capital Territory (Honiara)','CT',1194),(4328,'Guadalcanal','GU',1194),(4329,'Isabel','IS',1194),(4330,'Makira','MK',1194),(4331,'Malaita','ML',1194),(4332,'Temotu','TE',1194),(4333,'A\'ali an Nil','23',1200),(4334,'Al Bah al Ahmar','26',1200),(4335,'Al Buhayrat','18',1200),(4336,'Al Jazirah','07',1200),(4337,'Al Khartum','03',1200),(4338,'Al Qadarif','06',1200),(4339,'Al Wahdah','22',1200),(4340,'An Nil','04',1200),(4341,'An Nil al Abyaq','08',1200),(4342,'An Nil al Azraq','24',1200),(4343,'Ash Shamallyah','01',1200),(4344,'Bahr al Jabal','17',1200),(4345,'Gharb al Istiwa\'iyah','16',1200),(4346,'Gharb Ba~r al Ghazal','14',1200),(4347,'Gharb Darfur','12',1200),(4348,'Gharb Kurdufan','10',1200),(4349,'Janub Darfur','11',1200),(4350,'Janub Rurdufan','13',1200),(4351,'Jnqall','20',1200),(4352,'Kassala','05',1200),(4353,'Shamal Batr al Ghazal','15',1200),(4354,'Shamal Darfur','02',1200),(4355,'Shamal Kurdufan','09',1200),(4356,'Sharq al Istiwa\'iyah','19',1200),(4357,'Sinnar','25',1200),(4358,'Warab','21',1200),(4359,'Blekinge lan','K',1204),(4360,'Dalarnas lan','W',1204),(4361,'Gotlands lan','I',1204),(4362,'Gavleborge lan','X',1204),(4363,'Hallands lan','N',1204),(4364,'Jamtlande lan','Z',1204),(4365,'Jonkopings lan','F',1204),(4366,'Kalmar lan','H',1204),(4367,'Kronoberge lan','G',1204),(4368,'Norrbottena lan','BD',1204),(4369,'Skane lan','M',1204),(4370,'Stockholms lan','AB',1204),(4371,'Sodermanlands lan','D',1204),(4372,'Uppsala lan','C',1204),(4373,'Varmlanda lan','S',1204),(4374,'Vasterbottens lan','AC',1204),(4375,'Vasternorrlands lan','Y',1204),(4376,'Vastmanlanda lan','U',1204),(4377,'Vastra Gotalands lan','Q',1204),(4378,'Orebro lan','T',1204),(4379,'Ostergotlands lan','E',1204),(4380,'Saint Helena','SH',1180),(4381,'Ascension','AC',1180),(4382,'Tristan da Cunha','TA',1180),(4383,'Ajdovscina','001',1193),(4384,'Beltinci','002',1193),(4385,'Benedikt','148',1193),(4386,'Bistrica ob Sotli','149',1193),(4387,'Bled','003',1193),(4388,'Bloke','150',1193),(4389,'Bohinj','004',1193),(4390,'Borovnica','005',1193),(4391,'Bovec','006',1193),(4392,'Braslovce','151',1193),(4393,'Brda','007',1193),(4394,'Brezovica','008',1193),(4395,'Brezica','009',1193),(4396,'Cankova','152',1193),(4397,'Celje','011',1193),(4398,'Cerklje na Gorenjskem','012',1193),(4399,'Cerknica','013',1193),(4400,'Cerkno','014',1193),(4401,'Cerkvenjak','153',1193),(4402,'Crensovci','015',1193),(4403,'Crna na Koroskem','016',1193),(4404,'Crnomelj','017',1193),(4405,'Destrnik','018',1193),(4406,'Divaca','019',1193),(4407,'Dobje','154',1193),(4408,'Dobrepolje','020',1193),(4409,'Dobrna','155',1193),(4410,'Dobrova-Polhov Gradec','021',1193),(4411,'Dobrovnik','156',1193),(4412,'Dol pri Ljubljani','022',1193),(4413,'Dolenjske Toplice','157',1193),(4414,'Domzale','023',1193),(4415,'Dornava','024',1193),(4416,'Dravograd','025',1193),(4417,'Duplek','026',1193),(4418,'Gorenja vas-Poljane','027',1193),(4419,'Gorsnica','028',1193),(4420,'Gornja Radgona','029',1193),(4421,'Gornji Grad','030',1193),(4422,'Gornji Petrovci','031',1193),(4423,'Grad','158',1193),(4424,'Grosuplje','032',1193),(4425,'Hajdina','159',1193),(4426,'Hoce-Slivnica','160',1193),(4427,'Hodos','161',1193),(4428,'Jorjul','162',1193),(4429,'Hrastnik','034',1193),(4430,'Hrpelje-Kozina','035',1193),(4431,'Idrija','036',1193),(4432,'Ig','037',1193),(4433,'IIrska Bistrica','038',1193),(4434,'Ivancna Gorica','039',1193),(4435,'Izola','040',1193),(4436,'Jesenice','041',1193),(4437,'Jezersko','163',1193),(4438,'Jursinci','042',1193),(4439,'Kamnik','043',1193),(4440,'Kanal','044',1193),(4441,'Kidricevo','045',1193),(4442,'Kobarid','046',1193),(4443,'Kobilje','047',1193),(4444,'Jovevje','048',1193),(4445,'Komen','049',1193),(4446,'Komenda','164',1193),(4447,'Koper','050',1193),(4448,'Kostel','165',1193),(4449,'Kozje','051',1193),(4450,'Kranj','052',1193),(4451,'Kranjska Gora','053',1193),(4452,'Krizevci','166',1193),(4453,'Krsko','054',1193),(4454,'Kungota','055',1193),(4455,'Kuzma','056',1193),(4456,'Lasko','057',1193),(4457,'Lenart','058',1193),(4458,'Lendava','059',1193),(4459,'Litija','060',1193),(4460,'Ljubljana','061',1193),(4461,'Ljubno','062',1193),(4462,'Ljutomer','063',1193),(4463,'Logatec','064',1193),(4464,'Loska dolina','065',1193),(4465,'Loski Potok','066',1193),(4466,'Lovrenc na Pohorju','167',1193),(4467,'Luce','067',1193),(4468,'Lukovica','068',1193),(4469,'Majsperk','069',1193),(4470,'Maribor','070',1193),(4471,'Markovci','168',1193),(4472,'Medvode','071',1193),(4473,'Menges','072',1193),(4474,'Metlika','073',1193),(4475,'Mezica','074',1193),(4476,'Miklavz na Dravskern polju','169',1193),(4477,'Miren-Kostanjevica','075',1193),(4478,'Mirna Pec','170',1193),(4479,'Mislinja','076',1193),(4480,'Moravce','077',1193),(4481,'Moravske Toplice','078',1193),(4482,'Mozirje','079',1193),(4483,'Murska Sobota','080',1193),(4484,'Muta','081',1193),(4485,'Naklo','082',1193),(4486,'Nazarje','083',1193),(4487,'Nova Gorica','084',1193),(4488,'Nova mesto','085',1193),(4489,'Sveta Ana','181',1193),(4490,'Sveti Andraz v Slovenskih goricah','182',1193),(4491,'Sveti Jurij','116',1193),(4492,'Salovci','033',1193),(4493,'Sempeter-Vrtojba','183',1193),(4494,'Sencur','117',1193),(4495,'Sentilj','118',1193),(4496,'Sentjernej','119',1193),(4497,'Sentjur pri Celju','120',1193),(4498,'Skocjan','121',1193),(4499,'Skofja Loka','122',1193),(4500,'Skoftjica','123',1193),(4501,'Smarje pri Jelsah','124',1193),(4502,'Smartno ob Paki','125',1193),(4503,'Smartno pri Litiji','194',1193),(4504,'Sostanj','126',1193),(4505,'Store','127',1193),(4506,'Tabor','184',1193),(4507,'Tisina','010',1193),(4508,'Tolmin','128',1193),(4509,'Trbovje','129',1193),(4510,'Trebnje','130',1193),(4511,'Trnovska vas','185',1193),(4512,'Trzic','131',1193),(4513,'Trzin','186',1193),(4514,'Turnisce','132',1193),(4515,'Velenje','133',1193),(4516,'Velika Polana','187',1193),(4517,'Velika Lasce','134',1193),(4518,'Verzej','188',1193),(4519,'Videm','135',1193),(4520,'Vipava','136',1193),(4521,'Vitanje','137',1193),(4522,'Vojnik','138',1193),(4523,'Vransko','189',1193),(4524,'Vrhnika','140',1193),(4525,'Vuzenica','141',1193),(4526,'Zagorje ob Savi','142',1193),(4527,'Zavrc','143',1193),(4528,'Zrece','144',1193),(4529,'Zalec','190',1193),(4530,'Zelezniki','146',1193),(4531,'Zetale','191',1193),(4532,'Ziri','147',1193),(4533,'Zirovnica','192',1193),(4534,'Zuzemberk','193',1193),(4535,'BanskobystrickÃ½ kraj','BC',1192),(4536,'BratislavskÃ½ kraj','BL',1192),(4537,'KoÅ¡ickÃ½ kraj','KI',1192),(4538,'Nitriansky kraj','NJ',1192),(4539,'PreÅ¡ovskÃ½ kraj','PV',1192),(4540,'TrenÄiansky kraj','TC',1192),(4541,'TrnavskÃ½ kraj','TA',1192),(4542,'Å½ilinskÃ½ kraj','ZI',1192),(4543,'Western Area (Freetown)','W',1190),(4544,'Dakar','DK',1188),(4545,'Diourbel','DB',1188),(4546,'Fatick','FK',1188),(4547,'Kaolack','KL',1188),(4548,'Kolda','KD',1188),(4549,'Louga','LG',1188),(4550,'Matam','MT',1188),(4551,'Saint-Louis','SL',1188),(4552,'Tambacounda','TC',1188),(4553,'Thies','TH',1188),(4554,'Ziguinchor','ZG',1188),(4555,'Awdal','AW',1195),(4556,'Bakool','BK',1195),(4557,'Banaadir','BN',1195),(4558,'Bay','BY',1195),(4559,'Galguduud','GA',1195),(4560,'Gedo','GE',1195),(4561,'Hiirsan','HI',1195),(4562,'Jubbada Dhexe','JD',1195),(4563,'Jubbada Hoose','JH',1195),(4564,'Mudug','MU',1195),(4565,'Nugaal','NU',1195),(4566,'Saneag','SA',1195),(4567,'Shabeellaha Dhexe','SD',1195),(4568,'Shabeellaha Hoose','SH',1195),(4569,'Sool','SO',1195),(4570,'Togdheer','TO',1195),(4571,'Woqooyi Galbeed','WO',1195),(4572,'Brokopondo','BR',1201),(4573,'Commewijne','CM',1201),(4574,'Coronie','CR',1201),(4575,'Marowijne','MA',1201),(4576,'Nickerie','NI',1201),(4577,'Paramaribo','PM',1201),(4578,'Saramacca','SA',1201),(4579,'Sipaliwini','SI',1201),(4580,'Wanica','WA',1201),(4581,'Principe','P',1207),(4582,'Sao Tome','S',1207),(4583,'Ahuachapan','AH',1066),(4584,'Cabanas','CA',1066),(4585,'Cuscatlan','CU',1066),(4586,'Chalatenango','CH',1066),(4587,'Morazan','MO',1066),(4588,'San Miguel','SM',1066),(4589,'San Salvador','SS',1066),(4590,'Santa Ana','SA',1066),(4591,'San Vicente','SV',1066),(4592,'Sonsonate','SO',1066),(4593,'Usulutan','US',1066),(4594,'Al Hasakah','HA',1206),(4595,'Al Ladhiqiyah','LA',1206),(4596,'Al Qunaytirah','QU',1206),(4597,'Ar Raqqah','RA',1206),(4598,'As Suwayda\'','SU',1206),(4599,'Dar\'a','DR',1206),(4600,'Dayr az Zawr','DY',1206),(4601,'Dimashq','DI',1206),(4602,'Halab','HL',1206),(4603,'Hamah','HM',1206),(4604,'Jim\'','HI',1206),(4605,'Idlib','ID',1206),(4606,'Rif Dimashq','RD',1206),(4607,'Tarts','TA',1206),(4608,'Hhohho','HH',1203),(4609,'Lubombo','LU',1203),(4610,'Manzini','MA',1203),(4611,'Shiselweni','SH',1203),(4612,'Batha','BA',1043),(4613,'Biltine','BI',1043),(4614,'Borkou-Ennedi-Tibesti','BET',1043),(4615,'Chari-Baguirmi','CB',1043),(4616,'Guera','GR',1043),(4617,'Kanem','KA',1043),(4618,'Lac','LC',1043),(4619,'Logone-Occidental','LO',1043),(4620,'Logone-Oriental','LR',1043),(4621,'Mayo-Kebbi','MK',1043),(4622,'Moyen-Chari','MC',1043),(4623,'Ouaddai','OD',1043),(4624,'Salamat','SA',1043),(4625,'Tandjile','TA',1043),(4626,'Kara','K',1214),(4627,'Maritime (Region)','M',1214),(4628,'Savannes','S',1214),(4629,'Krung Thep Maha Nakhon Bangkok','10',1211),(4630,'Phatthaya','S',1211),(4631,'Amnat Charoen','37',1211),(4632,'Ang Thong','15',1211),(4633,'Buri Ram','31',1211),(4634,'Chachoengsao','24',1211),(4635,'Chai Nat','18',1211),(4636,'Chaiyaphum','36',1211),(4637,'Chanthaburi','22',1211),(4638,'Chiang Mai','50',1211),(4639,'Chiang Rai','57',1211),(4640,'Chon Buri','20',1211),(4641,'Chumphon','86',1211),(4642,'Kalasin','46',1211),(4643,'Kamphasng Phet','62',1211),(4644,'Kanchanaburi','71',1211),(4645,'Khon Kaen','40',1211),(4646,'Krabi','81',1211),(4647,'Lampang','52',1211),(4648,'Lamphun','51',1211),(4649,'Loei','42',1211),(4650,'Lop Buri','16',1211),(4651,'Mae Hong Son','58',1211),(4652,'Maha Sarakham','44',1211),(4653,'Mukdahan','49',1211),(4654,'Nakhon Nayok','26',1211),(4655,'Nakhon Pathom','73',1211),(4656,'Nakhon Phanom','48',1211),(4657,'Nakhon Ratchasima','30',1211),(4658,'Nakhon Sawan','60',1211),(4659,'Nakhon Si Thammarat','80',1211),(4660,'Nan','55',1211),(4661,'Narathiwat','96',1211),(4662,'Nong Bua Lam Phu','39',1211),(4663,'Nong Khai','43',1211),(4664,'Nonthaburi','12',1211),(4665,'Pathum Thani','13',1211),(4666,'Pattani','94',1211),(4667,'Phangnga','82',1211),(4668,'Phatthalung','93',1211),(4669,'Phayao','56',1211),(4670,'Phetchabun','67',1211),(4671,'Phetchaburi','76',1211),(4672,'Phichit','66',1211),(4673,'Phitsanulok','65',1211),(4674,'Phrae','54',1211),(4675,'Phra Nakhon Si Ayutthaya','14',1211),(4676,'Phaket','83',1211),(4677,'Prachin Buri','25',1211),(4678,'Prachuap Khiri Khan','77',1211),(4679,'Ranong','85',1211),(4680,'Ratchaburi','70',1211),(4681,'Rayong','21',1211),(4682,'Roi Et','45',1211),(4683,'Sa Kaeo','27',1211),(4684,'Sakon Nakhon','47',1211),(4685,'Samut Prakan','11',1211),(4686,'Samut Sakhon','74',1211),(4687,'Samut Songkhram','75',1211),(4688,'Saraburi','19',1211),(4689,'Satun','91',1211),(4690,'Sing Buri','17',1211),(4691,'Si Sa Ket','33',1211),(4692,'Songkhla','90',1211),(4693,'Sukhothai','64',1211),(4694,'Suphan Buri','72',1211),(4695,'Surat Thani','84',1211),(4696,'Surin','32',1211),(4697,'Tak','63',1211),(4698,'Trang','92',1211),(4699,'Trat','23',1211),(4700,'Ubon Ratchathani','34',1211),(4701,'Udon Thani','41',1211),(4702,'Uthai Thani','61',1211),(4703,'Uttaradit','53',1211),(4704,'Yala','95',1211),(4705,'Yasothon','35',1211),(4706,'Sughd','SU',1209),(4707,'Khatlon','KT',1209),(4708,'Gorno-Badakhshan','GB',1209),(4709,'Ahal','A',1220),(4710,'Balkan','B',1220),(4711,'Dasoguz','D',1220),(4712,'Lebap','L',1220),(4713,'Mary','M',1220),(4714,'BÃ©ja','31',1218),(4715,'Ben Arous','13',1218),(4716,'Bizerte','23',1218),(4717,'GabÃ¨s','81',1218),(4718,'Gafsa','71',1218),(4719,'Jendouba','32',1218),(4720,'Kairouan','41',1218),(4721,'Rasserine','42',1218),(4722,'Kebili','73',1218),(4723,'L\'Ariana','12',1218),(4724,'Le Ref','33',1218),(4725,'Mahdia','53',1218),(4726,'La Manouba','14',1218),(4727,'Medenine','82',1218),(4728,'Moneatir','52',1218),(4729,'Naboul','21',1218),(4730,'Sfax','61',1218),(4731,'Sidi Bouxid','43',1218),(4732,'Siliana','34',1218),(4733,'Sousse','51',1218),(4734,'Tataouine','83',1218),(4735,'Tozeur','72',1218),(4736,'Tunis','11',1218),(4737,'Zaghouan','22',1218),(4738,'Adana','01',1219),(4739,'Ad yaman','02',1219),(4740,'Afyon','03',1219),(4741,'Ag r','04',1219),(4742,'Aksaray','68',1219),(4743,'Amasya','05',1219),(4744,'Ankara','06',1219),(4745,'Antalya','07',1219),(4746,'Ardahan','75',1219),(4747,'Artvin','08',1219),(4748,'Aydin','09',1219),(4749,'Bal kesir','10',1219),(4750,'Bartin','74',1219),(4751,'Batman','72',1219),(4752,'Bayburt','69',1219),(4753,'Bilecik','11',1219),(4754,'Bingol','12',1219),(4755,'Bitlis','13',1219),(4756,'Bolu','14',1219),(4757,'Burdur','15',1219),(4758,'Bursa','16',1219),(4759,'Canakkale','17',1219),(4760,'Cankir','18',1219),(4761,'Corum','19',1219),(4762,'Denizli','20',1219),(4763,'Diyarbakir','21',1219),(4764,'Duzce','81',1219),(4765,'Edirne','22',1219),(4766,'Elazig','23',1219),(4767,'Erzincan','24',1219),(4768,'Erzurum','25',1219),(4769,'Eskis\'ehir','26',1219),(4770,'Gaziantep','27',1219),(4771,'Giresun','28',1219),(4772,'Gms\'hane','29',1219),(4773,'Hakkari','30',1219),(4774,'Hatay','31',1219),(4775,'Igidir','76',1219),(4776,'Isparta','32',1219),(4777,'Icel','33',1219),(4778,'Istanbul','34',1219),(4779,'Izmir','35',1219),(4780,'Kahramanmaras','46',1219),(4781,'Karabk','78',1219),(4782,'Karaman','70',1219),(4783,'Kars','36',1219),(4784,'Kastamonu','37',1219),(4785,'Kayseri','38',1219),(4786,'Kirikkale','71',1219),(4787,'Kirklareli','39',1219),(4788,'Kirs\'ehir','40',1219),(4789,'Kilis','79',1219),(4790,'Kocaeli','41',1219),(4791,'Konya','42',1219),(4792,'Ktahya','43',1219),(4793,'Malatya','44',1219),(4794,'Manisa','45',1219),(4795,'Mardin','47',1219),(4796,'Mugila','48',1219),(4797,'Mus','49',1219),(4798,'Nevs\'ehir','50',1219),(4799,'Nigide','51',1219),(4800,'Ordu','52',1219),(4801,'Osmaniye','80',1219),(4802,'Rize','53',1219),(4803,'Sakarya','54',1219),(4804,'Samsun','55',1219),(4805,'Siirt','56',1219),(4806,'Sinop','57',1219),(4807,'Sivas','58',1219),(4808,'S\'anliurfa','63',1219),(4809,'S\'rnak','73',1219),(4810,'Tekirdag','59',1219),(4811,'Tokat','60',1219),(4812,'Trabzon','61',1219),(4813,'Tunceli','62',1219),(4814,'Us\'ak','64',1219),(4815,'Van','65',1219),(4816,'Yalova','77',1219),(4817,'Yozgat','66',1219),(4818,'Zonguldak','67',1219),(4819,'Couva-Tabaquite-Talparo','CTT',1217),(4820,'Diego Martin','DMN',1217),(4821,'Eastern Tobago','ETO',1217),(4822,'Penal-Debe','PED',1217),(4823,'Princes Town','PRT',1217),(4824,'Rio Claro-Mayaro','RCM',1217),(4825,'Sangre Grande','SGE',1217),(4826,'San Juan-Laventille','SJL',1217),(4827,'Siparia','SIP',1217),(4828,'Tunapuna-Piarco','TUP',1217),(4829,'Western Tobago','WTO',1217),(4830,'Arima','ARI',1217),(4831,'Chaguanas','CHA',1217),(4832,'Point Fortin','PTF',1217),(4833,'Port of Spain','POS',1217),(4834,'San Fernando','SFO',1217),(4835,'Aileu','AL',1063),(4836,'Ainaro','AN',1063),(4837,'Bacucau','BA',1063),(4838,'Bobonaro','BO',1063),(4839,'Cova Lima','CO',1063),(4840,'Dili','DI',1063),(4841,'Ermera','ER',1063),(4842,'Laulem','LA',1063),(4843,'Liquica','LI',1063),(4844,'Manatuto','MT',1063),(4845,'Manafahi','MF',1063),(4846,'Oecussi','OE',1063),(4847,'Viqueque','VI',1063),(4848,'Changhua County','CHA',1208),(4849,'Chiayi County','CYQ',1208),(4850,'Hsinchu County','HSQ',1208),(4851,'Hualien County','HUA',1208),(4852,'Ilan County','ILA',1208),(4853,'Kaohsiung County','KHQ',1208),(4854,'Miaoli County','MIA',1208),(4855,'Nantou County','NAN',1208),(4856,'Penghu County','PEN',1208),(4857,'Pingtung County','PIF',1208),(4858,'Taichung County','TXQ',1208),(4859,'Tainan County','TNQ',1208),(4860,'Taipei County','TPQ',1208),(4861,'Taitung County','TTT',1208),(4862,'Taoyuan County','TAO',1208),(4863,'Yunlin Conuty','YUN',1208),(4864,'Keelung City','KEE',1208),(4865,'Arusha','01',1210),(4866,'Dar-es-Salaam','02',1210),(4867,'Dodoma','03',1210),(4868,'Iringa','04',1210),(4869,'Kagera','05',1210),(4870,'Kaskazini Pemba','06',1210),(4871,'Kaskazini Unguja','07',1210),(4872,'Xigoma','08',1210),(4873,'Kilimanjaro','09',1210),(4874,'Rusini Pemba','10',1210),(4875,'Kusini Unguja','11',1210),(4876,'Lindi','12',1210),(4877,'Manyara','26',1210),(4878,'Mara','13',1210),(4879,'Mbeya','14',1210),(4880,'Mjini Magharibi','15',1210),(4881,'Morogoro','16',1210),(4882,'Mtwara','17',1210),(4883,'Pwani','19',1210),(4884,'Rukwa','20',1210),(4885,'Ruvuma','21',1210),(4886,'Shinyanga','22',1210),(4887,'Singida','23',1210),(4888,'Tabora','24',1210),(4889,'Tanga','25',1210),(4890,'Cherkas\'ka Oblast\'','71',1224),(4891,'Chernihivs\'ka Oblast\'','74',1224),(4892,'Chernivets\'ka Oblast\'','77',1224),(4893,'Dnipropetrovs\'ka Oblast\'','12',1224),(4894,'Donets\'ka Oblast\'','14',1224),(4895,'Ivano-Frankivs\'ka Oblast\'','26',1224),(4896,'Kharkivs\'ka Oblast\'','63',1224),(4897,'Khersons\'ka Oblast\'','65',1224),(4898,'Khmel\'nyts\'ka Oblast\'','68',1224),(4899,'Kirovohrads\'ka Oblast\'','35',1224),(4900,'Kyivs\'ka Oblast\'','32',1224),(4901,'Luhans\'ka Oblast\'','09',1224),(4902,'L\'vivs\'ka Oblast\'','46',1224),(4903,'Mykolaivs\'ka Oblast\'','48',1224),(4904,'Odes \'ka Oblast\'','51',1224),(4905,'Poltavs\'ka Oblast\'','53',1224),(4906,'Rivnens\'ka Oblast\'','56',1224),(4907,'Sums \'ka Oblast\'','59',1224),(4908,'Ternopil\'s\'ka Oblast\'','61',1224),(4909,'Vinnyts\'ka Oblast\'','05',1224),(4910,'Volyos\'ka Oblast\'','07',1224),(4911,'Zakarpats\'ka Oblast\'','21',1224),(4912,'Zaporiz\'ka Oblast\'','23',1224),(4913,'Zhytomyrs\'ka Oblast\'','18',1224),(4914,'Respublika Krym','43',1224),(4915,'Kyiv','30',1224),(4916,'Sevastopol','40',1224),(4917,'Adjumani','301',1223),(4918,'Apac','302',1223),(4919,'Arua','303',1223),(4920,'Bugiri','201',1223),(4921,'Bundibugyo','401',1223),(4922,'Bushenyi','402',1223),(4923,'Busia','202',1223),(4924,'Gulu','304',1223),(4925,'Hoima','403',1223),(4926,'Iganga','203',1223),(4927,'Jinja','204',1223),(4928,'Kabale','404',1223),(4929,'Kabarole','405',1223),(4930,'Kaberamaido','213',1223),(4931,'Kalangala','101',1223),(4932,'Kampala','102',1223),(4933,'Kamuli','205',1223),(4934,'Kamwenge','413',1223),(4935,'Kanungu','414',1223),(4936,'Kapchorwa','206',1223),(4937,'Kasese','406',1223),(4938,'Katakwi','207',1223),(4939,'Kayunga','112',1223),(4940,'Kibaale','407',1223),(4941,'Kiboga','103',1223),(4942,'Kisoro','408',1223),(4943,'Kitgum','305',1223),(4944,'Kotido','306',1223),(4945,'Kumi','208',1223),(4946,'Kyenjojo','415',1223),(4947,'Lira','307',1223),(4948,'Luwero','104',1223),(4949,'Masaka','105',1223),(4950,'Masindi','409',1223),(4951,'Mayuge','214',1223),(4952,'Mbale','209',1223),(4953,'Mbarara','410',1223),(4954,'Moroto','308',1223),(4955,'Moyo','309',1223),(4956,'Mpigi','106',1223),(4957,'Mubende','107',1223),(4958,'Mukono','108',1223),(4959,'Nakapiripirit','311',1223),(4960,'Nakasongola','109',1223),(4961,'Nebbi','310',1223),(4962,'Ntungamo','411',1223),(4963,'Pader','312',1223),(4964,'Pallisa','210',1223),(4965,'Rakai','110',1223),(4966,'Rukungiri','412',1223),(4967,'Sembabule','111',1223),(4968,'Sironko','215',1223),(4969,'Soroti','211',1223),(4970,'Tororo','212',1223),(4971,'Wakiso','113',1223),(4972,'Yumbe','313',1223),(4973,'Baker Island','81',1227),(4974,'Howland Island','84',1227),(4975,'Jarvis Island','86',1227),(4976,'Johnston Atoll','67',1227),(4977,'Kingman Reef','89',1227),(4978,'Midway Islands','71',1227),(4979,'Navassa Island','76',1227),(4980,'Palmyra Atoll','95',1227),(4981,'Wake Ialand','79',1227),(4982,'Artigsa','AR',1229),(4983,'Canelones','CA',1229),(4984,'Cerro Largo','CL',1229),(4985,'Colonia','CO',1229),(4986,'Durazno','DU',1229),(4987,'Flores','FS',1229),(4988,'Lavalleja','LA',1229),(4989,'Maldonado','MA',1229),(4990,'Montevideo','MO',1229),(4991,'Paysandu','PA',1229),(4992,'Rivera','RV',1229),(4993,'Rocha','RO',1229),(4994,'Salto','SA',1229),(4995,'Soriano','SO',1229),(4996,'Tacuarembo','TA',1229),(4997,'Treinta y Tres','TT',1229),(4998,'Toshkent (city)','TK',1230),(4999,'Qoraqalpogiston Respublikasi','QR',1230),(5000,'Andijon','AN',1230),(5001,'Buxoro','BU',1230),(5002,'Farg\'ona','FA',1230),(5003,'Jizzax','JI',1230),(5004,'Khorazm','KH',1230),(5005,'Namangan','NG',1230),(5006,'Navoiy','NW',1230),(5007,'Qashqadaryo','QA',1230),(5008,'Samarqand','SA',1230),(5009,'Sirdaryo','SI',1230),(5010,'Surxondaryo','SU',1230),(5011,'Toshkent','TO',1230),(5012,'Xorazm','XO',1230),(5013,'Diatrito Federal','A',1232),(5014,'Anzoategui','B',1232),(5015,'Apure','C',1232),(5016,'Aragua','D',1232),(5017,'Barinas','E',1232),(5018,'Carabobo','G',1232),(5019,'Cojedes','H',1232),(5020,'Falcon','I',1232),(5021,'Guarico','J',1232),(5022,'Lara','K',1232),(5023,'Merida','L',1232),(5024,'Miranda','M',1232),(5025,'Monagas','N',1232),(5026,'Nueva Esparta','O',1232),(5027,'Portuguesa','P',1232),(5028,'Tachira','S',1232),(5029,'Trujillo','T',1232),(5030,'Vargas','X',1232),(5031,'Yaracuy','U',1232),(5032,'Zulia','V',1232),(5033,'Delta Amacuro','Y',1232),(5034,'Dependencias Federales','W',1232),(5035,'An Giang','44',1233),(5036,'Ba Ria - Vung Tau','43',1233),(5037,'Bac Can','53',1233),(5038,'Bac Giang','54',1233),(5039,'Bac Lieu','55',1233),(5040,'Bac Ninh','56',1233),(5041,'Ben Tre','50',1233),(5042,'Binh Dinh','31',1233),(5043,'Binh Duong','57',1233),(5044,'Binh Phuoc','58',1233),(5045,'Binh Thuan','40',1233),(5046,'Ca Mau','59',1233),(5047,'Can Tho','48',1233),(5048,'Cao Bang','04',1233),(5049,'Da Nang, thanh pho','60',1233),(5050,'Dong Nai','39',1233),(5051,'Dong Thap','45',1233),(5052,'Gia Lai','30',1233),(5053,'Ha Giang','03',1233),(5054,'Ha Nam','63',1233),(5055,'Ha Noi, thu do','64',1233),(5056,'Ha Tay','15',1233),(5057,'Ha Tinh','23',1233),(5058,'Hai Duong','61',1233),(5059,'Hai Phong, thanh pho','62',1233),(5060,'Hoa Binh','14',1233),(5061,'Ho Chi Minh, thanh pho [Sai Gon]','65',1233),(5062,'Hung Yen','66',1233),(5063,'Khanh Hoa','34',1233),(5064,'Kien Giang','47',1233),(5065,'Kon Tum','28',1233),(5066,'Lai Chau','01',1233),(5067,'Lam Dong','35',1233),(5068,'Lang Son','09',1233),(5069,'Lao Cai','02',1233),(5070,'Long An','41',1233),(5071,'Nam Dinh','67',1233),(5072,'Nghe An','22',1233),(5073,'Ninh Binh','18',1233),(5074,'Ninh Thuan','36',1233),(5075,'Phu Tho','68',1233),(5076,'Phu Yen','32',1233),(5077,'Quang Binh','24',1233),(5078,'Quang Nam','27',1233),(5079,'Quang Ngai','29',1233),(5080,'Quang Ninh','13',1233),(5081,'Quang Tri','25',1233),(5082,'Soc Trang','52',1233),(5083,'Son La','05',1233),(5084,'Tay Ninh','37',1233),(5085,'Thai Binh','20',1233),(5086,'Thai Nguyen','69',1233),(5087,'Thanh Hoa','21',1233),(5088,'Thua Thien-Hue','26',1233),(5089,'Tien Giang','46',1233),(5090,'Tra Vinh','51',1233),(5091,'Tuyen Quang','07',1233),(5092,'Vinh Long','49',1233),(5093,'Vinh Phuc','70',1233),(5094,'Yen Bai','06',1233),(5095,'Malampa','MAP',1231),(5096,'Penama','PAM',1231),(5097,'Sanma','SAM',1231),(5098,'Shefa','SEE',1231),(5099,'Tafea','TAE',1231),(5100,'Torba','TOB',1231),(5101,'A\'ana','AA',1185),(5102,'Aiga-i-le-Tai','AL',1185),(5103,'Atua','AT',1185),(5104,'Fa\'aaaleleaga','FA',1185),(5105,'Gaga\'emauga','GE',1185),(5106,'Gagaifomauga','GI',1185),(5107,'Palauli','PA',1185),(5108,'Satupa\'itea','SA',1185),(5109,'Tuamasaga','TU',1185),(5110,'Va\'a-o-Fonoti','VF',1185),(5111,'Vaisigano','VS',1185),(5112,'Crna Gora','CG',1238),(5113,'Srbija','SR',1238),(5114,'Kosovo-Metohija','KM',1238),(5115,'Vojvodina','VO',1238),(5116,'Abyan','AB',1237),(5117,'Adan','AD',1237),(5118,'Ad Dali','DA',1237),(5119,'Al Bayda\'','BA',1237),(5120,'Al Hudaydah','MU',1237),(5121,'Al Mahrah','MR',1237),(5122,'Al Mahwit','MW',1237),(5123,'Amran','AM',1237),(5124,'Dhamar','DH',1237),(5125,'Hadramawt','HD',1237),(5126,'Hajjah','HJ',1237),(5127,'Ibb','IB',1237),(5128,'Lahij','LA',1237),(5129,'Ma\'rib','MA',1237),(5130,'Sa\'dah','SD',1237),(5131,'San\'a\'','SN',1237),(5132,'Shabwah','SH',1237),(5133,'Ta\'izz','TA',1237),(5134,'Eastern Cape','EC',1196),(5135,'Free State','FS',1196),(5136,'Gauteng','GT',1196),(5137,'Kwazulu-Natal','NL',1196),(5138,'Mpumalanga','MP',1196),(5139,'Northern Cape','NC',1196),(5140,'Limpopo','NP',1196),(5141,'Western Cape','WC',1196),(5142,'Copperbelt','08',1239),(5143,'Luapula','04',1239),(5144,'Lusaka','09',1239),(5145,'North-Western','06',1239),(5146,'Bulawayo','BU',1240),(5147,'Harare','HA',1240),(5148,'Manicaland','MA',1240),(5149,'Mashonaland Central','MC',1240),(5150,'Mashonaland East','ME',1240),(5151,'Mashonaland West','MW',1240),(5152,'Masvingo','MV',1240),(5153,'Matabeleland North','MN',1240),(5154,'Matabeleland South','MS',1240),(5155,'Midlands','MI',1240),(5156,'South Karelia','SK',1075),(5157,'South Ostrobothnia','SO',1075),(5158,'EtelÃ¤-Savo','ES',1075),(5159,'HÃ¤me','HH',1075),(5160,'ItÃ¤-Uusimaa','IU',1075),(5161,'Kainuu','KA',1075),(5162,'Central Ostrobothnia','CO',1075),(5163,'Central Finland','CF',1075),(5164,'Kymenlaakso','KY',1075),(5165,'Lapland','LA',1075),(5166,'Tampere Region','TR',1075),(5167,'Ostrobothnia','OB',1075),(5168,'North Karelia','NK',1075),(5169,'Nothern Ostrobothnia','NO',1075),(5170,'Northern Savo','NS',1075),(5171,'PÃ¤ijÃ¤t-HÃ¤me','PH',1075),(5172,'Satakunta','SK',1075),(5173,'Uusimaa','UM',1075),(5174,'South-West Finland','SW',1075),(5175,'Ã…land','AL',1075),(5176,'Limburg','LI',1152),(5177,'Central and Western','CW',1098),(5178,'Eastern','EA',1098),(5179,'Southern','SO',1098),(5180,'Wan Chai','WC',1098),(5181,'Kowloon City','KC',1098),(5182,'Kwun Tong','KU',1098),(5183,'Sham Shui Po','SS',1098),(5184,'Wong Tai Sin','WT',1098),(5185,'Yau Tsim Mong','YT',1098),(5186,'Islands','IS',1098),(5187,'Kwai Tsing','KI',1098),(5188,'North','NO',1098),(5189,'Sai Kung','SK',1098),(5190,'Sha Tin','ST',1098),(5191,'Tai Po','TP',1098),(5192,'Tsuen Wan','TW',1098),(5193,'Tuen Mun','TM',1098),(5194,'Yuen Long','YL',1098),(5195,'Manchester','MR',1108),(5196,'Al ManÄmah (Al â€˜Ä€ÅŸimah)','13',1016),(5197,'Al JanÅ«bÄ«yah','14',1016),(5199,'Al WusÅ£Ã¡','16',1016),(5200,'Ash ShamÄlÄ«yah','17',1016),(5201,'Jenin','_A',1165),(5202,'Tubas','_B',1165),(5203,'Tulkarm','_C',1165),(5204,'Nablus','_D',1165),(5205,'Qalqilya','_E',1165),(5206,'Salfit','_F',1165),(5207,'Ramallah and Al-Bireh','_G',1165),(5208,'Jericho','_H',1165),(5209,'Jerusalem','_I',1165),(5210,'Bethlehem','_J',1165),(5211,'Hebron','_K',1165),(5212,'North Gaza','_L',1165),(5213,'Gaza','_M',1165),(5214,'Deir el-Balah','_N',1165),(5215,'Khan Yunis','_O',1165),(5216,'Rafah','_P',1165),(5217,'Brussels','BRU',1020),(5218,'Distrito Federal','DIF',1140),(5219,'Taichung City','TXG',1208),(5220,'Kaohsiung City','KHH',1208),(5221,'Taipei City','TPE',1208),(5222,'Chiayi City','CYI',1208),(5223,'Hsinchu City','HSZ',1208),(5224,'Tainan City','TNN',1208),(9000,'North West','NW',1196),(9986,'Tyne and Wear','TWR',1226),(9988,'Greater Manchester','GTM',1226),(9989,'Co Tyrone','TYR',1226),(9990,'West Yorkshire','WYK',1226),(9991,'South Yorkshire','SYK',1226),(9992,'Merseyside','MSY',1226),(9993,'Berkshire','BRK',1226),(9994,'West Midlands','WMD',1226),(9998,'West Glamorgan','WGM',1226),(9999,'Greater London','LON',1226),(10000,'Carbonia-Iglesias','CI',1107),(10001,'Olbia-Tempio','OT',1107),(10002,'Medio Campidano','VS',1107),(10003,'Ogliastra','OG',1107),(10004,'Bonaire','BON',1151),(10005,'CuraÃ§ao','CUR',1151),(10006,'Saba','SAB',1151),(10007,'St. Eustatius','EUA',1151),(10008,'St. Maarten','SXM',1151),(10009,'Jura','39',1076),(10010,'Barletta-Andria-Trani','Bar',1107),(10011,'Fermo','Fer',1107),(10012,'Monza e Brianza','Mon',1107),(10013,'Clwyd','CWD',1226),(10014,'Dyfed','DFD',1226),(10015,'South Glamorgan','SGM',1226),(10016,'Artibonite','AR',1094),(10017,'Centre','CE',1094),(10018,'Nippes','NI',1094),(10019,'Nord','ND',1094),(10020,'La Rioja','F',1010),(10021,'Andorra la Vella','07',1005),(10022,'Canillo','02',1005),(10023,'Encamp','03',1005),(10024,'Escaldes-Engordany','08',1005),(10025,'La Massana','04',1005),(10026,'Ordino','05',1005),(10027,'Sant Julia de Loria','06',1005),(10028,'Abaco Islands','AB',1212),(10029,'Andros Island','AN',1212),(10030,'Berry Islands','BR',1212),(10031,'Eleuthera','EL',1212),(10032,'Grand Bahama','GB',1212),(10033,'Rum Cay','RC',1212),(10034,'San Salvador Island','SS',1212),(10035,'Kongo central','01',1050),(10036,'Kwango','02',1050),(10037,'Kwilu','03',1050),(10038,'Mai-Ndombe','04',1050),(10039,'Kasai','05',1050),(10040,'Lulua','06',1050),(10041,'Lomami','07',1050),(10042,'Sankuru','08',1050),(10043,'Ituri','09',1050),(10044,'Haut-Uele','10',1050),(10045,'Tshopo','11',1050),(10046,'Bas-Uele','12',1050),(10047,'Nord-Ubangi','13',1050),(10048,'Mongala','14',1050),(10049,'Sud-Ubangi','15',1050),(10050,'Tshuapa','16',1050),(10051,'Haut-Lomami','17',1050),(10052,'Lualaba','18',1050),(10053,'Haut-Katanga','19',1050),(10054,'Tanganyika','20',1050);
/*!40000 ALTER TABLE `civicrm_state_province` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_subscription_history`
--

DROP TABLE IF EXISTS `civicrm_subscription_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_subscription_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal Id',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'Contact Id',
  `group_id` int(10) unsigned DEFAULT NULL COMMENT 'Group Id',
  `date` datetime NOT NULL COMMENT 'Date of the (un)subscription',
  `method` enum('Admin','Email','Web','API') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'How the (un)subscription was triggered',
  `status` enum('Added','Removed','Pending') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The state of the contact within the group',
  `tracking` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'IP address or other tracking info',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_subscription_history_contact_id` (`contact_id`),
  KEY `FK_civicrm_subscription_history_group_id` (`group_id`),
  CONSTRAINT `FK_civicrm_subscription_history_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_subscription_history_group_id` FOREIGN KEY (`group_id`) REFERENCES `civicrm_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_subscription_history`
--

LOCK TABLES `civicrm_subscription_history` WRITE;
/*!40000 ALTER TABLE `civicrm_subscription_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_subscription_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_survey`
--

DROP TABLE IF EXISTS `civicrm_survey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_survey` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Campaign Group id.',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title of the Survey.',
  `campaign_id` int(10) unsigned DEFAULT NULL COMMENT 'Foreign key to the activity Campaign.',
  `activity_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Implicit FK to civicrm_option_value where option_group = activity_type',
  `recontact_interval` text COLLATE utf8_unicode_ci COMMENT 'Recontact intervals for each status.',
  `instructions` text COLLATE utf8_unicode_ci COMMENT 'Script instructions for volunteers to use for the survey.',
  `release_frequency` int(10) unsigned DEFAULT NULL COMMENT 'Number of days for recurrence of release.',
  `max_number_of_contacts` int(10) unsigned DEFAULT NULL COMMENT 'Maximum number of contacts to allow for survey.',
  `default_number_of_contacts` int(10) unsigned DEFAULT NULL COMMENT 'Default number of contacts to allow for survey.',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Is this survey enabled or disabled/cancelled?',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is this default survey?',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who created this Survey.',
  `created_date` datetime DEFAULT NULL COMMENT 'Date and time that Survey was created.',
  `last_modified_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who recently edited this Survey.',
  `last_modified_date` datetime DEFAULT NULL COMMENT 'Date and time that Survey was edited last time.',
  `result_id` int(10) unsigned DEFAULT NULL COMMENT 'Used to store option group id.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_survey_campaign_id` (`campaign_id`),
  KEY `UI_activity_type_id` (`activity_type_id`),
  KEY `FK_civicrm_survey_created_id` (`created_id`),
  KEY `FK_civicrm_survey_last_modified_id` (`last_modified_id`),
  CONSTRAINT `FK_civicrm_survey_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `civicrm_campaign` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_survey_created_id` FOREIGN KEY (`created_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_survey_last_modified_id` FOREIGN KEY (`last_modified_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_survey`
--

LOCK TABLES `civicrm_survey` WRITE;
/*!40000 ALTER TABLE `civicrm_survey` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_survey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_tag`
--

DROP TABLE IF EXISTS `civicrm_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_tag` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tag ID',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name of Tag.',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Optional verbose description of the tag.',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Optional parent id for this tag.',
  `is_selectable` tinyint(4) DEFAULT '1' COMMENT 'Is this tag selectable / displayed',
  `is_reserved` tinyint(4) DEFAULT '0',
  `is_tagset` tinyint(4) DEFAULT '0',
  `used_for` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_id` int(10) unsigned DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_parent_id_name` (`parent_id`,`name`),
  KEY `FK_civicrm_tag_parent_id` (`parent_id`),
  CONSTRAINT `FK_civicrm_tag_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `civicrm_tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=297 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_tag`
--

LOCK TABLES `civicrm_tag` WRITE;
/*!40000 ALTER TABLE `civicrm_tag` DISABLE KEYS */;
INSERT INTO `civicrm_tag` VALUES (5,'Aging','Aging',291,1,1,0,'civicrm_contact',NULL,NULL),(6,'Agriculture','Agriculture',291,1,1,0,'civicrm_contact',NULL,NULL),(7,'Alcohol and Substance Abuse','Alcohol and Substance Abuse',291,1,1,0,'civicrm_contact',NULL,NULL),(8,'Arts and Cultural Affairs','Arts and Cultural Affairs',291,1,1,0,'civicrm_contact',NULL,NULL),(9,'Authorities and Commissions','Authorities and Commissions',291,1,1,0,'civicrm_contact',NULL,NULL),(10,'Banks','Banks',291,1,1,0,'civicrm_contact',NULL,NULL),(11,'Business and Economic Development','Business and Economic Development',291,1,1,0,'civicrm_contact',NULL,NULL),(12,'Children and Families','Children and Families',291,1,1,0,'civicrm_contact',NULL,NULL),(13,'Codes','Codes',291,1,1,0,'civicrm_contact',NULL,NULL),(14,'Consumer Protection','Consumer Protection',291,1,1,0,'civicrm_contact',NULL,NULL),(15,'Crime and Corrections','Crime and Corrections',291,1,1,0,'civicrm_contact',NULL,NULL),(16,'Education','Education',291,1,1,0,'civicrm_contact',NULL,NULL),(17,'Elections','Elections',291,1,1,0,'civicrm_contact',NULL,NULL),(18,'Energy','Energy',291,1,1,0,'civicrm_contact',NULL,NULL),(19,'Environment','Environment',291,1,1,0,'civicrm_contact',NULL,NULL),(20,'Government Operations','Government Operations',291,1,1,0,'civicrm_contact',NULL,NULL),(21,'Health','Health',291,1,1,0,'civicrm_contact',NULL,NULL),(22,'Higher Education','Higher Education',291,1,1,0,'civicrm_contact',NULL,NULL),(23,'Housing','Housing',291,1,1,0,'civicrm_contact',NULL,NULL),(24,'Human Rights','Human Rights',291,1,1,0,'civicrm_contact',NULL,NULL),(25,'Individuals With Disabilities','Individuals With Disabilities',291,1,1,0,'civicrm_contact',NULL,NULL),(26,'Insurance','Insurance',291,1,1,0,'civicrm_contact',NULL,NULL),(27,'Judiciary','Judiciary',291,1,1,0,'civicrm_contact',NULL,NULL),(28,'Labor','Labor',291,1,1,0,'civicrm_contact',NULL,NULL),(29,'Legislature','Legislature',291,1,1,0,'civicrm_contact',NULL,NULL),(30,'Local Government','Local Government',291,1,1,0,'civicrm_contact',NULL,NULL),(31,'Mental Health','Mental Health',291,1,1,0,'civicrm_contact',NULL,NULL),(32,'Military Affairs','Military Affairs',291,1,1,0,'civicrm_contact',NULL,NULL),(33,'New York City','New York City',291,1,1,0,'civicrm_contact',NULL,NULL),(34,'Professions','Professions',291,1,1,0,'civicrm_contact',NULL,NULL),(35,'Racing and Wagering','Racing and Wagering',291,1,1,0,'civicrm_contact',NULL,NULL),(36,'Recreation and Tourism','Recreation and Tourism',291,1,1,0,'civicrm_contact',NULL,NULL),(37,'Social Services','Social Services',291,1,1,0,'civicrm_contact',NULL,NULL),(38,'Taxes','Taxes',291,1,1,0,'civicrm_contact',NULL,NULL),(39,'Telecommunications','Telecommunications',291,1,1,0,'civicrm_contact',NULL,NULL),(40,'Transportation','Transportation',291,1,1,0,'civicrm_contact',NULL,NULL),(41,'Elder Abuse','Elder Abuse',5,1,1,0,'civicrm_contact',NULL,NULL),(42,'EPIC (Elderly Pharmaceutical Insurance Coverage) Program','EPIC (Elderly Pharmaceutical Insurance Coverage) Program',5,1,1,0,'civicrm_contact',NULL,NULL),(43,'Senior Centers and Services','Senior Centers and Services',5,1,1,0,'civicrm_contact',NULL,NULL),(44,'Senior Housing','Senior Housing',5,1,1,0,'civicrm_contact',NULL,NULL),(45,'Senior Real Property Tax Exemptions','Senior Real Property Tax Exemptions',5,1,1,0,'civicrm_contact',NULL,NULL),(46,'Seniors','Seniors',5,1,1,0,'civicrm_contact',NULL,NULL),(47,'State Office for the Aging','State Office for the Aging',5,1,1,0,'civicrm_contact',NULL,NULL),(48,'Animal Protection and Regulation','Animal Protection and Regulation',6,1,1,0,'civicrm_contact',NULL,NULL),(49,'Dairy Industry','Dairy Industry',6,1,1,0,'civicrm_contact',NULL,NULL),(50,'Farmland Preservation','Farmland Preservation',6,1,1,0,'civicrm_contact',NULL,NULL),(51,'Organic Farming','Organic Farming',6,1,1,0,'civicrm_contact',NULL,NULL),(52,'Sustainable Agriculture','Sustainable Agriculture',6,1,1,0,'civicrm_contact',NULL,NULL),(53,'Wine and Grape Industry','Wine and Grape Industry',6,1,1,0,'civicrm_contact',NULL,NULL),(54,'Heritage Areas','Heritage Areas',8,1,1,0,'civicrm_contact',NULL,NULL),(55,'Historic Preservation','Historic Preservation',8,1,1,0,'civicrm_contact',NULL,NULL),(56,'The Arts','The Arts',8,1,1,0,'civicrm_contact',NULL,NULL),(57,'Dormitory Authority','Dormitory Authority',9,1,1,0,'civicrm_contact',NULL,NULL),(58,'ESDC (Empire State Development Corporation)','ESDC (Empire State Development Corporation)',9,1,1,0,'civicrm_contact',NULL,NULL),(59,'MTA (Metropolitan Transportation Authority)','MTA (Metropolitan Transportation Authority)',9,1,1,0,'civicrm_contact',NULL,NULL),(60,'New York Power Authority','New York Power Authority',9,1,1,0,'civicrm_contact',NULL,NULL),(61,'NYC Housing Development Corporation','NYC Housing Development Corporation',9,1,1,0,'civicrm_contact',NULL,NULL),(62,'PANYNJ (Port Authority of New York and New Jersey)','PANYNJ (Port Authority of New York and New Jersey)',9,1,1,0,'civicrm_contact',NULL,NULL),(63,'Thruway Authority','Thruway Authority',9,1,1,0,'civicrm_contact',NULL,NULL),(64,'Credit Unions','Credit Unions',10,1,1,0,'civicrm_contact',NULL,NULL),(65,'Financial Services','Financial Services',10,1,1,0,'civicrm_contact',NULL,NULL),(66,'Foreclosure','Foreclosure',10,1,1,0,'civicrm_contact',NULL,NULL),(67,'Mortgages','Mortgages',10,1,1,0,'civicrm_contact',NULL,NULL),(68,'Predatory Lending','Predatory Lending',10,1,1,0,'civicrm_contact',NULL,NULL),(69,'Assistance and Incentive Programs','Assistance and Incentive Programs',11,1,1,0,'civicrm_contact',NULL,NULL),(70,'Business Regulation','Business Regulation',11,1,1,0,'civicrm_contact',NULL,NULL),(71,'Community Revitalization','Community Revitalization',11,1,1,0,'civicrm_contact',NULL,NULL),(72,'Federal Stimulus','Federal Stimulus',11,1,1,0,'civicrm_contact',NULL,NULL),(73,'MWBEs (Minority and Women Business Enterprises)','MWBEs (Minority and Women Business Enterprises)',11,1,1,0,'civicrm_contact',NULL,NULL),(74,'Not-for-Profit Corporations','Not-for-Profit Corporations',11,1,1,0,'civicrm_contact',NULL,NULL),(75,'Small Business','Small Business',11,1,1,0,'civicrm_contact',NULL,NULL),(76,'Adoption','Adoption',12,1,1,0,'civicrm_contact',NULL,NULL),(77,'Child Abuse and Neglect','Child Abuse and Neglect',12,1,1,0,'civicrm_contact',NULL,NULL),(78,'Child Custody and Visitation','Child Custody and Visitation',12,1,1,0,'civicrm_contact',NULL,NULL),(79,'Child Health and Safety','Child Health and Safety',12,1,1,0,'civicrm_contact',NULL,NULL),(80,'Child Support and Paternity','Child Support and Paternity',12,1,1,0,'civicrm_contact',NULL,NULL),(81,'Children in the Courtroom','Children in the Courtroom',12,1,1,0,'civicrm_contact',NULL,NULL),(82,'Day Care','Day Care',12,1,1,0,'civicrm_contact',NULL,NULL),(83,'Domestic Violence','Domestic Violence',12,1,1,0,'civicrm_contact',NULL,NULL),(84,'Foster Care','Foster Care',12,1,1,0,'civicrm_contact',NULL,NULL),(85,'Juvenile Delinquency and PINS','Juvenile Delinquency and PINS',12,1,1,0,'civicrm_contact',NULL,NULL),(86,'Matrimonial Actions','Matrimonial Actions',12,1,1,0,'civicrm_contact',NULL,NULL),(87,'Missing and Exploited Children','Missing and Exploited Children',12,1,1,0,'civicrm_contact',NULL,NULL),(88,'Office of Children and Family Services','Office of Children and Family Services',12,1,1,0,'civicrm_contact',NULL,NULL),(89,'Pregnancy and Parenthood','Pregnancy and Parenthood',12,1,1,0,'civicrm_contact',NULL,NULL),(90,'Alcoholic Beverage Control','Alcoholic Beverage Control',13,1,1,0,'civicrm_contact',NULL,NULL),(91,'Controlled Substances','Controlled Substances',13,1,1,0,'civicrm_contact',NULL,NULL),(92,'Orders of Protection','Orders of Protection',13,1,1,0,'civicrm_contact',NULL,NULL),(93,'Penal Code','Penal Code',13,1,1,0,'civicrm_contact',NULL,NULL),(94,'Consumer Credit','Consumer Credit',14,1,1,0,'civicrm_contact',NULL,NULL),(95,'Contracts and Transactions','Contracts and Transactions',14,1,1,0,'civicrm_contact',NULL,NULL),(96,'Food, Drug, and Product Safety','Food, Drug, and Product Safety',14,1,1,0,'civicrm_contact',NULL,NULL),(97,'Bail and Release on Recognizance','Bail and Release on Recognizance',15,1,1,0,'civicrm_contact',NULL,NULL),(98,'Capital Punishment (Death Penalty)','Capital Punishment (Death Penalty)',15,1,1,0,'civicrm_contact',NULL,NULL),(99,'Correction Officers','Correction Officers',15,1,1,0,'civicrm_contact',NULL,NULL),(100,'Crime Victims and Witnesses','Crime Victims and Witnesses',15,1,1,0,'civicrm_contact',NULL,NULL),(101,'Criminal Procedure','Criminal Procedure',15,1,1,0,'civicrm_contact',NULL,NULL),(102,'Criminal Sentencing','Criminal Sentencing',15,1,1,0,'civicrm_contact',NULL,NULL),(103,'Drug Crime','Drug Crime',15,1,1,0,'civicrm_contact',NULL,NULL),(104,'Drunk Driving','Drunk Driving',15,1,1,0,'civicrm_contact',NULL,NULL),(105,'Forensic Use of DNA','Forensic Use of DNA',15,1,1,0,'civicrm_contact',NULL,NULL),(106,'Insanity Defense','Insanity Defense',15,1,1,0,'civicrm_contact',NULL,NULL),(107,'Juvenile Justice','Juvenile Justice',15,1,1,0,'civicrm_contact',NULL,NULL),(108,'Local Jails and Corrections','Local Jails and Corrections',15,1,1,0,'civicrm_contact',NULL,NULL),(109,'Organized Crime and Forfeiture','Organized Crime and Forfeiture',15,1,1,0,'civicrm_contact',NULL,NULL),(110,'Parole, Probation, and Correctional Alternatives','Parole, Probation, and Correctional Alternatives',15,1,1,0,'civicrm_contact',NULL,NULL),(111,'Police Officers, Peace Officers, and Law Enforcement','Police Officers, Peace Officers, and Law Enforcement',15,1,1,0,'civicrm_contact',NULL,NULL),(112,'Sex Offenses','Sex Offenses',15,1,1,0,'civicrm_contact',NULL,NULL),(113,'State Prisons','State Prisons',15,1,1,0,'civicrm_contact',NULL,NULL),(114,'Weapons and Ammunition','Weapons and Ammunition',15,1,1,0,'civicrm_contact',NULL,NULL),(115,'Board of Regents','Board of Regents',16,1,1,0,'civicrm_contact',NULL,NULL),(116,'BOCES','BOCES',16,1,1,0,'civicrm_contact',NULL,NULL),(117,'Charter Schools','Charter Schools',16,1,1,0,'civicrm_contact',NULL,NULL),(118,'Continuing Education','Continuing Education',16,1,1,0,'civicrm_contact',NULL,NULL),(119,'Curriculum and Testing','Curriculum and Testing',16,1,1,0,'civicrm_contact',NULL,NULL),(120,'Libraries','Libraries',16,1,1,0,'civicrm_contact',NULL,NULL),(121,'Local School District Issues','Local School District Issues',16,1,1,0,'civicrm_contact',NULL,NULL),(122,'Nonpublic Schools','Nonpublic Schools',16,1,1,0,'civicrm_contact',NULL,NULL),(123,'School Budgets and Elections','School Budgets and Elections',16,1,1,0,'civicrm_contact',NULL,NULL),(124,'School Health and Safety','School Health and Safety',16,1,1,0,'civicrm_contact',NULL,NULL),(125,'School Transportation','School Transportation',16,1,1,0,'civicrm_contact',NULL,NULL),(126,'Special Education','Special Education',16,1,1,0,'civicrm_contact',NULL,NULL),(127,'State Aid','State Aid',16,1,1,0,'civicrm_contact',NULL,NULL),(128,'Teachers','Teachers',16,1,1,0,'civicrm_contact',NULL,NULL),(129,'Absentee and Military Voting','Absentee and Military Voting',17,1,1,0,'civicrm_contact',NULL,NULL),(130,'Campaign Finance','Campaign Finance',17,1,1,0,'civicrm_contact',NULL,NULL),(131,'Constitutional Amendments and Other Ballot Propositions','Constitutional Amendments and Other Ballot Propositions',17,1,1,0,'civicrm_contact',NULL,NULL),(132,'Election Reform','Election Reform',17,1,1,0,'civicrm_contact',NULL,NULL),(133,'HAVA (Help America Vote Act)','HAVA (Help America Vote Act)',17,1,1,0,'civicrm_contact',NULL,NULL),(134,'Initiative and Referendum','Initiative and Referendum',17,1,1,0,'civicrm_contact',NULL,NULL),(135,'Primary Elections','Primary Elections',17,1,1,0,'civicrm_contact',NULL,NULL),(136,'Special Elections','Special Elections',17,1,1,0,'civicrm_contact',NULL,NULL),(137,'Voter Protection','Voter Protection',17,1,1,0,'civicrm_contact',NULL,NULL),(138,'Voter Registration','Voter Registration',17,1,1,0,'civicrm_contact',NULL,NULL),(139,'Alternative Energy and Renewable Resources (Green Energy)','Alternative Energy and Renewable Resources (Green Energy)',18,1,1,0,'civicrm_contact',NULL,NULL),(140,'Electricity','Electricity',18,1,1,0,'civicrm_contact',NULL,NULL),(141,'Fossil Fuels','Fossil Fuels',18,1,1,0,'civicrm_contact',NULL,NULL),(142,'Public Power and Utilities','Public Power and Utilities',18,1,1,0,'civicrm_contact',NULL,NULL),(143,'Air','Air',19,1,1,0,'civicrm_contact',NULL,NULL),(144,'Climate Change','Climate Change',19,1,1,0,'civicrm_contact',NULL,NULL),(145,'Earth Day','Earth Day',19,1,1,0,'civicrm_contact',NULL,NULL),(146,'Environmental Justice','Environmental Justice',19,1,1,0,'civicrm_contact',NULL,NULL),(147,'Environmental Permits','Environmental Permits',19,1,1,0,'civicrm_contact',NULL,NULL),(148,'Fish, Wildlife, and Marine Resources','Fish, Wildlife, and Marine Resources',19,1,1,0,'civicrm_contact',NULL,NULL),(149,'Going Green','Going Green',19,1,1,0,'civicrm_contact',NULL,NULL),(150,'Invasive Species','Invasive Species',19,1,1,0,'civicrm_contact',NULL,NULL),(151,'Lands and Forests','Lands and Forests',19,1,1,0,'civicrm_contact',NULL,NULL),(152,'Mineral Resources','Mineral Resources',19,1,1,0,'civicrm_contact',NULL,NULL),(153,'Site Remediation','Site Remediation',19,1,1,0,'civicrm_contact',NULL,NULL),(154,'Solid and Hazardous Waste','Solid and Hazardous Waste',19,1,1,0,'civicrm_contact',NULL,NULL),(155,'Water','Water',19,1,1,0,'civicrm_contact',NULL,NULL),(156,'Wetlands','Wetlands',19,1,1,0,'civicrm_contact',NULL,NULL),(157,'Budget and Finance','Budget and Finance',20,1,1,0,'civicrm_contact',NULL,NULL),(158,'Census','Census',20,1,1,0,'civicrm_contact',NULL,NULL),(159,'Disaster Prevention, Response, and Recovery','Disaster Prevention, Response, and Recovery',20,1,1,0,'civicrm_contact',NULL,NULL),(160,'Executive Branch','Executive Branch',20,1,1,0,'civicrm_contact',NULL,NULL),(161,'Federal Programs','Federal Programs',20,1,1,0,'civicrm_contact',NULL,NULL),(162,'Homeland Security','Homeland Security',20,1,1,0,'civicrm_contact',NULL,NULL),(163,'Investigations','Investigations',20,1,1,0,'civicrm_contact',NULL,NULL),(164,'Land Transactions and Eminent Domain','Land Transactions and Eminent Domain',20,1,1,0,'civicrm_contact',NULL,NULL),(165,'Lobbying and Ethics','Lobbying and Ethics',20,1,1,0,'civicrm_contact',NULL,NULL),(166,'Official State Designations','Official State Designations',20,1,1,0,'civicrm_contact',NULL,NULL),(167,'Procurement, Contracting, and Inventory Control','Procurement, Contracting, and Inventory Control',20,1,1,0,'civicrm_contact',NULL,NULL),(168,'Abortion','Abortion',21,1,1,0,'civicrm_contact',NULL,NULL),(169,'Alcoholism and Substance Abuse','Alcoholism and Substance Abuse',21,1,1,0,'civicrm_contact',NULL,NULL),(170,'End-of-Life Care and Decision-Making','End-of-Life Care and Decision-Making',21,1,1,0,'civicrm_contact',NULL,NULL),(171,'Health Care Financing','Health Care Financing',21,1,1,0,'civicrm_contact',NULL,NULL),(172,'HIV/AIDS','HIV/AIDS',21,1,1,0,'civicrm_contact',NULL,NULL),(173,'Hospitals and Other Health Care Providers','Hospitals and Other Health Care Providers',21,1,1,0,'civicrm_contact',NULL,NULL),(174,'Long-Term Care','Long-Term Care',21,1,1,0,'civicrm_contact',NULL,NULL),(175,'Organ and Tissue Donation','Organ and Tissue Donation',21,1,1,0,'civicrm_contact',NULL,NULL),(176,'Prescription Drugs','Prescription Drugs',21,1,1,0,'civicrm_contact',NULL,NULL),(177,'Public Health','Public Health',21,1,1,0,'civicrm_contact',NULL,NULL),(178,'Smoking and Tobacco Use','Smoking and Tobacco Use',21,1,1,0,'civicrm_contact',NULL,NULL),(179,'Campus Issues','Campus Issues',22,1,1,0,'civicrm_contact',NULL,NULL),(180,'Community Colleges','Community Colleges',22,1,1,0,'civicrm_contact',NULL,NULL),(181,'CUNY (City University of New York)','CUNY (City University of New York)',22,1,1,0,'civicrm_contact',NULL,NULL),(182,'Medical and Dental Education','Medical and Dental Education',22,1,1,0,'civicrm_contact',NULL,NULL),(183,'Proprietary Schools','Proprietary Schools',22,1,1,0,'civicrm_contact',NULL,NULL),(184,'Student Financial Aid','Student Financial Aid',22,1,1,0,'civicrm_contact',NULL,NULL),(185,'SUNY (State University of New York)','SUNY (State University of New York)',22,1,1,0,'civicrm_contact',NULL,NULL),(186,'Construction','Construction',23,1,1,0,'civicrm_contact',NULL,NULL),(187,'Co-ops and Condos','Co-ops and Condos',23,1,1,0,'civicrm_contact',NULL,NULL),(188,'Fire Prevention and Building Code','Fire Prevention and Building Code',23,1,1,0,'civicrm_contact',NULL,NULL),(189,'Homeless','Homeless',23,1,1,0,'civicrm_contact',NULL,NULL),(190,'Housing Preservation and Development','Housing Preservation and Development',23,1,1,0,'civicrm_contact',NULL,NULL),(191,'Landlord and Tenant Concerns','Landlord and Tenant Concerns',23,1,1,0,'civicrm_contact',NULL,NULL),(192,'Manufactured Housing','Manufactured Housing',23,1,1,0,'civicrm_contact',NULL,NULL),(193,'Municipal Housing Authorities','Municipal Housing Authorities',23,1,1,0,'civicrm_contact',NULL,NULL),(194,'Rent Regulation','Rent Regulation',23,1,1,0,'civicrm_contact',NULL,NULL),(195,'Civil Rights','Civil Rights',24,1,1,0,'civicrm_contact',NULL,NULL),(196,'Immigration','Immigration',24,1,1,0,'civicrm_contact',NULL,NULL),(197,'LGBT Rights','LGBT Rights',24,1,1,0,'civicrm_contact',NULL,NULL),(198,'Native Americans','Native Americans',24,1,1,0,'civicrm_contact',NULL,NULL),(199,'Privacy','Privacy',24,1,1,0,'civicrm_contact',NULL,NULL),(200,'Women\'s Issues','Women\'s Issues',24,1,1,0,'civicrm_contact',NULL,NULL),(201,'Developmentally Disabled','Developmentally Disabled',25,1,1,0,'civicrm_contact',NULL,NULL),(202,'Handicapped Accessibility','Handicapped Accessibility',25,1,1,0,'civicrm_contact',NULL,NULL),(203,'Vocational and Educational Services for Disabled','Vocational and Educational Services for Disabled',25,1,1,0,'civicrm_contact',NULL,NULL),(204,'Auto','Auto',26,1,1,0,'civicrm_contact',NULL,NULL),(205,'Insurance Fraud','Insurance Fraud',26,1,1,0,'civicrm_contact',NULL,NULL),(206,'Life Insurance and Annuities','Life Insurance and Annuities',26,1,1,0,'civicrm_contact',NULL,NULL),(207,'Medical Malpractice','Medical Malpractice',26,1,1,0,'civicrm_contact',NULL,NULL),(208,'Property/Casualty','Property/Casualty',26,1,1,0,'civicrm_contact',NULL,NULL),(209,'Civil Procedure','Civil Procedure',27,1,1,0,'civicrm_contact',NULL,NULL),(210,'Court Administration','Court Administration',27,1,1,0,'civicrm_contact',NULL,NULL),(211,'Estates, Trusts, and Guardianships','Estates, Trusts, and Guardianships',27,1,1,0,'civicrm_contact',NULL,NULL),(212,'Judges','Judges',27,1,1,0,'civicrm_contact',NULL,NULL),(213,'Juries','Juries',27,1,1,0,'civicrm_contact',NULL,NULL),(214,'Lawyers and Legal Services','Lawyers and Legal Services',27,1,1,0,'civicrm_contact',NULL,NULL),(215,'Child Labor/Employment of Minors','Child Labor/Employment of Minors',28,1,1,0,'civicrm_contact',NULL,NULL),(216,'Civil Service and Pensions','Civil Service and Pensions',291,1,1,0,'civicrm_contact',NULL,NULL),(217,'Employee Protections','Employee Protections',28,1,1,0,'civicrm_contact',NULL,NULL),(218,'Minimum Wage','Minimum Wage',28,1,1,0,'civicrm_contact',NULL,NULL),(219,'Public Works','Public Works',28,1,1,0,'civicrm_contact',NULL,NULL),(220,'Unemployment','Unemployment',28,1,1,0,'civicrm_contact',NULL,NULL),(221,'Unions','Unions',28,1,1,0,'civicrm_contact',NULL,NULL),(222,'Workers\' Compensation and Disability Benefits','Workers\' Compensation and Disability Benefits',28,1,1,0,'civicrm_contact',NULL,NULL),(223,'Ethics','Ethics',29,1,1,0,'civicrm_contact',NULL,NULL),(224,'Picture Bills and Special Legislation','Picture Bills and Special Legislation',29,1,1,0,'civicrm_contact',NULL,NULL),(225,'Rules','Rules',29,1,1,0,'civicrm_contact',NULL,NULL),(226,'Session','Session',29,1,1,0,'civicrm_contact',NULL,NULL),(227,'Administration and Public Officials','Administration and Public Officials',30,1,1,0,'civicrm_contact',NULL,NULL),(228,'Emergency Medical Services','Emergency Medical Services',30,1,1,0,'civicrm_contact',NULL,NULL),(229,'Firefighters','Firefighters',30,1,1,0,'civicrm_contact',NULL,NULL),(230,'Intermunicipal Agreements and Consolidation','Intermunicipal Agreements and Consolidation',30,1,1,0,'civicrm_contact',NULL,NULL),(231,'Local Finance','Local Finance',30,1,1,0,'civicrm_contact',NULL,NULL),(232,'Local Laws and Ordinances','Local Laws and Ordinances',30,1,1,0,'civicrm_contact',NULL,NULL),(233,'Mandate Relief','Mandate Relief',30,1,1,0,'civicrm_contact',NULL,NULL),(234,'Planning and Zoning','Planning and Zoning',30,1,1,0,'civicrm_contact',NULL,NULL),(235,'Police','Police',30,1,1,0,'civicrm_contact',NULL,NULL),(236,'Public Lands','Public Lands',30,1,1,0,'civicrm_contact',NULL,NULL),(237,'Special Districts and Authorities','Special Districts and Authorities',30,1,1,0,'civicrm_contact',NULL,NULL),(238,'Community Services','Community Services',31,1,1,0,'civicrm_contact',NULL,NULL),(239,'Involuntary and Emergency Admissions','Involuntary and Emergency Admissions',31,1,1,0,'civicrm_contact',NULL,NULL),(240,'Office of Mental Health','Office of Mental Health',31,1,1,0,'civicrm_contact',NULL,NULL),(241,'Patient Rights and Safety','Patient Rights and Safety',31,1,1,0,'civicrm_contact',NULL,NULL),(242,'Psychiatric Centers and Developmental Centers','Psychiatric Centers and Developmental Centers',31,1,1,0,'civicrm_contact',NULL,NULL),(243,'Coast Guard','Coast Guard',32,1,1,0,'civicrm_contact',NULL,NULL),(244,'National Guard','National Guard',32,1,1,0,'civicrm_contact',NULL,NULL),(245,'Reserves','Reserves',32,1,1,0,'civicrm_contact',NULL,NULL),(246,'Veterans','Veterans',32,1,1,0,'civicrm_contact',NULL,NULL),(247,'Finance','Finance',33,1,1,0,'civicrm_contact',NULL,NULL),(248,'Schools','Schools',33,1,1,0,'civicrm_contact',NULL,NULL),(249,'World Trade Center','World Trade Center',33,1,1,0,'civicrm_contact',NULL,NULL),(250,'Good Samaritan Laws','Good Samaritan Laws',34,1,1,0,'civicrm_contact',NULL,NULL),(251,'Nursing','Nursing',34,1,1,0,'civicrm_contact',NULL,NULL),(252,'Professional Licensing, Oversight, and Discipline','Professional Licensing, Oversight, and Discipline',34,1,1,0,'civicrm_contact',NULL,NULL),(253,'Charitable Gaming','Charitable Gaming',35,1,1,0,'civicrm_contact',NULL,NULL),(254,'Indian Gaming','Indian Gaming',35,1,1,0,'civicrm_contact',NULL,NULL),(255,'Lotteries and VLTs','Lotteries and VLTs',35,1,1,0,'civicrm_contact',NULL,NULL),(256,'New York State Board','New York State Board',35,1,1,0,'civicrm_contact',NULL,NULL),(257,'Racing','Racing',35,1,1,0,'civicrm_contact',NULL,NULL),(258,'Boating and Recreational Vehicle Use','Boating and Recreational Vehicle Use',36,1,1,0,'civicrm_contact',NULL,NULL),(259,'Boxing, Sparring, and Wrestling','Boxing, Sparring, and Wrestling',36,1,1,0,'civicrm_contact',NULL,NULL),(260,'Hunting and Fishing','Hunting and Fishing',36,1,1,0,'civicrm_contact',NULL,NULL),(261,'State Parks','State Parks',36,1,1,0,'civicrm_contact',NULL,NULL),(262,'Tourism','Tourism',36,1,1,0,'civicrm_contact',NULL,NULL),(263,'Children and Family Assistance','Children and Family Assistance',37,1,1,0,'civicrm_contact',NULL,NULL),(264,'Medicaid','Medicaid',37,1,1,0,'civicrm_contact',NULL,NULL),(265,'Medicare','Medicare',37,1,1,0,'civicrm_contact',NULL,NULL),(266,'Social Security','Social Security',37,1,1,0,'civicrm_contact',NULL,NULL),(267,'SSI (Supplemental Security Income)','SSI (Supplemental Security Income)',37,1,1,0,'civicrm_contact',NULL,NULL),(268,'Temporary and Disability Assistance','Temporary and Disability Assistance',37,1,1,0,'civicrm_contact',NULL,NULL),(269,'EITC (Earned Income Tax Credit)','EITC (Earned Income Tax Credit)',38,1,1,0,'civicrm_contact',NULL,NULL),(270,'Income Tax','Income Tax',38,1,1,0,'civicrm_contact',NULL,NULL),(271,'Payroll Tax','Payroll Tax',38,1,1,0,'civicrm_contact',NULL,NULL),(272,'Property Tax','Property Tax',291,1,1,0,'civicrm_contact',NULL,NULL),(273,'Property Transfer, Estate, and Gift Taxes','Property Transfer, Estate, and Gift Taxes',38,1,1,0,'civicrm_contact',NULL,NULL),(274,'Sales Tax','Sales Tax',38,1,1,0,'civicrm_contact',NULL,NULL),(275,'STAR (School Tax Relief Program)','STAR (School Tax Relief Program)',38,1,1,0,'civicrm_contact',NULL,NULL),(276,'Internet and Broadband Access','Internet and Broadband Access',39,1,1,0,'civicrm_contact',NULL,NULL),(277,'Landlines','Landlines',39,1,1,0,'civicrm_contact',NULL,NULL),(278,'Television Providers','Television Providers',39,1,1,0,'civicrm_contact',NULL,NULL),(279,'Wireless and Mobile Communications','Wireless and Mobile Communications',39,1,1,0,'civicrm_contact',NULL,NULL),(280,'Aviation','Aviation',40,1,1,0,'civicrm_contact',NULL,NULL),(281,'Alternative Transportation','Alternative Transportation',40,1,1,0,'civicrm_contact',NULL,NULL),(282,'DMV (Department of Motor Vehicles)','DMV (Department of Motor Vehicles)',40,1,1,0,'civicrm_contact',NULL,NULL),(283,'Infrastructure (Roads, Highways, Bridges)','Infrastructure (Roads, Highways, Bridges)',40,1,1,0,'civicrm_contact',NULL,NULL),(284,'New York State Thruway','New York State Thruway',40,1,1,0,'civicrm_contact',NULL,NULL),(285,'Ports and Waterways','Ports and Waterways',40,1,1,0,'civicrm_contact',NULL,NULL),(286,'Public Transportation/Mass Transit','Public Transportation/Mass Transit',40,1,1,0,'civicrm_contact',NULL,NULL),(287,'Trucking and Freight Rail','Trucking and Freight Rail',40,1,1,0,'civicrm_contact',NULL,NULL),(288,'Marriage Equality','Marriage Equality',197,1,1,0,'civicrm_contact',NULL,NULL),(289,'GENDA','GENDA',197,1,1,0,'civicrm_contact',NULL,NULL),(291,'Issue Codes',NULL,NULL,1,1,0,'civicrm_contact',NULL,NULL),(292,'Positions','hidden parent tag for positions',NULL,1,1,1,'civicrm_contact',NULL,NULL),(296,'Keywords',NULL,NULL,1,1,1,'civicrm_contact,civicrm_activity,civicrm_case',NULL,NULL);
/*!40000 ALTER TABLE `civicrm_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_task`
--

DROP TABLE IF EXISTS `civicrm_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_task` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Task ID',
  `title` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Task name.',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Optional verbose description of the Task. May be used for display - HTML allowed.',
  `task_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Configurable task type values (e.g. App Submit, App Review...). FK to civicrm_option_value.',
  `owner_entity_table` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of table where Task owner being referenced is stored (e.g. civicrm_contact or civicrm_group).',
  `owner_entity_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to Task owner (contact, group, etc.).',
  `parent_entity_table` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name of table where optional Task parent is stored (e.g. civicrm_project, or civicrm_task for sub-tasks).',
  `parent_entity_id` int(10) unsigned DEFAULT NULL COMMENT 'Optional foreign key to Task Parent (project, another task, etc.).',
  `due_date` datetime DEFAULT NULL COMMENT 'Task due date.',
  `priority_id` int(10) unsigned DEFAULT NULL COMMENT 'Configurable priority value (e.g. Critical, High, Medium...). FK to civicrm_option_value.',
  `task_class` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Optional key to a process class related to this task (e.g. CRM_Quest_PreApp).',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this record active? For tasks: can it be assigned, does it appear on open task listings, etc.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_task_owner` (`id`,`owner_entity_table`,`owner_entity_id`),
  UNIQUE KEY `UI_task_parent` (`id`,`parent_entity_table`,`parent_entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_task`
--

LOCK TABLES `civicrm_task` WRITE;
/*!40000 ALTER TABLE `civicrm_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_task_status`
--

DROP TABLE IF EXISTS `civicrm_task_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_task_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Task ID',
  `task_id` int(10) unsigned NOT NULL COMMENT 'Status is for which task.',
  `responsible_entity_table` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Entity responsible for this task_status instance (table where entity is stored e.g. civicrm_contact or civicrm_group).',
  `responsible_entity_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to responsible entity (contact, group, etc.).',
  `target_entity_table` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Optional target entity for this task_status instance, i.e. review this membership application-prospect member contact record is target (table where entity is stored e.g. civicrm_contact or civicrm_group).',
  `target_entity_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to target entity (contact, group, etc.).',
  `status_detail` text COLLATE utf8_unicode_ci COMMENT 'Encoded array of status details used for programmatic progress reporting and tracking.',
  `status_id` int(10) unsigned DEFAULT NULL COMMENT 'Configurable status value (e.g. Not Started, In Progress, Completed, Deferred...). FK to civicrm_option_value.',
  `create_date` datetime DEFAULT NULL COMMENT 'Date this record was created (date work on task started).',
  `modified_date` datetime DEFAULT NULL COMMENT 'Date-time of last update to this task_status record.',
  PRIMARY KEY (`id`),
  KEY `index_task_status_responsible` (`task_id`,`responsible_entity_table`,`responsible_entity_id`),
  KEY `index_task_status_target` (`task_id`,`target_entity_table`,`target_entity_id`),
  CONSTRAINT `FK_civicrm_task_status_task_id` FOREIGN KEY (`task_id`) REFERENCES `civicrm_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_task_status`
--

LOCK TABLES `civicrm_task_status` WRITE;
/*!40000 ALTER TABLE `civicrm_task_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_task_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_tell_friend`
--

DROP TABLE IF EXISTS `civicrm_tell_friend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_tell_friend` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Friend ID',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of table where item being referenced is stored.',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to the referenced item.',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `intro` text COLLATE utf8_unicode_ci COMMENT 'Introductory message to contributor or participant displayed on the Tell a Friend form.',
  `suggested_message` text COLLATE utf8_unicode_ci COMMENT 'Suggested message to friends, provided as default on the Tell A Friend form.',
  `general_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'URL for general info about the organization - included in the email sent to friends.',
  `thankyou_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Text for Tell a Friend thank you page header and HTML title.',
  `thankyou_text` text COLLATE utf8_unicode_ci COMMENT 'Thank you message displayed on success page.',
  `is_active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_tell_friend`
--

LOCK TABLES `civicrm_tell_friend` WRITE;
/*!40000 ALTER TABLE `civicrm_tell_friend` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_tell_friend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_timezone`
--

DROP TABLE IF EXISTS `civicrm_timezone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_timezone` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Timezone Id',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Timezone full name',
  `abbreviation` char(3) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'ISO Code for timezone abbreviation',
  `gmt` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'GMT name of the timezone',
  `offset` int(11) DEFAULT NULL,
  `country_id` int(10) unsigned NOT NULL COMMENT 'Country Id',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_timezone_country_id` (`country_id`),
  CONSTRAINT `FK_civicrm_timezone_country_id` FOREIGN KEY (`country_id`) REFERENCES `civicrm_country` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_timezone`
--

LOCK TABLES `civicrm_timezone` WRITE;
/*!40000 ALTER TABLE `civicrm_timezone` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_timezone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_uf_field`
--

DROP TABLE IF EXISTS `civicrm_uf_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_uf_field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique table ID',
  `uf_group_id` int(10) unsigned NOT NULL COMMENT 'Which form does this field belong to.',
  `field_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name for CiviCRM field which is being exposed for sharing.',
  `is_active` tinyint(4) DEFAULT '1' COMMENT 'Is this field currently shareable? If false, hide the field for all sharing contexts.',
  `is_view` tinyint(4) DEFAULT '0' COMMENT 'the field is view only and not editable in user forms.',
  `is_required` tinyint(4) DEFAULT '0' COMMENT 'Is this field required when included in a user or registration form?',
  `weight` int(11) NOT NULL DEFAULT '1' COMMENT 'Controls field display order when user framework fields are displayed in registration and account editing forms.',
  `help_post` text COLLATE utf8_unicode_ci COMMENT 'Description and/or help text to display after this field.',
  `help_pre` text COLLATE utf8_unicode_ci COMMENT 'Description and/or help text to display before this field.',
  `visibility` enum('User and User Admin Only','Public Pages','Public Pages and Listings') COLLATE utf8_unicode_ci DEFAULT 'User and User Admin Only' COMMENT 'In what context(s) is this field visible.',
  `in_selector` tinyint(4) DEFAULT '0' COMMENT 'Is this field included as a column in the selector table?',
  `is_searchable` tinyint(4) DEFAULT '0' COMMENT 'Is this field included search form of profile?',
  `location_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Location type of this mapping, if required',
  `phone_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Phone Type Id, if required',
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'To save label for fields.',
  `field_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'This field saves field type (ie individual,household.. field etc).',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'Is this field reserved for use by some other CiviCRM functionality?',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_uf_field_uf_group_id` (`uf_group_id`),
  KEY `FK_civicrm_uf_field_location_type_id` (`location_type_id`),
  CONSTRAINT `FK_civicrm_uf_field_location_type_id` FOREIGN KEY (`location_type_id`) REFERENCES `civicrm_location_type` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_uf_field_uf_group_id` FOREIGN KEY (`uf_group_id`) REFERENCES `civicrm_uf_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_uf_field`
--

LOCK TABLES `civicrm_uf_field` WRITE;
/*!40000 ALTER TABLE `civicrm_uf_field` DISABLE KEYS */;
INSERT INTO `civicrm_uf_field` VALUES (1,1,'first_name',1,0,1,1,NULL,NULL,'Public Pages and Listings',0,1,NULL,NULL,'First Name','Individual',0),(2,1,'last_name',1,0,1,2,'First and last name will be shared with other visitors to the site.',NULL,'Public Pages and Listings',0,1,NULL,NULL,'Last Name','Individual',0),(3,1,'street_address',1,0,0,3,NULL,NULL,'User and User Admin Only',0,0,1,NULL,'Street Address (Home)','Contact',0),(4,1,'city',1,0,0,4,NULL,NULL,'User and User Admin Only',0,0,1,NULL,'City (Home)','Contact',0),(5,1,'postal_code',1,0,0,5,NULL,NULL,'User and User Admin Only',0,0,1,NULL,'Postal Code (Home)','Contact',0),(6,1,'country',1,0,0,6,'Your state/province and country of residence will be shared with others so folks can find others in their community.',NULL,'Public Pages and Listings',0,1,1,NULL,'Country (Home)','Contact',0),(7,1,'state_province',1,0,0,7,NULL,NULL,'Public Pages and Listings',1,1,1,NULL,'State (Home)','Contact',0),(8,2,'first_name',1,0,1,1,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'First Name','Individual',0),(9,2,'last_name',1,0,1,2,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'Last Name','Individual',0),(10,2,'email',1,0,1,3,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'Email Address','Contact',0),(11,3,'participant_status_id',1,0,1,1,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'Participant Status','Participant',1),(12,4,'first_name',1,0,1,1,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'First Name','Individual',0),(13,4,'last_name',1,0,1,2,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'Last Name','Individual',0),(14,4,'email',1,0,0,3,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'Email Address','Contact',0),(15,5,'organization_name',1,0,1,2,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'Organization Name','Organization',0),(16,5,'email',1,0,0,3,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'Email Address','Contact',0),(17,6,'household_name',1,0,1,2,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'Household Name','Household',0),(18,6,'email',1,0,0,3,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'Email Address','Contact',0),(32,8,'first_name',1,1,0,1,'',NULL,'User and User Admin Only',0,0,NULL,NULL,'First Name','Individual',NULL),(33,8,'last_name',1,1,0,2,'',NULL,'User and User Admin Only',0,0,NULL,NULL,'Last Name','Individual',NULL),(34,8,'email',1,0,0,3,'',NULL,'User and User Admin Only',0,0,NULL,NULL,'Email','Contact',NULL),(35,9,'first_name',1,1,0,1,'',NULL,'User and User Admin Only',0,0,NULL,NULL,'First Name','Individual',NULL),(36,9,'last_name',1,1,0,2,'',NULL,'User and User Admin Only',0,0,NULL,NULL,'Last Name','Individual',NULL),(37,9,'email',1,1,0,3,'',NULL,'User and User Admin Only',0,0,NULL,NULL,'Email','Contact',NULL),(38,9,'do_not_email',1,0,0,4,'',NULL,'User and User Admin Only',0,0,NULL,NULL,'Do Not Email','Contact',NULL),(39,10,'first_name',1,1,0,1,'',NULL,'User and User Admin Only',0,0,NULL,NULL,'First Name','Individual',NULL),(40,10,'last_name',1,1,0,2,'',NULL,'User and User Admin Only',0,0,NULL,NULL,'Last Name','Individual',NULL),(41,10,'street_address',1,1,0,3,'',NULL,'User and User Admin Only',0,0,NULL,NULL,'Street Address','Contact',NULL),(42,10,'supplemental_address_1',1,1,0,4,'',NULL,'User and User Admin Only',0,0,NULL,NULL,'Supplemental Address 1','Contact',NULL),(43,10,'city',1,1,0,5,'',NULL,'User and User Admin Only',0,0,NULL,NULL,'City','Contact',NULL),(44,10,'postal_code',1,1,0,6,'',NULL,'User and User Admin Only',0,0,NULL,NULL,'Postal Code','Contact',NULL),(45,10,'do_not_mail',1,0,0,7,'',NULL,'User and User Admin Only',0,0,NULL,NULL,'Do Not Mail','Contact',NULL),(46,11,'street_address',1,0,0,1,'',NULL,'Public Pages and Listings',1,0,NULL,NULL,'Address','Contact',NULL),(47,11,'city',1,0,0,2,'',NULL,'Public Pages and Listings',1,0,NULL,NULL,'City','Contact',NULL),(48,11,'postal_code',1,0,0,4,'',NULL,'Public Pages and Listings',1,0,NULL,NULL,'Postal Code','Contact',NULL),(49,11,'phone',1,0,0,5,'',NULL,'Public Pages and Listings',1,0,NULL,1,'Phone','Contact',NULL),(51,11,'state_province',1,0,0,3,'',NULL,'Public Pages and Listings',1,0,NULL,NULL,'State','Contact',NULL),(52,11,'email',1,0,0,6,'',NULL,'Public Pages and Listings',1,0,NULL,NULL,'Email','Contact',NULL),(64,13,'phone',1,0,1,1,NULL,NULL,'User and User Admin Only',0,0,1,1,'Home Phone','Contact',0),(65,13,'phone',1,0,1,2,NULL,NULL,'User and User Admin Only',0,0,1,2,'Home Mobile','Contact',0),(66,13,'street_address',1,0,1,3,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'Primary Address','Contact',0),(67,13,'city',1,0,1,4,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'City','Contact',0),(68,13,'state_province',1,0,1,5,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'State','Contact',0),(69,13,'postal_code',1,0,1,6,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'Postal Code','Contact',0),(70,13,'email',1,0,1,7,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'Primary Email','Contact',0),(71,13,'group',1,0,1,8,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'Groups','Contact',0),(72,13,'tag',1,0,1,9,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'Tags','Contact',0),(73,13,'gender',1,0,1,10,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'Gender','Individual',0),(74,13,'birth_date',1,0,1,11,NULL,NULL,'User and User Admin Only',0,0,NULL,NULL,'Date of Birth','Individual',0),(75,14,'street_address',1,0,1,1,NULL,NULL,'User and User Admin Only',0,0,1,NULL,'Street Address (Home)','Contact',1),(76,14,'city',1,0,1,2,NULL,NULL,'User and User Admin Only',0,0,1,NULL,'City (Home)','Contact',1),(77,14,'postal_code',1,0,0,3,NULL,NULL,'User and User Admin Only',0,0,1,NULL,'Postal Code (Home)','Contact',0),(78,14,'country',1,0,0,4,NULL,NULL,'Public Pages and Listings',0,1,1,NULL,'Country (Home)','Contact',0),(79,14,'state_province',1,0,0,5,NULL,NULL,'Public Pages and Listings',1,1,1,NULL,'State (Home)','Contact',0);
/*!40000 ALTER TABLE `civicrm_uf_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_uf_group`
--

DROP TABLE IF EXISTS `civicrm_uf_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_uf_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique table ID',
  `is_active` tinyint(4) DEFAULT '1' COMMENT 'Is this form currently active? If false, hide all related fields for all sharing contexts.',
  `group_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'This column will store a comma separated list of the type(s) of profile fields.',
  `title` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Form title.',
  `help_pre` text COLLATE utf8_unicode_ci COMMENT 'Description and/or help text to display before fields in form.',
  `help_post` text COLLATE utf8_unicode_ci COMMENT 'Description and/or help text to display after fields in form.',
  `limit_listings_group_id` int(10) unsigned DEFAULT NULL COMMENT 'Group id, foriegn key from civicrm_group',
  `post_URL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Redirect to URL.',
  `add_to_group_id` int(10) unsigned DEFAULT NULL COMMENT 'foreign key to civicrm_group_id',
  `add_captcha` tinyint(4) DEFAULT '0' COMMENT 'Should a CAPTCHA widget be included this Profile form.',
  `is_map` tinyint(4) DEFAULT '0' COMMENT 'Do we want to map results from this profile.',
  `is_edit_link` tinyint(4) DEFAULT '0' COMMENT 'Should edit link display in profile selector',
  `is_uf_link` tinyint(4) DEFAULT '0' COMMENT 'Should we display a link to the website profile in profile selector',
  `is_update_dupe` tinyint(4) DEFAULT '0' COMMENT 'Should we update the contact record if we find a duplicate',
  `cancel_URL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Redirect to URL when Cancle button clik .',
  `is_cms_user` tinyint(4) DEFAULT '0' COMMENT 'Should we create a cms user for this profile ',
  `notify` text COLLATE utf8_unicode_ci,
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'Is this group reserved for use by some other CiviCRM functionality?',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name of the UF group for directly addressing it in the codebase',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who created this UF group',
  `created_date` datetime DEFAULT NULL COMMENT 'Date and time this UF group was created.',
  `is_proximity_search` tinyint(4) DEFAULT '0' COMMENT 'Should we include proximity search feature in this profile search form?',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_uf_group_limit_listings_group_id` (`limit_listings_group_id`),
  KEY `FK_civicrm_uf_group_add_to_group_id` (`add_to_group_id`),
  KEY `FK_civicrm_uf_group_created_id` (`created_id`),
  CONSTRAINT `FK_civicrm_uf_group_add_to_group_id` FOREIGN KEY (`add_to_group_id`) REFERENCES `civicrm_group` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_uf_group_created_id` FOREIGN KEY (`created_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_uf_group_limit_listings_group_id` FOREIGN KEY (`limit_listings_group_id`) REFERENCES `civicrm_group` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_uf_group`
--

LOCK TABLES `civicrm_uf_group` WRITE;
/*!40000 ALTER TABLE `civicrm_uf_group` DISABLE KEYS */;
INSERT INTO `civicrm_uf_group` VALUES (1,1,'Individual,Contact','Name and Address','<br />','<br />',NULL,NULL,NULL,0,0,0,0,0,NULL,0,NULL,0,'Name_and_Address',NULL,NULL,0),(2,1,'Individual,Contact','Supporter Profile',NULL,'<p><strong>The information you provide will NOT be shared with any third party organisations.</strong></p><p>Thank you for getting involved in our campaign!</p>',NULL,NULL,NULL,0,0,0,0,0,NULL,2,NULL,0,'Supporter_Profile',NULL,NULL,0),(3,1,'Participant','Participant Status',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL,0,NULL,1,'Participant_Status',NULL,NULL,0),(4,1,'Individual,Contact','New Individual',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL,0,NULL,1,'New_Individual',NULL,NULL,0),(5,1,'Organization,Contact','New Organization',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL,0,NULL,1,'New_Organization',NULL,NULL,0),(6,1,'Household,Contact','New Household',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL,0,NULL,1,'New_Household',NULL,NULL,0),(8,1,'Individual,Contact','Batch Email Delete','<br />','<br />',NULL,NULL,NULL,0,0,0,0,0,NULL,NULL,NULL,NULL,'Batch_Email_Delete',1,'2010-04-25 13:03:35',0),(9,1,'Individual,Contact','Batch Do Not Email','<br />','<br />',NULL,NULL,NULL,0,0,0,0,0,NULL,NULL,NULL,NULL,'Batch_Do_Not_Email',1,'2010-04-25 13:05:41',0),(10,1,'Individual,Contact','Batch Do Not Postal Mail','<br />','<br />',NULL,NULL,NULL,0,0,0,0,0,NULL,NULL,NULL,NULL,'Batch_Do_Not_Postal_Mail',1,'2010-04-25 13:07:28',0),(11,1,'Contact','NYSS Search Results','<br />','<br />',NULL,NULL,NULL,0,0,1,0,0,NULL,0,NULL,NULL,'NYSS_Search_Results',1,'2010-04-25 13:12:26',0),(13,1,'Contact','Summary Overlay',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL,0,NULL,1,'Summary_Overlay',NULL,NULL,0),(14,1,'Contact','Shared Address',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL,0,NULL,1,'shared_address',NULL,NULL,0);
/*!40000 ALTER TABLE `civicrm_uf_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_uf_join`
--

DROP TABLE IF EXISTS `civicrm_uf_join`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_uf_join` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique table ID',
  `is_active` tinyint(4) DEFAULT '1' COMMENT 'Is this join currently active?',
  `module` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Module which owns this uf_join instance, e.g. User Registration, CiviDonate, etc.',
  `entity_table` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name of table where item being referenced is stored. Modules which only need a single collection of uf_join instances may choose not to populate entity_table and entity_id.',
  `entity_id` int(10) unsigned DEFAULT NULL COMMENT 'Foreign key to the referenced item.',
  `weight` int(11) NOT NULL DEFAULT '1' COMMENT 'Controls display order when multiple user framework groups are setup for concurrent display.',
  `uf_group_id` int(10) unsigned NOT NULL COMMENT 'Which form does this field belong to.',
  PRIMARY KEY (`id`),
  KEY `index_entity` (`entity_table`,`entity_id`),
  KEY `FK_civicrm_uf_join_uf_group_id` (`uf_group_id`),
  CONSTRAINT `FK_civicrm_uf_join_uf_group_id` FOREIGN KEY (`uf_group_id`) REFERENCES `civicrm_uf_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_uf_join`
--

LOCK TABLES `civicrm_uf_join` WRITE;
/*!40000 ALTER TABLE `civicrm_uf_join` DISABLE KEYS */;
INSERT INTO `civicrm_uf_join` VALUES (3,1,'Profile',NULL,NULL,1,1),(4,1,'Profile',NULL,NULL,2,2),(5,1,'Profile',NULL,NULL,3,4),(6,1,'Profile',NULL,NULL,4,5),(7,1,'Profile',NULL,NULL,5,6),(9,1,'Profile',NULL,NULL,7,8),(10,1,'Profile',NULL,NULL,8,9),(11,1,'Profile',NULL,NULL,9,10),(12,1,'Search Profile',NULL,NULL,10,11),(13,1,'Profile',NULL,NULL,10,11),(15,1,'Profile',NULL,NULL,6,13),(16,1,'Profile',NULL,NULL,7,14);
/*!40000 ALTER TABLE `civicrm_uf_join` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_uf_match`
--

DROP TABLE IF EXISTS `civicrm_uf_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_uf_match` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'System generated ID.',
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this match entry for',
  `uf_id` int(10) unsigned NOT NULL COMMENT 'UF ID',
  `uf_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'UF Name',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `language` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'UI language preferred by the given user/contact',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_uf_name_domain_id` (`uf_name`,`domain_id`),
  UNIQUE KEY `UI_contact_domain_id` (`contact_id`,`domain_id`),
  KEY `FK_civicrm_uf_match_domain_id` (`domain_id`),
  KEY `I_civicrm_uf_match_uf_id` (`uf_id`),
  CONSTRAINT `FK_civicrm_uf_match_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_civicrm_uf_match_domain_id` FOREIGN KEY (`domain_id`) REFERENCES `civicrm_domain` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_uf_match`
--

LOCK TABLES `civicrm_uf_match` WRITE;
/*!40000 ALTER TABLE `civicrm_uf_match` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_uf_match` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_value_activity_details_6`
--

DROP TABLE IF EXISTS `civicrm_value_activity_details_6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_value_activity_details_6` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `place_of_inquiry_43` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `activity_category_44` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_place_of_inquiry_43` (`place_of_inquiry_43`),
  KEY `INDEX_activity_category_44` (`activity_category_44`),
  CONSTRAINT `FK_civicrm_value_activity_details_6_entity_id` FOREIGN KEY (`entity_id`) REFERENCES `civicrm_activity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_value_activity_details_6`
--

LOCK TABLES `civicrm_value_activity_details_6` WRITE;
/*!40000 ALTER TABLE `civicrm_value_activity_details_6` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_value_activity_details_6` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_value_attachments_5`
--

DROP TABLE IF EXISTS `civicrm_value_attachments_5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_value_attachments_5` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `attachment_36` int(10) unsigned DEFAULT NULL,
  `attachment_2_37` int(10) unsigned DEFAULT NULL,
  `attachment_3_38` int(10) unsigned DEFAULT NULL,
  `attachment_4_39` int(10) unsigned DEFAULT NULL,
  `attachment_5_40` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `FK_civicrm_value_attachments_5_attachment_36` (`attachment_36`),
  KEY `FK_civicrm_value_attachments_5_attachment_2_37` (`attachment_2_37`),
  KEY `FK_civicrm_value_attachments_5_attachment_3_38` (`attachment_3_38`),
  KEY `FK_civicrm_value_attachments_5_attachment_4_39` (`attachment_4_39`),
  KEY `FK_civicrm_value_attachments_5_attachment_5_40` (`attachment_5_40`),
  CONSTRAINT `FK_civicrm_value_attachments_5_attachment_2_37` FOREIGN KEY (`attachment_2_37`) REFERENCES `civicrm_file` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_value_attachments_5_attachment_36` FOREIGN KEY (`attachment_36`) REFERENCES `civicrm_file` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_value_attachments_5_attachment_3_38` FOREIGN KEY (`attachment_3_38`) REFERENCES `civicrm_file` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_value_attachments_5_attachment_4_39` FOREIGN KEY (`attachment_4_39`) REFERENCES `civicrm_file` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_value_attachments_5_attachment_5_40` FOREIGN KEY (`attachment_5_40`) REFERENCES `civicrm_file` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_civicrm_value_attachments_5_entity_id` FOREIGN KEY (`entity_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_value_attachments_5`
--

LOCK TABLES `civicrm_value_attachments_5` WRITE;
/*!40000 ALTER TABLE `civicrm_value_attachments_5` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_value_attachments_5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_value_constituent_information_1`
--

DROP TABLE IF EXISTS `civicrm_value_constituent_information_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_value_constituent_information_1` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned NOT NULL,
  `professional_accreditations_16` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `interest_in_volunteering__17` tinyint(4) DEFAULT NULL,
  `active_constituent__18` tinyint(4) DEFAULT NULL,
  `friend_of_the_senator__19` tinyint(4) DEFAULT NULL,
  `skills_areas_of_interest_20` text COLLATE utf8_unicode_ci,
  `honors_and_awards_21` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `voter_registration_status_23` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `boe_date_of_registration_24` datetime DEFAULT NULL,
  `individual_category_42` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `other_gender_45` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ethnicity1_58` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_source_60` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `record_type_61` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `other_ethnicity_62` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `religion_63` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_professional_accreditations_16` (`professional_accreditations_16`),
  KEY `INDEX_interest_in_volunteering__17` (`interest_in_volunteering__17`),
  KEY `INDEX_active_constituent__18` (`active_constituent__18`),
  KEY `INDEX_friend_of_the_senator__19` (`friend_of_the_senator__19`),
  KEY `INDEX_voter_registration_status_23` (`voter_registration_status_23`),
  KEY `INDEX_boe_date_of_registration_24` (`boe_date_of_registration_24`),
  KEY `INDEX_individual_category_42` (`individual_category_42`),
  KEY `INDEX_other_gender_45` (`other_gender_45`),
  KEY `INDEX_contact_source_60` (`contact_source_60`),
  KEY `INDEX_record_type_61` (`record_type_61`),
  KEY `INDEX_ethnicity1_58` (`ethnicity1_58`),
  KEY `INDEX_other_ethnicity_62` (`other_ethnicity_62`),
  CONSTRAINT `FK_civicrm_value_constituent_information_1_entity_id` FOREIGN KEY (`entity_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_value_constituent_information_1`
--

LOCK TABLES `civicrm_value_constituent_information_1` WRITE;
/*!40000 ALTER TABLE `civicrm_value_constituent_information_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_value_constituent_information_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_value_district_information_7`
--

DROP TABLE IF EXISTS `civicrm_value_district_information_7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_value_district_information_7` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `congressional_district_46` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ny_senate_district_47` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ny_assembly_district_48` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `election_district_49` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `county_50` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `county_legislative_district_51` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `town_52` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ward_53` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `school_district_54` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `new_york_city_council_55` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `neighborhood_56` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_import_57` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_congressional_district_46` (`congressional_district_46`),
  KEY `INDEX_ny_senate_district_47` (`ny_senate_district_47`),
  KEY `INDEX_ny_assembly_district_48` (`ny_assembly_district_48`),
  KEY `INDEX_election_district_49` (`election_district_49`),
  KEY `INDEX_county_50` (`county_50`),
  KEY `INDEX_county_legislative_district_51` (`county_legislative_district_51`),
  KEY `INDEX_town_52` (`town_52`),
  KEY `INDEX_ward_53` (`ward_53`),
  KEY `INDEX_school_district_54` (`school_district_54`),
  KEY `INDEX_new_york_city_council_55` (`new_york_city_council_55`),
  KEY `INDEX_neighborhood_56` (`neighborhood_56`),
  CONSTRAINT `FK_civicrm_value_district_information_7_entity_id` FOREIGN KEY (`entity_id`) REFERENCES `civicrm_address` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_value_district_information_7`
--

LOCK TABLES `civicrm_value_district_information_7` WRITE;
/*!40000 ALTER TABLE `civicrm_value_district_information_7` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_value_district_information_7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_value_organization_constituent_informa_3`
--

DROP TABLE IF EXISTS `civicrm_value_organization_constituent_informa_3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_value_organization_constituent_informa_3` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `charity_registration__dos__25` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employer_identification_number___26` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `organization_category_41` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_charity_registration__dos__25` (`charity_registration__dos__25`),
  KEY `INDEX_employer_identification_number___26` (`employer_identification_number___26`),
  KEY `INDEX_organization_category_41` (`organization_category_41`),
  KEY `dedupe_index_employer_identification_number___26` (`employer_identification_number___26`),
  CONSTRAINT `FK_civicrm_value_organization_const_0b6696f66ab102ad` FOREIGN KEY (`entity_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_value_organization_constituent_informa_3`
--

LOCK TABLES `civicrm_value_organization_constituent_informa_3` WRITE;
/*!40000 ALTER TABLE `civicrm_value_organization_constituent_informa_3` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_value_organization_constituent_informa_3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_website`
--

DROP TABLE IF EXISTS `civicrm_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_website` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Website ID',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `url` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Website',
  `website_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Website type does this website belong to.',
  PRIMARY KEY (`id`),
  KEY `UI_website_type_id` (`website_type_id`),
  KEY `FK_civicrm_website_contact_id` (`contact_id`),
  CONSTRAINT `FK_civicrm_website_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_website`
--

LOCK TABLES `civicrm_website` WRITE;
/*!40000 ALTER TABLE `civicrm_website` DISABLE KEYS */;
/*!40000 ALTER TABLE `civicrm_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `civicrm_worldregion`
--

DROP TABLE IF EXISTS `civicrm_worldregion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `civicrm_worldregion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Country Id',
  `name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Region name to be associated with countries',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `civicrm_worldregion`
--

LOCK TABLES `civicrm_worldregion` WRITE;
/*!40000 ALTER TABLE `civicrm_worldregion` DISABLE KEYS */;
INSERT INTO `civicrm_worldregion` VALUES (1,'Europe and Central Asia'),(2,'America South, Central, North and Caribbean'),(3,'Middle East and North Africa'),(4,'Asia-Pacific'),(5,'Africa West, East, Central and Southern'),(99,'unassigned');
/*!40000 ALTER TABLE `civicrm_worldregion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-04-20 16:30:25
