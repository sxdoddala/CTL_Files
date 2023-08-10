--  /************************************************************************************/
--  /*                                                                                  */
--  /*     Program Name: adp_garn_interp_ldr.ctl										*/
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
TRUNCATE
--INTO TABLE TT_ADP.ADP_TTEC_ADP_GARN_RAW_STG -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
INTO TABLE APPS.ADP_TTEC_ADP_GARN_RAW_STG	-- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 
(record_text position(1:3000)
)
