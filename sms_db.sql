-- phpMyAdmin SQL Dump
-- version 3.2.3
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Dec 02, 2009 at 11:55 PM
-- Server version: 5.0.67
-- PHP Version: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `sms`
--

-- --------------------------------------------------------

--
-- Table structure for table `count`
--

CREATE TABLE IF NOT EXISTS `count` (
  `counter` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `count`
--

INSERT INTO `count` (`counter`) VALUES
(1);

-- --------------------------------------------------------

--
-- Table structure for table `daemons`
--

CREATE TABLE IF NOT EXISTS `daemons` (
  `Start` text NOT NULL,
  `Info` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `daemons`
--


-- --------------------------------------------------------

--
-- Table structure for table `gammu`
--

CREATE TABLE IF NOT EXISTS `gammu` (
  `Version` int(11) NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gammu`
--

INSERT INTO `gammu` (`Version`) VALUES
(11);

-- --------------------------------------------------------

--
-- Table structure for table `inbox`
--

CREATE TABLE IF NOT EXISTS `inbox` (
  `UpdatedInDB` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `ReceivingDateTime` timestamp NOT NULL default '0000-00-00 00:00:00',
  `Text` text NOT NULL,
  `SenderNumber` varchar(20) NOT NULL default '',
  `Coding` enum('Default_No_Compression','Unicode_No_Compression','8bit','Default_Compression','Unicode_Compression') NOT NULL default 'Default_No_Compression',
  `UDH` text NOT NULL,
  `SMSCNumber` varchar(20) NOT NULL default '',
  `Class` int(11) NOT NULL default '-1',
  `TextDecoded` text NOT NULL,
  `ID` int(10) unsigned NOT NULL auto_increment,
  `RecipientID` text NOT NULL,
  `Processed` enum('false','true') NOT NULL default 'false',
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=43 ;

--
-- Dumping data for table `inbox`
--

INSERT INTO `inbox` (`UpdatedInDB`, `ReceivingDateTime`, `Text`, `SenderNumber`, `Coding`, `UDH`, `SMSCNumber`, `Class`, `TextDecoded`, `ID`, `RecipientID`, `Processed`) VALUES
('2009-11-19 14:13:17', '2009-11-19 13:19:42', '00470036', '+919811827487', 'Default_No_Compression', '', '+919811009998', -1, 'testaitankit@gmail.com ankit1234', 1, '', 'false'),
('2009-11-19 22:09:12', '2009-11-19 22:09:12', '76876564465975975960606060676075044', '+919811827487', 'Default_No_Compression', '', '+919243155009', -1, 'sagar.narla@gmail.com angelsndemons', 2, '', 'false'),
('2009-11-19 22:13:44', '2009-11-19 22:13:44', '76876564465975975960606060676075044', '+919811827487', 'Default_No_Compression', '', '+919243155009', -1, 'sagar.narla@gmail.com angelsndemons', 3, '', 'false'),
('2009-11-19 22:28:42', '2009-11-19 22:28:42', '76876564465975975960606060676075044', '+919811827487', 'Default_No_Compression', '', '+919243155009', -1, 'sagar.narla@gmail.com angelsndemons', 4, '', 'false'),
('2009-11-27 22:53:41', '2009-11-27 22:53:41', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, '*', 20, '', 'false'),
('2009-11-27 22:55:46', '2009-11-27 22:55:46', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, '*', 22, '', 'false'),
('2009-11-27 22:54:35', '2009-11-27 22:54:35', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, '*', 21, '', 'false'),
('2009-11-27 22:49:49', '2009-11-27 22:49:49', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, '*', 19, '', 'false'),
('2009-11-27 22:48:03', '2009-11-27 22:48:03', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, '*', 18, '', 'false'),
('2009-11-27 22:47:09', '2009-11-27 22:47:09', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, '*', 17, '', 'false'),
('2009-11-27 22:45:28', '2009-11-27 22:45:28', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, '*', 16, '', 'false'),
('2009-11-27 22:44:36', '2009-11-27 22:44:36', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, '*', 15, '', 'false'),
('2009-11-27 22:43:53', '2009-11-27 22:43:53', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, '*', 14, '', 'false'),
('2009-11-27 22:41:28', '2009-11-27 22:41:28', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, '*', 13, '', 'false'),
('2009-11-27 22:06:56', '2009-11-27 22:06:56', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, '*', 12, '', 'false'),
('2009-11-27 22:04:25', '2009-11-27 22:04:25', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, '*', 11, '', 'false'),
('2009-11-27 22:02:43', '2009-11-27 22:02:43', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, '*', 10, '', 'false'),
('2009-11-27 22:00:50', '2009-11-27 22:00:50', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, '*', 9, '', 'false'),
('2009-11-27 21:23:22', '2009-11-27 21:23:22', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'sagar.narla angelsndemons 1', 8, '', 'false'),
('2009-11-27 21:18:03', '2009-11-27 21:18:03', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'sagar.narla angelsndemons 1', 7, '', 'false'),
('2009-11-27 21:11:56', '2009-11-27 21:11:56', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'sagar.narla angelsndemons 1', 6, '', 'false'),
('2009-11-27 21:10:45', '2009-11-27 21:10:45', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'sagar.narla angelsndemons 1', 5, '', 'false'),
('2009-11-27 22:58:52', '2009-11-27 22:58:52', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'sagar.narla angelsndemons 3 usief', 23, '', 'false'),
('2009-11-27 23:02:29', '2009-11-27 23:02:29', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'sagar.narla angelsndemons 3 usief', 24, '', 'false'),
('2009-11-27 23:04:13', '2009-11-27 23:04:13', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'sagar.narla angelsndemons 3 usief', 25, '', 'false'),
('2009-11-27 23:05:12', '2009-11-27 23:05:12', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'sagar.narla angelsndemons 3 usief', 26, '', 'false'),
('2009-11-27 23:19:03', '2009-11-27 23:19:03', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, '3', 27, '', 'false'),
('2009-11-27 23:20:13', '2009-11-27 23:20:13', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, '3', 28, '', 'false'),
('2009-11-27 23:27:49', '2009-11-27 23:27:49', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'sagar.narla angelsndemons 3 project report', 29, '', 'false'),
('2009-11-27 23:29:15', '2009-11-27 23:29:15', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'sagar.narla angelsndemons 4 sagar_narla@yahoo.com', 30, '', 'false'),
('2009-11-27 23:30:11', '2009-11-27 23:30:11', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'testmail this is a test mail', 31, '', 'false'),
('2009-11-27 23:34:30', '2009-11-27 23:34:30', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'testmail this is a test mail', 32, '', 'false'),
('2009-11-27 23:36:14', '2009-11-27 23:36:14', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'sagar.narla angelsndemons 4 sagar_narla@yahoo.com', 33, '', 'false'),
('2009-11-27 23:37:14', '2009-11-27 23:37:14', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'emailsubject email contents', 34, '', 'false'),
('2009-11-27 23:39:05', '2009-11-27 23:39:05', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'emailsubject email contents', 35, '', 'false'),
('2009-11-27 23:40:25', '2009-11-27 23:40:25', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'emailsubject email contents', 36, '', 'false'),
('2009-11-27 23:44:13', '2009-11-27 23:44:13', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'emailsubject email contents', 37, '', 'false'),
('2009-11-27 23:45:54', '2009-11-27 23:45:54', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'emailsubject email contents', 38, '', 'false'),
('2009-11-27 23:47:58', '2009-11-27 23:47:58', '00324203402340', '+9811827487', 'Default_No_Compression', '', '+919876543210', -1, 'emailsubject email contents', 39, '', 'false'),
('2009-11-27 23:56:24', '2009-11-27 23:56:24', '00324203402340', '+9811142287', 'Default_No_Compression', '', '+919876543210', -1, 'sagar.narla angelsndemons 1', 40, '', 'false'),
('2009-11-27 23:57:10', '2009-11-27 23:57:10', '00324203402340', '+9811142287', 'Default_No_Compression', '', '+919876543210', -1, '1', 41, '', 'false'),
('2009-11-27 23:58:53', '2009-11-27 23:58:53', '00324203402340', '+9811142287', 'Default_No_Compression', '', '+919876543210', -1, '3', 42, '', 'false');

-- --------------------------------------------------------

--
-- Table structure for table `indices`
--

CREATE TABLE IF NOT EXISTS `indices` (
  `UID` int(11) NOT NULL,
  `Index` int(11) NOT NULL,
  `MessageNumber` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `indices`
--

INSERT INTO `indices` (`UID`, `Index`, `MessageNumber`) VALUES
(7, 28, 426),
(7, 27, 419),
(7, 26, 410),
(7, 25, 396),
(7, 24, 392),
(7, 23, 380),
(7, 22, 357),
(7, 21, 350),
(7, 20, 348),
(7, 19, 320),
(7, 18, 283),
(7, 17, 277),
(7, 16, 271),
(7, 15, 256),
(7, 14, 244),
(7, 13, 243),
(7, 12, 239),
(7, 11, 224),
(7, 10, 212),
(7, 9, 209),
(7, 8, 198),
(7, 7, 184),
(7, 6, 181),
(7, 5, 175),
(7, 4, 170),
(7, 3, 164),
(7, 2, 157),
(7, 1, 153),
(2, 1, 1165),
(2, 2, 1166),
(2, 3, 1168),
(2, 4, 1169),
(2, 5, 1170),
(2, 6, 1171),
(2, 7, 1172),
(2, 8, 1173),
(7, 29, 433),
(7, 30, 445),
(7, 31, 451),
(7, 32, 477),
(7, 33, 492),
(7, 34, 501),
(7, 35, 523),
(7, 36, 547),
(7, 37, 609),
(7, 38, 645),
(7, 39, 707),
(7, 40, 708),
(7, 41, 729),
(7, 42, 741),
(7, 43, 752),
(7, 44, 758),
(7, 45, 830),
(7, 46, 855),
(7, 47, 917),
(7, 48, 930),
(7, 49, 1031),
(7, 50, 1095),
(7, 51, 1118),
(7, 52, 1141),
(10, 1, 1165),
(10, 2, 1166),
(10, 3, 1168),
(10, 4, 1169),
(10, 5, 1170),
(10, 6, 1171),
(10, 7, 1172),
(10, 8, 1173);

-- --------------------------------------------------------

--
-- Table structure for table `info`
--

CREATE TABLE IF NOT EXISTS `info` (
  `UID` int(11) NOT NULL auto_increment,
  `Username` varchar(30) NOT NULL,
  `Password` varchar(30) NOT NULL,
  `SenderNumber` varchar(20) NOT NULL,
  `Action` varchar(30) NOT NULL,
  `State` int(11) NOT NULL,
  `SearchString` varchar(50) NOT NULL,
  PRIMARY KEY  (`UID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `info`
--

INSERT INTO `info` (`UID`, `Username`, `Password`, `SenderNumber`, `Action`, `State`, `SearchString`) VALUES
(9, 'sagar.narla', 'angelsndemons', '+9811827487', 'SEND', 0, 'sagar_narla@yahoo.com'),
(10, 'sagar.narla', 'angelsndemons', '+9811142287', 'UNSEEN', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `outbox`
--

CREATE TABLE IF NOT EXISTS `outbox` (
  `UpdatedInDB` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `InsertIntoDB` timestamp NOT NULL default '0000-00-00 00:00:00',
  `SendingDateTime` timestamp NOT NULL default '0000-00-00 00:00:00',
  `Text` text,
  `DestinationNumber` varchar(20) NOT NULL default '',
  `Coding` enum('Default_No_Compression','Unicode_No_Compression','8bit','Default_Compression','Unicode_Compression') NOT NULL default 'Default_No_Compression',
  `UDH` text,
  `Class` int(11) default '-1',
  `TextDecoded` text NOT NULL,
  `ID` int(10) unsigned NOT NULL auto_increment,
  `MultiPart` enum('false','true') default 'false',
  `RelativeValidity` int(11) default '-1',
  `SenderID` varchar(255) default NULL,
  `SendingTimeOut` timestamp NULL default '0000-00-00 00:00:00',
  `DeliveryReport` enum('default','yes','no') default 'default',
  `CreatorID` text NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `outbox_date` (`SendingDateTime`,`SendingTimeOut`),
  KEY `outbox_sender` (`SenderID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `outbox`
--


-- --------------------------------------------------------

--
-- Table structure for table `outbox_multipart`
--

CREATE TABLE IF NOT EXISTS `outbox_multipart` (
  `Text` text,
  `Coding` enum('Default_No_Compression','Unicode_No_Compression','8bit','Default_Compression','Unicode_Compression') NOT NULL default 'Default_No_Compression',
  `UDH` text,
  `Class` int(11) default '-1',
  `TextDecoded` text,
  `ID` int(10) unsigned NOT NULL default '0',
  `SequencePosition` int(11) NOT NULL default '1',
  PRIMARY KEY  (`ID`,`SequencePosition`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `outbox_multipart`
--


-- --------------------------------------------------------

--
-- Table structure for table `pbk`
--

CREATE TABLE IF NOT EXISTS `pbk` (
  `ID` int(11) NOT NULL auto_increment,
  `GroupID` int(11) NOT NULL default '-1',
  `Name` text NOT NULL,
  `Number` text NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `pbk`
--


-- --------------------------------------------------------

--
-- Table structure for table `pbk_groups`
--

CREATE TABLE IF NOT EXISTS `pbk_groups` (
  `Name` text NOT NULL,
  `ID` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `pbk_groups`
--


-- --------------------------------------------------------

--
-- Table structure for table `phones`
--

CREATE TABLE IF NOT EXISTS `phones` (
  `ID` text NOT NULL,
  `UpdatedInDB` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `InsertIntoDB` timestamp NOT NULL default '0000-00-00 00:00:00',
  `TimeOut` timestamp NOT NULL default '0000-00-00 00:00:00',
  `Send` enum('yes','no') NOT NULL default 'no',
  `Receive` enum('yes','no') NOT NULL default 'no',
  `IMEI` varchar(35) NOT NULL,
  `Client` text NOT NULL,
  `Battery` int(11) NOT NULL default '0',
  `Signal` int(11) NOT NULL default '0',
  `Sent` int(11) NOT NULL default '0',
  `Received` int(11) NOT NULL default '0',
  PRIMARY KEY  (`IMEI`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `phones`
--

INSERT INTO `phones` (`ID`, `UpdatedInDB`, `InsertIntoDB`, `TimeOut`, `Send`, `Receive`, `IMEI`, `Client`, `Battery`, `Signal`, `Sent`, `Received`) VALUES
('', '2009-11-19 14:17:30', '2009-11-19 13:38:25', '2009-11-19 14:17:40', 'yes', 'yes', '357060006200243', 'Gammu 1.26.1, Linux, kernel 2.6.27.7-9-pae (#1 SMP 2008-12-04 18:10:04 +0100), GCC 4.3', 28, 100, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `sentitems`
--

CREATE TABLE IF NOT EXISTS `sentitems` (
  `UpdatedInDB` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `InsertIntoDB` timestamp NOT NULL default '0000-00-00 00:00:00',
  `SendingDateTime` timestamp NOT NULL default '0000-00-00 00:00:00',
  `DeliveryDateTime` timestamp NULL default NULL,
  `Text` text NOT NULL,
  `DestinationNumber` varchar(20) NOT NULL default '',
  `Coding` enum('Default_No_Compression','Unicode_No_Compression','8bit','Default_Compression','Unicode_Compression') NOT NULL default 'Default_No_Compression',
  `UDH` text NOT NULL,
  `SMSCNumber` varchar(20) NOT NULL default '',
  `Class` int(11) NOT NULL default '-1',
  `TextDecoded` text NOT NULL,
  `ID` int(10) unsigned NOT NULL default '0',
  `SenderID` varchar(255) NOT NULL,
  `SequencePosition` int(11) NOT NULL default '1',
  `Status` enum('SendingOK','SendingOKNoReport','SendingError','DeliveryOK','DeliveryFailed','DeliveryPending','DeliveryUnknown','Error') NOT NULL default 'SendingOK',
  `StatusError` int(11) NOT NULL default '-1',
  `TPMR` int(11) NOT NULL default '-1',
  `RelativeValidity` int(11) NOT NULL default '-1',
  `CreatorID` text NOT NULL,
  PRIMARY KEY  (`ID`,`SequencePosition`),
  KEY `sentitems_date` (`DeliveryDateTime`),
  KEY `sentitems_tpmr` (`TPMR`),
  KEY `sentitems_dest` (`DestinationNumber`),
  KEY `sentitems_sender` (`SenderID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sentitems`
--

INSERT INTO `sentitems` (`UpdatedInDB`, `InsertIntoDB`, `SendingDateTime`, `DeliveryDateTime`, `Text`, `DestinationNumber`, `Coding`, `UDH`, `SMSCNumber`, `Class`, `TextDecoded`, `ID`, `SenderID`, `SequencePosition`, `Status`, `StatusError`, `TPMR`, `RelativeValidity`, `CreatorID`) VALUES
('2009-11-19 13:56:16', '0000-00-00 00:00:00', '2009-11-19 13:56:16', NULL, '0031003200340035', '919811827487', 'Default_No_Compression', '', '+919868199994', -1, '1245', 1, '', 1, 'SendingOKNoReport', -1, 178, 255, ''),
('2009-11-19 14:13:58', '0000-00-00 00:00:00', '2009-11-19 14:13:58', NULL, '0033', '919811827487', 'Default_No_Compression', '', '+919868199994', -1, '3', 2, '', 1, 'SendingOKNoReport', -1, 179, 255, '');

