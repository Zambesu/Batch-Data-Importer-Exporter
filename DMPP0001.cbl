      *----------------------------------------------------------------*
      * PROGRAM..: DMP0001
      * AUTHOR...: MATEUS RIBEIRO
      * DATE.....: 19\01\2025
      * PURPOSE..: TO IMPORT OR EXPORT DATA BETWEEN A FILE (CSV OR FIXED
      * -          WIDTH) AND A DB2 DATABASE (CAN BE ADAPTED TO OTHER
      *            DATABASES WITH MINOR MODIFICATIONS).
      *----------------------------------------------------------------*
      * VERSION..: VRS0001 - IMPLEMENTATION.
      *----------------------------------------------------------------*
      ******************************************************************
       IDENTIFICATION                  DIVISION.
      ******************************************************************
       PROGRAM-ID. DMPP0001.
      *
      * INPUT FILE:
      *-------------
      * DMP0001I - CSV FILE WITH ALL THE DATA THAT WILL BE UPLOADED
      *            INTO THE DATABASE.
      *
      * OUTPUT FILE:
      *-------------
      * DMP0001O - CSV FILE WITH ALL THE DATA FROM THE DATABASE TABLE.
      *
      ******************************************************************
       ENVIRONMENT                     DIVISION.
      ******************************************************************
      *
      *----------------------------------------------------------------*
       INPUT-OUTPUT                    SECTION.
      *----------------------------------------------------------------*
       FILE-CONTROL.
      *
           SELECT DMP0001I ASSIGN TO  UT-S-DMP0001I.
           SELECT DMP0001O ASSIGN TO  UT-S-DMP0001O.
      *----------------------------------------------------------------*
      *
      ******************************************************************
       DATA                            DIVISION.
      ******************************************************************
      *
      *----------------------------------------------------------------*
       FILE                            SECTION.
      *----------------------------------------------------------------*
      *
       FD  DMP0001I
           BLOCK 0
           RECORDING F
           RECORD 88.
       01  DMP0001I-FD                 PIC X(088).
      *
       FD  DMP0001O
           BLOCK 0
           RECORDING F
           RECORD 88.
       01  DMP0001O-FD                 PIC X(088).
      *
      *----------------------------------------------------------------*
       WORKING-STORAGE                 SECTION.
      *----------------------------------------------------------------*
      *
      *------------------- P L A C E H O L D E R S --------------------*
      *
       77  PLCH-CURR-DATE              PIC 9(008)     VALUE ZEROS.
           03 PLCH-DATE-YYYY           PIC 9(002)     VALUE ZEROS.
           03 PLCH-DATE-MM             PIC 9(002)     VALUE ZEROS.
           03 PLCH-DATE-DD             PIC 9(002)     VALUE ZEROS.
      *
      *-------------------------- F L A G S ---------------------------*
      *
       77  FLG-END-INPUT-FILE          PIC X(001)     VALUE SPACES.
      *
      *----------------------- C O U N T E R S ------------------------*
      *
       77  CNT-LOAD-INPUT              PIC 9(017)     VALUE ZEROS.
       77  CNT-READ-INPUT              PIC 9(017)     VALUE ZEROS.
       77  CNT-WRITE-OUTPUT            PIC 9(017)     VALUE ZEROS.
       77  CNT-UNLO-TABLE              PIC 9(017)     VALUE ZEROS.
       77  CNT-WRIT-OUTPUT             PIC 9(017)     VALUE ZEROS.
      *
      *----------------- F I L E - S T R U C T U R E S ----------------*
      *
       01  DMP-FILE-REGISTER           PIC X(088).
      *
       01  FILLER REDEFINES DMP-FILE-REGISTER.
           03 DMP-CLIENT-ID            PIC 9(004).
           03 FILLER                   PIC X(001)     VALUE ','.
           03 DMP-NAME                 PIC X(020).
           03 FILLER                   PIC X(001)     VALUE ','.
           03 DMP-EMAIL                PIC X(030).
           03 FILLER                   PIC X(001)     VALUE ','.
           03 DMP-PHONE                PIC 9(008).
           03 FILLER                   PIC X(001)     VALUE ','.
           03 DMP-ACC-TYPE             PIC 9(002).
           03 FILLER                   PIC X(001)     VALUE ','.
           03 DMP-ACC-BALANCE          PIC 9(015)V99.
      *
      *---------------- T A B L E - S T R U C T U R E S ---------------*
      *
       01  DMP-TABLE-REGISTER.
           03 TB_CLIENT_ID             PIC 9(004).
           03 FILLER                   PIC X(001)     VALUE ','.
           03 TB_NAME                  PIC X(020).
           03 FILLER                   PIC X(001)     VALUE ','.
           03 TB_EMAIL                 PIC X(030).
           03 FILLER                   PIC X(001)     VALUE ','.
           03 TB_PHONE                 PIC 9(008).
           03 FILLER                   PIC X(001)     VALUE ','.
           03 TB_ACC_TYPE              PIC 9(002).
           03 FILLER                   PIC X(001)     VALUE ','.
           03 TB_ACC_BALANCE           PIC 9(015)V99.
      *
      *----------------------------------------------------------------*
       LOCAL-STORAGE                   SECTION.
      *----------------------------------------------------------------*
      *
           EXEC SQL
               INCLUDE SQLCA
           END-EXEC.
      *
      *----------------------------------------------------------------*
       LINKAGE                         SECTION.
      *----------------------------------------------------------------*
      *
       01  DMP-PARM.
           03 DMP-FLAG                 PIC 9(001).
      *
      ******************************************************************
       PROCEDURE                       DIVISION USING DMP-PARM.
      ******************************************************************
      *
      *---------------------------------------*
       000000-MAIN-ROUTINE             SECTION.
      *---------------------------------------*
      *
           PERFORM 100000-START.
           PERFORM 200000-PROCESSING.
           PERFORM 800000-FINALIZATION.
      *
       000099-END-MAIN-PROCEDURE.
           STOP RUN.
      *
      *---------------------------------------*
       100000-START                    SECTION.
      *---------------------------------------*
      *
           ACCEPT PLCH-CURR-DATE       FROM DATE YYYYMMDD
      *
           DISPLAY '***************************************************'
           DISPLAY '*** DMP0001 - STARTING EXECUTION'
           DISPLAY '*** CURRENT DATE...: '
           PLCH-DATE-MM '/' PLCH-DATE-DD '/' PLCH-DATE-YYYY.
      *
           IF DMP-FLAG                 EQUAL 1
              DISPLAY '*** DATA EXPORT ***'
           ELSE
              IF DMP-FLAG              EQUAL 2
                 DISPLAY '*** DATA IMPORT ***'
              ELSE
                 PERFORM 999001-ERROR-001
              END-IF
           END-IF.
      *
       100099-END-START.
           EXIT.
      *
      *---------------------------------------*
       200000-PROCESSING               SECTION.
      *---------------------------------------*
      *
           EVALUATE DMP-FLAG
           WHEN 1
             PERFORM 300000-EXPORT
           WHEN 2
             PERFORM 400000-IMPORT
           WHEN OTHER
             PERFORM 999001-ERROR-001
           END-EVALUATE.
      *
       200099-END-PROCESSING.
           EXIT.
      *
      *---------------------------------------*
       300000-EXPORT                   SECTION.
      *---------------------------------------*
      *
           PERFORM 310000-VALIDATE-TABLE
           UNTIL SQLCODE               NOT EQUAL 0.
      *
       300099-END-EXPORT.
           EXIT.
      *
      *---------------------------------------*
       310000-VALIDATE-TABLE           SECTION.
      *---------------------------------------*
      *
           EXEC SQL
              DECLARE DB2CURSOR CURSOR FOR
              SELECT ClientID, ClientName, Email, Phone,
              AccountType, Balance
              FROM DB2TABLE.CLIENTS
           END-EXEC.
      *
           OPEN OUTPUT DMP0001O.
      *
           EXEC SQL
              OPEN DB2CURSOR
           END-EXEC.
      *
           PERFORM 320000-UNLOAD-TABLE
           UNTIL SQLCODE               EQUAL 100.
      *
           CLOSE DMP0001O.
      *
       310099-END-VALIDATE-TABLE.
           EXIT.
      *
      *---------------------------------------*
       320000-UNLOAD-TABLE             SECTION.
      *---------------------------------------*
      *
           EXEC SQL
              FETCH DB2CURSOR INTO :TB_CLIENT_ID, :TB_NAME, :TB_EMAIL,
              TB_PHONE, TB_ACC_TYPE, TB_ACC_BALANCE
           END-EXEC.
      *
           EVALUATE TRUE
           WHEN SQLCODE                EQUAL 0
                PERFORM 330000-WRITE-OUTPUT
           WHEN SQLCODE                GREATER 0
                PERFORM 999005-ERROR-005
           WHEN SQLCODE                LESS 0
                PERFORM 999004-ERROR-004
           WHEN OTHER
                CONTINUE
           END-EVALUATE.
      *
           IF SQLCODE                  EQUAL 0
              PERFORM 330000-WRITE-OUTPUT
           END-IF.
      *
           EXEC SQL
              CLOSE DB2CURSOR
           END-EXEC.
      *
       320099-END-UNLOAD-TABLE.
           EXIT.
      *
      *---------------------------------------*
       330000-WRITE-OUTPUT             SECTION.
      *---------------------------------------*
      *
           INITIALIZE DMP-FILE-REGISTER REPLACING
           NUMERIC                      BY ZEROS
           ALPHANUMERIC                 BY SPACES.
      *
           MOVE TB_CLIENT_ID           TO DMP-CLIENT-ID
           MOVE TB_NAME                TO DMP-NAME
           MOVE TB_EMAIL               TO DMP-EMAIL
           MOVE TB_PHONE               TO DMP-PHONE
           MOVE TB_ACC_TYPE            TO DMP-ACC-TYPE
           MOVE TB_ACC_BALANCE         TO DMP-ACC-BALANCE
      *
           WRITE DMP0001O-FD FROM DMP-FILE-REGISTER.
      *
       330099-END-WRITE-OUTPUT.
           EXIT.
      *
      *---------------------------------------*
       400000-IMPORT                   SECTION.
      *---------------------------------------*
      *
           PERFORM 410000-VALIDATE-FILE.
           PERFORM 430000-INSERT-TABLE.
      *
       400099-END-IMPORT.
           EXIT.
      *
      *---------------------------------------*
       410000-VALIDATE-FILE            SECTION.
      *---------------------------------------*
      *
           OPEN INPUT DMP0001I.
      *
           PERFORM 420000-READ-FILE.
           IF CNT-READ-INPUT           EQUAL ZEROS
              PERFORM 999002-ERROR-002
           END-IF.
      *
           MOVE ZEROS                  TO CNT-READ-INPUT.
      *
           CLOSE DMP0001I.
      *
       410099-END-VALIDATE-FILE.
           EXIT.
      *
      *---------------------------------------*
       420000-READ-FILE                SECTION.
      *---------------------------------------*
      *
           INITIALIZE DMP-FILE-REGISTER REPLACING
           NUMERIC                      BY ZEROS
           ALPHANUMERIC                 BY SPACES.
      *
           READ DMP0001I INTO DMP-FILE-REGISTER
           AT END
              MOVE 'Y'                 TO FLG-END-INPUT-FILE
           NOT AT END
              ADD 1 TO CNT-READ-INPUT
           END-READ.
      *
       420099-END-READ-FILE.
           EXIT.
      *
      *---------------------------------------*
       430000-INSERT-TABLE             SECTION.
      *---------------------------------------*
      *
           OPEN INPUT DMP0001I.
      *
           PERFORM 440000-LOAD-TABLE
           UNTIL   FLG-END-INPUT-FILE  EQUAL 'Y'.
      *
           CLOSE DMP0001I.
      *
       430099-END-INSERT-TABLE.
           EXIT.
      *
      *---------------------------------------*
       440000-LOAD-TABLE               SECTION.
      *---------------------------------------*
      *
           PERFORM 420000-READ-FILE.
      *
           EXEC SQL
              INSERT INTO DB2TABLE.ACCOUNTS(
              ClientID, ClientName, Email, Phone, AccountType, Balance)
              VALUES (:DMP-CLIENT-ID,
                      :DMP-NAME,
                      :DMP-EMAIL,
                      :DMP-PHONE,
                      :DMP-ACC-TYPE,
                      :DMP-ACC-BALANCE)
           END-EXEC.
      *
           IF SQLCODE                  NOT EQUAL 0
              PERFORM 999003-ERROR-003
           END-IF.
      *
       440099-END-LOAD-TABLE.
           EXIT.
      *
      *---------------------------------------*
       800000-FINALIZATION             SECTION.
      *---------------------------------------*
      *
           DISPLAY '***************************************************'
           EVALUATE DMP-FLAG
           WHEN 1
              DISPLAY 'NUMBER OF RECORDS READ........: ' CNT-READ-INPUT
              DISPLAY 'NUMBER OF RECORDS LOADED......: ' CNT-LOAD-INPUT
           WHEN 2
              DISPLAY 'NUMBER OF RECORDS UNLOADED....: ' CNT-UNLO-TABLE
              DISPLAY 'NUMBER OF RECORDS WRITTEN.....: ' CNT-WRIT-OUTPUT
           WHEN OTHER
              PERFORM 999001-ERROR-001
           END-EVALUATE.
      *
       800099-END-FINALIZATION.
           EXIT.
      *
      *---------------------------------------*
       999000-ERRORS                   SECTION.
      *---------------------------------------*
      *
       999001-ERROR-001.
      *
           DISPLAY '***************************************************'
           DISPLAY 'ERROR 001 - INVALID DMP-PARM PARAMETER.'.
           DISPLAY 'RECEIVED DMP-PARM.: ' DMP-PARM.
           DISPLAY 'EXPECTED..........: 1 OR 2'.
           MOVE 1                      TO RETURN-CODE.
           DISPLAY 'RETURN-CODE.......: ' RETURN-CODE.
           GO TO 000099-END-MAIN-PROCEDURE.
      *
       999002-ERROR-002.
      *
           DISPLAY '***************************************************'
           DISPLAY 'ERROR 002 - INPUT FILE IS EMPTY.'.
           MOVE 2                      TO RETURN-CODE.
           DISPLAY 'RETURN-CODE....: ' RETURN-CODE.
           GO TO 000099-END-MAIN-PROCEDURE.
      *
       999003-ERROR-003.
      *
           DISPLAY '***************************************************'
           DISPLAY 'ERROR 003 - FAILED TO INSERT DATA INTO TABLE,'
           DISPLAY 'PLEASE CHECK VALUES IN INPUT FILE'
           DISPLAY 'DMP-CLIENT-ID.....: ' DMP-CLIENT-ID
           DISPLAY 'DMP-NAME..........: ' DMP-NAME
           DISPLAY 'DMP-EMAIL.........: ' DMP-EMAIL
           DISPLAY 'DMP-PHONE.........: ' DMP-PHONE
           DISPLAY 'DMP-ACC-TYPE......: ' DMP-ACC-TYPE
           DISPLAY 'DMP-ACC-BALANCE...: ' DMP-ACC-BALANCE
           MOVE 3                      TO RETURN-CODE.
           GO TO 000099-END-MAIN-PROCEDURE.
      *
       999004-ERROR-004.
      *
           DISPLAY '***************************************************'
           DISPLAY 'ERROR 004 - FAILED TO SELECT DATA FROM TABLE'
           DISPLAY 'SQLCODE....: ' SQLCODE
           MOVE 4                      TO RETURN-CODE
           GO TO 000099-END-MAIN-PROCEDURE.
      *
       999005-ERROR-005.
      *
           DISPLAY 'WARNING IN SQL EXECUTION! '
           DISPLAY 'SQLCODE: ' SQLCODE.
      *
      ******************************************************************
      *                         END OF PROGRAM                         *
      ******************************************************************
