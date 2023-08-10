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
--  /*/     NXGARIKAPATI(ARGANO)   1.0      19-July-2023      R12.2 Upgrade Remediation*/
--  /************************************************************************************/
OPTIONS 
(ERRORS=0, SILENT=(HEADER,FEEDBACK,DISCARDS))
LOAD DATA
INFILE *
APPEND

-- Line 3 -> Invoice Header
--INTO TABLE cust.ttec_ar_inv_hdr_import_stg   -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
INTO TABLE apps.ttec_ar_inv_hdr_import_stg    -- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 
WHEN TRX_TYPE = 'Invoice'      -- Column Heading
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
( TRX_DATE            POSITION(1) "SUBSTRB(LTRIM(RTRIM(:TRX_DATE)),1,240)"
, TRX_NUMBER          "SUBSTRB(LTRIM(RTRIM(:TRX_NUMBER)),1,240)"
, CLIENT_NUMBER       "SUBSTRB(LTRIM(RTRIM(:CLIENT_NUMBER)),1,240)"
, CLIENT_NAME         "SUBSTRB(LTRIM(RTRIM(:CLIENT_NAME)),1,240)"
, SITE_NUMBER         "SUBSTRB(LTRIM(RTRIM(:SITE_NUMBER)),1,240)"
, PURCHASE_ORDER      "SUBSTRB(LTRIM(RTRIM(:PURCHASE_ORDER)),1,240)"
, COMMENTS            "SUBSTRB(LTRIM(RTRIM(:COMMENTS)),1,500)"
, FILLER1            
, FILLER2
, TERM_NAME           "SUBSTRB(LTRIM(RTRIM(:TERM_NAME)),1,240)"
, CURRENCY_CODE       "SUBSTRB(LTRIM(RTRIM(:CURRENCY_CODE)),1,240)"
, EXCHANGE_RATE       "SUBSTRB(LTRIM(RTRIM(:EXCHANGE_RATE)),1,240)"
, VERSION             "SUBSTRB(LTRIM(RTRIM(:VERSION)),1,240)"
, TRX_TYPE            "SUBSTRB(LTRIM(RTRIM(:TRX_TYPE)),1,240)"
, FILLER3             "SUBSTRB(LTRIM(RTRIM(:FILLER3)),1,240)" 
, FILLER4             "SUBSTRB(LTRIM(RTRIM(:FILLER4)),1,240)" 
, TTEC_TICKET         NULLIF TTEC_TICKET=blanks "SUBSTRB(LTRIM(RTRIM(:TTEC_TICKET)),1,50)" -- added by C. Chan Dec 07, 2018
, SERVICE_DATE        "SUBSTRB(LTRIM(RTRIM(:SERVICE_DATE)),1,240)"
--, INV_HDR_ID          "cust.ttec_ar_inv_hdr_import_s.nextval"  -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
, INV_HDR_ID          "apps.ttec_ar_inv_hdr_import_s.nextval"  -- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 
, STATUS              CONSTANT "NEW"
, INTERFACE_LINE_CONTEXT CONSTANT "EXCEL"
, BATCH_SOURCE_NAME   CONSTANT "EXCEL INV Import"
, TRANSACTION_TYPE    CONSTANT "EXCEL INV"
, CREATE_REQUEST_ID   "FND_GLOBAL.CONC_REQUEST_ID"
, CREATION_DATE       SYSDATE
, CREATED_BY          "FND_GLOBAL.USER_ID"
, LAST_UPDATE_DATE    SYSDATE
, LAST_UPDATED_BY     "FND_GLOBAL.USER_ID"
)

