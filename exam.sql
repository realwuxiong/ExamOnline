/*
Navicat MySQL Data Transfer

Source Server         : 在线考试系统
Source Server Version : 50726
Source Host           : 120.77.255.36:3306
Source Database       : exam

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2020-06-24 17:36:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for classandteacher
-- ----------------------------
DROP TABLE IF EXISTS `classandteacher`;
CREATE TABLE `classandteacher` (
  `ctid` int(11) NOT NULL AUTO_INCREMENT,
  `teacherId` int(11) DEFAULT NULL,
  `classId` int(11) DEFAULT NULL,
  PRIMARY KEY (`ctid`),
  KEY `FK_classandteacher` (`classId`),
  CONSTRAINT `FK_classandteacher` FOREIGN KEY (`classId`) REFERENCES `classinfo` (`classId`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of classandteacher
-- ----------------------------
INSERT INTO `classandteacher` VALUES ('1', '1000001', '10001');
INSERT INTO `classandteacher` VALUES ('2', '1000002', '10001');

-- ----------------------------
-- Table structure for classinfo
-- ----------------------------
DROP TABLE IF EXISTS `classinfo`;
CREATE TABLE `classinfo` (
  `classId` int(11) NOT NULL AUTO_INCREMENT,
  `className` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`classId`)
) ENGINE=InnoDB AUTO_INCREMENT=10002 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of classinfo
-- ----------------------------
INSERT INTO `classinfo` VALUES ('10001', '软件一班');

-- ----------------------------
-- Table structure for courseinfo
-- ----------------------------
DROP TABLE IF EXISTS `courseinfo`;
CREATE TABLE `courseinfo` (
  `courseId` int(11) NOT NULL AUTO_INCREMENT,
  `courseName` varchar(20) DEFAULT NULL,
  `teacherId` int(11) DEFAULT NULL,
  PRIMARY KEY (`courseId`),
  KEY `FK_courseTeacher` (`teacherId`),
  CONSTRAINT `FK_courseTeacher` FOREIGN KEY (`teacherId`) REFERENCES `teacherinfo` (`teacherId`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10000004 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of courseinfo
-- ----------------------------
INSERT INTO `courseinfo` VALUES ('10000001', '计算机网络', '1000001');
INSERT INTO `courseinfo` VALUES ('10000002', '项目实践', '1000001');
INSERT INTO `courseinfo` VALUES ('10000003', '操作系统', '1000002');

-- ----------------------------
-- Table structure for examplaninfo
-- ----------------------------
DROP TABLE IF EXISTS `examplaninfo`;
CREATE TABLE `examplaninfo` (
  `examplanId` int(11) NOT NULL AUTO_INCREMENT,
  `paperId` int(11) DEFAULT NULL,
  `classId` int(11) DEFAULT NULL,
  `startTime` date DEFAULT NULL,
  `overTime` date DEFAULT NULL,
  `examState` int(11) DEFAULT '0' COMMENT '0,1,2',
  PRIMARY KEY (`examplanId`),
  KEY `FK_examplanPaper` (`paperId`),
  KEY `FK_examplanClass` (`classId`),
  CONSTRAINT `FK_examplanClass` FOREIGN KEY (`classId`) REFERENCES `classinfo` (`classId`) ON DELETE NO ACTION,
  CONSTRAINT `FK_examplanPaper` FOREIGN KEY (`paperId`) REFERENCES `paperinfo` (`paperId`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of examplaninfo
-- ----------------------------
INSERT INTO `examplaninfo` VALUES ('18', '10002', '10001', '2020-06-04', null, '1');
INSERT INTO `examplaninfo` VALUES ('10001', '10001', '10001', '2020-04-13', '2020-06-04', '2');

-- ----------------------------
-- Table structure for paperinfo
-- ----------------------------
DROP TABLE IF EXISTS `paperinfo`;
CREATE TABLE `paperinfo` (
  `paperId` int(11) NOT NULL AUTO_INCREMENT,
  `paperName` varchar(20) DEFAULT NULL,
  `courseId` int(11) DEFAULT NULL,
  `isAdd` int(11) DEFAULT '0',
  PRIMARY KEY (`paperId`),
  KEY `FK_paperCourse` (`courseId`),
  CONSTRAINT `FK_paperCourse` FOREIGN KEY (`courseId`) REFERENCES `courseinfo` (`courseId`)
) ENGINE=InnoDB AUTO_INCREMENT=10003 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of paperinfo
-- ----------------------------
INSERT INTO `paperinfo` VALUES ('10001', '计算机网络考试', '10000001', '0');
INSERT INTO `paperinfo` VALUES ('10002', '操作系统', '10000003', '0');

-- ----------------------------
-- Table structure for resultinfo
-- ----------------------------
DROP TABLE IF EXISTS `resultinfo`;
CREATE TABLE `resultinfo` (
  `resultId` int(11) NOT NULL AUTO_INCREMENT,
  `paperId` int(11) DEFAULT NULL,
  `studentId` int(11) DEFAULT NULL,
  `titleCat` int(11) DEFAULT NULL,
  `titleId` int(11) DEFAULT NULL,
  `studentAnswer` varchar(500) DEFAULT NULL,
  `correctState` int(11) DEFAULT '0' COMMENT '0,1',
  PRIMARY KEY (`resultId`),
  KEY `FK_resultPaper` (`paperId`),
  KEY `FK_resultStudent` (`studentId`),
  KEY `FK_resultTitle` (`titleId`),
  CONSTRAINT `FK_resultPaper` FOREIGN KEY (`paperId`) REFERENCES `paperinfo` (`paperId`),
  CONSTRAINT `FK_resultStudent` FOREIGN KEY (`studentId`) REFERENCES `StudentInfo` (`studentId`),
  CONSTRAINT `FK_resultTitle` FOREIGN KEY (`titleId`) REFERENCES `titleinfo` (`titleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of resultinfo
-- ----------------------------

-- ----------------------------
-- Table structure for scoreinfo
-- ----------------------------
DROP TABLE IF EXISTS `scoreinfo`;
CREATE TABLE `scoreinfo` (
  `scoreId` int(11) NOT NULL AUTO_INCREMENT,
  `studentId` int(11) DEFAULT NULL,
  `paperId` int(11) DEFAULT NULL,
  `objectSco` int(11) DEFAULT NULL,
  `subjectSco` int(11) DEFAULT NULL,
  `sumSco` int(11) DEFAULT NULL,
  PRIMARY KEY (`scoreId`),
  KEY `FK_scoreStudent` (`studentId`),
  KEY `FK_scorePaper` (`paperId`),
  CONSTRAINT `FK_scorePaper` FOREIGN KEY (`paperId`) REFERENCES `paperinfo` (`paperId`),
  CONSTRAINT `FK_scoreStudent` FOREIGN KEY (`studentId`) REFERENCES `StudentInfo` (`studentId`)
) ENGINE=InnoDB AUTO_INCREMENT=355 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of scoreinfo
-- ----------------------------
INSERT INTO `scoreinfo` VALUES ('352', '2019102971', '10001', '2', null, '2');
INSERT INTO `scoreinfo` VALUES ('353', '2019102962', '10001', '0', null, '0');
INSERT INTO `scoreinfo` VALUES ('354', '2019102962', '10002', '0', null, '0');

-- ----------------------------
-- Table structure for StudentInfo
-- ----------------------------
DROP TABLE IF EXISTS `StudentInfo`;
CREATE TABLE `StudentInfo` (
  `studentId` int(11) NOT NULL AUTO_INCREMENT,
  `studentName` varchar(20) DEFAULT NULL,
  `studentPwd` varchar(20) DEFAULT NULL,
  `classId` int(11) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `school` varchar(20) DEFAULT NULL,
  `address` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`studentId`),
  KEY `Fk_classStudent` (`classId`),
  CONSTRAINT `Fk_classStudent` FOREIGN KEY (`classId`) REFERENCES `classinfo` (`classId`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2019102972 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of StudentInfo
-- ----------------------------
INSERT INTO `StudentInfo` VALUES ('2019102900', 'guest', 'guest', '10001', '2020-06-23', '东北师范大学', '东北师范大学净月校区', '18772138327');
INSERT INTO `StudentInfo` VALUES ('2019102962', '刘铎', '123456', '10001', '2020-09-01', '东北师范大学', '东北师范大学', '123333');
INSERT INTO `StudentInfo` VALUES ('2019102971', '吴雄', '123456', '10001', '2020-04-13', '东北师范大学', '东北师范大学', '2019102971');

-- ----------------------------
-- Table structure for studentstate
-- ----------------------------
DROP TABLE IF EXISTS `studentstate`;
CREATE TABLE `studentstate` (
  `stateId` int(11) NOT NULL AUTO_INCREMENT,
  `paperId` int(11) DEFAULT NULL,
  `studentId` int(11) DEFAULT NULL,
  `stateFlag` int(11) DEFAULT '0' COMMENT '0,1,2',
  PRIMARY KEY (`stateId`),
  KEY `FK_studentstatePaper` (`paperId`),
  KEY `FK_studentstateStudent` (`studentId`),
  CONSTRAINT `FK_studentstatePaper` FOREIGN KEY (`paperId`) REFERENCES `paperinfo` (`paperId`),
  CONSTRAINT `FK_studentstateStudent` FOREIGN KEY (`studentId`) REFERENCES `StudentInfo` (`studentId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of studentstate
-- ----------------------------
INSERT INTO `studentstate` VALUES ('1', '10001', '2019102971', '2');
INSERT INTO `studentstate` VALUES ('2', '10001', '2019102962', '2');
INSERT INTO `studentstate` VALUES ('6', '10002', '2019102971', '1');
INSERT INTO `studentstate` VALUES ('7', '10002', '2019102962', '2');

-- ----------------------------
-- Table structure for teacherinfo
-- ----------------------------
DROP TABLE IF EXISTS `teacherinfo`;
CREATE TABLE `teacherinfo` (
  `teacherId` int(11) NOT NULL AUTO_INCREMENT,
  `teacherName` varchar(20) DEFAULT NULL,
  `teacherPwd` varchar(20) DEFAULT NULL,
  `isAdmin` int(11) DEFAULT '0' COMMENT '0,1',
  `joindate` date DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`teacherId`)
) ENGINE=InnoDB AUTO_INCREMENT=1000005 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacherinfo
-- ----------------------------
INSERT INTO `teacherinfo` VALUES ('1000001', '许超', '1000001', '0', '2020-04-13', 'xuchao@nenu.edu.cn');
INSERT INTO `teacherinfo` VALUES ('1000002', '吴老师', '123456', '0', '2020-06-04', '123456@nenu.edu.cn');
INSERT INTO `teacherinfo` VALUES ('1000003', '管理员', '123456', '1', '2020-06-04', 'admin@nenu.edu.cn');
INSERT INTO `teacherinfo` VALUES ('1000004', '张老师', '123', '0', '2020-06-05', '123@qq.com');
INSERT INTO `teacherinfo` VALUES ('1000005', '测试', 'guest', '0', '2020-06-23', 'guest@qq.com');

-- ----------------------------
-- Table structure for titleinfo
-- ----------------------------
DROP TABLE IF EXISTS `titleinfo`;
CREATE TABLE `titleinfo` (
  `titleId` int(11) NOT NULL AUTO_INCREMENT,
  `titleCat` int(11) DEFAULT NULL,
  `titleStem` varchar(500) DEFAULT NULL,
  `optionA` varchar(500) DEFAULT NULL,
  `optionB` varchar(500) DEFAULT NULL,
  `optionC` varchar(500) DEFAULT NULL,
  `optionD` varchar(500) DEFAULT NULL,
  `answerRight` varchar(500) DEFAULT NULL,
  `answerScore` int(11) DEFAULT NULL,
  `analyze` varchar(500) DEFAULT NULL,
  `paperId` int(11) DEFAULT NULL,
  PRIMARY KEY (`titleId`),
  KEY `FK_titlePaper` (`paperId`),
  CONSTRAINT `FK_titlePaper` FOREIGN KEY (`paperId`) REFERENCES `paperinfo` (`paperId`)
) ENGINE=InnoDB AUTO_INCREMENT=10002 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of titleinfo
-- ----------------------------
INSERT INTO `titleinfo` VALUES ('1', '1', '一个网吧，把所有计算机连入网络，这个网络叫什么', '城域网', '局域网', '广域网', '内网', 'B', '2', 'null', '10001');
INSERT INTO `titleinfo` VALUES ('2', '1', '在下列传输介质中，不受电磁干扰和噪声影响的是', '双绞线', '通信卫星', '同轴电缆', '光纤', 'D', '2', 'null', '10001');
INSERT INTO `titleinfo` VALUES ('3', '1', '下列对以太网交换机的说法中错误的是', '以太网交换机可以对通过的信息进行过滤', '以太网交换机中端口的速率可能不同', '在交换式以太网中可以划分VLAN', '利用多个以太网交换机组成的局域网不能出现环路', 'D', '2', 'null', '10001');
INSERT INTO `titleinfo` VALUES ('4', '1', ' 实现进程互斥可采用的方法（  ） ', '中断', '查询 ', '开锁和关锁  ', '按键处理 ', 'C', '2', null, '10002');
INSERT INTO `titleinfo` VALUES ('5', '1', '进程的同步与互斥是由于程序的（  ）引起的 ', '顺序执行', '长短不同', '信号量', '并发执行', 'D', '2', null, '10002');
