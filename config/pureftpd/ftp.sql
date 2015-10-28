-- phpMyAdmin SQL Dump
-- version 3.3.10.5
-- http://www.phpmyadmin.net
--
-- 主机: 192.168.56.113
-- 生成日期: 2014 年 06 月 20 日 19:28
-- 服务器版本: 5.5.38
-- PHP 版本: 5.4.28

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `ftp`
--
CREATE DATABASE `ftp` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `ftp`;

-- --------------------------------------------------------

--
-- 表的结构 `f_user`
--

CREATE TABLE IF NOT EXISTS `f_user` (
  `f_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'FTP自增ID',
  `f_username` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT 'FTP用户',
  `f_password` char(32) COLLATE utf8_unicode_ci NOT NULL COMMENT 'FTP密码',
  `f_uid` smallint(4) unsigned NOT NULL DEFAULT '0' COMMENT '系统用户uid',
  `f_gid` smallint(4) unsigned NOT NULL DEFAULT '0' COMMENT '系统用户gid',
  `f_dir` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT 'FTP根目录[./ 开始]',
  `f_isdel` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除[1-是，0-否]',
  `f_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`f_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='FTP用户表' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `f_user`
--

INSERT INTO `f_user` (`f_id`, `f_username`, `f_password`, `f_uid`, `f_gid`, `f_dir`, `f_isdel`, `f_time`) VALUES
(1, 'ftpuser', 'ftppass', 1000, 1000, '/srv/websrv/data/wwwroot/./', 0, 1412092800);