-- Line 6+ -> Invoice Lines
--INTO TABLE cust.ttec_ar_inv_line_import_stg  -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
INTO TABLE cust.ttec_ar_inv_line_import_stg   -- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 
WHEN LINE_TYPE = 'LINE'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  LINE_NUMBER         POSITION(1) NULLIF LINE_NUMBER=blanks "SUBSTRB(LTRIM(RTRIM(:LINE_NUMBER)),1,240)"
, LINE_TYPE           "SUBSTRB(LTRIM(RTRIM(:LINE_TYPE)),1,240)"
, ITEM_CATEGORY       "SUBSTRB(LTRIM(RTRIM(:ITEM_CATEGORY)),1,240)"
, LINE_DESCRIPTION    "SUBSTRB(LTRIM(RTRIM(:LINE_DESCRIPTION)),1,500)"                         -- 1.1 
, UOM_NAME            "SUBSTRB(LTRIM(RTRIM(:UOM_NAME)),1,240)"
, QUANTITY            NULLIF QUANTITY=blanks "SUBSTRB(TRANSLATE(LTRIM(RTRIM(:QUANTITY)),'()$,','-'),1,240)"
, UNIT_SELLING_PRICE  NULLIF UNIT_SELLING_PRICE=blanks "SUBSTRB(TRANSLATE(LTRIM(RTRIM(:UNIT_SELLING_PRICE)),'()$,','-'),1,240)"
, TAX_CODE            "SUBSTRB(LTRIM(RTRIM(:TAX_CODE)),1,240)"
, LOCATION            "SUBSTRB(LTRIM(RTRIM(:LOCATION)),1,240)"
, CLIENT              "SUBSTRB(LTRIM(RTRIM(:CLIENT)),1,240)"
, DEPARTMENT          "SUBSTRB(LTRIM(RTRIM(:DEPARTMENT)),1,240)"
, ACCOUNT             "SUBSTRB(LTRIM(RTRIM(:ACCOUNT)),1,240)"
, GCC_FUTURE1         "SUBSTRB(LTRIM(RTRIM(:GCC_FUTURE1)),1,240)"
, GCC_FUTURE2         "SUBSTRB(LTRIM(RTRIM(:GCC_FUTURE2)),1,240)"
, DEBIT_AMOUNT        NULLIF DEBIT_AMOUNT=blanks "SUBSTRB(TRANSLATE(LTRIM(RTRIM(:DEBIT_AMOUNT)),'a$,-','a'),1,240)"
, CREDIT_AMOUNT       NULLIF CREDIT_AMOUNT=blanks "SUBSTRB(TRANSLATE(LTRIM(RTRIM(:CREDIT_AMOUNT)),'a$,-','a'),1,240)"
, REASON_CODE         NULLIF REASON_CODE=blanks "SUBSTRB(LTRIM(RTRIM(:REASON_CODE)),1,30)" -- added by C. Chan Aug 03, 2016
, REASON_CODE_MEANING  NULLIF REASON_CODE_MEANING=blanks "SUBSTRB(LTRIM(RTRIM(:REASON_CODE_MEANING)),1,80)" -- added by C. Chan Aug 03, 2016
, TRANSLATED_DESC     NULLIF TRANSLATED_DESC=blanks "SUBSTRB(LTRIM(RTRIM(:TRANSLATED_DESC)),1,1000)" -- added by C. Chan Aug 03, 2016
, BUSINESS_NAME         NULLIF BUSINESS_NAME=blanks "SUBSTRB(LTRIM(RTRIM(:BUSINESS_NAME)),1,150)" -- added by C. Chan Aug 08, 2017
, REFERENCE1  		NULLIF REFERENCE1=blanks "SUBSTRB(LTRIM(RTRIM(:REFERENCE1)),1,150)" -- added by C. Chan Aug 08, 2017
, REFERENCE2     	NULLIF REFERENCE2=blanks "SUBSTRB(LTRIM(RTRIM(:REFERENCE2)),1,150)" -- added by C. Chan Aug 08, 2017
--, INV_HDR_ID          "cust.ttec_ar_inv_hdr_import_s.currval"   -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
--, INV_LINE_ID         "cust.ttec_ar_inv_line_import_s.nextval"   -- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 
, INV_HDR_ID          "apps.ttec_ar_inv_hdr_import_s.currval"
, INV_LINE_ID         "apps.ttec_ar_inv_line_import_s.nextval"
, STATUS              CONSTANT "NEW"
, CREATE_REQUEST_ID   "FND_GLOBAL.CONC_REQUEST_ID"
, CREATION_DATE       SYSDATE
, CREATED_BY          "FND_GLOBAL.USER_ID"
, LAST_UPDATE_DATE    SYSDATE
, LAST_UPDATED_BY     "FND_GLOBAL.USER_ID"
)

