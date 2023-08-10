--  /************************************************************************************/
--  /*                                                                                  */
--  /*     Program Name: ttec_termload.ctl										*/
--  /*                                                                                  */
--  /*     Description:  																*/
--  /*	 			   					 	 				 	  	  	  			  	*/ 
--  /*                                                                                  *
--  /*                                                                                  */
--  /*     Modification Log:                                                            */
--  /*     Developer              Date      Description                                 */
--  /*     --------------------   --------  --------------------------------            */
--  /*     NXGARIKAPATI(ARGANO)   1.0      19-July-2023      R12.2 Upgrade Remediation*/
--  /************************************************************************************/
LOAD DATA 
INFILE '$CUST_TOP/data/temp/ttec_termload.csv'
TRUNCATE
--INTO TABLE CUST.ttec_termload_table  -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
INTO TABLE APPS.ttec_termload_table     -- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 
FIELDS TERMINATED BY '|'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(  	EMPLOYEE_NUMBER,	   
        TERM_REASON,                 
        TERM_DATE  
)
