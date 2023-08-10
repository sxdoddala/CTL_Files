--  /************************************************************************************/
--  /*                                                                                  */
--  /*     Program Name: load_bee_source_file.ctl										*/
--  /*                                                                                  */
--  /*     Description:  This script loads the source csv file into the BEE Interface	*/
--  /*	 			   staging table.	 	 				 	  	  	  			  	*/ 
--  /*                                                                                  */
--  /*     Input/Output Parameters:   None                                              */ 
--  /*                                                                                  */
--  /*     Tables Accessed:  None														*/
--  /*                                                                                  */
--  /*     Tables Modified:  NONE 													  	*/
--  /*                                                                                  */
--  /*     Procedures Called: None													  	*/
--  /*                                                                                  */
--  /*     Created by:        Chan Kang                                                 */ 
--  /*                        PricewaterhouseCoopers LLP                                */
--  /*     Date:              September 25,2002                                         */
--  /*                                                                                  */
--  /*     Modification Log:                                                            */
--  /*     Developer              Date      Description                                 */
--  /*     --------------------   --------  --------------------------------            */
--  /*      D.Thakker		   12/20    Changed REPLACE to APPEND	                           
--  /*/    NXGARIKAPATI(ARGANO)   1.0      19-July-2023      R12.2 Upgrade Remediation*/                                                 */
--  /************************************************************************************/
 
LOAD DATA
INFILE '$CUST_TOP/data/BEE_interface/BEE.csv'
BADFILE '$CUST_TOP/data/BEE_interface/BEE.bad'
DISCARDFILE '$CUST_TOP/data/BEE_interface/BEE.dsc'
APPEND
--INTO TABLE cust.tt_bee_interface_stage    -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
INTO TABLE apps.tt_bee_interface_stage		-- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 
FIELDS TERMINATED BY ','
TRAILING NULLCOLS
(
BATCH_NAME ":BATCH_NAME",
EMPLOYEE_NUMBER ":EMPLOYEE_NUMBER",    
ELEMENT_NAME ":ELEMENT_NAME",
VALUE1 ":VALUE1",        
VALUE2 ":VALUE2",        
VALUE3 ":VALUE3",        
VALUE4 ":VALUE4",        
VALUE5 ":VALUE5",        
VALUE6 ":VALUE6",        
VALUE7 ":VALUE7",        
VALUE8 ":VALUE8",        
VALUE9 ":VALUE9",        
VALUE10 ":VALUE10",        
VALUE11 ":VALUE11",        
VALUE12 ":VALUE12",        
VALUE13 ":VALUE13",        
VALUE14 ":VALUE14",        
VALUE15 ":VALUE15"        
)
