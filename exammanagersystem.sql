/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50536
Source Host           : localhost:3306
Source Database       : exammanagersystem

Target Server Type    : MYSQL
Target Server Version : 50536
File Encoding         : 65001

Date: 2021-09-13 15:10:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_question
-- ----------------------------
DROP TABLE IF EXISTS `t_question`;
CREATE TABLE `t_question` (
  `questionId` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `optionA` varchar(255) DEFAULT NULL,
  `optionB` varchar(255) DEFAULT NULL,
  `optionC` varchar(255) DEFAULT NULL,
  `optionD` varchar(255) DEFAULT NULL,
  `answer` char(1) DEFAULT NULL,
  PRIMARY KEY (`questionId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_question
-- ----------------------------
INSERT INTO `t_question` VALUES ('1', '2+3=？', '5', '6', '4', '10', 'A');
INSERT INTO `t_question` VALUES ('3', '2*5=？', '14', '15', '10', '3', 'C');
INSERT INTO `t_question` VALUES ('4', '20-8=？', '12', '6', '10', '5', 'A');
INSERT INTO `t_question` VALUES ('5', '6*9=？', '123', '54', '67', '68', 'B');
INSERT INTO `t_question` VALUES ('6', '30-15=？', '5', '6', '15', '3', 'C');
INSERT INTO `t_question` VALUES ('7', '12*9=？', '108', '109', '118', '128', 'A');
INSERT INTO `t_question` VALUES ('8', '2-2=？', '4', '0', '-2', '-4', 'B');
INSERT INTO `t_question` VALUES ('9', '17-9=？', '5', '15', '4', '8', 'D');
INSERT INTO `t_question` VALUES ('10', '-5+（-3）=？', '5', '2', '-8', '10', 'C');
INSERT INTO `t_question` VALUES ('11', '22*4=？', '22', '44', '66', '88', 'D');
INSERT INTO `t_question` VALUES ('12', '100-0=？', '10', '109', '67', '100', 'D');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_Name` varchar(255) DEFAULT NULL,
  `user_Password` varchar(255) DEFAULT NULL,
  `user_Sex` char(1) DEFAULT NULL,
  `user_Email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'liming', '123456', '男', 'liming@123.com');
INSERT INTO `t_user` VALUES ('2', 'huahua', '123456', '女', 'huahua@123.com');
INSERT INTO `t_user` VALUES ('3', 'mike', '000000', '男', 'mike@123.com');
INSERT INTO `t_user` VALUES ('19', 'admin', 'admin', '男', 'admin@123.com');
