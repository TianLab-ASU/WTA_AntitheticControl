clc
clear 

Parameter

tic
lambda_RC=0;Tc=0; lambda_Glob=0; lambda_NCR=0; CNc=0; % no resource competition 
PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
[P1s_NORC, P2s_NORC, SN_NORC]=SA_HeatMap_I1I2_Scaled_NORC(PP);
SN_NORC
toc

lambda_RC=1;Tc=0; lambda_Glob=0; lambda_NCR=0; CNc=0; %  resource competition no controller
PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
[P1s_RC_no_controller, P2s_RC_no_controller, SN_RC_no_controller]=SA_HeatMap_I1I2_Scaled(PP);  
SN_RC_no_controller

lambda_RC=1;Tc=0; lambda_Glob=0; lambda_NCR=0; CNc=150; %  resource competition with controller
PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
[P1s_RC_open_loop, P2s_RC_open_loop, SN_RC_open_loop]=SA_HeatMap_I1I2_Scaled(PP);  
SN_RC_open_loop

lambda_RC=1;Tc=8e-4;lambda_Glob=0; lambda_NCR=0; CNc=150; % local controller  
PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
[P1s_LC, P2s_LC, SN_LC]=SA_HeatMap_I1I2_Scaled(PP);   
SN_LC

lambda_RC=1;Tc=8e-4;lambda_Glob=1; lambda_NCR=0; CNc=150; % global controller
PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
[P1s_GC, P2s_GC, SN_GC]=SA_HeatMap_I1I2_Scaled(PP);
SN_GC

lambda_RC=1;Tc=8e-4;lambda_Glob=0; lambda_NCR=1; CNc=150; % NCR controller
PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
[P1s_NCR, P2s_NCR, SN_NCR]=SA_HeatMap_I1I2_Scaled(PP);
SN_NCR

save Data_Antithetic.mat
%%
load Data_Antithetic.mat   

% CA-Score Calculation

Nx=201;
I1=(0:Nx-1)*3/(Nx-1);
I2=(0:Nx-1)*3/(Nx-1);

subplot(2,3,1) % NORC
CA_score_NORC=HeatMap_Plot(I1,I2,P1s_NORC,P2s_NORC)
axis([0 3 0 3])
xlabel('I1')
ylabel('I2')
title(['No RC, CA_{score}=', num2str(CA_score_NORC)])

subplot(2,3,2) % RC-No-Controller
CA_score_RC_no_controller=HeatMap_Plot(I1,I2,P1s_RC_no_controller,P2s_RC_no_controller)
axis([0 3 0 3])
xlabel('I1')
ylabel('I2')
title(['RC, CA_{score}=', num2str(CA_score_RC_no_controller)])

subplot(2,3,3) % RC-Open-Loop
CA_score_RC_open_loop=HeatMap_Plot(I1,I2,P1s_RC_open_loop,P2s_RC_open_loop)
axis([0 3 0 3])
xlabel('I1')
ylabel('I2')
title(['RC, CA_{score}=', num2str(CA_score_RC_open_loop)])

subplot(2,3,4) % GC
CA_score_GC=HeatMap_Plot(I1,I2,P1s_GC,P2s_GC)
axis([0 3 0 3])
xlabel('I1')
ylabel('I2')
title(['GC, CA_{score}=', num2str(CA_score_GC)])

subplot(2,3,5) % LC
CA_score_LC=HeatMap_Plot(I1,I2,P1s_LC,P2s_LC)
axis([0 3 0 3])
xlabel('I1')
ylabel('I2')
title(['GC, CA_{score}=', num2str(CA_score_LC)])

subplot(2,3,6) % NCR
CA_score_NCR=HeatMap_Plot(I1,I2,P1s_NCR,P2s_NCR)
axis([0 3 0 3])
xlabel('I1')
ylabel('I2')
title(['NCR, CA_{score}=', num2str(CA_score_NCR)])

save('Data_Antithetic', 'CA_score_NORC', 'CA_score_RC_no_controller','CA_score_RC_open_loop' ,...
    'CA_score_GC','CA_score_LC','CA_score_NCR' , '-append');