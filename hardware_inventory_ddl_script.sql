-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema computer_hw_inventory
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `computer_hw_inventory` ;

-- -----------------------------------------------------
-- Schema computer_hw_inventory
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `computer_hw_inventory` DEFAULT CHARACTER SET utf8 ;
USE `computer_hw_inventory` ;

-- -----------------------------------------------------
-- Table `computer_hw_inventory`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `computer_hw_inventory`.`customer` ;

CREATE TABLE IF NOT EXISTS `computer_hw_inventory`.`customer` (
  `CustName` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `phone` INT(10) UNSIGNED NULL DEFAULT NULL,
  `CCInfo` INT(10) UNSIGNED NULL DEFAULT NULL,
  `delinquentAcct` TINYINT(4) NULL DEFAULT '0',
  PRIMARY KEY (`CustName`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `computer_hw_inventory`.`customerfees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `computer_hw_inventory`.`customerfees` ;

CREATE TABLE IF NOT EXISTS `computer_hw_inventory`.`customerfees` (
  `CustName` VARCHAR(46) NOT NULL,
  `fees_owed` DECIMAL(9,2) NULL DEFAULT '0.00',
  `fees_paid` DECIMAL(9,2) NULL DEFAULT '0.00',
  PRIMARY KEY (`CustName`),
  INDEX `custfees_custname` (`CustName` ASC),
  CONSTRAINT `fk_custfees_customers`
    FOREIGN KEY (`CustName`)
    REFERENCES `computer_hw_inventory`.`customer` (`CustName`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `computer_hw_inventory`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `computer_hw_inventory`.`employee` ;

CREATE TABLE IF NOT EXISTS `computer_hw_inventory`.`employee` (
  `idEmployee` INT(11) NOT NULL,
  `position` VARCHAR(45) NULL DEFAULT NULL,
  `empFName` VARCHAR(45) NULL DEFAULT NULL,
  `empLNAME` VARCHAR(45) NULL DEFAULT NULL,
  `salary` DECIMAL(8,2) NULL DEFAULT NULL,
  PRIMARY KEY (`idEmployee`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `computer_hw_inventory`.`transactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `computer_hw_inventory`.`transactions` ;

CREATE TABLE IF NOT EXISTS `computer_hw_inventory`.`transactions` (
  `rental_ID` INT(11) NOT NULL,
  `rentalDate` INT(11) NULL DEFAULT NULL COMMENT 'rental start date',
  `dueDate` INT(11) NULL DEFAULT NULL COMMENT 'rental end date',
  `returnDate` INT(11) NULL DEFAULT NULL COMMENT 'day customer returned rental items',
  `totalPrice` DECIMAL(9,2) NULL DEFAULT NULL COMMENT 'rentalRate from Hardware used to calculate\n\nneed TRIGGER',
  `CustName` VARCHAR(45) NULL DEFAULT NULL,
  `idEmployee` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`rental_ID`),
  INDEX `fk_Transactions_Customer1_idx` (`CustName` ASC),
  INDEX `fk_Transactions_Employee1_idx` (`idEmployee` ASC),
  CONSTRAINT `fk_Transactions_Customer1`
    FOREIGN KEY (`CustName`)
    REFERENCES `computer_hw_inventory`.`customer` (`CustName`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Transactions_Employee1`
    FOREIGN KEY (`idEmployee`)
    REFERENCES `computer_hw_inventory`.`employee` (`idEmployee`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `computer_hw_inventory`.`fees_fines`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `computer_hw_inventory`.`fees_fines` ;

CREATE TABLE IF NOT EXISTS `computer_hw_inventory`.`fees_fines` (
  `rental_ID` INT(11) NOT NULL,
  `damageFine` DECIMAL(9,2) NULL DEFAULT '0.00',
  `lateFee` DECIMAL(9,2) NULL DEFAULT '0.00',
  PRIMARY KEY (`rental_ID`),
  INDEX `Idx_feesfines_rentalID` (`rental_ID` ASC),
  CONSTRAINT `fk_fees&fines-to-transactions`
    FOREIGN KEY (`rental_ID`)
    REFERENCES `computer_hw_inventory`.`transactions` (`rental_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `computer_hw_inventory`.`supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `computer_hw_inventory`.`supplier` ;

CREATE TABLE IF NOT EXISTS `computer_hw_inventory`.`supplier` (
  `idSupplier` INT(11) NOT NULL,
  `supplierName` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `phone` BIGINT(11) NULL DEFAULT NULL,
  `qualityRating` INT(11) NULL DEFAULT NULL COMMENT '1-5 \'stars\'',
  PRIMARY KEY (`idSupplier`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `computer_hw_inventory`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `computer_hw_inventory`.`orders` ;

CREATE TABLE IF NOT EXISTS `computer_hw_inventory`.`orders` (
  `idOrder` INT(11) NOT NULL,
  `totalPrice` DECIMAL(9,2) NULL DEFAULT NULL COMMENT 'need a trigger to calculate based of Hardware itemPrice(s)',
  `itemQuantity` INT(11) NULL DEFAULT NULL COMMENT 'based on hardware equal to sum of hw_ids in one order',
  `ordDate` INT(11) NULL DEFAULT NULL,
  `idEmployee` INT(11) NULL DEFAULT NULL,
  `idSupplier` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idOrder`),
  INDEX `fk_Order_Employee1_idx` (`idEmployee` ASC),
  INDEX `fk_Order_Supplier1_idx` (`idSupplier` ASC),
  CONSTRAINT `fk_Order_Employee1`
    FOREIGN KEY (`idEmployee`)
    REFERENCES `computer_hw_inventory`.`employee` (`idEmployee`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Order_Supplier1`
    FOREIGN KEY (`idSupplier`)
    REFERENCES `computer_hw_inventory`.`supplier` (`idSupplier`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `computer_hw_inventory`.`unit_price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `computer_hw_inventory`.`unit_price` ;

CREATE TABLE IF NOT EXISTS `computer_hw_inventory`.`unit_price` (
  `itemPrice` DECIMAL(7,2) NOT NULL,
  `rentalRate` DECIMAL(7,2) GENERATED ALWAYS AS ((`itemPrice` * 0.25)) STORED,
  `itemRepairCost` DECIMAL(7,2) GENERATED ALWAYS AS ((`itemPrice` * 0.5)) STORED,
  PRIMARY KEY (`itemPrice`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `computer_hw_inventory`.`hardware`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `computer_hw_inventory`.`hardware` ;

CREATE TABLE IF NOT EXISTS `computer_hw_inventory`.`hardware` (
  `idHardware` INT(11) NOT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  `condition` INT(11) NULL DEFAULT '3' COMMENT 'Good=0 \nslightly damaged=1.\n  Medium =2\nSevere =3',
  `itemPrice` DECIMAL(7,2) NULL DEFAULT NULL,
  `checkedIN/Out` TINYINT(4) NULL DEFAULT '1' COMMENT 'TRUE=checked in\nFALSE=checked out',
  `rental_ID` INT(11) NULL DEFAULT NULL,
  `idOrder` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idHardware`),
  INDEX `fk_Hardware_Transactions1_idx` (`rental_ID` ASC),
  INDEX `fk_Hardware_Orders1_idx` (`idOrder` ASC),
  INDEX `fk_Hardware_unit-price1_idx` (`itemPrice` ASC),
  CONSTRAINT `fk_Hardware_Orders1`
    FOREIGN KEY (`idOrder`)
    REFERENCES `computer_hw_inventory`.`orders` (`idOrder`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Hardware_Transactions1`
    FOREIGN KEY (`rental_ID`)
    REFERENCES `computer_hw_inventory`.`transactions` (`rental_ID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Hardware_unitPrice1`
    FOREIGN KEY (`itemPrice`)
    REFERENCES `computer_hw_inventory`.`unit_price` (`itemPrice`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `computer_hw_inventory`.`repairservices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `computer_hw_inventory`.`repairservices` ;

CREATE TABLE IF NOT EXISTS `computer_hw_inventory`.`repairservices` (
  `service_orderID` INT(11) NOT NULL,
  `total_repair_cost` DECIMAL(8,2) NULL DEFAULT NULL COMMENT 'TRIGGER\n\n(condition)*(repairCost)\nof each item in a rental_ID',
  `numDamagedItems` INT(11) NULL DEFAULT NULL COMMENT 'STORED PROCEDURE?',
  `CustName` VARCHAR(45) NULL DEFAULT NULL,
  `rental_ID` INT(11) NULL DEFAULT NULL,
  `idEmployee` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`service_orderID`),
  INDEX `fk_RepairServices_Customer1_idx` (`CustName` ASC),
  INDEX `fk_RepairServices_Transactions1_idx` (`rental_ID` ASC),
  INDEX `fk_RepairServices_Employee1_idx` (`idEmployee` ASC),
  CONSTRAINT `fk_RepairServices_Customer1`
    FOREIGN KEY (`CustName`)
    REFERENCES `computer_hw_inventory`.`customer` (`CustName`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_RepairServices_Employee1`
    FOREIGN KEY (`idEmployee`)
    REFERENCES `computer_hw_inventory`.`employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RepairServices_Transactions1`
    FOREIGN KEY (`rental_ID`)
    REFERENCES `computer_hw_inventory`.`transactions` (`rental_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `computer_hw_inventory` ;

-- -----------------------------------------------------
-- procedure AGG Emp MAX MIN salary
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`AGG Emp MAX MIN salary`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AGG Emp MAX MIN salary`()
BEGIN

SELECT MAX(salary) AS TopSalary,  MIN(salary) AS BottomSalary
FROM Employee;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AGG customer delinquent accounts
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`AGG customer delinquent accounts`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AGG customer delinquent accounts`()
BEGIN
SELECT COUNT(CustName) AS TotDelnqAccts
FROM Customer
WHERE `delinquentAcct`=TRUE;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AGG customerFees
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`AGG customerFees`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AGG customerFees`()
BEGIN

SELECT `CustName`, fees_owed
FROM `customerfees`
WHERE fees_owed=(SELECT MAX(`fees_owed`)
                    FROM `customerfees`);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AGG hardware checked in for type
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`AGG hardware checked in for type`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AGG hardware checked in for type`(IN hwtype CHAR(46))
BEGIN
SELECT COUNT(`type`) AS Checked_IN
FROM Hardware
WHERE `type` = hwtype AND `checkedIN/Out`=TRUE;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AGG orders average price
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`AGG orders average price`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AGG orders average price`()
BEGIN
SELECT AVG(`totalPrice`) AS avg_supply_price
FROM `Orders`;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AGG repairservices sum costs+items
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`AGG repairservices sum costs+items`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AGG repairservices sum costs+items`()
BEGIN
SELECT SUM(total_repair_cost) AS tot_repair_cost,
 SUM(numDamagedItems) AS total_damaged
FROM `repairservices`;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AGG supplier lowest rating
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`AGG supplier lowest rating`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AGG supplier lowest rating`()
BEGIN
SELECT supplierName AS `worst_supplier(s)`, qualityRating
FROM Supplier
WHERE qualityRating= (SELECT MIN(qualityRating)
						FROM Supplier);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AGG transactions average  sale price
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`AGG transactions average  sale price`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AGG transactions average  sale price`()
BEGIN
SELECT AVG(totalPrice) AS AvgSale 
FROM Transactions;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AGG unit_price
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`AGG unit_price`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AGG unit_price`()
BEGIN
SELECT MAX(itemPrice) AS most_expensive, AVG(`rentalRate`) AS avg_rental_rate
FROM unit_price;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AGGfees_fines
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`AGGfees_fines`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AGGfees_fines`()
BEGIN

SELECT SUM(damageFine) AS total_damageFines, SUM(`lateFee`) AS total_lateFees
FROM Fees_Fines;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure JOIN Customer-transactions past due
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`JOIN Customer-transactions past due`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `JOIN Customer-transactions past due`(IN vDate CHAR(8))
BEGIN
SELECT rental_ID, totalPrice, rentalDate, dueDate,
 `returnDate`-dueDate AS past_Due, custName, phone
FROM Transactions JOIN Customer USING (custName)
WHERE dueDate < vDate
GROUP BY custName
ORDER BY rentalDate, rental_ID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure JOIN Employee-Orders-Supplier whoBoughtSupply
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`JOIN Employee-Orders-Supplier whoBoughtSupply`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `JOIN Employee-Orders-Supplier whoBoughtSupply`()
BEGIN

SELECT s.`idSupplier`, supplierName, e.`idEmployee`,
 e.`empLNAME`, o.`idOrder`, `totalPrice`, ordDate
FROM `employee` e JOIN `Orders` o USING (idEmployee) JOIN `supplier` s USING(idSupplier)
/*WHERE e.`empLNAME` = vELastN*/
ORDER BY totalPrice;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure JOIN Employee-transactions whoMadeSales
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`JOIN Employee-transactions whoMadeSales`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `JOIN Employee-transactions whoMadeSales`(IN sDate INT, IN eDate INT)
BEGIN
SELECT empFNAME, empLNAME, idEmployee, rental_ID, totalPrice
FROM Employee JOIN Transactions USING (idEmployee)
WHERE rentalDate BETWEEN sDate AND eDate
ORDER BY rentalDate, totalPrice;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure JOIN Hardware-Orders-Supplier itemsInSupplyOrder
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`JOIN Hardware-Orders-Supplier itemsInSupplyOrder`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `JOIN Hardware-Orders-Supplier itemsInSupplyOrder`(in vSuppOrder INT)
BEGIN

SELECT `idOrder`, `idHardware`, itemPrice, `type`, `totalPrice`, ordDate, `idSupplier`, `supplierName`
FROM `Orders` JOIN `hardware` USING(`idOrder`) JOIN `supplier` USING(`idSupplier`)
WHERE `idOrder` = vSuppOrder;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure JOIN Hardware-transactions showItems
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`JOIN Hardware-transactions showItems`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `JOIN Hardware-transactions showItems`(IN rentID INT)
BEGIN

SELECT rental_ID, rentalDate, dueDate,
 `idHardware`, `type`, `checkedIN/Out`, `condition`
FROM Transactions JOIN Hardware Using (rental_ID)
WHERE rental_ID=rentID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure JOIN Transactions-repair-Hardware hardware_in_repair
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`JOIN Transactions-repair-Hardware hardware_in_repair`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `JOIN Transactions-repair-Hardware hardware_in_repair`(in vRepServ int)
BEGIN

SELECT service_orderID, total_repair_cost, numDamagedItems, 
t.rental_ID, h.idHardware, `type`, `condition`
FROM `repairservices` r JOIN `transactions` t USING (rental_ID)
		JOIN `hardware` h USING(rental_ID) 
WHERE service_orderID = vRepServ and `condition` > 0
ORDER BY idHardware;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure JOIN emp-repair-cust repairmanFixes
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`JOIN emp-repair-cust repairmanFixes`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `JOIN emp-repair-cust repairmanFixes`()
BEGIN

SELECT e.`idEmployee`, `empLNAME`, position, service_orderID, total_repair_cost,
 numDamagedItems, c.`CustName`, phone
FROM `employee` e JOIN `repairservices` r USING (idEmployee)
		JOIN `customer` c USING(`CustName`)
ORDER BY service_orderID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Manager Adds Inventory
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`Manager Adds Inventory`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Manager Adds Inventory`(in hwType char(20), in Price decimal)
BEGIN

DECLARE hwIDincrmt int;

SELECT MAX(idHardware)
INTO hwIDincrmt
FROM Hardware;

SET hwIDincrmt = hwIDincrmt+1;

IF NOT EXISTS(SELECT itemPrice
				FROM unit_price
                WHERE itemPrice=Price) THEN

INSERT INTO unit_price (itemPrice)
value (Price);
END IF;


INSERT INTO  Hardware (`idHardware`, `type`,
 `condition`, `itemPrice`, `checkedIN/Out`)
VALUES (hwIDincrmt, hwType, 0, Price, 1);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Staff Creates Transaction
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`Staff Creates Transaction`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Staff Creates Transaction`(in rDate int, in dDate int, 
in cName CHAR(46), in empID int )
BEGIN

DECLARE transIDincrmt int;

SELECT MAX(rental_ID)
INTO transIDincrmt
FROM Transactions;

SET transIDincrmt = transIDincrmt+1;

INSERT INTO Transactions (rental_ID, rentalDate, dueDate, CustName, idEmployee)
VALUES (transIDincrmt, rDate, dDate, cName, empID);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert into repairServices
-- -----------------------------------------------------

USE `computer_hw_inventory`;
DROP procedure IF EXISTS `computer_hw_inventory`.`insert into repairServices`;

DELIMITER $$
USE `computer_hw_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert into repairServices`(IN serviceID INT, 
IN custName CHAR(46), IN vRentalID INT, IN empID INT)
BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE rentCond integer;
DECLARE rentRepair decimal;
DECLARE damageSubtot decimal; 
DECLARE numDamaged integer;
DECLARE hwcursor cursor for 
			SELECT h.`condition`, itemRepairCost
            FROM Hardware h JOIN `unit_price` USING (`itemPrice`)
            WHERE  rental_ID = vRentalID;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
   
   
   SET damageSubtot = 0;
   
OPEN hwcursor;

read_loop: LOOP


	FETCH hwcursor
		INTO rentCond, rentRepair ;
IF done THEN
LEAVE read_loop;
END IF;

SET damageSubtot = damageSubtot + rentCond*rentRepair;

END LOOP;
   
   


SELECT COUNT(*)
INTO numDamaged
FROM Hardware h
WHERE rental_ID = rentalID 
AND h.`condition` > 0;

insert into repairServices
VALUES (serviceID, damageSubtot, numDamaged, 
custName, rentalID, empID);

END$$

DELIMITER ;
USE `computer_hw_inventory`;

DELIMITER $$

USE `computer_hw_inventory`$$
DROP TRIGGER IF EXISTS `computer_hw_inventory`.`customer_AFTER_DELETE` $$
USE `computer_hw_inventory`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `computer_hw_inventory`.`customer_AFTER_DELETE`
AFTER DELETE ON `computer_hw_inventory`.`customer`
FOR EACH ROW
BEGIN
DELETE FROM customerfees
WHERE CustName=old.CustName;

END$$


USE `computer_hw_inventory`$$
DROP TRIGGER IF EXISTS `computer_hw_inventory`.`customer_AFTER_INSERT` $$
USE `computer_hw_inventory`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `computer_hw_inventory`.`customer_AFTER_INSERT`
AFTER INSERT ON `computer_hw_inventory`.`customer`
FOR EACH ROW
BEGIN
INSERT INTO customerfees
(CustName)
VALUE (new.CustName);
END$$


USE `computer_hw_inventory`$$
DROP TRIGGER IF EXISTS `computer_hw_inventory`.`customer_AFTER_UPDATE` $$
USE `computer_hw_inventory`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `computer_hw_inventory`.`customer_AFTER_UPDATE`
AFTER UPDATE ON `computer_hw_inventory`.`customer`
FOR EACH ROW
BEGIN
UPDATE customerfees
SET CustName = new.CustName;
END$$


USE `computer_hw_inventory`$$
DROP TRIGGER IF EXISTS `computer_hw_inventory`.`customerfees_AFTER_INSERT` $$
USE `computer_hw_inventory`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `computer_hw_inventory`.`customerfees_AFTER_INSERT`
AFTER INSERT ON `computer_hw_inventory`.`customerfees`
FOR EACH ROW
BEGIN
DECLARE owed decimal;
DECLARE paid decimal;

SELECT `fees_owed`, `fees_paid`
INTO owed, paid
FROM `customerfees` JOIN `customer` USING (`CustName`)
WHERE `CustName`=new.`CustName`;

IF owed > paid THEN
UPDATE `customer`
SET `delinquentAcct` = 1
WHERE `CustName`=new.`CustName`;

else
UPDATE `customer`
SET `delinquentAcct` = 0
WHERE `CustName`=new.`CustName`;

END IF;


END$$


USE `computer_hw_inventory`$$
DROP TRIGGER IF EXISTS `computer_hw_inventory`.`customerfees_AFTER_UPDATE` $$
USE `computer_hw_inventory`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `computer_hw_inventory`.`customerfees_AFTER_UPDATE`
AFTER UPDATE ON `computer_hw_inventory`.`customerfees`
FOR EACH ROW
BEGIN
DECLARE owed decimal;
DECLARE paid decimal;

SELECT `fees_owed`, `fees_paid`
INTO owed, paid
FROM `customerfees` JOIN `customer` USING (`CustName`)
WHERE `CustName`=new.`CustName`;

IF owed > paid THEN
UPDATE `customer`
SET `delinquentAcct` = 1
WHERE `CustName`=new.`CustName`;

else
UPDATE `customer`
SET `delinquentAcct` = 0
WHERE `CustName`=new.`CustName`;

END IF;

END$$


USE `computer_hw_inventory`$$
DROP TRIGGER IF EXISTS `computer_hw_inventory`.`transactions_AFTER_INSERT` $$
USE `computer_hw_inventory`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `computer_hw_inventory`.`transactions_AFTER_INSERT`
AFTER INSERT ON `computer_hw_inventory`.`transactions`
FOR EACH ROW
BEGIN
DECLARE endDays integer;
   DECLARE endMonths integer;
   DECLARE startDays integer;
   DECLARE startMonths integer;
	DECLARE endYear integer;
   DECLARE startYear integer;
   
DECLARE	latePrice decimal;
DECLARE renturned integer;
DECLARE due integer;

  /*begin set  lateFee of fees_fines table */

   SELECT returnDate
   INTO renturned
   FROM Transactions
   WHERE rental_ID=NEW.rental_ID;
   
    SELECT dueDate, totalPrice
   INTO due, latePrice
   FROM Transactions
   WHERE rental_ID=NEW.rental_ID; 
   
   SET endYear = (renturned%20000000) DIV 10000; 
   SET startYear = (due%20000000) DIV 10000;
   
   SET endMonths = ((renturned%20000000)%10000) DIV 100 ; /*months since beginning of year*/
   SET startMonths = ((due%20000000)%10000) DIV 100; /*months since beginning of year*/
   
   SET endYear = 365*endYear; /*days since 2000*/
   SET startYear = 365*startYear;/*days since 2000*/
   
   SET endDays = (((renturned%20000000)%10000))%100 ; /*days since beginning of month*/
   SET startDays = (((due%20000000)%10000))%100 ;/*days since beginning of month*/
   
  
    CASE endMonths
		WHEN 1 THEN SET endMonths=endDays+endYear;
		WHEN 2 THEN SET endMonths=31+endDays+endYear;
		WHEN 3 THEN SET endMonths=59+endDays+endYear;
		WHEN 4 THEN SET endMonths=90+endDays+endYear;
        WHEN 5 THEN SET endMonths=120+endDays+endYear;
        WHEN 6 THEN SET endMonths=151+endDays+endYear;
        WHEN 7 THEN SET endMonths=181+endDays+endYear;
        WHEN 8 THEN SET endMonths=212+endDays+endYear;
        WHEN 9 THEN SET endMonths=243+endDays+endYear;
        WHEN 10 THEN SET endMonths=273+endDays+endYear;
        WHEN 11 THEN SET endMonths=304+endDays+endYear;
        WHEN 12 THEN SET endMonths=334+endDays+endYear;
	END CASE;
    
     CASE startMonths
		WHEN 1 THEN SET startMonths=startDays+startYear;
		WHEN 2 THEN SET startMonths=31+startDays+startYear;
		WHEN 3 THEN SET startMonths=59+startDays+startYear;
		WHEN 4 THEN SET startMonths=90+startDays+startYear;
        WHEN 5 THEN SET startMonths=120+startDays+startYear;
        WHEN 6 THEN SET startMonths=151+startDays+startYear;
        WHEN 7 THEN SET startMonths=181+startDays+startYear;
        WHEN 8 THEN SET startMonths=212+startDays+startYear;
        WHEN 9 THEN SET startMonths=243+startDays+startYear;
        WHEN 10 THEN SET startMonths=273+startDays+startYear;
        WHEN 11 THEN SET startMonths=304+startDays+startYear;
        WHEN 12 THEN SET startMonths=334+startDays+startYear;
	END CASE;
  
 
   SET latePrice = (endMonths - startMonths)*(0.25*latePrice);
   
   INSERT INTO fees_fines
	(`lateFee`,rental_ID) 
   VALUES (latePrice,  new.rental_ID);

END$$


USE `computer_hw_inventory`$$
DROP TRIGGER IF EXISTS `computer_hw_inventory`.`transactions_AFTER_UPDATE` $$
USE `computer_hw_inventory`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `computer_hw_inventory`.`transactions_AFTER_UPDATE`
AFTER UPDATE ON `computer_hw_inventory`.`transactions`
FOR EACH ROW
BEGIN

DECLARE endDays integer;
   DECLARE endMonths integer;
   DECLARE startDays integer;
   DECLARE startMonths integer;
	DECLARE endYear integer;
   DECLARE startYear integer;
   
DECLARE	latePrice decimal;
DECLARE renturned integer;
DECLARE due integer;

  /*begin set  lateFee of fees_fines table */

   SELECT returnDate
   INTO renturned
   FROM Transactions
   WHERE rental_ID=NEW.rental_ID;
   
    SELECT dueDate, totalPrice
   INTO due, latePrice
   FROM Transactions
   WHERE rental_ID=NEW.rental_ID; 
   
   SET endYear = (renturned%20000000) DIV 10000; 
   SET startYear = (due%20000000) DIV 10000;
   
   SET endMonths = ((renturned%20000000)%10000) DIV 100 ; /*months since beginning of year*/
   SET startMonths = ((due%20000000)%10000) DIV 100; /*months since beginning of year*/
   
   SET endYear = 365*endYear; /*days since 2000*/
   SET startYear = 365*startYear;/*days since 2000*/
   
   SET endDays = (((renturned%20000000)%10000))%100 ; /*days since beginning of month*/
   SET startDays = (((due%20000000)%10000))%100 ;/*days since beginning of month*/
   
  
    CASE endMonths
		WHEN 1 THEN SET endMonths=endDays+endYear;
		WHEN 2 THEN SET endMonths=31+endDays+endYear;
		WHEN 3 THEN SET endMonths=59+endDays+endYear;
		WHEN 4 THEN SET endMonths=90+endDays+endYear;
        WHEN 5 THEN SET endMonths=120+endDays+endYear;
        WHEN 6 THEN SET endMonths=151+endDays+endYear;
        WHEN 7 THEN SET endMonths=181+endDays+endYear;
        WHEN 8 THEN SET endMonths=212+endDays+endYear;
        WHEN 9 THEN SET endMonths=243+endDays+endYear;
        WHEN 10 THEN SET endMonths=273+endDays+endYear;
        WHEN 11 THEN SET endMonths=304+endDays+endYear;
        WHEN 12 THEN SET endMonths=334+endDays+endYear;
	END CASE;
    
     CASE startMonths
		WHEN 1 THEN SET startMonths=startDays+startYear;
		WHEN 2 THEN SET startMonths=31+startDays+startYear;
		WHEN 3 THEN SET startMonths=59+startDays+startYear;
		WHEN 4 THEN SET startMonths=90+startDays+startYear;
        WHEN 5 THEN SET startMonths=120+startDays+startYear;
        WHEN 6 THEN SET startMonths=151+startDays+startYear;
        WHEN 7 THEN SET startMonths=181+startDays+startYear;
        WHEN 8 THEN SET startMonths=212+startDays+startYear;
        WHEN 9 THEN SET startMonths=243+startDays+startYear;
        WHEN 10 THEN SET startMonths=273+startDays+startYear;
        WHEN 11 THEN SET startMonths=304+startDays+startYear;
        WHEN 12 THEN SET startMonths=334+startDays+startYear;
	END CASE;
  
 
   SET latePrice = (endMonths - startMonths)*(0.25*latePrice);
   
   UPDATE fees_fines
   SET `lateFee` = latePrice
   WHERE rental_ID = new.rental_ID;

END$$


USE `computer_hw_inventory`$$
DROP TRIGGER IF EXISTS `computer_hw_inventory`.`fees_fines_AFTER_DELETE` $$
USE `computer_hw_inventory`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `computer_hw_inventory`.`fees_fines_AFTER_DELETE`
AFTER DELETE ON `computer_hw_inventory`.`fees_fines`
FOR EACH ROW
BEGIN

DECLARE tempCust varchar(46);
DECLARE vDmg decimal;
DECLARE vLate decimal;


SELECT `CustName`
INTO tempCust
FROM `transactions`
WHERE `rental_ID`=old.`rental_ID`;

SELECT SUM(`damageFine`), SUM(`lateFee`)
INTO vDmg, vLate
FROM `transactions` JOIN `fees_fines` USING(rental_ID)
WHERE CustName=tempCust;

UPDATE `customerfees`
SET `fees_owed` = vDmg + vLate
WHERE CustName=tempCust;

END$$


USE `computer_hw_inventory`$$
DROP TRIGGER IF EXISTS `computer_hw_inventory`.`fees_fines_AFTER_INSERT` $$
USE `computer_hw_inventory`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `computer_hw_inventory`.`fees_fines_AFTER_INSERT`
AFTER INSERT ON `computer_hw_inventory`.`fees_fines`
FOR EACH ROW
BEGIN

DECLARE tempCust varchar(46);
DECLARE vDmg decimal;
DECLARE vLate decimal;


SELECT `CustName`
INTO tempCust
FROM `transactions`
WHERE `rental_ID`=new.`rental_ID`;

SELECT SUM(`damageFine`), SUM(`lateFee`)
INTO vDmg, vLate
FROM `transactions` JOIN `fees_fines` USING(rental_ID)
WHERE CustName=tempCust;

UPDATE `customerfees`
SET `fees_owed` = vDmg + vLate
WHERE CustName=tempCust;

END$$


USE `computer_hw_inventory`$$
DROP TRIGGER IF EXISTS `computer_hw_inventory`.`fees_fines_AFTER_UPDATE` $$
USE `computer_hw_inventory`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `computer_hw_inventory`.`fees_fines_AFTER_UPDATE`
AFTER UPDATE ON `computer_hw_inventory`.`fees_fines`
FOR EACH ROW
BEGIN

DECLARE tempCust varchar(46);
DECLARE vDmg decimal;
DECLARE vLate decimal;


SELECT `CustName`
INTO tempCust
FROM `transactions`
WHERE `rental_ID`=new.`rental_ID`;

SELECT SUM(`damageFine`), SUM(`lateFee`)
INTO vDmg, vLate
FROM `transactions` JOIN `fees_fines` USING(rental_ID)
WHERE CustName=tempCust;

UPDATE `customerfees`
SET `fees_owed` = vDmg + vLate
WHERE CustName=tempCust;

END$$


USE `computer_hw_inventory`$$
DROP TRIGGER IF EXISTS `computer_hw_inventory`.`hardware_AFTER_DELETE` $$
USE `computer_hw_inventory`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `computer_hw_inventory`.`hardware_AFTER_DELETE`
AFTER DELETE ON `computer_hw_inventory`.`hardware`
FOR EACH ROW
BEGIN
DECLARE done INT DEFAULT FALSE;
/*variables for calc price of rental transactions and supply orders*/
DECLARE rentPrice decimal;
DECLARE rentalPeriod integer;
DECLARE rentStart integer;
DECLARE rentEnd integer;
DECLARE rentSubtot decimal;
 
   DECLARE endDays integer;
   DECLARE endMonths integer;
   DECLARE startDays integer;
   DECLARE startMonths integer;
	DECLARE endYear integer;
   DECLARE startYear integer;
/*variables for calc repaircost of service in repairservices table*/
DECLARE totCost decimal;
DECLARE numDamaged integer;
/*variables for calc price and total num or supply orders*/
DECLARE totPrice decimal;
DECLARE numItems integer;
/*variables for calc damage fine of rental transactions*/
DECLARE rentCond integer;
DECLARE rentRepair decimal;
DECLARE damageSubtot decimal;

   /*rentalRate and damage cursor*/
DECLARE hwcursor cursor for 
			SELECT `condition`, itemRepairCost, rentalRate
            FROM Hardware JOIN `unit_price` USING(itemPrice)
            WHERE  rental_ID = old.rental_ID;
            
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
 
 
   SET rentSubtot = 0;
      SET damageSubtot = 0;
            SET totCost =0;

OPEN hwcursor;

read_loop: LOOP

	FETCH hwcursor
		INTO rentCond, rentRepair, rentPrice;
IF done THEN
LEAVE read_loop;
END IF;

SET rentSubtot = rentSubtot + rentPrice;
SET damageSubtot = damageSubtot + rentCond*rentRepair + rentCond*50;
SET totCost = totCost + rentCond*rentRepair;
END LOOP;
CLOSE hwcursor;   
      /*begin set repairservices*/
   SELECT COUNT(*)
INTO numDamaged
FROM Hardware
WHERE rental_ID = old.rental_ID 
AND `condition` > 0;

   UPDATE RepairServices
   SET total_repair_cost = totCost, numDamagedItems = numDamaged
   WHERE rental_ID = old.rental_ID ; 
   
      /*begin set price of rental in transactions table*/ 
   SELECT rentalDate
   INTO rentStart
   FROM Transactions
   WHERE rental_ID=old.rental_ID;
   
    SELECT dueDate
   INTO rentEnd
   FROM Transactions
   WHERE rental_ID=old.rental_ID; 
   
   SET endYear = (rentEnd%20000000) DIV 10000; 
   SET startYear = (rentStart%20000000) DIV 10000;
   
   SET endMonths = ((rentEnd%20000000)%10000) DIV 100 ; /*months since beginning of year*/
   SET startMonths = ((rentStart%20000000)%10000) DIV 100; /*months since beginning of year*/
   
   SET endYear = 365*endYear; /*days since 2000*/
   SET startYear = 365*startYear;/*days since 2000*/
   
   SET endDays = (((rentEnd%20000000)%10000))%100 ; /*days since beginning of month*/
   SET startDays = (((rentStart%20000000)%10000))%100 ;/*days since beginning of month*/
   
  
    CASE endMonths
		WHEN 1 THEN SET endMonths=endDays+endYear;
		WHEN 2 THEN SET endMonths=31+endDays+endYear;
		WHEN 3 THEN SET endMonths=59+endDays+endYear;
		WHEN 4 THEN SET endMonths=90+endDays+endYear;
        WHEN 5 THEN SET endMonths=120+endDays+endYear;
        WHEN 6 THEN SET endMonths=151+endDays+endYear;
        WHEN 7 THEN SET endMonths=181+endDays+endYear;
        WHEN 8 THEN SET endMonths=212+endDays+endYear;
        WHEN 9 THEN SET endMonths=243+endDays+endYear;
        WHEN 10 THEN SET endMonths=273+endDays+endYear;
        WHEN 11 THEN SET endMonths=304+endDays+endYear;
        WHEN 12 THEN SET endMonths=334+endDays+endYear;
	END CASE;
    
     CASE startMonths
		WHEN 1 THEN SET startMonths=startDays+startYear;
		WHEN 2 THEN SET startMonths=31+startDays+startYear;
		WHEN 3 THEN SET startMonths=59+startDays+startYear;
		WHEN 4 THEN SET startMonths=90+startDays+startYear;
        WHEN 5 THEN SET startMonths=120+startDays+startYear;
        WHEN 6 THEN SET startMonths=151+startDays+startYear;
        WHEN 7 THEN SET startMonths=181+startDays+startYear;
        WHEN 8 THEN SET startMonths=212+startDays+startYear;
        WHEN 9 THEN SET startMonths=243+startDays+startYear;
        WHEN 10 THEN SET startMonths=273+startDays+startYear;
        WHEN 11 THEN SET startMonths=304+startDays+startYear;
        WHEN 12 THEN SET startMonths=334+startDays+startYear;
	END CASE;
  
SET rentalPeriod = endMonths - startMonths;
   
   UPDATE Transactions
   SET totalPrice = rentSubtot*rentalPeriod
   WHERE rental_ID = old.rental_ID;
   
   /*begin set damageFine of rental in transactions table*/ 
   
   UPDATE `fees_fines`
   SET damageFine = damageSubtot
   WHERE rental_ID = old.rental_ID;
   
    /*begin set price of order in order table*/ 

SELECT SUM(itemPrice)
INTO totPrice
FROM Hardware
WHERE idOrder = old.idOrder;

SELECT COUNT(*)
INTO numItems
FROM Hardware
WHERE idOrder = old.idOrder;

UPDATE `computer_hw_inventory`.`Orders`
SET totalPrice=totPrice, itemQuantity=numItems
WHERE idOrder=old.idOrder;

END$$


USE `computer_hw_inventory`$$
DROP TRIGGER IF EXISTS `computer_hw_inventory`.`hardware_AFTER_INSERT` $$
USE `computer_hw_inventory`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `computer_hw_inventory`.`hardware_AFTER_INSERT`
AFTER INSERT ON `computer_hw_inventory`.`hardware`
FOR EACH ROW
BEGIN
DECLARE done INT DEFAULT FALSE;
/*variables for calc price of rental transactions and supply orders*/
DECLARE rentPrice decimal;
DECLARE rentalPeriod integer;
DECLARE rentStart integer;
DECLARE rentEnd integer;
DECLARE rentSubtot decimal;
 
   DECLARE endDays integer;
   DECLARE endMonths integer;
   DECLARE startDays integer;
   DECLARE startMonths integer;
	DECLARE endYear integer;
   DECLARE startYear integer;
/*variables for calc repaircost of service in repairservices table*/
DECLARE totCost decimal;
DECLARE numDamaged integer;
/*variables for calc price and total num or supply orders*/
DECLARE totPrice decimal;
DECLARE numItems integer;
/*variables for calc damage fine of rental transactions*/
DECLARE rentCond integer;
DECLARE rentRepair decimal;
DECLARE damageSubtot decimal;

   /*rentalRate and damage cursor*/
DECLARE hwcursor cursor for 
			SELECT `condition`, itemRepairCost, rentalRate
            FROM Hardware JOIN `unit_price` USING(itemPrice)
            WHERE  rental_ID = new.rental_ID;
            
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
 
 
   SET rentSubtot = 0;
      SET damageSubtot = 0;
            SET totCost =0;

OPEN hwcursor;

read_loop: LOOP

	FETCH hwcursor
		INTO rentCond, rentRepair, rentPrice;
IF done THEN
LEAVE read_loop;
END IF;

SET rentSubtot = rentSubtot + rentPrice;
SET damageSubtot = damageSubtot + rentCond*rentRepair + rentCond*50;
SET totCost = totCost + rentCond*rentRepair;
END LOOP;
CLOSE hwcursor;   
      /*begin set repairservices*/
   SELECT COUNT(*)
INTO numDamaged
FROM Hardware
WHERE rental_ID = new.rental_ID 
AND `condition` > 0;

   UPDATE RepairServices
   SET total_repair_cost = totCost, numDamagedItems = numDamaged
   WHERE rental_ID = new.rental_ID ; 
   
      /*begin set price of rental in transactions table*/ 
   SELECT rentalDate
   INTO rentStart
   FROM Transactions
   WHERE rental_ID=NEW.rental_ID;
   
    SELECT dueDate
   INTO rentEnd
   FROM Transactions
   WHERE rental_ID=NEW.rental_ID; 
   
   SET endYear = (rentEnd%20000000) DIV 10000; 
   SET startYear = (rentStart%20000000) DIV 10000;
   
   SET endMonths = ((rentEnd%20000000)%10000) DIV 100 ; /*months since beginning of year*/
   SET startMonths = ((rentStart%20000000)%10000) DIV 100; /*months since beginning of year*/
   
   SET endYear = 365*endYear; /*days since 2000*/
   SET startYear = 365*startYear;/*days since 2000*/
   
   SET endDays = (((rentEnd%20000000)%10000))%100 ; /*days since beginning of month*/
   SET startDays = (((rentStart%20000000)%10000))%100 ;/*days since beginning of month*/
   
  
    CASE endMonths
		WHEN 1 THEN SET endMonths=endDays+endYear;
		WHEN 2 THEN SET endMonths=31+endDays+endYear;
		WHEN 3 THEN SET endMonths=59+endDays+endYear;
		WHEN 4 THEN SET endMonths=90+endDays+endYear;
        WHEN 5 THEN SET endMonths=120+endDays+endYear;
        WHEN 6 THEN SET endMonths=151+endDays+endYear;
        WHEN 7 THEN SET endMonths=181+endDays+endYear;
        WHEN 8 THEN SET endMonths=212+endDays+endYear;
        WHEN 9 THEN SET endMonths=243+endDays+endYear;
        WHEN 10 THEN SET endMonths=273+endDays+endYear;
        WHEN 11 THEN SET endMonths=304+endDays+endYear;
        WHEN 12 THEN SET endMonths=334+endDays+endYear;
	END CASE;
    
     CASE startMonths
		WHEN 1 THEN SET startMonths=startDays+startYear;
		WHEN 2 THEN SET startMonths=31+startDays+startYear;
		WHEN 3 THEN SET startMonths=59+startDays+startYear;
		WHEN 4 THEN SET startMonths=90+startDays+startYear;
        WHEN 5 THEN SET startMonths=120+startDays+startYear;
        WHEN 6 THEN SET startMonths=151+startDays+startYear;
        WHEN 7 THEN SET startMonths=181+startDays+startYear;
        WHEN 8 THEN SET startMonths=212+startDays+startYear;
        WHEN 9 THEN SET startMonths=243+startDays+startYear;
        WHEN 10 THEN SET startMonths=273+startDays+startYear;
        WHEN 11 THEN SET startMonths=304+startDays+startYear;
        WHEN 12 THEN SET startMonths=334+startDays+startYear;
	END CASE;
  
SET rentalPeriod = endMonths - startMonths;
   
   UPDATE Transactions
   SET totalPrice = rentSubtot*rentalPeriod
   WHERE rental_ID = new.rental_ID;
   
   /*begin set damageFine of rental in transactions table*/ 
   
   UPDATE `fees_fines`
   SET damageFine = damageSubtot
   WHERE rental_ID = new.rental_ID;
   
    /*begin set price of order in order table*/ 

SELECT SUM(itemPrice)
INTO totPrice
FROM Hardware
WHERE idOrder = new.idOrder;

SELECT COUNT(*)
INTO numItems
FROM Hardware
WHERE idOrder = new.idOrder;

UPDATE `computer_hw_inventory`.`Orders`
SET totalPrice=totPrice, itemQuantity=numItems
WHERE idOrder=new.idOrder;

END$$


USE `computer_hw_inventory`$$
DROP TRIGGER IF EXISTS `computer_hw_inventory`.`hardware_AFTER_UPDATE` $$
USE `computer_hw_inventory`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `computer_hw_inventory`.`hardware_AFTER_UPDATE`
AFTER UPDATE ON `computer_hw_inventory`.`hardware`
FOR EACH ROW
BEGIN
DECLARE done INT DEFAULT FALSE;
/*variables for calc price of rental transactions and supply orders*/
DECLARE rentPrice decimal;
DECLARE rentalPeriod integer;
DECLARE rentStart integer;
DECLARE rentEnd integer;
DECLARE rentSubtot decimal;
 
   DECLARE endDays integer;
   DECLARE endMonths integer;
   DECLARE startDays integer;
   DECLARE startMonths integer;
	DECLARE endYear integer;
   DECLARE startYear integer;
/*variables for calc repaircost of service in repairservices table*/
DECLARE totCost decimal;
DECLARE numDamaged integer;
/*variables for calc price and total num or supply orders*/
DECLARE totPrice decimal;
DECLARE numItems integer;
/*variables for calc damage fine of rental transactions*/
DECLARE rentCond integer;
DECLARE rentRepair decimal;
DECLARE damageSubtot decimal;

   /*rentalRate and damage cursor*/
DECLARE hwcursor cursor for 
			SELECT `condition`, itemRepairCost, rentalRate
            FROM Hardware JOIN `unit_price` USING(itemPrice)
            WHERE  rental_ID = new.rental_ID;
            
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
 
 
   SET rentSubtot = 0;
      SET damageSubtot = 0;
            SET totCost =0;

OPEN hwcursor;

read_loop: LOOP

	FETCH hwcursor
		INTO rentCond, rentRepair, rentPrice;
IF done THEN
LEAVE read_loop;
END IF;

SET rentSubtot = rentSubtot + rentPrice;
SET damageSubtot = damageSubtot + rentCond*rentRepair + rentCond*50;
SET totCost = totCost + rentCond*rentRepair;
END LOOP;
CLOSE hwcursor;   
      /*begin set repairservices*/
   SELECT COUNT(*)
INTO numDamaged
FROM Hardware
WHERE rental_ID = new.rental_ID 
AND `condition` > 0;

   UPDATE RepairServices
   SET total_repair_cost = totCost, numDamagedItems = numDamaged
   WHERE rental_ID = new.rental_ID ; 
   
      /*begin set price of rental in transactions table*/ 
   SELECT rentalDate
   INTO rentStart
   FROM Transactions
   WHERE rental_ID=NEW.rental_ID;
   
    SELECT dueDate
   INTO rentEnd
   FROM Transactions
   WHERE rental_ID=NEW.rental_ID; 
   
   SET endYear = (rentEnd%20000000) DIV 10000; 
   SET startYear = (rentStart%20000000) DIV 10000;
   
   SET endMonths = ((rentEnd%20000000)%10000) DIV 100 ; /*months since beginning of year*/
   SET startMonths = ((rentStart%20000000)%10000) DIV 100; /*months since beginning of year*/
   
   SET endYear = 365*endYear; /*days since 2000*/
   SET startYear = 365*startYear;/*days since 2000*/
   
   SET endDays = (((rentEnd%20000000)%10000))%100 ; /*days since beginning of month*/
   SET startDays = (((rentStart%20000000)%10000))%100 ;/*days since beginning of month*/
   
  
    CASE endMonths
		WHEN 1 THEN SET endMonths=endDays+endYear;
		WHEN 2 THEN SET endMonths=31+endDays+endYear;
		WHEN 3 THEN SET endMonths=59+endDays+endYear;
		WHEN 4 THEN SET endMonths=90+endDays+endYear;
        WHEN 5 THEN SET endMonths=120+endDays+endYear;
        WHEN 6 THEN SET endMonths=151+endDays+endYear;
        WHEN 7 THEN SET endMonths=181+endDays+endYear;
        WHEN 8 THEN SET endMonths=212+endDays+endYear;
        WHEN 9 THEN SET endMonths=243+endDays+endYear;
        WHEN 10 THEN SET endMonths=273+endDays+endYear;
        WHEN 11 THEN SET endMonths=304+endDays+endYear;
        WHEN 12 THEN SET endMonths=334+endDays+endYear;
	END CASE;
    
     CASE startMonths
		WHEN 1 THEN SET startMonths=startDays+startYear;
		WHEN 2 THEN SET startMonths=31+startDays+startYear;
		WHEN 3 THEN SET startMonths=59+startDays+startYear;
		WHEN 4 THEN SET startMonths=90+startDays+startYear;
        WHEN 5 THEN SET startMonths=120+startDays+startYear;
        WHEN 6 THEN SET startMonths=151+startDays+startYear;
        WHEN 7 THEN SET startMonths=181+startDays+startYear;
        WHEN 8 THEN SET startMonths=212+startDays+startYear;
        WHEN 9 THEN SET startMonths=243+startDays+startYear;
        WHEN 10 THEN SET startMonths=273+startDays+startYear;
        WHEN 11 THEN SET startMonths=304+startDays+startYear;
        WHEN 12 THEN SET startMonths=334+startDays+startYear;
	END CASE;
  
SET rentalPeriod = endMonths - startMonths;
   
   UPDATE Transactions
   SET totalPrice = rentSubtot*rentalPeriod
   WHERE rental_ID = new.rental_ID;
   
   /*begin set damageFine of rental in transactions table*/ 
   
   UPDATE `fees_fines`
   SET damageFine = damageSubtot
   WHERE rental_ID = new.rental_ID;
   
    /*begin set price of order in order table*/ 

SELECT SUM(itemPrice)
INTO totPrice
FROM Hardware
WHERE idOrder = new.idOrder;

SELECT COUNT(*)
INTO numItems
FROM Hardware
WHERE idOrder = new.idOrder;

UPDATE `computer_hw_inventory`.`Orders`
SET totalPrice=totPrice, itemQuantity=numItems
WHERE idOrder=new.idOrder;

END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
