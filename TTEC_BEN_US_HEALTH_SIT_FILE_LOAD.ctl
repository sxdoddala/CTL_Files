-- /* $Header: TTEC_BEN_US_HEALTH_SIT_FILE_LOAD.ctl 1.0 2011/03/11 mdodge ship $ */
--
-- /*== START ================================================================================================*\
--    Author: Michelle Dodge
--      Date: 11-MAR-2011
-- Call From: 
--      Desc: This is the control file which will load the HC Benefits US Health SIT
--            data into the ttec_ben_us_health_sit_stg staging table.
-- 
--     Parameter Description:
--       INFILE - Data file to be loaded
--            
--   Modification History:
-- 
--  Version    Date     Author   Description (Include Ticket#)
--  -------  --------  --------  ------------------------------------------------------------------------------
--      1.0  03/11/10  MDodge    R577703: US Health Assessment SIT Upload - Initial Version
--      1.0  19-July-2023  NXGARIKAPATI(ARGANO)              -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023  Upgrade Remediation 
-- \*== END ==================================================================================================*/

OPTIONS 
(SKIP=1, ERRORS=0, SILENT=(HEADER,FEEDBACK,DISCARDS))
LOAD DATA
INFILE *
APPEND
--INTO TABLE cust.ttec_ben_us_health_sit_stg  -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
INTO TABLE apps.ttec_ben_us_health_sit_stg    -- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
( EFFECTIVE_DATE      POSITION(1) "SUBSTRB(LTRIM(RTRIM(:EFFECTIVE_DATE)),1,15)"
, EMPLOYEE_NUMBER     "SUBSTRB(LTRIM(RTRIM(:EMPLOYEE_NUMBER)),1,30)"
, DATE_FROM           "SUBSTRB(LTRIM(RTRIM(:DATE_FROM)),1,15)"
, DATE_TO             "SUBSTRB(LTRIM(RTRIM(:DATE_TO)),1,15)"
, SEGMENT1            "SUBSTRB(LTRIM(RTRIM(:SEGMENT1)),1,150)"
--, SIT_ID              "cust.ttec_ben_us_health_sit_s.nextval"  -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
, SIT_ID              "apps.ttec_ben_us_health_sit_s.nextval"	-- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 	
, STATUS              CONSTANT "NEW"
, CREATE_REQUEST_ID   "FND_GLOBAL.CONC_REQUEST_ID"
, CREATION_DATE       SYSDATE
, CREATED_BY          "FND_GLOBAL.USER_ID"
, LAST_UPDATE_DATE    SYSDATE
, LAST_UPDATED_BY     "FND_GLOBAL.USER_ID"
)