-- Line 6+ -> Invoice Lines
--INTO TABLE cust.ttec_ar_inv_line_import_stg R12.2
INTO TABLE apps.ttec_ar_inv_line_import_stg
WHEN LINE_TYPE = 'TAX'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  LINE_NUMBER         POSITION(1) NULLIF LINE_NUMBER=blanks "SUBSTRB(LTRIM(RTRIM(:LINE_NUMBER)),1,240)"
, LINE_TYPE           "SUBSTRB(LTRIM(RTRIM(:LINE_TYPE)),1,240)"
, ITEM_CATEGORY       "SUBSTRB(LTRIM(RTRIM(:ITEM_CATEGORY)),1,240)"
, LINE_DESCRIPTION    "SUBSTRB(LTRIM(RTRIM(:LINE_DESCRIPTION)),1,500)"                         -- 1.1 
, UOM_NAME            "SUBSTRB(LTRIM(RTRIM(:UOM_NAME)),1,240)"
, QUANTITY            NULLIF QUANTITY=blanks "SUBSTRB(TRANSLATE(LTRIM(RTRIM(:QUANTITY)),'()$,','-'),1,240)"
, UNIT_SELLING_PRICE  NULLIF UNIT_SELLING_PRICE=blanks "SUBSTRB(TRANSLATE(LTRIM(RTRIM(:UNIT_SELLING_PRICE)),'()$,','-'),1,240)"
, TAX_CODE            "SUBSTRB(LTRIM(RTRIM(:TAX_CODE)),1,240)"
, LOCATION            "SUBSTRB(LTRIM(RTRIM(:LOCATION)),1,240)"
, CLIENT              "SUBSTRB(LTRIM(RTRIM(:CLIENT)),1,240)"
, DEPARTMENT          "SUBSTRB(LTRIM(RTRIM(:DEPARTMENT)),1,240)"
, ACCOUNT             "SUBSTRB(LTRIM(RTRIM(:ACCOUNT)),1,240)"
, GCC_FUTURE1         "SUBSTRB(LTRIM(RTRIM(:GCC_FUTURE1)),1,240)"
, GCC_FUTURE2         "SUBSTRB(LTRIM(RTRIM(:GCC_FUTURE2)),1,240)"
, DEBIT_AMOUNT        NULLIF DEBIT_AMOUNT=blanks "SUBSTRB(TRANSLATE(LTRIM(RTRIM(:DEBIT_AMOUNT)),'a$,-','a'),1,240)"
, CREDIT_AMOUNT       NULLIF CREDIT_AMOUNT=blanks "SUBSTRB(TRANSLATE(LTRIM(RTRIM(:CREDIT_AMOUNT)),'a$,-','a'),1,240)"
, REASON_CODE         NULLIF REASON_CODE=blanks "SUBSTRB(LTRIM(RTRIM(:REASON_CODE)),1,30)" -- added by C. Chan Aug 03, 2016
, REASON_CODE_MEANING  NULLIF REASON_CODE_MEANING=blanks "SUBSTRB(LTRIM(RTRIM(:REASON_CODE_MEANING)),1,80)" -- added by C. Chan Aug 03, 2016
, TRANSLATED_DESC     NULLIF TRANSLATED_DESC=blanks "SUBSTRB(LTRIM(RTRIM(:TRANSLATED_DESC)),1,1000)" -- added by C. Chan Aug 03, 2016
, BUSINESS_NAME         NULLIF BUSINESS_NAME=blanks "SUBSTRB(LTRIM(RTRIM(:BUSINESS_NAME)),1,150)" -- added by C. Chan Aug 08, 2017
, REFERENCE1  		NULLIF REFERENCE1=blanks "SUBSTRB(LTRIM(RTRIM(:REFERENCE1)),1,150)" -- added by C. Chan Aug 08, 2017
, REFERENCE2     	NULLIF REFERENCE2=blanks "SUBSTRB(LTRIM(RTRIM(:REFERENCE2)),1,150)" -- added by C. Chan Aug 08, 2017
--, INV_HDR_ID          "cust.ttec_ar_inv_hdr_import_s.currval"  -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
--, INV_LINE_ID         "cust.ttec_ar_inv_line_import_s.nextval"  -- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 
, INV_HDR_ID          "apps.ttec_ar_inv_hdr_import_s.currval"
, INV_LINE_ID         "apps.ttec_ar_inv_line_import_s.nextval"
, STATUS              CONSTANT "NEW"
, CREATE_REQUEST_ID   "FND_GLOBAL.CONC_REQUEST_ID"
, CREATION_DATE       SYSDATE
, CREATED_BY          "FND_GLOBAL.USER_ID"
, LAST_UPDATE_DATE    SYSDATE
, LAST_UPDATED_BY     "FND_GLOBAL.USER_ID"
)

