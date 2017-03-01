CREATE DATABASE IF NOT EXSITS body_parts DEFAULT CHARSET utf8 COLLATE utf8 utf8_general_ci;

# 清单 1 中所示的 Model 表十分简单：
# label 列将列举车型的名称 （“Corvette”）；
# description 使用客户友好方式进行描述（“两门跑车；第一年引入”）；
# begin_production 和 end_production 分别表示开始生产和结束生产该车型的年份。
# 由于前述列中的值并不惟一，因此使用一个独立 ID 表示每四个这样的元素（label、description、begin_production、end_production），
# 并且是其他表中的外键。
CREATE TABLE IF NOT EXSITS Model (
  id int(10) unsigned NOT NULL auto_increment,
  label varchar(7) NOT NULL,
  description varchar(256) NOT NULL,
  begin_production int(4) NOT NULL,
  end_production int(4) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;
INSERT INTO Model 
  (`id`, `label`, `description`, `begin_production`, `end_production`) 
VALUES 
  (1,'X Sedan','Four-door performance sedan',1998,1999),
  (3,'X Sedan','Four door performance sedan, 1st model year',1995,1997),
  (4,'J Convertible','Two-door roadster, metal retracting roof',2002,2005),
  (5,'J Convertible','Two-door roadster',2000,2001),
  (7,'W Wagon','Four-door, all-wheel drive sport station wagon',2007,0);
  
# assembly 是一个子系统，例如汽车上安装的传动装置或所有玻璃。车主使用部件图及相关零件列表来查找备件。
# 清单 2 中所示的 Assembly 表也十分简单：它将把一个惟一 ID 与部件标签和描述关联起来。
CREATE TABLE IF NOT EXSITS Assembly (
  id int(10) unsigned NOT NULL auto_increment,
  label varchar(7) NOT NULL,
  description varchar(128) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

INSERT INTO Assembly 
  (`id`, `label`, `description`) 
VALUES 
  (1,'5-00','Seats'),
  (2,'4-00','Electrical'),
  (3,'3-00','Glasses'),
  (4,'2-00','Frame'),
  (5,'1-00','Engine'),
  (7,'101-00','Accessories');
  
  
# Inventory 表是汽车零件的典范列表。
# 零件 —— 例如螺钉或灯泡 —— 可能用于每辆汽车和多个部件中，但是零件只在 Inventory 表中显示一次。
# Inventory 表中的每行包含：
# 	使用了惟一的 32 位整数标识行。
# 	字母数字零件号（此零件号惟一并且可以用作主键。但是，由于它可以包含字母数字字符，因此它不适于与 Sphinx 结合使用，Sphinx 要求索引的每条记录都有一个惟一的 32 位整型键）。
# 	文本描述。
# 	价格。

CREATE TABLE IF NOT EXSITS Inventory (
  id int(10) unsigned NOT NULL auto_increment,
  partno varchar(32) NOT NULL,
  description varchar(256) NOT NULL,
  price float unsigned NOT NULL default '0',
  PRIMARY KEY (id),
  UNIQUE KEY partno USING BTREE (partno)
) ENGINE=InnoDB; 

INSERT INTO `Inventory` 
  (`id`, `partno`, `description`, `price`) 
VALUES 
  (1,'WIN408','Portal window',423),
  (2,'ACC711','Jack kit',110),
  (3,'ACC43','Rear-view mirror',55),
  (4,'ACC5409','Cigarette lighter',20),
  (5,'WIN958','Windshield, front',500),
  (6,'765432','Bolt',0.1),
  (7,'ENG001','Entire engine',10000),
  (8,'ENG088','Cylinder head',55),
  (9,'ENG976','Large cylinder head',65);
  
# Schematic 表将把零件与部件和车型版本绑定在一起。
# 因此，将使用 Schematic 表来查找组装 1979 J Class 敞篷车引擎的所有零件。
# Schematic 表中的每行都有:
# 	一个惟一 ID，
# 	一个引用 Inventory 表行的外键，
# 	一个标识部件的外键，
#	用于引用 Model 表中特定型号和版本的另一个键。

CREATE TABLE IF NOT EXSITS Schematic (
  id int(10) unsigned NOT NULL auto_increment,
  partno_id int(10) unsigned NOT NULL,
  assembly_id int(10) unsigned NOT NULL,
  model_id int(10) unsigned NOT NULL,
  PRIMARY KEY (id),
  KEY partno_index USING BTREE (partno_id),
  KEY assembly_index USING BTREE (assembly_id),
  KEY model_index USING BTREE (model_id),
  FOREIGN KEY (partno_id) REFERENCES Inventory(id),
  FOREIGN KEY (assembly_id) REFERENCES Assembly(id),
  FOREIGN KEY (model_id) REFERENCES Model(id)
) ENGINE=InnoDB;

INSERT INTO `Schematic` 
  (`id`, `partno_id`, `assembly_id`, `model_id`) 
VALUES 
  (1,6,5,1),
  (2,8,5,1),
  (3,1,3,1),
  (4,5,3,1),
  (5,8,5,7),
  (6,6,5,7),
  (7,4,7,3),
  (8,9,5,3);
  
# 清单 6. Catalog 视图将把数据整合到虚拟表中
# 在视图中，字段 id 将指回 Inventory 表中的零件条目。
# partno 和 description 列是要搜索的主要文本，
# 而 assembly 和 model 列用作进一步过滤结果的组

CREATE OR REPLACE VIEW `Catalog` AS
SELECT
  Inventory.id,
  Inventory.partno,
  Inventory.description,
  Assembly.id AS assembly,
  Model.id AS model
FROM
  Assembly, Inventory, Model, Schematic
WHERE
  Schematic.partno_id=Inventory.id 
  AND Schematic.model_id=Model.id 
  AND Schematic.assembly_id=Assembly.id;
