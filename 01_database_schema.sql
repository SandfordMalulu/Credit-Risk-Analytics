CREATE DATABASE  IF NOT EXISTS `credit_risk_analytics` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `credit_risk_analytics`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: credit_risk_analytics
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `analytics_control`
--

DROP TABLE IF EXISTS `analytics_control`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analytics_control` (
  `control_name` varchar(50) NOT NULL,
  `control_date` date NOT NULL,
  PRIMARY KEY (`control_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branches` (
  `branch` varchar(60) NOT NULL,
  `region` varchar(40) DEFAULT NULL,
  `branch_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`branch`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `age` tinyint unsigned DEFAULT NULL,
  `employment_type` varchar(30) DEFAULT NULL,
  `monthly_income_zmw` decimal(12,2) DEFAULT NULL,
  `credit_score` smallint unsigned DEFAULT NULL,
  `region` varchar(40) DEFAULT NULL,
  `customer_since` date DEFAULT NULL,
  `existing_customer_flag` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  CONSTRAINT `chk_customer_age` CHECK ((`age` between 18 and 100)),
  CONSTRAINT `chk_customer_income` CHECK ((`monthly_income_zmw` >= 0)),
  CONSTRAINT `chk_customer_score` CHECK ((`credit_score` between 300 and 850)),
  CONSTRAINT `chk_existing_customer` CHECK ((`existing_customer_flag` in (0,1)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loans`
--

DROP TABLE IF EXISTS `loans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loans` (
  `loan_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `application_date` date DEFAULT NULL,
  `disbursement_date` date DEFAULT NULL,
  `loan_product` varchar(40) DEFAULT NULL,
  `loan_amount_zmw` decimal(14,2) DEFAULT NULL,
  `interest_rate_pct` decimal(5,2) DEFAULT NULL,
  `term_months` smallint unsigned DEFAULT NULL,
  `loan_status` varchar(30) DEFAULT NULL,
  `risk_band` varchar(20) DEFAULT NULL,
  `branch` varchar(60) DEFAULT NULL,
  `default_flag` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`loan_id`),
  KEY `idx_loans_customer` (`customer_id`),
  KEY `idx_loans_status_date` (`loan_status`,`disbursement_date`),
  KEY `idx_loans_branch` (`branch`),
  CONSTRAINT `fk_loans_branch` FOREIGN KEY (`branch`) REFERENCES `branches` (`branch`),
  CONSTRAINT `fk_loans_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `chk_default_flag` CHECK ((`default_flag` in (0,1))),
  CONSTRAINT `chk_interest_rate` CHECK ((`interest_rate_pct` >= 0)),
  CONSTRAINT `chk_loan_amount` CHECK ((`loan_amount_zmw` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loans_full_import`
--

DROP TABLE IF EXISTS `loans_full_import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loans_full_import` (
  `loan_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `application_date` text,
  `disbursement_date` text,
  `loan_product` text,
  `loan_amount_zmw` double DEFAULT NULL,
  `interest_rate_pct` double DEFAULT NULL,
  `term_months` int DEFAULT NULL,
  `loan_status` text,
  `risk_band` text,
  `branch` text,
  `default_flag` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loans_staging`
--

DROP TABLE IF EXISTS `loans_staging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loans_staging` (
  `loan_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `application_date` date DEFAULT NULL,
  `disbursement_date` date DEFAULT NULL,
  `loan_product` varchar(40) DEFAULT NULL,
  `loan_amount_zmw` decimal(14,2) DEFAULT NULL,
  `interest_rate_pct` decimal(5,2) DEFAULT NULL,
  `term_months` smallint unsigned DEFAULT NULL,
  `loan_status` varchar(30) DEFAULT NULL,
  `risk_band` varchar(20) DEFAULT NULL,
  `branch` varchar(60) DEFAULT NULL,
  `default_flag` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`loan_id`),
  KEY `idx_loans_customer` (`customer_id`),
  KEY `idx_loans_status_date` (`loan_status`,`disbursement_date`),
  KEY `idx_loans_branch` (`branch`),
  CONSTRAINT `loans_staging_chk_1` CHECK ((`default_flag` in (0,1))),
  CONSTRAINT `loans_staging_chk_2` CHECK ((`interest_rate_pct` >= 0)),
  CONSTRAINT `loans_staging_chk_3` CHECK ((`loan_amount_zmw` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL,
  `loan_id` int NOT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_amount_zmw` decimal(14,2) DEFAULT NULL,
  `payment_channel` varchar(30) DEFAULT NULL,
  `payment_status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `idx_payments_loan_date` (`loan_id`,`payment_date`),
  CONSTRAINT `fk_payments_loan` FOREIGN KEY (`loan_id`) REFERENCES `loans` (`loan_id`),
  CONSTRAINT `chk_payment_amount` CHECK ((`payment_amount_zmw` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `repayment_schedule`
--

DROP TABLE IF EXISTS `repayment_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repayment_schedule` (
  `schedule_id` int NOT NULL,
  `loan_id` int NOT NULL,
  `installment_number` smallint unsigned DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `scheduled_amount_zmw` decimal(14,2) DEFAULT NULL,
  `paid_amount_zmw` decimal(14,2) DEFAULT NULL,
  `paid_date` date DEFAULT NULL,
  PRIMARY KEY (`schedule_id`),
  KEY `idx_schedule_loan_due` (`loan_id`,`due_date`),
  CONSTRAINT `fk_schedule_loan` FOREIGN KEY (`loan_id`) REFERENCES `loans` (`loan_id`),
  CONSTRAINT `chk_paid_amount` CHECK ((`paid_amount_zmw` >= 0)),
  CONSTRAINT `chk_scheduled_amount` CHECK ((`scheduled_amount_zmw` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `vw_application_funnel`
--

DROP TABLE IF EXISTS `vw_application_funnel`;
/*!50001 DROP VIEW IF EXISTS `vw_application_funnel`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_application_funnel` AS SELECT 
 1 AS `total_applications`,
 1 AS `approved_applications`,
 1 AS `disbursed_loans`,
 1 AS `approval_rate_pct`,
 1 AS `total_disbursed_zmw`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_dpd_bucket_dimension`
--

DROP TABLE IF EXISTS `vw_dpd_bucket_dimension`;
/*!50001 DROP VIEW IF EXISTS `vw_dpd_bucket_dimension`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_dpd_bucket_dimension` AS SELECT 
 1 AS `dpd_bucket`,
 1 AS `sort_order`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_installment_arrears_snapshot`
--

DROP TABLE IF EXISTS `vw_installment_arrears_snapshot`;
/*!50001 DROP VIEW IF EXISTS `vw_installment_arrears_snapshot`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_installment_arrears_snapshot` AS SELECT 
 1 AS `schedule_id`,
 1 AS `loan_id`,
 1 AS `installment_number`,
 1 AS `due_date`,
 1 AS `paid_date`,
 1 AS `scheduled_amount_zmw`,
 1 AS `paid_as_of_zmw`,
 1 AS `unpaid_as_of_zmw`,
 1 AS `installment_dpd`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_loan_delinquency_snapshot`
--

DROP TABLE IF EXISTS `vw_loan_delinquency_snapshot`;
/*!50001 DROP VIEW IF EXISTS `vw_loan_delinquency_snapshot`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_loan_delinquency_snapshot` AS SELECT 
 1 AS `loan_id`,
 1 AS `customer_id`,
 1 AS `branch`,
 1 AS `loan_product`,
 1 AS `loan_amount_zmw`,
 1 AS `disbursement_date`,
 1 AS `reporting_date`,
 1 AS `installment_count`,
 1 AS `total_unpaid_scheduled_zmw`,
 1 AS `overdue_amount_zmw`,
 1 AS `oldest_unpaid_due_date`,
 1 AS `days_past_due`,
 1 AS `dpd_bucket`,
 1 AS `schedule_quality_flag`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_application_funnel`
--

/*!50001 DROP VIEW IF EXISTS `vw_application_funnel`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_application_funnel` AS select count(0) AS `total_applications`,sum((`loans`.`loan_status` in ('Approved','Disbursed','Approved_Not_Disbursed'))) AS `approved_applications`,sum((`loans`.`loan_status` = 'Disbursed')) AS `disbursed_loans`,round(((100 * sum((`loans`.`loan_status` in ('Approved','Disbursed','Approved_Not_Disbursed')))) / nullif(count(0),0)),2) AS `approval_rate_pct`,sum((case when (`loans`.`loan_status` = 'Disbursed') then `loans`.`loan_amount_zmw` else 0 end)) AS `total_disbursed_zmw` from `loans` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dpd_bucket_dimension`
--

/*!50001 DROP VIEW IF EXISTS `vw_dpd_bucket_dimension`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dpd_bucket_dimension` AS select 'Current' AS `dpd_bucket`,1 AS `sort_order` union all select '1-30 DPD' AS `1-30 DPD`,2 AS `2` union all select '31-60 DPD' AS `31-60 DPD`,3 AS `3` union all select '61-90 DPD' AS `61-90 DPD`,4 AS `4` union all select '90+ DPD' AS `90+ DPD`,5 AS `5` union all select 'Missing Schedule' AS `Missing Schedule`,6 AS `6` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_installment_arrears_snapshot`
--

/*!50001 DROP VIEW IF EXISTS `vw_installment_arrears_snapshot`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_installment_arrears_snapshot` AS select `r`.`schedule_id` AS `schedule_id`,`r`.`loan_id` AS `loan_id`,`r`.`installment_number` AS `installment_number`,`r`.`due_date` AS `due_date`,`r`.`paid_date` AS `paid_date`,`r`.`scheduled_amount_zmw` AS `scheduled_amount_zmw`,(case when (`r`.`paid_date` <= '2026-09-30') then coalesce(`r`.`paid_amount_zmw`,0) else 0 end) AS `paid_as_of_zmw`,greatest((coalesce(`r`.`scheduled_amount_zmw`,0) - (case when (`r`.`paid_date` <= '2026-09-30') then coalesce(`r`.`paid_amount_zmw`,0) else 0 end)),0) AS `unpaid_as_of_zmw`,(case when ((`r`.`due_date` < '2026-09-30') and (greatest((coalesce(`r`.`scheduled_amount_zmw`,0) - (case when (`r`.`paid_date` <= '2026-09-30') then coalesce(`r`.`paid_amount_zmw`,0) else 0 end)),0) > 0.01)) then (to_days('2026-09-30') - to_days(`r`.`due_date`)) else 0 end) AS `installment_dpd` from `repayment_schedule` `r` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_loan_delinquency_snapshot`
--

/*!50001 DROP VIEW IF EXISTS `vw_loan_delinquency_snapshot`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_loan_delinquency_snapshot` AS select `l`.`loan_id` AS `loan_id`,`l`.`customer_id` AS `customer_id`,`l`.`branch` AS `branch`,`l`.`loan_product` AS `loan_product`,`l`.`loan_amount_zmw` AS `loan_amount_zmw`,`l`.`disbursement_date` AS `disbursement_date`,cast('2026-09-30' as date) AS `reporting_date`,count(`r`.`schedule_id`) AS `installment_count`,round(coalesce(sum(`r`.`unpaid_as_of_zmw`),0),2) AS `total_unpaid_scheduled_zmw`,round(coalesce(sum((case when (`r`.`installment_dpd` > 0) then `r`.`unpaid_as_of_zmw` else 0 end)),0),2) AS `overdue_amount_zmw`,min((case when (`r`.`installment_dpd` > 0) then `r`.`due_date` else NULL end)) AS `oldest_unpaid_due_date`,coalesce(max(`r`.`installment_dpd`),0) AS `days_past_due`,(case when (count(`r`.`schedule_id`) = 0) then 'Missing Schedule' when (max(`r`.`installment_dpd`) > 90) then '90+ DPD' when (max(`r`.`installment_dpd`) > 60) then '61-90 DPD' when (max(`r`.`installment_dpd`) > 30) then '31-60 DPD' when (max(`r`.`installment_dpd`) > 0) then '1-30 DPD' else 'Current' end) AS `dpd_bucket`,(case when (count(`r`.`schedule_id`) = 0) then 'Missing Schedule' else 'Schedule Available' end) AS `schedule_quality_flag` from (`loans` `l` left join `vw_installment_arrears_snapshot` `r` on((`l`.`loan_id` = `r`.`loan_id`))) where ((`l`.`loan_status` = 'Disbursed') and (`l`.`disbursement_date` <= '2026-09-30')) group by `l`.`loan_id`,`l`.`customer_id`,`l`.`branch`,`l`.`loan_product`,`l`.`loan_amount_zmw`,`l`.`disbursement_date` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-19  9:41:38
