-- /* $Header: ttec_mex_gl_iface_load_file.ctl 1.0 2009/03/05 mdodge ship $ */
--
-- /*== START ================================================================================================*\
--    Author: Michelle Dodge
--      Date: 05-MAR-2009
-- Call From: <Concurrent program name>, Report Name, Form Name   
--      Desc: This is the control file which will load the Mexico Payroll GL Interface
--            data into the ttec_mex_gl_iface_stg staging table
-- 
--     Parameter Description:
--       INFILE - Data file to be loaded
--            
--   Modification History:
-- 
--  Version    Date     Author   Description (Include Ticket#)
--  -------  --------  --------  ------------------------------------------------------------------------------
--      1.0  03/05/09  MDodge    WO #561427 - Initial Version
--      1.0  19/07/23  NXGARIKAPATI(ARGANO) R12.2 Upgrade Remediation
-- 
-- \*== END ==================================================================================================*/

OPTIONS 
(SILENT=(HEADER,FEEDBACK,DISCARDS) 
 ERRORS = 0 )
LOAD DATA
INFILE *
REPLACE
--INTO TABLE cust.ttec_mex_gl_iface_stg -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
INTO TABLE apps.ttec_mex_gl_iface_stg	-- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 
WHEN (1) = 'P'
(
  status            CONSTANT                         'MEX PAY HDR'
, accounting_date   POSITION(3:10)  DATE "YYYYMMDD"
)

--INTO TABLE cust.ttec_mex_gl_iface_stg  -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
INTO TABLE apps.ttec_mex_gl_iface_stg	-- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 
WHEN (1) = 'M' and (35) = '1'
(
  status                            CONSTANT         'MEX PAY LINE'
, actual_flag                       CONSTANT         'A'
, user_currency_conversion_type     CONSTANT         'Spot'
, segment1          POSITION(3:7)   CHAR
, segment2          POSITION(8:11)  CHAR
, segment3          POSITION(12:14) CHAR
, segment4          POSITION(15:18) CHAR
, segment5                          CONSTANT         '0000'
, segment6                          CONSTANT         '0000'
, entered_dr        POSITION(37:52) DECIMAL EXTERNAL
)

--INTO TABLE cust.ttec_mex_gl_iface_stg  R12.2
INTO TABLE apps.ttec_mex_gl_iface_stg
WHEN (1) = 'M' and (35) = '2'
(
  status                            CONSTANT         'MEX PAY LINE'
, actual_flag                       CONSTANT         'A'
, user_currency_conversion_type     CONSTANT         'Spot'
, segment1          POSITION(3:7)   CHAR
, segment2          POSITION(8:11)  CHAR
, segment3          POSITION(12:14) CHAR
, segment4          POSITION(15:18) CHAR
, segment5                          CONSTANT         '0000'
, segment6                          CONSTANT         '0000'
, entered_cr        POSITION(37:52) DECIMAL EXTERNAL
)
