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


-- Dumping database structure for chaniadb
CREATE DATABASE IF NOT EXISTS `chaniadb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `chaniadb`;

-- Dumping structure for table chaniadb.chania
CREATE TABLE IF NOT EXISTS `chania` (
  `cha_id` int(11) DEFAULT NULL,
  `cha_type` varchar(200) DEFAULT NULL,
  `cha_availability` varchar(100) DEFAULT NULL,
  `cha_location` varchar(100) DEFAULT NULL,
  `cha_sqm` int(11) DEFAULT NULL,
  `cha_price` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table chaniadb.chania: ~2 rows (approximately)
/*!40000 ALTER TABLE `chania` DISABLE KEYS */;
INSERT INTO `chania` (`cha_id`, `cha_type`, `cha_availability`, `cha_location`, `cha_sqm`, `cha_price`) VALUES
	(12, 'Loft', 'Sale', 'Chania', 45, 20000),
	(14, 'Loft', 'Rent', 'Chania', 65, 400);
/*!40000 ALTER TABLE `chania` ENABLE KEYS */;

-- Dumping structure for view chaniadb.spinview
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `spinview` (
	`id` INT(11) NULL,
	`type` VARCHAR(200) NULL COLLATE 'utf8_general_ci',
	`availability` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`location` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`sqm` INT(11) NULL,
	`price` FLOAT NULL
) ENGINE=MyISAM;

-- Dumping structure for view chaniadb.spinview
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `spinview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `spinview` AS select `chania`.`cha_id` AS `id`,`chania`.`cha_type` AS `type`,`chania`.`cha_availability` AS `availability`,`chania`.`cha_location` AS `location`,`chania`.`cha_sqm` AS `sqm`,`chania`.`cha_price` AS `price` from `chania` order by `chania`.`cha_sqm`,`chania`.`cha_price` ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