-- Line 6+ -> Invoice Lines
--INTO TABLE cust.ttec_ar_inv_line_import_stg  -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
INTO TABLE apps.ttec_ar_inv_line_import_stg    -- Added code by NXGARIKAPATI-ARGANO, 19/07/2023  
WHEN LINE_TYPE = 'FREIGHT'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  LINE_NUMBER         POSITION(1) NULLIF LINE_NUMBER=blanks "SUBSTRB(LTRIM(RTRIM(:LINE_NUMBER)),1,240)"
, LINE_TYPE           "SUBSTRB(LTRIM(RTRIM(:LINE_TYPE)),1,240)"
, ITEM_CATEGORY       "SUBSTRB(LTRIM(RTRIM(:ITEM_CATEGORY)),1,240)"
, LINE_DESCRIPTION    "SUBSTRB(LTRIM(RTRIM(:LINE_DESCRIPTION)),1,500)"                         -- 1.1
, UOM_NAME            "SUBSTRB(LTRIM(RTRIM(:UOM_NAME)),1,240)"
, QUANTITY            NULLIF QUANTITY=blanks "SUBSTRB(TRANSLATE(LTRIM(RTRIM(:QUANTITY)),'()$,','-'),1,240)"
, UNIT_SELLING_PRICE  NULLIF UNIT_SELLING_PRICE=blanks "SUBSTRB(TRANSLATE(LTRIM(RTRIM(:UNIT_SELLING_PRICE)),'()$,','-'),1,240)"
, TAX_CODE            "SUBSTRB(LTRIM(RTRIM(:TAX_CODE)),1,240)"
, LOCATION            "SUBSTRB(LTRIM(RTRIM(:LOCATION)),1,240)"
, CLIENT              "SUBSTRB(LTRIM(RTRIM(:CLIENT)),1,240)"
, DEPARTMENT          "SUBSTRB(LTRIM(RTRIM(:DEPARTMENT)),1,240)"
, ACCOUNT             "SUBSTRB(LTRIM(RTRIM(:ACCOUNT)),1,240)"
, GCC_FUTURE1         "SUBSTRB(LTRIM(RTRIM(:GCC_FUTURE1)),1,240)"
, GCC_FUTURE2         "SUBSTRB(LTRIM(RTRIM(:GCC_FUTURE2)),1,240)"
, DEBIT_AMOUNT        NULLIF DEBIT_AMOUNT=blanks "SUBSTRB(TRANSLATE(LTRIM(RTRIM(:DEBIT_AMOUNT)),'a$,-','a'),1,240)"
, CREDIT_AMOUNT       NULLIF CREDIT_AMOUNT=blanks "SUBSTRB(TRANSLATE(LTRIM(RTRIM(:DEBIT_AMOUNT)),'a$,-','a'),1,240)"
, REASON_CODE         NULLIF REASON_CODE=blanks "SUBSTRB(LTRIM(RTRIM(:REASON_CODE)),1,30)" -- added by C. Chan Aug 03, 2016
, REASON_CODE_MEANING  NULLIF REASON_CODE_MEANING=blanks "SUBSTRB(LTRIM(RTRIM(:REASON_CODE_MEANING)),1,80)" -- added by C. Chan Aug 03, 2016
, TRANSLATED_DESC     NULLIF TRANSLATED_DESC=blanks "SUBSTRB(LTRIM(RTRIM(:TRANSLATED_DESC)),1,1000)" -- added by C. Chan Aug 03, 2016
, BUSINESS_NAME         NULLIF BUSINESS_NAME=blanks "SUBSTRB(LTRIM(RTRIM(:BUSINESS_NAME)),1,150)" -- added by C. Chan Aug 08, 2017
, REFERENCE1  		NULLIF REFERENCE1=blanks "SUBSTRB(LTRIM(RTRIM(:REFERENCE1)),1,150)" -- added by C. Chan Aug 08, 2017
, REFERENCE2     	NULLIF REFERENCE2=blanks "SUBSTRB(LTRIM(RTRIM(:REFERENCE2)),1,150)" -- added by C. Chan Aug 08, 2017
--, INV_HDR_ID          "cust.ttec_ar_inv_hdr_import_s.currval"  -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
--, INV_LINE_ID         "cust.ttec_ar_inv_line_import_s.nextval" -- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 
, INV_HDR_ID          "apps.ttec_ar_inv_hdr_import_s.currval"
, INV_LINE_ID         "apps.ttec_ar_inv_line_import_s.nextval"
, STATUS              CONSTANT "NEW"
, CREATE_REQUEST_ID   "FND_GLOBAL.CONC_REQUEST_ID"
, CREATION_DATE       SYSDATE
, CREATED_BY          "FND_GLOBAL.USER_ID"
, LAST_UPDATE_DATE    SYSDATE
, LAST_UPDATED_BY     "FND_GLOBAL.USER_ID"
)

