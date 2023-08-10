--  /************************************************************************************/
--  /*                                                                                  */
--  /*     Program Name: tt_401k_load_temp.ctl										*/
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
INFILE '$CUST_TOP/data/BenefitInterface/tt_401k.csv'
BADFILE '$CUST_TOP/data/BenefitInterface/tt_401k.bad'
TRUNCATE
--INTO TABLE CUST.TT_TEMP_401K -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
INTO TABLE APPS.TT_TEMP_401K	-- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(    trx_type        ,
		ssn   		 ,
		first_name		,
		last_name    	,
		sort1           ,
		address1        ,
	    address2        ,
		city            ,
		state           ,
		zip             ,
		division_code1  ,
		division_code2  ,
		status          ,
		high_comp       ,
		key_stat        ,
		plan_entry      ,
		birth_date      ,
		hire_date       ,
		rehire_date     ,
		filler1         ,
		term_date       ,
		payroll_cycle_code   ,
		hours_ytd            ,
		cum_hours            ,
		rehire_months        ,
		money_type1          ,
		money_type2          ,		
		money_type3          ,
		money_type4          ,
		money_type5          ,
		money_type6          ,		
		money_type7          ,
		money_type8          ,
		money_type9          ,
		money_type10         ,		
		money_type11         ,
		money_type12         ,
		money_type13         ,
		money_type14         ,		
		money_type15         ,
		loan1                ,
		loan2                ,		
		loan3                ,
		loan4                ,
		loan5                ,
		loan6                ,		
		loan7                ,
		loan8                ,
		loan9                ,
		loan10               ,		
        comp1                ,
		comp2                ,
		comp3                
)
