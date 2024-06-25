vm1=0.06; vm2=0.06; vp1=0.06; vp2=0.06; vc1=0.07; vc2=0.07;

dm=0.002; dp=0.0005; dc=0.002;

Qm1=50; Qm2=50; Qbm1=5000; Qbm2=5000;
Qc1=50; Qc2=50; Qbc1=5000; Qbc2=5000;
Qp1=50; Qp2=50;

KI1=50; KI2=50; Kc1=1; Kc2=1; 

CNm=150; CNc=150; n=2; 

lambda_CRC=1;

I1=0;I2=0; 

lambda_RC=0; Tc=0; lambda_Glob=0; lambda_NCR=0; % no resource competition 

PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n]; 