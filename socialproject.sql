-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 15, 2023 at 03:13 AM
-- Server version: 11.0.2-MariaDB-log
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `socialproject`
--

-- --------------------------------------------------------

--
-- Table structure for table `account_emailaddress`
--

CREATE TABLE `account_emailaddress` (
  `id` int(11) NOT NULL,
  `email` varchar(254) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `account_emailconfirmation`
--

CREATE TABLE `account_emailconfirmation` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `sent` datetime(6) DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  `email_address_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add category', 1, 'add_category'),
(2, 'Can change category', 1, 'change_category'),
(3, 'Can delete category', 1, 'delete_category'),
(4, 'Can view category', 1, 'view_category'),
(5, 'Can add language', 2, 'add_language'),
(6, 'Can change language', 2, 'change_language'),
(7, 'Can delete language', 2, 'delete_language'),
(8, 'Can view language', 2, 'view_language'),
(9, 'Can add type', 3, 'add_type'),
(10, 'Can change type', 3, 'change_type'),
(11, 'Can delete type', 3, 'delete_type'),
(12, 'Can view type', 3, 'view_type'),
(13, 'Can add media', 4, 'add_media'),
(14, 'Can change media', 4, 'change_media'),
(15, 'Can delete media', 4, 'delete_media'),
(16, 'Can view media', 4, 'view_media'),
(17, 'Can add comment', 5, 'add_comment'),
(18, 'Can change comment', 5, 'change_comment'),
(19, 'Can delete comment', 5, 'delete_comment'),
(20, 'Can view comment', 5, 'view_comment'),
(21, 'Can add channel counter', 6, 'add_channelcounter'),
(22, 'Can change channel counter', 6, 'change_channelcounter'),
(23, 'Can delete channel counter', 6, 'delete_channelcounter'),
(24, 'Can view channel counter', 6, 'view_channelcounter'),
(25, 'Can add group counter', 7, 'add_groupcounter'),
(26, 'Can change group counter', 7, 'change_groupcounter'),
(27, 'Can delete group counter', 7, 'delete_groupcounter'),
(28, 'Can view group counter', 7, 'view_groupcounter'),
(29, 'Can add log entry', 8, 'add_logentry'),
(30, 'Can change log entry', 8, 'change_logentry'),
(31, 'Can delete log entry', 8, 'delete_logentry'),
(32, 'Can view log entry', 8, 'view_logentry'),
(33, 'Can add permission', 9, 'add_permission'),
(34, 'Can change permission', 9, 'change_permission'),
(35, 'Can delete permission', 9, 'delete_permission'),
(36, 'Can view permission', 9, 'view_permission'),
(37, 'Can add group', 10, 'add_group'),
(38, 'Can change group', 10, 'change_group'),
(39, 'Can delete group', 10, 'delete_group'),
(40, 'Can view group', 10, 'view_group'),
(41, 'Can add user', 11, 'add_user'),
(42, 'Can change user', 11, 'change_user'),
(43, 'Can delete user', 11, 'delete_user'),
(44, 'Can view user', 11, 'view_user'),
(45, 'Can add content type', 12, 'add_contenttype'),
(46, 'Can change content type', 12, 'change_contenttype'),
(47, 'Can delete content type', 12, 'delete_contenttype'),
(48, 'Can view content type', 12, 'view_contenttype'),
(49, 'Can add session', 13, 'add_session'),
(50, 'Can change session', 13, 'change_session'),
(51, 'Can delete session', 13, 'delete_session'),
(52, 'Can view session', 13, 'view_session'),
(53, 'Can add site', 14, 'add_site'),
(54, 'Can change site', 14, 'change_site'),
(55, 'Can delete site', 14, 'delete_site'),
(56, 'Can view site', 14, 'view_site'),
(57, 'Can add avatar', 15, 'add_avatar'),
(58, 'Can change avatar', 15, 'change_avatar'),
(59, 'Can delete avatar', 15, 'delete_avatar'),
(60, 'Can view avatar', 15, 'view_avatar'),
(61, 'Can add tag', 16, 'add_tag'),
(62, 'Can change tag', 16, 'change_tag'),
(63, 'Can delete tag', 16, 'delete_tag'),
(64, 'Can view tag', 16, 'view_tag'),
(65, 'Can add tagged item', 17, 'add_taggeditem'),
(66, 'Can change tagged item', 17, 'change_taggeditem'),
(67, 'Can delete tagged item', 17, 'delete_taggeditem'),
(68, 'Can view tagged item', 17, 'view_taggeditem'),
(69, 'Can add email address', 18, 'add_emailaddress'),
(70, 'Can change email address', 18, 'change_emailaddress'),
(71, 'Can delete email address', 18, 'delete_emailaddress'),
(72, 'Can view email address', 18, 'view_emailaddress'),
(73, 'Can add email confirmation', 19, 'add_emailconfirmation'),
(74, 'Can change email confirmation', 19, 'change_emailconfirmation'),
(75, 'Can delete email confirmation', 19, 'delete_emailconfirmation'),
(76, 'Can view email confirmation', 19, 'view_emailconfirmation'),
(77, 'Can add social account', 20, 'add_socialaccount'),
(78, 'Can change social account', 20, 'change_socialaccount'),
(79, 'Can delete social account', 20, 'delete_socialaccount'),
(80, 'Can view social account', 20, 'view_socialaccount'),
(81, 'Can add social application', 21, 'add_socialapp'),
(82, 'Can change social application', 21, 'change_socialapp'),
(83, 'Can delete social application', 21, 'delete_socialapp'),
(84, 'Can view social application', 21, 'view_socialapp'),
(85, 'Can add social application token', 22, 'add_socialtoken'),
(86, 'Can change social application token', 22, 'change_socialtoken'),
(87, 'Can delete social application token', 22, 'delete_socialtoken'),
(88, 'Can view social application token', 22, 'view_socialtoken');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$fnFQGdORrO1ZLIA37d0YwV$DoBXA9w6XvIhds1VC9uIR7brILU3z5VvMnZBXHa/inc=', '2023-10-14 09:07:22.001735', 1, 'mactron', '', '', '', 1, 1, '2023-10-14 09:05:02.707068');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `avatar_avatar`
--

CREATE TABLE `avatar_avatar` (
  `id` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `avatar` varchar(1024) NOT NULL,
  `date_uploaded` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2023-10-14 09:08:01.713193', '1', 'Forex', 1, '[{\"added\": {}}]', 1, 1),
(2, '2023-10-14 09:08:43.102839', '2', 'Crypto', 1, '[{\"added\": {}}]', 1, 1),
(3, '2023-10-14 09:09:04.963406', '1', 'English', 1, '[{\"added\": {}}]', 2, 1),
(4, '2023-10-14 09:09:44.016171', '1', 'Channels Title', 1, '[{\"added\": {}}]', 3, 1),
(5, '2023-10-14 09:10:01.531233', '2', 'Groups Title', 1, '[{\"added\": {}}]', 3, 1),
(6, '2023-10-14 09:10:24.084319', '3', 'Bots Title', 1, '[{\"added\": {}}]', 3, 1),
(7, '2023-10-14 09:13:16.279256', '3', 'Bots Title', 2, '[]', 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(18, 'account', 'emailaddress'),
(19, 'account', 'emailconfirmation'),
(8, 'admin', 'logentry'),
(10, 'auth', 'group'),
(9, 'auth', 'permission'),
(11, 'auth', 'user'),
(15, 'avatar', 'avatar'),
(12, 'contenttypes', 'contenttype'),
(1, 'media', 'category'),
(6, 'media', 'channelcounter'),
(5, 'media', 'comment'),
(7, 'media', 'groupcounter'),
(2, 'media', 'language'),
(4, 'media', 'media'),
(3, 'media', 'type'),
(13, 'sessions', 'session'),
(14, 'sites', 'site'),
(20, 'socialaccount', 'socialaccount'),
(21, 'socialaccount', 'socialapp'),
(22, 'socialaccount', 'socialtoken'),
(16, 'taggit', 'tag'),
(17, 'taggit', 'taggeditem');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2023-10-14 09:04:31.892809'),
(2, 'auth', '0001_initial', '2023-10-14 09:04:32.283036'),
(3, 'account', '0001_initial', '2023-10-14 09:04:32.365378'),
(4, 'account', '0002_email_max_length', '2023-10-14 09:04:32.385860'),
(5, 'admin', '0001_initial', '2023-10-14 09:04:32.426952'),
(6, 'admin', '0002_logentry_remove_auto_add', '2023-10-14 09:04:32.443065'),
(7, 'admin', '0003_logentry_add_action_flag_choices', '2023-10-14 09:04:32.452323'),
(8, 'contenttypes', '0002_remove_content_type_name', '2023-10-14 09:04:32.492040'),
(9, 'auth', '0002_alter_permission_name_max_length', '2023-10-14 09:04:32.520922'),
(10, 'auth', '0003_alter_user_email_max_length', '2023-10-14 09:04:32.546027'),
(11, 'auth', '0004_alter_user_username_opts', '2023-10-14 09:04:32.549555'),
(12, 'auth', '0005_alter_user_last_login_null', '2023-10-14 09:04:32.575492'),
(13, 'auth', '0006_require_contenttypes_0002', '2023-10-14 09:04:32.575492'),
(14, 'auth', '0007_alter_validators_add_error_messages', '2023-10-14 09:04:32.582007'),
(15, 'auth', '0008_alter_user_username_max_length', '2023-10-14 09:04:32.600199'),
(16, 'auth', '0009_alter_user_last_name_max_length', '2023-10-14 09:04:32.617059'),
(17, 'auth', '0010_alter_group_name_max_length', '2023-10-14 09:04:32.629569'),
(18, 'auth', '0011_update_proxy_permissions', '2023-10-14 09:04:32.647357'),
(19, 'auth', '0012_alter_user_first_name_max_length', '2023-10-14 09:04:32.685498'),
(20, 'avatar', '0001_initial', '2023-10-14 09:04:32.707705'),
(21, 'avatar', '0002_add_verbose_names_to_avatar_fields', '2023-10-14 09:04:32.738962'),
(22, 'avatar', '0003_auto_20170827_1345', '2023-10-14 09:04:32.754587'),
(23, 'sessions', '0001_initial', '2023-10-14 09:04:32.770213'),
(24, 'sites', '0001_initial', '2023-10-14 09:04:32.785838'),
(25, 'sites', '0002_alter_domain_unique', '2023-10-14 09:04:32.801463'),
(26, 'socialaccount', '0001_initial', '2023-10-14 09:04:33.031454'),
(27, 'socialaccount', '0002_token_max_lengths', '2023-10-14 09:04:33.078744'),
(28, 'socialaccount', '0003_extra_data_default_dict', '2023-10-14 09:04:33.092682'),
(29, 'taggit', '0001_initial', '2023-10-14 09:04:33.189306'),
(30, 'taggit', '0002_auto_20150616_2121', '2023-10-14 09:04:33.214129'),
(31, 'taggit', '0003_taggeditem_add_unique_index', '2023-10-14 09:04:33.230341'),
(32, 'taggit', '0004_alter_taggeditem_content_type_alter_taggeditem_tag', '2023-10-14 09:04:33.261808'),
(33, 'taggit', '0005_auto_20220424_2025', '2023-10-14 09:04:33.265330'),
(34, 'media', '0001_initial', '2023-10-14 09:07:02.163822'),
(35, 'media', '0002_alter_media_created', '2023-10-14 09:18:11.424772'),
(36, 'media', '0003_rename_created_media_created_at_and_more', '2023-10-14 13:06:02.599149');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('bugmnzqsnso9ksg90cn9hrvumalssc6h', '.eJyVU9uO2jAQ_RUrUtWXBWICNOxT2SRcAizllrIIKXIS57JJ7KwvEFjtv9ehq6pSnypFjmfGZ8Y-M-ddi5BA2uO7liISFVh71BJaRH5c-zxLCCq4D7UHjaCyCU1WCxvsNiN79jwB29nkebTYgvHGcdSRCPOQZZXIKFEntwJdASWASgZihjEIVX6CC5DF4ErlV4ZBRgRmmAscqS1IsBAZSQAq0a35f1YHEcqKK7hkIgWyAoKCofEFoDCUDIVXENPf6U8yMo1IrViP_t4DixKBQgFQVGbkEXyfqMfF9d3yIdilGQfqEykGEcOo_HNNRQbIQEorDC4YpLioQIlyDFBRNPdXVTOCSJih4jeQg5CWGAgmcVuRwWXQsBFgxhUZ0HgYmIZyo7MimylPKkTFHzudMCK9tsAFThgqW8pqU5Z04qzAHWsyft4aiHaTlnUsdAfPnSodDIulmeYrVvvW0LMDe7MMajM2Fmv9QGrbFa-X6cVHwtnkF7sUPWHS6nVdjrvSqVyayickR91RUOpsHKyhPg9ncxs-Vf3-zu270L2tcACzeeQviah5KzTxiG3qvDommLgp6e-ftot4ATeOZ53ZbMET2LshT0Yv1c4dtg4LuJ-8mc8Wz8305_4onUHrUHil9PbSmkfGcTh1uNV_4VDuV7lOS77djX-Y9hndhgukH_yzHtVly-1Kfb2Nr6vddAhfjy8WXL_dit1t9HQOUjmfBez2chzQXmVV8Or5XnnbLqcrd1QP4dKFcLambjLhedc7-EvPdszleBqeRb4KTTpdt1-rRDWioAn1KyRS1QsuKEMJ7ny2np9OUD-d_lGB32A-4SKVZfC_-DvonuDjQQvV0KjJb4SnBNhoq6t3jZb-rQUH9ziVjTyaeJVSQZsxMtoQzlX1cxbhuwP2e81bMpI3Vl_XPj5-Ad-RSc8:1qrqib:kwwTizimyV801apcvEhjtcFqrGHnItTsgGhzyev0ZMo', '2023-10-29 02:19:01.537535'),
('eoliy6wv0vyh1vw0y52cn5ap3a8y7jep', '.eJylU8uSojAU_ZUUbtsWFRTdzIjNw1ZBBRu1rKJ4BIjDyxBAnep_n-BjlrOZRUjl3nMONzf3_GZ8hzjM-DcTOakfQ2bMePiak8wOSlJiWNgFClMnLmwXpU7qQeaNSZ2kwYmPADAeACA_CMDEjo_SkAJ9WHgY5QRlKcVbGY59oB1LlnXZLpjef_OXfSx9oQ_p1-eG4CWNCkAiCB5MEYUhLMiLKF08WnJIQekdVDegY9ljewNgRdcfQJSmk60hgZkJ1IkBlpMPCUyArG_MrSY1OzBVneYtVQdzTbeASpepgydHLK_ga7Yag5_PEo0yzzNMbBoErVeFrVf9rdf1W8_6nrtXYgxTDzWZB5Y2pijdpjMuxAVtzKDLvrHDPo07FX0MTEMRIXkx7nQ8P-XeCYxhiJ2kTU_vGQ47AYphRxVVeWgpMDJMoR7eKmFxi6GY_Eonm9mqVrm1Y2_7gnswr93pl-uXhYiS204f6Kq5rBzzMsvb6nohC6KikHITbIQg1Cz0ZRF_vkSh2sZFNFqZRSKrfAJ3oiYP1TZLdvsuls-GchNRJqYL3oqUlTs6nxKPv4Sb006Tpm1vibb1JmP5lXzw2-WpKqp-xCZnVEta5QZhjg4r3tvF9qd0PkPhtEj2xFdGpROsxZ2UbZbGlKvUUdDvOfNa6O-4g41MzO97bPSpzhVB_cj3rC4V7lKQ5n3IzW4f9mdw44bKhZj1cHITkCWP8JpPTte1ukenem5szl17WGU9shiMrLVSaiwZ5aNDzBsmul7DSN_ZULvU9fspbyY3zsLMzh0S0bcoSIadEHaacUthXByPXfZ4_LdL7EbgqUWiMnH_S-yucFf7fqP2hA6BfmNZat3GiHTk-21WaHcH93xWpgTiJp9HGcmaCetyLPP9_QeqflVy:1qrnO4:nxi6CRbOh82gjF2u5bbLt4Rsx8JIGk_HNRNmOcDWeVo', '2023-10-28 22:45:36.543557'),
('lin7w5wjvvkmdmioti7vk6ihmxvutx7k', '.eJyNkkuPokAUhf8KweU0LQ8R7R2igNKgoNJqTEwJxaMFilQViHT6vw_YM5ntLM-591RO5X5fbAgoYN--2AQUYQbZNzZCGDb0QVDBvrAFyHtP7z3mrxlCEuC0pGmnuhkglDEwujMaKFMKMsZGBU2yByNbnCBbv5jBJi3JC6NjCJmfl7ZpXICMMIMdBmFaxMzgxz9XIs9HzMAG-AZplxn8bDKDZyvyJ6YGgQ0KEHddSHXty1whJl0XUewsUHdfwp1KKC3J23AYhIX8SmEGYwxyrlOvCMfDKM3gkC582RZPovreOpd5a51WZmy4p7s0WQihY2x2i5WcWcsLKFdTvHFcJfbESNZKfkRRi83xop2OTGk9qZFm-E5JGwWNPpVj3jjvGVkanjcNbEP5WBxMnTN1RylctZknY95t0jxIshuvR3l5LPZCmCvRSIrbqrmY_nis7Im2bdt2ItneAj_QbGkHE12b32d-7dWSerN2yY6Xa9hUubvS19oHH-sOL-LWsu4Klysb_5hgJwThAR3j6mTMlhBHt9i5JI-aEhy6k6aGXnjXbGHJV-p0q2wd5VMpbaEiGXeVZvW83N986eAE8nbp8u52vY7p1ErRPsvtfLKbmQd1_068cgpVx1fcyuE-pBTfT46mvn6W_W0yFKNLCWjS3YJQhEEMh0HHWQEzcj4L_Pn8j7VLv_wnR5Mqv_538Ln9TH6_sAGGgMKwB7oDu0dX5EWB40VO4J9zVBUU4n5eJoiiHhph3FNTpyF8ynEnejaePLHf378BOFYMgw:1qrnsa:Jy7yEEDyxh1S2dcb7w_JW9W3Lo24uOfeuYUbs3gUICc', '2023-10-28 23:17:08.668007'),
('lwhvk72q622adl6u95f4xobtxc43ysci', '.eJyVVNuOozgQ_RWU5yYBwrXfuhNyJ-nJvaNIyNgGnAZDbEOGHvW_r8lmd3qkfdkXS65T59iuquNfnRBUIg0rjllIUOe5o3eevsciAD8wbQF0ATQpurCggpGo26Z0HyjvBgXC2esj9w-BFPBUsmPcdz2oObEbmTHWXM9BtqnDyPJA7JquY8pd37Mh0rU40nGMoYmsGAPddJDlebYURUCAzvOvTgooyrDU5JhecMKKqowBy2UGBXkbH7CmFIUSAC4wU1om5pCRUpCCSvgF5YQqqRDlc68nujnuwTshv-eHACnnCrl9JFcIXeWhtmUAEZoo_s8SM8FljhFp9rmSj4n_BTckoSC7g45mPcCHwJTWmIscU6FsBAMCJ83vgzA0lEUBKP87BOUa65rygmp5GOH4TrtDWK5IR9_lfl830pQ3QJDyxoq8aJ_7Tc7VlTGpMbiBhn-jmJ4yBCRr_rnmEt_-E348TVaTV1FbzggzLqtpuk-OYcowqGV_mIy0leWytBBRsytwJlsEclXuugVLejHJcG-_yVeb2diKxSkWt0IEBj8N7NXJgfYu2A2tzP5IswG5JlY92atWeZ3Eo1OwRSvvndr-QV1X-iizrXhyq20f5K8DUrs5zCy6cUrRX8yvdXCxDul1Pn47xOywnpAji7hJtnnerObbqNqPMrUkfjiq1nMrAJPs2hTT_DYIKN654hWyi7f7HI2rvs12N20xsxoXri3N8EeBP_psApINPpYTaJXLi79mk2A7TuYfp-ZysPhiMaircEqIrjqr7bZIsvj9WuXGyw83vxB_NYqHi3CGZcd56hTRSVdhs6P78XF36Y_3QqPqcDa0Vu-DzXqtTm-fx5883U8cf2lHcLm86XzeHOtVFB5fyXA2HW1ifx0dZsSvf3QvZSIbkRVJEZZAtLbjomAgkRMuTUNxxs9nXTuf_zRO2BIeXJFWefS_yHfGnf311IEMy8FGrUulW1svGpphqJqt6t4dLyoqPdbiZVqIoh0go-sZc3l0TRC-B6zW7O2Y8Md3lBH6cR81p9_5-voL3OyXcQ:1qroJX:sqkUgGWyJUnUBDDnWxEF5eTUuU7k90IxrpfTeFRN7xc', '2023-10-28 23:44:59.054336'),
('t91hzfthki2y3c1bqunwap8tc1ygdwyg', '.eJyNU9mSqjAQ_ZUUz4OyiMo8XcQVXHBfyiorQAaQSFgCiFPz7zcw1n2-b-nTp093pU9_cy6kkPv85nwYuRhxnxyMggfEGcXcBxfBRw1pvxAYb0YjsN3NM5ZyUeakQUwDEjHGAgYRmKQkjwEP_rz5TczoYFSgtKoLgc7aRAg3JIxxDe1IDOQhsNIgokHkgSGqWzFCg6A0-wUmiALoOCjLACUANYpe05ANDpy3bhlQH1A_yIBN6D8RJjvJAxcNCGWTZ7ldj24zaTa51P9QJZXBsGA_kTLEpzTOPtttx406LYow8lL44FnUIqnX_gowauuVLjzn98Er2mfJMU7sqHDpE8tyb7Mqb1U1toIDPPFmzz3b3toQkuOqMk5wAMv7jtz0_koxoi3t6fvT1JryhRN6Y1LerO1MXoVz_xW-zDKBNDwsVh2s7nVe2-yHA9hTSJ9cdolzMeanxZfw1FRFOyWxrhBBeS61yn8KiTvLN4ZhdagUnnXZ7MipNVeldL_fdrWhRb1lkDovNHwp60BM7tVrJDi77qIwLEWbhevdyl4WKhKL8oyM86wq1nOCdk5VncyOk1zw5WxN5VxJ1KV4TDxeJCY-RJdZTxRsQdMTYyA-zKwU7WQrK6978Zh505M3ruhQ8M-LgRtWsnhcWJPQyL9ku6tv-lPFMhN-NYoOWtm6xx5bBCYeucWQ-mwXGSUp9FD7vd_sehWF6_WfRW81911G_fxh_29dQ24Kfz44J0WQIre-AnYNteElQRJ4octLUpMneW3EOh_7hJLGNq2ubLKuBbNVA_RZUHujfostuVcncRCFv-Qei39-_gJMACVZ:1qrqUX:t5xA1_o5aD57cCUgDUtcch9OIhcQsvPoV78vd6w418o', '2023-10-29 02:04:29.816882'),
('u04d75urgt8v39ir9zsyoln2wyd3lln3', '.eJyVkk1vqkAUhv-KIbm7UkGtQHdQwaqIH4hQYmKGYfhQYOgwAtr43zvY5i7u7i7P-54nM8l5vrgQUMC9fnEJKMIMca9clLYozAGFCaoEQVa4J64AedcYXdNb_lQsDlEFSVrSFBd_21-wJwrCn14MCCgoQr0mLdh-dQk6IECkYvvikyyKLAU1-wFhQUJpWb32-zAsRs8UZSgmIOfZ9IxJ3I_SDPW94dZPrnkQqDyAH5tkOq18rY5saXHLjcVqtnNUT9aNZqc4k9ad1dKAbm23mZL5VW-lzRxKL5aDq00jGNs3n4riYrxZDb22AYVljXilvVa2054taT45edDTrjdnL2WnHb_0cXDKjVmQJWqE2qae01KTKk8LRwqEtjnS9ZnlRvnC_IiMMfRkI_p8nxRXx94nW2l5e9_Y4zZKzWbNR3Q10cZ7DBwaxpub-XkeQOpe1WpsfrrzW6zX6zSWTQPY69U602xtUGb5XLTdNr5k58uU7KZCo4cuks4qOVmkmC6D4Vn2eX7tDdQXWJz3RW0d0zfdkJfKieRKM6HqyxoLOPD37x97YDbjbelbFXhTbol6bJ5PZcwOkeEYH0tAE3aLimICYtSHTIsCZdXhIAqHw79qHDvkl6bJJQ_-E38wD_7-xEGCAEVh5yJzsvNtIIgKLwx5UXj0-MJcIl1fJpjih0MDmT1dpyH6GWXufv8GEWfzMA:1qrqdV:SzC0ylT7SnogrjDfCUSq53Hem-y_GrL5w6CGAXpUqkg', '2023-10-29 02:13:45.760259');

-- --------------------------------------------------------

--
-- Table structure for table `django_site`
--

CREATE TABLE `django_site` (
  `id` int(11) NOT NULL,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `django_site`
--

INSERT INTO `django_site` (`id`, `domain`, `name`) VALUES
(1, 'example.com', 'example.com');

-- --------------------------------------------------------

--
-- Table structure for table `media_category`
--

CREATE TABLE `media_category` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `slug` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `media_category`
--

INSERT INTO `media_category` (`id`, `name`, `title`, `description`, `slug`) VALUES
(1, 'Forex', 'Forex Title', 'Forex Description', 'forex'),
(2, 'Crypto', 'Crypto Title', 'Crypto Description', 'crypto');

-- --------------------------------------------------------

--
-- Table structure for table `media_channelcounter`
--

CREATE TABLE `media_channelcounter` (
  `id` bigint(20) NOT NULL,
  `subscribers` int(11) DEFAULT NULL,
  `photos` varchar(20) DEFAULT NULL,
  `videos` varchar(20) DEFAULT NULL,
  `files` varchar(20) DEFAULT NULL,
  `links` varchar(20) DEFAULT NULL,
  `updated` date NOT NULL,
  `channel_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `media_channelcounter`
--

INSERT INTO `media_channelcounter` (`id`, `subscribers`, `photos`, `videos`, `files`, `links`, `updated`, `channel_id`) VALUES
(7, 4895, '1.4K', '2', '0', '527', '2023-10-14', 7),
(8, 56873, '0', '0', '0', '0', '2023-10-14', 8),
(9, 19134, '25.7K', '92', '22.5K', '6.14K', '2023-10-14', 9),
(10, 3427, '5.92K', '14', '0', '6.01K', '2023-10-14', 10),
(11, 81873, '3.35K', '1.33K', '0', '641', '2023-10-14', 11),
(12, 3804, '634', '7', '0', '127', '2023-10-14', 12),
(13, 1380, '81', '0', '0', '80', '2023-10-14', 13),
(14, 114, '10', '0', '0', '2', '2023-10-14', 14),
(15, 218686, '1.03K', '17', '0', '875', '2023-10-14', 16),
(16, 559, '10', '1', '0', '2.22K', '2023-10-14', 17),
(17, 13135, '1.07K', '67', '0', '33', '2023-10-14', 20),
(18, 5641, '0', '0', '0', '0', '2023-10-15', 21),
(19, 10277, '4.9K', '251', '0', '137', '2023-10-15', 22),
(20, 1366, '9', '0', '0', '0', '2023-10-15', 23),
(21, 752176, '0', '0', '0', '0', '2023-10-15', 24),
(22, 39129, '0', '0', '0', '0', '2023-10-15', 25),
(23, 1946018, '66', '0', '0', '79', '2023-10-15', 26),
(24, 5758, '11', '0', '0', '37', '2023-10-15', 27),
(25, 2559, '14', '1.4K', '0', '352', '2023-10-15', 28),
(26, 379981, '1.71K', '118', '0', '1.57K', '2023-10-15', 29),
(27, 161, '2', '0', '0', '147', '2023-10-15', 30),
(28, 22440, '9.83K', '438', '1', '143', '2023-10-15', 31),
(29, 112581, '6.92K', '2.37K', '3', '19', '2023-10-15', 32),
(30, 4778, '0', '309', '0', '3', '2023-10-15', 33),
(31, 121926, '0', '0', '0', '0', '2023-10-15', 34),
(32, 36600, '22', '5', '0', '35', '2023-10-15', 35),
(33, 54427, '2.52K', '124', '0', '55', '2023-10-15', 36),
(34, 9483, '1.86K', '123', '1', '748', '2023-10-15', 37),
(35, 4395, '2.93K', '121', '0', '47', '2023-10-15', 38),
(36, 10092, '5.02K', '243', '1', '80', '2023-10-15', 39),
(37, 610073, '140', '0', '0', '0', '2023-10-15', 40),
(38, 40963, '16.3K', '808', '3', '731', '2023-10-15', 41),
(39, 10614, '351', '4', '0', '41', '2023-10-15', 42),
(40, 10347, '3.89K', '187', '0', '102', '2023-10-15', 43),
(41, 61832, '1.61K', '30', '1', '282', '2023-10-15', 44),
(42, 22692, '0', '0', '0', '0', '2023-10-15', 45),
(43, 418647, '450', '16', '0', '2', '2023-10-15', 46),
(44, 21, '0', '0', '0', '0', '2023-10-15', 47),
(45, 1700, '7', '0', '0', '0', '2023-10-15', 48),
(46, 568, '0', '0', '0', '0', '2023-10-15', 49),
(47, 3214, '8', '0', '0', '4', '2023-10-15', 50),
(48, 339, '1.89K', '8', '0', '1.45K', '2023-10-15', 52),
(49, 168, '0', '0', '0', '0', '2023-10-15', 53),
(50, 481, '0', '0', '0', '0', '2023-10-15', 54),
(51, 2964, '0', '0', '0', '0', '2023-10-15', 55),
(52, 2491, '135', '20', '41', '156', '2023-10-15', 56),
(53, 130, '54', '0', '0', '60', '2023-10-15', 57),
(54, 174, '0', '0', '0', '0', '2023-10-15', 58),
(55, 292, '1', '0', '0', '0', '2023-10-15', 59),
(56, 6041, '4', '0', '0', '54.5K', '2023-10-15', 60),
(57, 26819, '3', '0', '0', '49.8K', '2023-10-15', 61),
(58, 26751, '0', '0', '0', '0', '2023-10-15', 62),
(59, 100, '0', '0', '0', '0', '2023-10-15', 63),
(60, 53111, '646', '17', '0', '4', '2023-10-15', 64),
(61, 6643, '402', '0', '9', '14', '2023-10-15', 65),
(62, 22, '162', '6', '2', '0', '2023-10-15', 68),
(63, 19452, '0', '0', '0', '0', '2023-10-15', 69),
(64, 624925, '140', '0', '0', '0', '2023-10-15', 70),
(65, 256107, '13', '0', '0', '16', '2023-10-15', 71),
(66, 476220, '120', '0', '0', '0', '2023-10-15', 72),
(67, 321937, '3.99K', '148', '0', '118', '2023-10-15', 73),
(68, 6700, '3', '1', '0', '2', '2023-10-15', 74),
(69, 35441, '8.69K', '419', '1', '172', '2023-10-15', 75),
(70, 11886, '847', '20', '0', '21', '2023-10-15', 76),
(71, 8327, '0', '0', '0', '0', '2023-10-15', 77),
(72, 1172, '86', '4', '0', '12', '2023-10-15', 78),
(73, 222, '0', '0', '0', '0', '2023-10-15', 79),
(74, 2311, '1.57K', '7', '2', '926', '2023-10-15', 80),
(75, 18467, '629', '73', '0', '71', '2023-10-15', 81),
(76, 13146, '0', '0', '0', '0', '2023-10-15', 82),
(77, 149615, '867', '190', '0', '137', '2023-10-15', 83),
(78, 1031, '0', '0', '0', '0', '2023-10-15', 84),
(79, 1433, '0', '0', '0', '0', '2023-10-15', 85),
(80, 35224, '0', '0', '0', '0', '2023-10-15', 86),
(81, 48724, '2.92K', '56', '1', '473', '2023-10-15', 87),
(82, 70852, '76', '3', '0', '407', '2023-10-15', 88),
(83, 374, '3', '0', '0', '11', '2023-10-15', 89),
(84, 1006, '0', '0', '0', '0', '2023-10-15', 90),
(85, 1182, '2.28K', '1', '0', '5', '2023-10-15', 91),
(86, 28929, '2.63K', '8', '1.37K', '2.77K', '2023-10-15', 92),
(87, 1811, '128', '18', '0', '0', '2023-10-15', 93),
(88, 14924, '9.75K', '745', '0', '287', '2023-10-15', 94),
(89, 751, '5.98K', '7', '0', '1.86K', '2023-10-15', 95),
(90, 48778, '1.98K', '29', '0', '37', '2023-10-15', 96),
(91, 316, '3', '0', '0', '2', '2023-10-15', 97),
(92, 79895, '3', '0', '0', '11.8K', '2023-10-15', 98),
(93, 10651, '6.04K', '332', '0', '99', '2023-10-15', 99),
(95, 13683, '3.11K', '154', '0', '50', '2023-10-15', 101);

-- --------------------------------------------------------

--
-- Table structure for table `media_comment`
--

CREATE TABLE `media_comment` (
  `id` bigint(20) NOT NULL,
  `text` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `media_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `media_comment`
--

INSERT INTO `media_comment` (`id`, `text`, `created_at`, `active`, `media_id`) VALUES
(1, 'hey hey', '2023-10-14 23:45:24.018293', 1, 14);

-- --------------------------------------------------------

--
-- Table structure for table `media_groupcounter`
--

CREATE TABLE `media_groupcounter` (
  `id` bigint(20) NOT NULL,
  `members` int(11) DEFAULT NULL,
  `group_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `media_groupcounter`
--

INSERT INTO `media_groupcounter` (`id`, `members`, `group_id`) VALUES
(1, 162975, 18),
(2, 85522, 19);

-- --------------------------------------------------------

--
-- Table structure for table `media_language`
--

CREATE TABLE `media_language` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `code` varchar(10) NOT NULL,
  `slug` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `media_language`
--

INSERT INTO `media_language` (`id`, `name`, `title`, `description`, `code`, `slug`) VALUES
(1, 'English', 'English Title', 'English Description', 'EN', 'en');

-- --------------------------------------------------------

--
-- Table structure for table `media_media`
--

CREATE TABLE `media_media` (
  `id` bigint(20) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `body` longtext DEFAULT NULL,
  `nsfw` tinyint(1) NOT NULL,
  `accept_payments` tinyint(1) NOT NULL,
  `status` int(11) NOT NULL,
  `official` int(11) NOT NULL,
  `logo_path` varchar(100) NOT NULL,
  `thumb_path` varchar(100) NOT NULL,
  `created_at` date DEFAULT NULL,
  `published_at` datetime(6) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `language_id` bigint(20) NOT NULL,
  `type_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `media_media`
--

INSERT INTO `media_media` (`id`, `handle`, `name`, `description`, `body`, `nsfw`, `accept_payments`, `status`, `official`, `logo_path`, `thumb_path`, `created_at`, `published_at`, `category_id`, `language_id`, `type_id`) VALUES
(7, 'royalforexsignalsfree', 'Royal Forex Signals FREE', 'ed', 'ed', 0, 0, 0, 1, 'storage/channels\\10\\royalforexsignalsfree_logo.jpg', 'storage/channels\\10\\royalforexsignalsfree_thumb.jpg', '2017-08-07', '2023-10-14 11:04:49.194736', 1, 1, 1),
(8, 'learning_french_francais', 'Learning French apprendre le français', 'ed', 'ed', 0, 0, 0, 0, 'storage/channels\\10\\learning_french_francais_logo.jpg', 'storage/channels\\10\\learning_french_francais_thumb.jpg', NULL, '2023-10-14 11:05:00.099583', 2, 1, 1),
(9, 'tridrob', 'STL 3D Model  TRIDROB ', 'Created: 2022-03-13', 'Created: 2022-03-13', 0, 0, 0, 0, 'storage/channels\\10\\tridrob_logo.jpg', 'storage/channels\\10\\tridrob_thumb.jpg', '2022-03-13', '2023-10-14 13:00:18.072349', 1, 1, 1),
(10, 'printersdeals', '3D Printers BEST Deals', 'printersdeals', 'printersdeals', 0, 0, 0, 0, 'storage/channels\\10\\printersdeals_logo.jpg', 'storage/channels\\10\\printersdeals_thumb.jpg', '2020-06-12', '2023-10-14 13:01:07.081774', 1, 1, 1),
(11, 'hnaftali', 'Hananya Naftali  Israel News', 'eded', 'eded', 0, 0, 0, 0, 'storage/channels\\10\\hnaftali_logo.jpg', 'storage/channels\\10\\hnaftali_thumb.jpg', '2021-01-09', '2023-10-14 13:01:25.558846', 1, 1, 1),
(12, 'sports_bet_central', 'Sports Bet Central', 'sports_bet_central', 'sports_bet_central', 0, 0, 0, 0, 'storage/channels\\10\\sports_bet_central_logo.jpg', 'storage/channels\\10\\sports_bet_central_thumb.jpg', '2023-02-09', '2023-10-14 13:01:54.965155', 2, 1, 1),
(13, 'anime_counter', 'Anime Counter', 'anime_counter', 'anime_counter', 0, 0, 0, 0, 'storage/channels\\10\\anime_counter_logo.jpg', 'storage/channels\\10\\anime_counter_thumb.jpg', '2023-01-09', '2023-10-14 13:02:18.275593', 1, 1, 1),
(14, 'royalforexsignals', 'ROYAL FOREX SIGNALS ', 'ed', 'ed', 0, 0, 0, 0, 'storage/channels\\10\\royalforexsignals_logo.jpg', 'storage/channels\\10\\royalforexsignals_thumb.jpg', '2018-08-10', '2023-10-14 16:12:53.807521', 1, 1, 1),
(16, 'crypto7987sekta', 'BTP CRYPTO PUMPS  SIGNALS', 'crypto7987sekta', 'crypto7987sekta', 0, 0, 0, 0, 'storage/channels\\10\\crypto7987sekta_logo.jpg', 'storage/channels\\10\\crypto7987sekta_thumb.jpg', '2022-02-19', '2023-10-14 16:16:17.619061', 1, 1, 1),
(17, 'livebetsignals', 'Bet Signals', 'livebetsignals', 'livebetsignals', 0, 0, 0, 0, 'storage/channels\\10\\livebetsignals_logo.jpg', 'storage/channels\\10\\livebetsignals_thumb.jpg', '2022-12-20', '2023-10-14 16:16:55.162246', 1, 1, 1),
(18, 'binanceexchange', 'Binance English', 'ed', 'ed', 0, 0, 0, 0, 'storage/groups\\10\\binanceexchange_logo.jpg', 'storage/groups\\10\\binanceexchange_thumb.jpg', NULL, '2023-10-14 19:25:43.857986', 1, 1, 2),
(19, 'icospeaks', 'ICO SPEAKS', 'icospeaks', 'icospeaks', 0, 0, 0, 0, 'storage/groups\\10\\icospeaks_logo.jpg', 'storage/groups\\10\\icospeaks_thumb.jpg', NULL, '2023-10-14 19:51:25.644889', 1, 1, 2),
(20, 'gold_forex_tradingl', 'GOLD FOREX TRADING', 'gold_forex_tradingl', 'gold_forex_tradingl', 0, 0, 0, 0, 'storage/channels\\10\\gold_forex_tradingl_logo.jpg', 'storage/channels\\10\\gold_forex_tradingl_thumb.jpg', '2023-08-24', '2023-10-14 21:57:02.810979', 1, 1, 1),
(21, 'seasidesignalscrypto', 'SeaSideSignals', 'seasidesignalscrypto', 'seasidesignalscrypto', 0, 0, 0, 0, 'storage/channels\\10\\seasidesignalscrypto_logo.jpg', 'storage/channels\\10\\seasidesignalscrypto_thumb.jpg', NULL, '2023-10-14 22:00:21.428895', 1, 1, 1),
(22, 'gold_forex_trading1', 'GOLD FOREX SIGNALS', 'gold_forex_trading1', 'gold_forex_trading1', 0, 0, 0, 0, 'storage/channels\\10\\gold_forex_trading1_logo.jpg', 'storage/channels\\10\\gold_forex_trading1_thumb.jpg', '2023-05-26', '2023-10-14 22:05:07.484704', 1, 1, 1),
(23, 'byignazio', 'Ignazio', 'byignazio', 'byignazio', 0, 0, 0, 0, 'storage/channels\\10\\byignazio_logo.jpg', 'storage/channels\\10\\byignazio_thumb.jpg', '2020-06-08', '2023-10-14 22:10:29.873290', 1, 1, 1),
(24, 'olymp_trade_signals_quotex', 'Olymp Trade Signals Quotex', 'olymp_trade_signals_quotex', 'olymp_trade_signals_quotex', 0, 0, 0, 0, 'storage/channels\\10\\olymp_trade_signals_quotex_logo.jpg', 'storage/channels\\10\\olymp_trade_signals_quotex_thumb.jpg', NULL, '2023-10-14 22:11:43.495446', 1, 1, 1),
(25, 'sickmindsmedia', 'Sick Minds Media', 'sickmindsmedia', 'sickmindsmedia', 0, 0, 0, 0, 'storage/channels\\10\\sickmindsmedia_logo.jpg', 'storage/channels\\10\\sickmindsmedia_thumb.jpg', NULL, '2023-10-14 22:12:28.864687', 1, 1, 1),
(26, 'crypto_pumps_signals_global', 'Crypto Pumps', 'crypto_pumps_signals_global', 'crypto_pumps_signals_global', 0, 0, 0, 0, 'storage/channels\\10\\crypto_pumps_signals_global_logo.jpg', 'storage/channels\\10\\crypto_pumps_signals_global_thumb.jpg', '2023-05-03', '2023-10-14 22:14:02.545953', 1, 1, 1),
(27, 'ayurvedawellbeing', 'Ayurveda Wellbeing', 'ayurvedawellbeing', 'ayurvedawellbeing', 0, 0, 0, 0, 'storage/channels\\10\\ayurvedawellbeing_logo.jpg', 'storage/channels\\10\\ayurvedawellbeing_thumb.jpg', '2019-01-26', '2023-10-14 22:14:23.143910', 1, 1, 1),
(28, 'utcutie', 'Daily dose of Cuteness', 'utcutie', 'utcutie', 0, 0, 0, 0, 'storage/channels\\10\\utcutie_logo.jpg', 'storage/channels\\10\\utcutie_thumb.jpg', '2023-04-23', '2023-10-14 22:16:35.862681', 1, 1, 1),
(29, 'netflix', '8 Great Movies', 'netflix', 'netflix', 0, 0, 0, 0, 'storage/channels\\10\\netflix_logo.jpg', 'storage/channels\\10\\netflix_thumb.jpg', '2016-02-23', '2023-10-14 22:18:11.966217', 1, 1, 1),
(30, 'thehealthchannelnews', 'World Health News', 'thehealthchannelnews', 'thehealthchannelnews', 0, 0, 0, 0, 'storage/channels\\10\\thehealthchannelnews_logo.jpg', 'storage/channels\\10\\thehealthchannelnews_thumb.jpg', '2019-04-08', '2023-10-14 22:20:31.037530', 1, 1, 1),
(31, 'gbpjpyforexfree', 'GBPJPY FOREX', 'gbpjpyforexfree', 'gbpjpyforexfree', 0, 0, 0, 0, 'storage/channels\\10\\gbpjpyforexfree_logo.jpg', 'storage/channels\\10\\gbpjpyforexfree_thumb.jpg', '2023-03-22', '2023-10-14 22:24:51.858216', 1, 1, 1),
(32, 'memes', 'Memes ', 'memes', 'memes', 0, 0, 0, 0, 'storage/channels\\10\\memes_logo.jpg', 'storage/channels\\10\\memes_thumb.jpg', '2015-12-22', '2023-10-14 22:25:35.716780', 1, 1, 1),
(33, 'animal_fighting', 'Animal Fights', 'animal_fighting', 'animal_fighting', 0, 0, 0, 0, 'storage/channels\\10\\animal_fighting_logo.jpg', 'storage/channels\\10\\animal_fighting_thumb.jpg', '2022-04-11', '2023-10-14 22:27:03.512576', 1, 1, 1),
(34, 'getcoinit', 'Gimme The Coin', 'getcoinit', 'getcoinit', 0, 0, 0, 0, 'storage/channels\\10\\getcoinit_logo.jpg', 'storage/channels\\10\\getcoinit_thumb.jpg', NULL, '2023-10-14 22:37:18.162732', 1, 1, 1),
(35, 'cryptosignal', 'Crypto Signal', 'cryptosignal', 'cryptosicryptosignalgnal', 0, 0, 0, 0, 'storage/channels\\10\\cryptosignal_logo.jpg', 'storage/channels\\10\\cryptosignal_thumb.jpg', '2020-06-04', '2023-10-14 22:38:42.883195', 1, 1, 1),
(36, 'goldfxsignaldaily', 'Gold Fx Signals Daily ', 'goldfxsignaldaily', 'goldfxsignaldaily', 0, 0, 0, 0, 'storage/channels\\10\\goldfxsignaldaily_logo.jpg', 'storage/channels\\10\\goldfxsignaldaily_thumb.jpg', '2023-07-30', '2023-10-14 22:39:55.129686', 1, 1, 1),
(37, 'elizabethhome1', 'MASTER ODDS ', 'elizabethhome1', 'elizabethhome1', 0, 0, 0, 0, 'storage/channels\\10\\elizabethhome1_logo.jpg', 'storage/channels\\10\\elizabethhome1_thumb.jpg', '2022-01-16', '2023-10-14 22:40:40.838104', 1, 1, 1),
(38, 'gbpusdusdcadnzdjpyfx', 'GBPUSD USDCAD NZDJPY SIGNALS', 'gbpusdusdcadnzdjpyfx', 'gbpusdusdcadnzdjpyfx', 0, 0, 0, 0, 'storage/channels\\10\\gbpusdusdcadnzdjpyfx_logo.jpg', 'storage/channels\\10\\gbpusdusdcadnzdjpyfx_thumb.jpg', '2023-06-21', '2023-10-14 22:42:15.019878', 1, 1, 1),
(39, 'arrrashfx', 'Forex by Arrash', 'arrrashfx', 'arrrashfx', 0, 0, 0, 0, 'storage/channels\\10\\arrrashfx_logo.jpg', 'storage/channels\\10\\arrrashfx_thumb.jpg', '2021-10-11', '2023-10-14 22:44:33.258579', 1, 1, 1),
(40, 'crypto_futures_signals_binance', 'Binance Signals Futures Trading', 'crypto_futures_signals_binance', 'crypto_futures_signals_binance', 0, 0, 0, 0, 'storage/channels\\10\\crypto_futures_signals_binance_logo.jpg', 'storage/channels\\10\\crypto_futures_signals_binance_thumb.jpg', '2023-08-16', '2023-10-14 22:45:42.779420', 1, 1, 1),
(41, 'goldfx_signalls', 'GOLD FX SIGNALS', 'goldfx_signalls', 'goldfx_signalls', 0, 0, 0, 0, 'storage/channels\\10\\goldfx_signalls_logo.jpg', 'storage/channels\\10\\goldfx_signalls_thumb.jpg', '2022-09-18', '2023-10-14 22:46:28.463250', 1, 1, 1),
(42, 'asiasignal_com', 'AsiaSignal  Crypto Signals', 'asiasignal_com', 'asiasignal_com', 0, 0, 0, 0, 'storage/channels\\10\\asiasignal_com_logo.jpg', 'storage/channels\\10\\asiasignal_com_thumb.jpg', '2021-11-04', '2023-10-14 22:49:14.034725', 1, 1, 1),
(43, 'gold_trading_signallo', 'GOLD TRADING SIGNALS', 'gold_trading_signallo', 'gold_trading_signallo', 0, 0, 0, 0, 'storage/channels\\10\\gold_trading_signallo_logo.jpg', 'storage/channels\\10\\gold_trading_signallo_thumb.jpg', '2023-06-26', '2023-10-14 22:50:04.482502', 1, 1, 1),
(44, 'binance_earn_community', 'Binance Earn Community', 'binance_earn_community', 'binance_earn_community', 0, 0, 0, 0, 'storage/channels\\10\\binance_earn_community_logo.jpg', 'storage/channels\\10\\binance_earn_community_thumb.jpg', '2022-06-28', '2023-10-14 22:50:26.699360', 1, 1, 1),
(45, 'tradebullsnewss', 'Austen Trade bullsNews  Signal', 'tradebullsnewss', 'tradebullsnewss', 0, 0, 0, 0, 'storage/channels\\10\\tradebullsnewss_logo.jpg', 'storage/channels\\10\\tradebullsnewss_thumb.jpg', NULL, '2023-10-14 22:50:49.948786', 1, 1, 1),
(46, 'gold_signalfx_daily', 'Gold Signals Daily ', 'gold_signalfx_daily', 'gold_signalfx_daily', 0, 0, 0, 0, 'storage/channels\\10\\gold_signalfx_daily_logo.jpg', 'storage/channels\\10\\gold_signalfx_daily_thumb.jpg', '2022-08-30', '2023-10-14 22:52:11.131619', 1, 1, 1),
(47, 'forexminister2017', 'forexminister2017', 'forexminister2017', 'forexminister2017', 0, 0, 0, 0, 'storage/empty.jpg', 'storage/empty_thumb.jpg', '2021-04-18', '2023-10-14 22:52:46.720631', 1, 1, 1),
(48, 'developappandwebsitee', 'Develop App and Website', 'developappandwebsitee', 'developappandwebsitee', 0, 0, 0, 0, 'storage/channels\\10\\developappandwebsitee_logo.jpg', 'storage/channels\\10\\developappandwebsitee_thumb.jpg', '2018-04-03', '2023-10-14 22:53:32.972637', 1, 1, 1),
(49, 'priceactionforexebook', 'Price Action Forex Ebook  Material', 'priceactionforexebook', 'priceactionforexebook', 0, 0, 0, 0, 'storage/channels\\10\\priceactionforexebook_logo.jpg', 'storage/channels\\10\\priceactionforexebook_thumb.jpg', NULL, '2023-10-14 22:54:22.139684', 1, 1, 1),
(50, 'booksbunch', 'BooksBunch  Books Library  AudioBooks Podcasts', 'booksbunch', 'booksbunch', 0, 0, 0, 0, 'storage/channels\\10\\booksbunch_logo.jpg', 'storage/channels\\10\\booksbunch_thumb.jpg', '2023-04-09', '2023-10-14 22:55:28.439512', 1, 1, 1),
(52, 'medicalebo', 'Medical ebooks', 'medicalebo', 'medicalebo', 0, 0, 0, 0, 'storage/channels\\10\\medicalebo_logo.jpg', 'storage/channels\\10\\medicalebo_thumb.jpg', '2023-04-22', '2023-10-14 22:58:20.159103', 1, 1, 1),
(53, 'mj_resources', 'MJ Resources', 'mj_resources', 'mj_resources', 0, 0, 0, 0, 'storage/channels\\10\\mj_resources_logo.jpg', 'storage/channels\\10\\mj_resources_thumb.jpg', NULL, '2023-10-14 23:01:37.625104', 1, 1, 1),
(54, 'internal1', 'Internal books  courses articles', 'internal1', 'internal1', 0, 0, 0, 0, 'storage/channels\\10\\internal1_logo.jpg', 'storage/channels\\10\\internal1_thumb.jpg', NULL, '2023-10-14 23:02:13.023019', 1, 1, 1),
(55, 'library', 'Library  Top Reviews  Summary', 'library', 'library', 0, 0, 0, 0, 'storage/channels\\10\\library_logo.jpg', 'storage/channels\\10\\library_thumb.jpg', NULL, '2023-10-14 23:02:29.631934', 1, 1, 1),
(56, 'arthutchannel', 'ArtHut', 'arthutchannel', 'arthutchannel', 0, 0, 0, 0, 'storage/channels\\10\\arthutchannel_logo.jpg', 'storage/channels\\10\\arthutchannel_thumb.jpg', '2021-07-18', '2023-10-14 23:07:18.387298', 1, 1, 1),
(57, 'bookoffersamazon', 'BOOKS BEST BUY DEALS  It Starts with US  It Ends with US available HERE', 'bookoffersamazon', 'bookoffersamazon', 0, 0, 0, 0, 'storage/channels\\10\\bookoffersamazon_logo.jpg', 'storage/channels\\10\\bookoffersamazon_thumb.jpg', '2022-10-30', '2023-10-14 23:09:21.070782', 1, 1, 1),
(58, 'xlitehub', 'XLite Hub  Make Money Online  Finance', 'xlitehub', 'xlitehub', 0, 0, 0, 0, 'storage/channels\\10\\xlitehub_logo.jpg', 'storage/channels\\10\\xlitehub_thumb.jpg', NULL, '2023-10-14 23:10:16.596267', 1, 1, 1),
(59, 'hollywoodmovieshub1', 'Hollywood', 'hollywoodmovieshub1', 'hollywoodmovieshub1', 0, 0, 0, 0, 'storage/channels\\10\\hollywoodmovieshub1_logo.jpg', 'storage/channels\\10\\hollywoodmovieshub1_thumb.jpg', '2020-09-15', '2023-10-14 23:10:57.371078', 1, 1, 1),
(60, 'ebookskindle', 'Free and Flash Kindle Ebooks', 'ebookskindle', 'ebookskindle', 0, 0, 0, 0, 'storage/empty.jpg', 'storage/empty_thumb.jpg', '2015-10-29', '2023-10-14 23:11:11.190837', 1, 1, 1),
(61, 'worldnews', 'World News Breaking News', 'worldnews', 'worldnews', 0, 0, 0, 0, 'storage/channels\\10\\worldnews_logo.jpg', 'storage/channels\\10\\worldnews_thumb.jpg', '2018-01-04', '2023-10-14 23:12:01.885526', 1, 1, 1),
(62, 'sportybetke1', 'SPORTYBET MASTER', 'sportybetke1', 'sportybetke1', 0, 0, 0, 0, 'storage/channels\\10\\sportybetke1_logo.jpg', 'storage/channels\\10\\sportybetke1_thumb.jpg', NULL, '2023-10-14 23:12:26.996049', 1, 1, 1),
(63, 'wavefxmarketanalysis', 'Wave FX Market Analysis', 'wavefxmarketanalysis', 'wavefxmarketanalysis', 0, 0, 0, 0, 'storage/channels\\10\\wavefxmarketanalysis_logo.jpg', 'storage/channels\\10\\wavefxmarketanalysis_thumb.jpg', NULL, '2023-10-14 23:12:49.722328', 1, 1, 1),
(64, 'wordporn', 'Word Porn', 'wordporn', 'wordporn', 0, 0, 0, 0, 'storage/channels\\10\\wordporn_logo.jpg', 'storage/channels\\10\\wordporn_thumb.jpg', '2016-01-19', '2023-10-14 23:13:17.528523', 1, 1, 1),
(65, 'cnc_stl_free', 'Jewelry Design by Aule for Casting STL Files', 'cnc_stl_free', 'cnc_stl_free', 0, 0, 0, 0, 'storage/channels\\10\\cnc_stl_free_logo.jpg', 'storage/channels\\10\\cnc_stl_free_thumb.jpg', '2021-01-30', '2023-10-14 23:15:16.015583', 1, 1, 1),
(68, 'forextyson', 'Forex tyson', 'forextyson', 'forextyson', 0, 0, 0, 0, 'storage/channels\\10\\forextyson_logo.jpg', 'storage/channels\\10\\forextyson_thumb.jpg', '2021-02-10', '2023-10-14 23:17:14.213157', 1, 1, 1),
(69, 'spongebets', ' Sponge Bets ', 'spongebets', 'spongebets', 0, 0, 0, 0, 'storage/channels\\10\\spongebets_logo.jpg', 'storage/channels\\10\\spongebets_thumb.jpg', NULL, '2023-10-14 23:19:34.101386', 1, 1, 1),
(70, 'crypto_signals_binance_tp', 'Binance Signals Futures Trading', 'crypto_signals_binance_tp', 'crypto_signals_binance_tp', 0, 0, 0, 0, 'storage/channels\\10\\crypto_signals_binance_tp_logo.jpg', 'storage/channels\\10\\crypto_signals_binance_tp_thumb.jpg', '2023-08-16', '2023-10-14 23:19:47.839472', 1, 1, 1),
(71, 'hotpotcrypto', 'CryptoTalks', 'hotpotcrypto', 'hotpotcrypto', 0, 0, 0, 0, 'storage/channels\\10\\hotpotcrypto_logo.jpg', 'storage/channels\\10\\hotpotcrypto_thumb.jpg', '2022-03-17', '2023-10-14 23:20:00.191119', 1, 1, 1),
(72, 'crypto_signals_futures_one', 'Binance Signals Futures Trading', 'crypto_signals_futures_one', 'crypto_signals_futures_one', 0, 0, 0, 0, 'storage/channels\\10\\crypto_signals_futures_one_logo.jpg', 'storage/channels\\10\\crypto_signals_futures_one_thumb.jpg', '2023-08-20', '2023-10-14 23:20:13.764699', 1, 1, 1),
(73, 'us30dowjones_usa_usoil_nas100', 'US30 DOW JONES OFFICIAL', 'us30dowjones_usa_usoil_nas100', 'us30dowjones_usa_usoil_nas100', 0, 0, 0, 0, 'storage/channels\\10\\us30dowjones_usa_usoil_nas100_logo.jpg', 'storage/channels\\10\\us30dowjones_usa_usoil_nas100_thumb.jpg', '2022-10-09', '2023-10-14 23:21:12.842799', 2, 1, 1),
(74, 'btcflashsoftware001', 'BTC FLASH SOFTWARE', 'ede', 'd', 0, 0, 0, 0, 'storage/channels\\10\\btcflashsoftware001_logo.jpg', 'storage/channels\\10\\btcflashsoftware001_thumb.jpg', '2023-09-26', '2023-10-14 23:21:35.850053', 1, 1, 1),
(75, 'goldfx51', 'GOLD FOREX SIGNALS', 'goldfx51', 'goldfx51', 0, 0, 0, 0, 'storage/channels\\10\\goldfx51_logo.jpg', 'storage/channels\\10\\goldfx51_thumb.jpg', '2023-04-20', '2023-10-14 23:21:49.669449', 1, 1, 1),
(76, 'evoluteminingtradingsignals', 'EVOLUTE MINING TRADING SIGNALS', 'evoluteminingtradingsignals', 'evoluteminingtradingsignals', 0, 0, 0, 0, 'storage/channels\\10\\evoluteminingtradingsignals_logo.jpg', 'storage/channels\\10\\evoluteminingtradingsignals_thumb.jpg', '2023-08-04', '2023-10-14 23:22:02.057548', 1, 1, 1),
(77, 'ai_crypto_trading_signals', 'AI Crypto Signals', 'ai_crypto_trading_signals', 'ai_crypto_trading_signals', 0, 0, 0, 0, 'storage/channels\\10\\ai_crypto_trading_signals_logo.jpg', 'storage/channels\\10\\ai_crypto_trading_signals_thumb.jpg', NULL, '2023-10-14 23:24:44.639638', 1, 1, 1),
(78, 'dalibetsport', 'DALIBET  Sports betting killer', 'dalibetsport', 'dalibetsport', 0, 0, 0, 0, 'storage/channels\\10\\dalibetsport_logo.jpg', 'storage/channels\\10\\dalibetsport_thumb.jpg', '2021-10-13', '2023-10-14 23:35:38.941295', 1, 1, 1),
(79, 'downloadpcgamesdz', 'Highly Compressed PC Games', 'downloadpcgamesdz', 'downloadpcgamesdz', 0, 0, 0, 0, 'storage/channels\\10\\downloadpcgamesdz_logo.jpg', 'storage/channels\\10\\downloadpcgamesdz_thumb.jpg', NULL, '2023-10-14 23:36:03.320771', 1, 1, 1),
(80, 'gokusports', 'GoKu BETS', 'gokusports', 'gokusports', 0, 0, 0, 0, 'storage/channels\\10\\gokusports_logo.jpg', 'storage/channels\\10\\gokusports_thumb.jpg', '2022-09-06', '2023-10-14 23:36:20.100434', 1, 1, 1),
(81, 'hacker_of_algorithms', 'Hacker of Algorithms', 'hacker_of_algorithms', 'hacker_of_algorithms', 0, 0, 0, 0, 'storage/channels\\10\\hacker_of_algorithms_logo.jpg', 'storage/channels\\10\\hacker_of_algorithms_thumb.jpg', '2022-09-08', '2023-10-14 23:37:08.910709', 1, 1, 1),
(82, 'clonesliege', 'Cloning Core', 'clonesliege', 'clonesliege', 0, 0, 0, 0, 'storage/channels\\10\\clonesliege_logo.jpg', 'storage/channels\\10\\clonesliege_thumb.jpg', NULL, '2023-10-14 23:37:29.400349', 1, 1, 1),
(83, 'fixedsportsm', 'Fixed Sports Matches', 'fixedsportsm', 'fixedsportsm', 0, 0, 0, 0, 'storage/channels\\10\\fixedsportsm_logo.jpg', 'storage/channels\\10\\fixedsportsm_thumb.jpg', '2022-06-25', '2023-10-14 23:37:42.816711', 1, 1, 1),
(84, 'acts17apologetics', 'David Wood Acts17Apologetics Video Mirror', 'acts17apologetics', 'acts17apologetics', 0, 0, 0, 0, 'storage/channels\\10\\acts17apologetics_logo.jpg', 'storage/channels\\10\\acts17apologetics_thumb.jpg', NULL, '2023-10-14 23:39:45.709940', 1, 1, 1),
(85, 'leakbank', 'HackThePlanet', 'leakbank', 'leakbank', 0, 0, 0, 0, 'storage/channels\\10\\leakbank_logo.jpg', 'storage/channels\\10\\leakbank_thumb.jpg', NULL, '2023-10-14 23:41:03.995587', 1, 1, 1),
(86, 'androidmalware', 'Android Security  Malware', 'androidmalware', 'androidmalware', 0, 0, 0, 0, 'storage/channels\\10\\androidmalware_logo.jpg', 'storage/channels\\10\\androidmalware_thumb.jpg', NULL, '2023-10-14 23:42:10.028640', 1, 1, 1),
(87, 'senjegroupfarm', 'Crypto Master ', 'senjegroupfarm', 'senjegroupfarm', 0, 0, 0, 0, 'storage/channels\\10\\senjegroupfarm_logo.jpg', 'storage/channels\\10\\senjegroupfarm_thumb.jpg', '2022-06-19', '2023-10-14 23:45:03.822533', 1, 1, 1),
(88, 'books', 'Books  NFT Books  Selfhelp  Nonfiction', 'books', 'books', 0, 0, 0, 0, 'storage/channels\\10\\books_logo.jpg', 'storage/channels\\10\\books_thumb.jpg', '2016-07-18', '2023-10-15 00:05:03.956746', 1, 1, 1),
(89, 'keyseaxyz', 'KeySea Announcements', 'keyseaxyz', 'keyseaxyz', 0, 0, 0, 0, 'storage/channels\\10\\keyseaxyz_logo.jpg', 'storage/channels\\10\\keyseaxyz_thumb.jpg', '2023-10-07', '2023-10-15 02:02:49.536144', 1, 1, 1),
(90, 'mrjassimgoldclub', 'GOLD GLOBAL CLUB', 'mrjassimgoldclub', 'mrjassimgoldclub', 0, 0, 0, 0, 'storage/channels\\10\\mrjassimgoldclub_logo.jpg', 'storage/channels\\10\\mrjassimgoldclub_thumb.jpg', NULL, '2023-10-15 02:03:13.617051', 1, 1, 1),
(91, 'kingjjm', 'King James 5 Vip Tips', 'kingjjm', 'kingjjm', 0, 0, 0, 0, 'storage/channels\\10\\kingjjm_logo.jpg', 'storage/channels\\10\\kingjjm_thumb.jpg', '2020-07-27', '2023-10-15 02:04:20.284933', 1, 1, 1),
(92, 'animalstl', 'Animals FREE STLs', 'animalstl', 'animalstl', 0, 0, 0, 0, 'storage/channels\\10\\animalstl_logo.jpg', 'storage/channels\\10\\animalstl_thumb.jpg', '2020-06-22', '2023-10-15 02:04:34.837648', 1, 1, 1),
(93, 'fixedmatches0089', 'Fixed Matches', 'fixedmatches0089', 'fixedmatches0089', 0, 0, 0, 0, 'storage/channels\\10\\fixedmatches0089_logo.jpg', 'storage/channels\\10\\fixedmatches0089_thumb.jpg', '2019-03-10', '2023-10-15 02:13:51.384142', 1, 1, 1),
(94, 'gold_accuracy', 'ULTRA SCALPER  GFS', 'gold_accuracy', 'gold_accuracy', 0, 0, 0, 0, 'storage/channels\\10\\gold_accuracy_logo.jpg', 'storage/channels\\10\\gold_accuracy_thumb.jpg', '2023-04-07', '2023-10-15 02:14:43.446303', 1, 1, 1),
(95, 'tradewithesofree', 'Trade with ESO', 'tradewithesofree', 'tradewithesofree', 0, 0, 0, 0, 'storage/channels\\10\\tradewithesofree_logo.jpg', 'storage/channels\\10\\tradewithesofree_thumb.jpg', '2021-09-16', '2023-10-15 02:15:21.349461', 1, 1, 1),
(96, 'infinity_crypto_signals', 'Infinity Signals', 'infinity_crypto_signals', 'infinity_crypto_signals', 0, 0, 0, 0, 'storage/channels\\10\\infinity_crypto_signals_logo.jpg', 'storage/channels\\10\\infinity_crypto_signals_thumb.jpg', '2022-08-21', '2023-10-15 02:15:57.111463', 1, 1, 1),
(97, 'insidersfxmatch', 'INSIDER FIXED MATCHES ', 'insidersfxmatch', 'insidersfxmatch', 0, 0, 0, 0, 'storage/channels\\10\\insidersfxmatch_logo.jpg', 'storage/channels\\10\\insidersfxmatch_thumb.jpg', '2023-07-16', '2023-10-15 02:16:14.689553', 1, 1, 1),
(98, 'remotejobss', 'Remote Jobs', 'remotejobss', 'remotejobss', 0, 0, 0, 0, 'storage/channels\\10\\remotejobss_logo.jpg', 'storage/channels\\10\\remotejobss_thumb.jpg', '2018-09-11', '2023-10-15 02:17:15.477797', 1, 1, 1),
(99, 'goldfx_signal5', 'GOLD FOREX SIGNALS', 'goldfx_signal5goldfx_signal5', 'goldfx_signal5', 0, 0, 0, 0, 'storage/channels\\10\\goldfx_signal5_logo.jpg', 'storage/channels\\10\\goldfx_signal5_thumb.jpg', '2023-01-30', '2023-10-15 02:17:35.191454', 1, 1, 1),
(101, 'gold_fx_signals_1', 'GOLD TRADING SIGNALS FREE', 'gold_fx_signals_1', 'gold_fx_signals_1', 0, 0, 0, 0, 'storage/channels\\10\\gold_fx_signals_1_logo.jpg', 'storage/channels\\10\\gold_fx_signals_1_thumb.jpg', '2023-07-16', '2023-10-15 02:19:06.453657', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `media_type`
--

CREATE TABLE `media_type` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `slug` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `media_type`
--

INSERT INTO `media_type` (`id`, `name`, `title`, `description`, `slug`) VALUES
(1, 'Channels', 'Channels Title', 'Channels Descripton', 'channels'),
(2, 'Groups', 'Groups Title', 'Groups Description', 'groups'),
(3, 'Bots', 'Bots Title', 'Bots Description', 'bots');

-- --------------------------------------------------------

--
-- Table structure for table `socialaccount_socialaccount`
--

CREATE TABLE `socialaccount_socialaccount` (
  `id` int(11) NOT NULL,
  `provider` varchar(30) NOT NULL,
  `uid` varchar(191) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `extra_data` longtext NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `socialaccount_socialapp`
--

CREATE TABLE `socialaccount_socialapp` (
  `id` int(11) NOT NULL,
  `provider` varchar(30) NOT NULL,
  `name` varchar(40) NOT NULL,
  `client_id` varchar(191) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `socialaccount_socialapp_sites`
--

CREATE TABLE `socialaccount_socialapp_sites` (
  `id` bigint(20) NOT NULL,
  `socialapp_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `socialaccount_socialtoken`
--

CREATE TABLE `socialaccount_socialtoken` (
  `id` int(11) NOT NULL,
  `token` longtext NOT NULL,
  `token_secret` longtext NOT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `app_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `taggit_tag`
--

CREATE TABLE `taggit_tag` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `taggit_tag`
--

INSERT INTO `taggit_tag` (`id`, `name`, `slug`) VALUES
(1, 'eded', 'eded'),
(2, 'ed', 'ed'),
(3, 'hnaftali', 'hnaftali'),
(4, 'anime_counter', 'anime_counter'),
(5, 'crypto7987sekta', 'crypto7987sekta'),
(6, 'livebetsignals', 'livebetsignals'),
(7, 'seasidesignalscrypto', 'seasidesignalscrypto'),
(8, 'gold_forex_trading1', 'gold_forex_trading1'),
(9, 'byignazio', 'byignazio'),
(10, 'olymp_trade_signals_quotex', 'olymp_trade_signals_quotex'),
(11, 'sickmindsmedia', 'sickmindsmedia'),
(12, 'crypto_pumps_signals_global', 'crypto_pumps_signals_global'),
(13, 'ayurvedawellbeing', 'ayurvedawellbeing'),
(14, 'utcutie', 'utcutie'),
(15, 'netflix', 'netflix'),
(16, 'thehealthchannelnews', 'thehealthchannelnews'),
(17, 'gbpjpyforexfree', 'gbpjpyforexfree'),
(18, 'memes', 'memes'),
(19, 'animal_fighting', 'animal_fighting'),
(20, 'getcoinit', 'getcoinit'),
(21, 'cryptosignal', 'cryptosignal'),
(22, 'goldfxsignaldaily', 'goldfxsignaldaily'),
(23, 'elizabethhome1', 'elizabethhome1'),
(24, 'gbpusdusdcadnzdjpyfx', 'gbpusdusdcadnzdjpyfx'),
(25, 'arrrashfx', 'arrrashfx'),
(26, 'goldfx_signalls', 'goldfx_signalls'),
(27, 'asiasignal_com', 'asiasignal_com'),
(28, 'gold_trading_signallo', 'gold_trading_signallo'),
(29, 'binance_earn_community', 'binance_earn_community'),
(30, 'tradebullsnewss', 'tradebullsnewss'),
(31, 'gold_signalfx_daily', 'gold_signalfx_daily'),
(32, 'forexminister2017', 'forexminister2017'),
(33, 'developappandwebsitee', 'developappandwebsitee'),
(34, 'priceactionforexebook', 'priceactionforexebook'),
(35, 'booksbunch', 'booksbunch'),
(36, 'medicalebo', 'medicalebo'),
(37, 'mj_resources', 'mj_resources'),
(38, 'internal1', 'internal1'),
(39, 'library', 'library'),
(40, 'arthutchannel', 'arthutchannel'),
(41, 'bookoffersamazon', 'bookoffersamazon'),
(42, 'xlitehub', 'xlitehub'),
(43, 'hollywoodmovieshub1', 'hollywoodmovieshub1'),
(44, 'ebookskindle', 'ebookskindle'),
(45, 'worldnews', 'worldnews'),
(46, 'sportybetke1', 'sportybetke1'),
(47, 'wavefxmarketanalysis', 'wavefxmarketanalysis'),
(48, 'cnc_stl_free', 'cnc_stl_free'),
(49, 'forextyson', 'forextyson'),
(50, 'spongebets', 'spongebets'),
(51, 'crypto_signals_binance_tp', 'crypto_signals_binance_tp'),
(52, 'hotpotcrypto', 'hotpotcrypto'),
(53, 'crypto_signals_futures_one', 'crypto_signals_futures_one'),
(54, 'us30dowjones_usa_usoil_nas100', 'us30dowjones_usa_usoil_nas100'),
(55, 'goldfx51', 'goldfx51'),
(56, 'evoluteminingtradingsignals', 'evoluteminingtradingsignals'),
(57, 'dalibetsport', 'dalibetsport'),
(58, 'downloadpcgamesdz', 'downloadpcgamesdz'),
(59, 'gokusports', 'gokusports'),
(60, 'hacker_of_algorithms', 'hacker_of_algorithms'),
(61, 'clonesliege', 'clonesliege'),
(62, 'fixedsportsm', 'fixedsportsm'),
(63, 'acts17apologetics', 'acts17apologetics'),
(64, 'androidmalware', 'androidmalware'),
(65, 'senjegroupfarm', 'senjegroupfarm'),
(66, 'keyseaxyz', 'keyseaxyz'),
(67, 'mrjassimgoldclub', 'mrjassimgoldclub'),
(68, 'kingjjm', 'kingjjm'),
(69, 'animalstl', 'animalstl'),
(70, 'fixedmatches0089', 'fixedmatches0089'),
(71, 'gold_accuracy', 'gold_accuracy'),
(72, 'tradewithesofree', 'tradewithesofree'),
(73, 'infinity_crypto_signals', 'infinity_crypto_signals'),
(74, 'insidersfxmatch', 'insidersfxmatch'),
(75, 'remotejobss', 'remotejobss'),
(76, 'goldfx_signal5', 'goldfx_signal5'),
(77, 'gold_fx_signals_1', 'gold_fx_signals_1');

-- --------------------------------------------------------

--
-- Table structure for table `taggit_taggeditem`
--

CREATE TABLE `taggit_taggeditem` (
  `id` int(11) NOT NULL,
  `object_id` int(11) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `taggit_taggeditem`
--

INSERT INTO `taggit_taggeditem` (`id`, `object_id`, `content_type_id`, `tag_id`) VALUES
(1, 1, 4, 1),
(2, 3, 4, 2),
(3, 4, 4, 2),
(4, 6, 4, 2),
(5, 11, 4, 3),
(6, 13, 4, 4),
(7, 14, 4, 2),
(8, 17, 4, 5),
(9, 17, 4, 6),
(10, 20, 4, 5),
(11, 21, 4, 7),
(12, 22, 4, 8),
(13, 23, 4, 9),
(14, 24, 4, 10),
(15, 25, 4, 11),
(16, 26, 4, 12),
(17, 27, 4, 13),
(18, 28, 4, 14),
(19, 29, 4, 15),
(20, 30, 4, 16),
(21, 31, 4, 17),
(22, 32, 4, 18),
(23, 33, 4, 19),
(24, 34, 4, 20),
(25, 35, 4, 21),
(26, 36, 4, 22),
(27, 37, 4, 23),
(28, 38, 4, 24),
(29, 39, 4, 25),
(30, 41, 4, 26),
(31, 42, 4, 27),
(32, 43, 4, 28),
(33, 44, 4, 29),
(34, 45, 4, 30),
(35, 46, 4, 31),
(36, 47, 4, 32),
(37, 48, 4, 33),
(38, 49, 4, 34),
(39, 50, 4, 35),
(40, 52, 4, 36),
(41, 53, 4, 37),
(42, 54, 4, 38),
(43, 55, 4, 39),
(44, 56, 4, 40),
(45, 57, 4, 41),
(46, 58, 4, 42),
(47, 59, 4, 43),
(48, 60, 4, 44),
(49, 61, 4, 45),
(50, 62, 4, 46),
(51, 63, 4, 47),
(52, 65, 4, 48),
(53, 68, 4, 49),
(54, 69, 4, 50),
(55, 70, 4, 51),
(56, 71, 4, 52),
(57, 72, 4, 53),
(58, 73, 4, 54),
(59, 75, 4, 55),
(60, 76, 4, 56),
(61, 78, 4, 57),
(62, 79, 4, 58),
(63, 80, 4, 59),
(64, 81, 4, 60),
(65, 82, 4, 61),
(66, 83, 4, 62),
(67, 84, 4, 63),
(68, 86, 4, 64),
(69, 87, 4, 65),
(70, 89, 4, 66),
(71, 90, 4, 67),
(72, 91, 4, 68),
(73, 92, 4, 69),
(74, 93, 4, 70),
(75, 94, 4, 71),
(76, 95, 4, 72),
(77, 96, 4, 73),
(78, 97, 4, 74),
(79, 98, 4, 75),
(80, 99, 4, 76),
(81, 100, 4, 77),
(82, 101, 4, 77);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account_emailaddress`
--
ALTER TABLE `account_emailaddress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `account_emailaddress_user_id_2c513194_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `account_emailconfirmation`
--
ALTER TABLE `account_emailconfirmation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `key` (`key`),
  ADD KEY `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` (`email_address_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `avatar_avatar`
--
ALTER TABLE `avatar_avatar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `avatar_avatar_user_id_ae13b50b_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `django_site`
--
ALTER TABLE `django_site`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`);

--
-- Indexes for table `media_category`
--
ALTER TABLE `media_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `media_channelcounter`
--
ALTER TABLE `media_channelcounter`
  ADD PRIMARY KEY (`id`),
  ADD KEY `media_channelcounter_channel_id_21f6dd75_fk_media_media_id` (`channel_id`);

--
-- Indexes for table `media_comment`
--
ALTER TABLE `media_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `media_comment_media_id_9c6bfcac_fk_media_media_id` (`media_id`);

--
-- Indexes for table `media_groupcounter`
--
ALTER TABLE `media_groupcounter`
  ADD PRIMARY KEY (`id`),
  ADD KEY `media_groupcounter_group_id_cb37994f_fk_media_media_id` (`group_id`);

--
-- Indexes for table `media_language`
--
ALTER TABLE `media_language`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `media_media`
--
ALTER TABLE `media_media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `handle` (`handle`),
  ADD KEY `media_media_category_id_3dd38ea3_fk_media_category_id` (`category_id`),
  ADD KEY `media_media_language_id_fc18bc41_fk_media_language_id` (`language_id`),
  ADD KEY `media_media_type_id_3d2890dd_fk_media_type_id` (`type_id`);

--
-- Indexes for table `media_type`
--
ALTER TABLE `media_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `media_type_slug_8ec11d68` (`slug`);

--
-- Indexes for table `socialaccount_socialaccount`
--
ALTER TABLE `socialaccount_socialaccount`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `socialaccount_socialaccount_provider_uid_fc810c6e_uniq` (`provider`,`uid`),
  ADD KEY `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `socialaccount_socialapp`
--
ALTER TABLE `socialaccount_socialapp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `socialaccount_socialapp_sites`
--
ALTER TABLE `socialaccount_socialapp_sites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `socialaccount_socialapp_sites_socialapp_id_site_id_71a9a768_uniq` (`socialapp_id`,`site_id`),
  ADD KEY `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` (`site_id`);

--
-- Indexes for table `socialaccount_socialtoken`
--
ALTER TABLE `socialaccount_socialtoken`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq` (`app_id`,`account_id`),
  ADD KEY `socialaccount_social_account_id_951f210e_fk_socialacc` (`account_id`);

--
-- Indexes for table `taggit_tag`
--
ALTER TABLE `taggit_tag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `taggit_taggeditem`
--
ALTER TABLE `taggit_taggeditem`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `taggit_taggeditem_content_type_id_object_id_tag_id_4bb97a8e_uniq` (`content_type_id`,`object_id`,`tag_id`),
  ADD KEY `taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id` (`tag_id`),
  ADD KEY `taggit_taggeditem_object_id_e2d7d1df` (`object_id`),
  ADD KEY `taggit_taggeditem_content_type_id_object_id_196cc965_idx` (`content_type_id`,`object_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account_emailaddress`
--
ALTER TABLE `account_emailaddress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `account_emailconfirmation`
--
ALTER TABLE `account_emailconfirmation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `avatar_avatar`
--
ALTER TABLE `avatar_avatar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `django_site`
--
ALTER TABLE `django_site`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `media_category`
--
ALTER TABLE `media_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `media_channelcounter`
--
ALTER TABLE `media_channelcounter`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `media_comment`
--
ALTER TABLE `media_comment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `media_groupcounter`
--
ALTER TABLE `media_groupcounter`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `media_language`
--
ALTER TABLE `media_language`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `media_media`
--
ALTER TABLE `media_media`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `media_type`
--
ALTER TABLE `media_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `socialaccount_socialaccount`
--
ALTER TABLE `socialaccount_socialaccount`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `socialaccount_socialapp`
--
ALTER TABLE `socialaccount_socialapp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `socialaccount_socialapp_sites`
--
ALTER TABLE `socialaccount_socialapp_sites`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `socialaccount_socialtoken`
--
ALTER TABLE `socialaccount_socialtoken`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taggit_tag`
--
ALTER TABLE `taggit_tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `taggit_taggeditem`
--
ALTER TABLE `taggit_taggeditem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account_emailaddress`
--
ALTER TABLE `account_emailaddress`
  ADD CONSTRAINT `account_emailaddress_user_id_2c513194_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `account_emailconfirmation`
--
ALTER TABLE `account_emailconfirmation`
  ADD CONSTRAINT `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `avatar_avatar`
--
ALTER TABLE `avatar_avatar`
  ADD CONSTRAINT `avatar_avatar_user_id_ae13b50b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `media_channelcounter`
--
ALTER TABLE `media_channelcounter`
  ADD CONSTRAINT `media_channelcounter_channel_id_21f6dd75_fk_media_media_id` FOREIGN KEY (`channel_id`) REFERENCES `media_media` (`id`);

--
-- Constraints for table `media_comment`
--
ALTER TABLE `media_comment`
  ADD CONSTRAINT `media_comment_media_id_9c6bfcac_fk_media_media_id` FOREIGN KEY (`media_id`) REFERENCES `media_media` (`id`);

--
-- Constraints for table `media_groupcounter`
--
ALTER TABLE `media_groupcounter`
  ADD CONSTRAINT `media_groupcounter_group_id_cb37994f_fk_media_media_id` FOREIGN KEY (`group_id`) REFERENCES `media_media` (`id`);

--
-- Constraints for table `media_media`
--
ALTER TABLE `media_media`
  ADD CONSTRAINT `media_media_category_id_3dd38ea3_fk_media_category_id` FOREIGN KEY (`category_id`) REFERENCES `media_category` (`id`),
  ADD CONSTRAINT `media_media_language_id_fc18bc41_fk_media_language_id` FOREIGN KEY (`language_id`) REFERENCES `media_language` (`id`),
  ADD CONSTRAINT `media_media_type_id_3d2890dd_fk_media_type_id` FOREIGN KEY (`type_id`) REFERENCES `media_type` (`id`);

--
-- Constraints for table `socialaccount_socialaccount`
--
ALTER TABLE `socialaccount_socialaccount`
  ADD CONSTRAINT `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `socialaccount_socialapp_sites`
--
ALTER TABLE `socialaccount_socialapp_sites`
  ADD CONSTRAINT `socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc` FOREIGN KEY (`socialapp_id`) REFERENCES `socialaccount_socialapp` (`id`),
  ADD CONSTRAINT `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`);

--
-- Constraints for table `socialaccount_socialtoken`
--
ALTER TABLE `socialaccount_socialtoken`
  ADD CONSTRAINT `socialaccount_social_account_id_951f210e_fk_socialacc` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  ADD CONSTRAINT `socialaccount_social_app_id_636a42d7_fk_socialacc` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`);

--
-- Constraints for table `taggit_taggeditem`
--
ALTER TABLE `taggit_taggeditem`
  ADD CONSTRAINT `taggit_taggeditem_content_type_id_9957a03c_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `taggit_tag` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
