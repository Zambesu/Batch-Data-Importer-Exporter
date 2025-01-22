//JOB0001  JOB 'BATCH DATA IMPORT',
//         ROS.GITHUB.MATEUS.R,REGION=0M,MSGCLASS=R,
//         COND=((08,EQ),(12,EQ),(16,EQ),(888,EQ)),
//*        TYPRUN=SCAN,                         * JCL TEST.
//         CLASS=A
//*--------------------------------------------------------------------*
//SET00A   SET DMPPARM=2,             **** INPUT PARAMETER
//             DATE=21012025,         **** CURRENT DATE
//             USERID='USER'
//*--------------------------------------------------------------------*
//SYS00A   EXEC PGM=SYS000,
//         PARM='DMP.&USERID..D&DATE..DMP0001.OUTPUT'
//*--------------------------------------------------------------------*
//DMP0001  EXEC PGM=DMPP0001,PARM='&DMPPARM'
//SYSOUT   DD   SYSOUT=*
//*--------------------------------------------------------------------*
//DMP0001I DD DSN='DMP.&USERID..D&DATE..DMP0001.INPUT',
//         DISP=SHR
//DMP0001O DD DSN='DMP.&USERID..D&DATE..DMP0001.OUTPUT',
//         DISP=(,CATLG),AVGREC=K,UNIT=(SYSDA,50),
//         DSORG=PS,RECFM=FB,LRECL=88,
//         SPACE=(250,(1,10),RLSE)
