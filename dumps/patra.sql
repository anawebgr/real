-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               5.7.24 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for patradb
CREATE DATABASE IF NOT EXISTS `patradb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `patradb`;

-- Dumping structure for table patradb.patra
CREATE TABLE IF NOT EXISTS `patra` (
  `pat_id` int(11) DEFAULT NULL,
  `pat_type` varchar(200) DEFAULT NULL,
  `pat_availability` varchar(100) DEFAULT NULL,
  `pat_location` varchar(100) DEFAULT NULL,
  `pat_sqm` int(11) DEFAULT NULL,
  `pat_price` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table patradb.patra: ~7 rows (approximately)
/*!40000 ALTER TABLE `patra` DISABLE KEYS */;
INSERT INTO `patra` (`pat_id`, `pat_type`, `pat_availability`, `pat_location`, `pat_sqm`, `pat_price`) VALUES
	(4, 'Apartment', 'Rent', 'Patra', 55, 250),
	(5, 'Apartment, Loft', 'Rent', 'Patra', 80, 360),
	(13, 'Loft', 'Sale', 'Patra', 55, 35000),
	(15, 'Loft', 'Rent', 'Patra', 45, 250),
	(17, 'Maisonette', 'Sale', 'Patra', 210, 340000),
	(19, 'Maisonette', 'Rent', 'Patra', 100, 160),
	(20, 'Maisonette', 'Rent', 'Patra', 100, 160);
/*!40000 ALTER TABLE `patra` ENABLE KEYS */;

-- Dumping structure for view patradb.spinview
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `spinview` (
	`id` INT(11) NULL,
	`type` VARCHAR(200) NULL COLLATE 'utf8_general_ci',
	`availability` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`location` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`sqm` INT(11) NULL,
	`price` FLOAT NULL
) ENGINE=MyISAM;

-- Dumping structure for view patradb.spinview
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `spinview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `spinview` AS select `patra`.`pat_id` AS `id`,`patra`.`pat_type` AS `type`,`patra`.`pat_availability` AS `availability`,`patra`.`pat_location` AS `location`,`patra`.`pat_sqm` AS `sqm`,`patra`.`pat_price` AS `price` from `patra` order by `patra`.`pat_sqm`,`patra`.`pat_price` ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
