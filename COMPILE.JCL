//JOB0001  JOB 'BATCH DATA IMPORT',
//         ROS.GITHUB.MATEUS.R,REGION=0M,MSGCLASS=R,
//         COND=((08,EQ),(12,EQ),(16,EQ),(888,EQ)),
//*        TYPRUN=SCAN,                         * JCL TEST.
//         CLASS=A
//*--------------------------------------------------------------------*
//SET00A   SET INPUTLIB='YOUR.INPUT.LIB', **** DATASET WITH THE PROGRAM
//*--------------------------------------------------------------------*
//STEP01   EXEC PGM=IGYCRCTL
//SYSPRINT DD  SYSOUT=*
//SYSLIN   DD  DSN=&&OBJLIB(DMPP0001),
//             DISP=(MOD,PASS),
//             UNIT=SYSDA,SPACE=(CYL,(1,1))
//SYSUT1   DD  UNIT=SYSDA,SPACE=(CYL,(1,1))
//SYSUT2   DD  UNIT=SYSDA,SPACE=(CYL,(1,1))
//SYSUT3   DD  UNIT=SYSDA,SPACE=(CYL,(1,1))
//SYSUT4   DD  UNIT=SYSDA,SPACE=(CYL,(1,1))
//SYSIN    DD  DSN=&INPUTLIB(DMPP0001),DISP=SHR