-- Line 6+ -> Invoice Lines
--INTO TABLE cust.ttec_ar_inv_line_import_stg -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
INTO TABLE apps.ttec_ar_inv_line_import_stg    -- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 
WHEN LINE_TYPE = 'CHARGES'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  LINE_NUMBER         POSITION(1) NULLIF LINE_NUMBER=blanks "SUBSTRB(LTRIM(RTRIM(:LINE_NUMBER)),1,240)"
, LINE_TYPE           "SUBSTRB(LTRIM(RTRIM(:LINE_TYPE)),1,240)"
, ITEM_CATEGORY       "SUBSTRB(LTRIM(RTRIM(:ITEM_CATEGORY)),1,240)"
, LINE_DESCRIPTION    "SUBSTRB(LTRIM(RTRIM(:LINE_DESCRIPTION)),1,500)"                         -- 1.1 
, UOM_NAME            "SUBSTRB(LTRIM(RTRIM(:UOM_NAME)),1,240)"
, QUANTITY            NULLIF QUANTITY=blanks "SUBSTRB(TRANSLATE(LTRIM(RTRIM(:QUANTITY)),'()$,','-'),1,240)"
, UNIT_SELLING_PRICE  NULLIF UNIT_SELLING_PRICE=blanks "SUBSTRB(TRANSLATE(LTRIM(RTRIM(:UNIT_SELLING_PRICE)),'()$,','-'),1,240)"
, TAX_CODE            "SUBSTRB(LTRIM(RTRIM(:TAX_CODE)),1,240)"
, LOCATION            "SUBSTRB(LTRIM(RTRIM(:LOCATION)),1,240)"
, CLIENT              "SUBSTRB(LTRIM(RTRIM(:CLIENT)),1,240)"
, DEPARTMENT          "SUBSTRB(LTRIM(RTRIM(:DEPARTMENT)),1,240)"
, ACCOUNT             "SUBSTRB(LTRIM(RTRIM(:ACCOUNT)),1,240)"
, GCC_FUTURE1         "SUBSTRB(LTRIM(RTRIM(:GCC_FUTURE1)),1,240)"
, GCC_FUTURE2         "SUBSTRB(LTRIM(RTRIM(:GCC_FUTURE2)),1,240)"
, DEBIT_AMOUNT        NULLIF DEBIT_AMOUNT=blanks "SUBSTRB(TRANSLATE(LTRIM(RTRIM(:DEBIT_AMOUNT)),'a$,-','a'),1,240)"
, CREDIT_AMOUNT       NULLIF CREDIT_AMOUNT=blanks "SUBSTRB(TRANSLATE(LTRIM(RTRIM(:DEBIT_AMOUNT)),'a$,-','a'),1,240)"
, REASON_CODE         NULLIF REASON_CODE=blanks "SUBSTRB(LTRIM(RTRIM(:REASON_CODE)),1,30)" -- added by C. Chan Aug 03, 2016
, REASON_CODE_MEANING  NULLIF REASON_CODE_MEANING=blanks "SUBSTRB(LTRIM(RTRIM(:REASON_CODE_MEANING)),1,80)" -- added by C. Chan Aug 03, 2016
, TRANSLATED_DESC     NULLIF TRANSLATED_DESC=blanks "SUBSTRB(LTRIM(RTRIM(:TRANSLATED_DESC)),1,1000)" -- added by C. Chan Aug 03, 2016
, BUSINESS_NAME         NULLIF BUSINESS_NAME=blanks "SUBSTRB(LTRIM(RTRIM(:BUSINESS_NAME)),1,150)" -- added by C. Chan Aug 08, 2017
, REFERENCE1  		NULLIF REFERENCE1=blanks "SUBSTRB(LTRIM(RTRIM(:REFERENCE1)),1,150)" -- added by C. Chan Aug 08, 2017
, REFERENCE2     	NULLIF REFERENCE2=blanks "SUBSTRB(LTRIM(RTRIM(:REFERENCE2)),1,150)" -- added by C. Chan Aug 08, 2017
--, INV_HDR_ID          "cust.ttec_ar_inv_hdr_import_s.currval"   -- Commented code by NXGARIKAPATI-ARGANO, 19/07/2023 
--, INV_LINE_ID         "cust.ttec_ar_inv_line_import_s.nextval"   -- Added code by NXGARIKAPATI-ARGANO, 19/07/2023 
, INV_HDR_ID          "apps.ttec_ar_inv_hdr_import_s.currval"
, INV_LINE_ID         "apps.ttec_ar_inv_line_import_s.nextval"
, STATUS              CONSTANT "NEW"
, CREATE_REQUEST_ID   "FND_GLOBAL.CONC_REQUEST_ID"
, CREATION_DATE       SYSDATE
, CREATED_BY          "FND_GLOBAL.USER_ID"
, LAST_UPDATE_DATE    SYSDATE
, LAST_UPDATED_BY     "FND_GLOBAL.USER_ID"
)




