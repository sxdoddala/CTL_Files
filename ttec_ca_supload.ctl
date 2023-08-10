--  /************************************************************************************/
--  /*                                                                                  */
--  /*     Program Name: ttec_ca_supload.ctl										*/
--  /*                                                                                  */
--  /*     Description:  																*/
--  /*	 			   					 	 				 	  	  	  			  	*/ 
--  /*                                                                                  *
--  /*                                                                                  */
--  /*     Modification Log:                                                            */
--  /*     Developer              Date      Description                                 */
--  /*     --------------------   --------  --------------------------------            */
--  /*/     NXGARIKAPATI(ARGANO)   1.0      19-July-2023      R12.2 Upgrade Remediation*/
--  /************************************************************************************/
LOAD DATA 
INFILE '$CUST_TOP/data/temp/ttec_ca_supload.csv'
TRUNCATE
--INTO TABLE CUST.TTEC_TEMP_SUPLOAD  -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
INTO TABLE APPS.TTEC_TEMP_SUPLOAD	-- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(       EMPLOYEE_NUMBER,
	SUP_NUMBER,
	EFFECTIVE_DATE
)
