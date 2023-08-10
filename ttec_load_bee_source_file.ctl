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
--  /*      D.Thakker		   12/20    Changed REPLACE to APPEND	                */
--  /*      I.Konak            12/28    Added OPTIONALLY ENCLOSED BY '"'                */
--  /*      I.Konak            01/06    Added BUSINESS GROUP and ROW WHO columns        */
--  /*/     I.KONAK            03/06    Increased error limit                           */
--  /*/     C.CHAN             05/27    Change infile to * allowing filename to pass in */
--  /*/                                 as parameter. also added columns SITE_NAME.     */
--  /*/                                 BEE_EFFECTIVE_DATE and ASSIGNMENT_NUMBER        */
--  /*/                                 based on new requirement requested by user group*/
--  /*/                                 while fully automate the BEE LOAD INTERFACE     */
--  /*                                                                                  */
--  /*/     C.CHAN             02/14/08 WO#407423 - adding effective start/end dates    */
--  /*/     N.Mondada	       15/09/08 TT#1014154 - Allowing blank values for VALUE1   */
--  /*/     NXGARIKAPATI(ARGANO)   1.0      19-July-2023      R12.2 Upgrade Remediation*/
--  /************************************************************************************/

options 
(silent=(header,feedback,discards)
 errors = 0 )
LOAD DATA
INFILE *
APPEND
--INTO TABLE cust.tt_bee_interface_stage  -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
INTO TABLE apps.tt_bee_interface_stage  -- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 
WHEN ELEMENT_NAME <> 'ELEMENT NAME' and ELEMENT_NAME <> 'Element Name' --Modified by NMondada
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
BUSINESS_GROUP "rtrim(ltrim(:BUSINESS_GROUP))",
SITE_NAME "rtrim(ltrim(:SITE_NAME))",
BATCH_NAME "substr(rtrim(ltrim(:BATCH_NAME)),1,30)",
BEE_EFFECTIVE_DATE "to_char(to_date(UPPER(:BEE_EFFECTIVE_DATE),'YYYY-MON-DD'))",
EMPLOYEE_NAME "rtrim(ltrim(:EMPLOYEE_NAME))",
ASSIGNMENT_NUMBER "rtrim(ltrim(:ASSIGNMENT_NUMBER))",  
ELEMENT_NAME "rtrim(ltrim(:ELEMENT_NAME))",
VALUE1 NULLIF VALUE1=BLANKS ":VALUE1",        --Modified by NMondada
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
VALUE15 ":VALUE15",
EFFECTIVE_START_DATE "to_char(to_date(UPPER(:EFFECTIVE_START_DATE),'YYYY-MON-DD'))",
EFFECTIVE_END_DATE "to_char(to_date(UPPER(:EFFECTIVE_END_DATE),'YYYY-MON-DD'))",
CREATION_DATE   sysdate,
CREATED_BY "FND_GLOBAL.USER_ID",
--LAST_UPDATE_DATE  sysdate 
--LAST_UPDATED_BY,
CREATE_REQUEST_ID  "FND_GLOBAL.CONC_REQUEST_ID"   
)
