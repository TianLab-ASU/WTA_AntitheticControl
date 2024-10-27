clc
clear 

Parameter
numTrajectories=1000;

% for i=4
switch 5
    case 1
    lambda_RC=0;Tc=0; lambda_Glob=0; lambda_NCR=0; CNc=0; % no resource competition 
    PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
    [P1_det_NORC, P2_det_NORC, P1_stoch_NORC, P2_stoch_NORC, SN_NORC, I1_values_NORC] = SA_Stoc_I1I2_Scaled_traj(PP, numTrajectories);
    
    case 2
    lambda_RC=1;Tc=0; lambda_Glob=0; lambda_NCR=0; CNc=0; %  resource competition no controller
    PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
    [P1_det_RC_no_controller, P2_det_RC_no_controller, P1_stoch_RC_no_controller, P2_stoch_RC_no_controller, SN_RC_no_controller, I1_values_RC_no_controller] = SA_Stoc_I1I2_Scaled_traj(PP, numTrajectories);

    case 3
    lambda_RC=1;Tc=0; lambda_Glob=0; lambda_NCR=0; CNc=150; %  resource competition with controller
    PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
    [P1_det_RC_open_loop, P2_det_RC_open_loop, P1_stoch_RC_open_loop, P2_stoch_RC_open_loop, SN_RC_open_loop, I1_values_RC_open_loop] = SA_Stoc_I1I2_Scaled_traj(PP, numTrajectories);
    
    case 4
    lambda_RC=1;Tc=8e-4;lambda_Glob=0; lambda_NCR=0; CNc=150; % local controller  
    PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
    [P1_det_LC, P2_det_LC, P1_stoch_LC, P2_stoch_LC, SN_LC, I1_values_LC] = SA_Stoc_I1I2_Scaled_traj(PP, numTrajectories);
 
    case 5
    lambda_RC=1;Tc=8e-4;lambda_Glob=1; lambda_NCR=0; CNc=150; % global controller
    PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
    [P1_det_GC, P2_det_GC, P1_stoch_GC, P2_stoch_GC, SN_GC, I1_values_GC] = SA_Stoc_I1I2_Scaled_traj(PP, numTrajectories);

    case 6
    lambda_RC=1;Tc=8e-4;lambda_Glob=0; lambda_NCR=1; CNc=150; % NCR controller
    PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
    [P1_det_NCR, P2_det_NCR, P1_stoch_NCR, P2_stoch_NCR, SN_NCR, I1_values_NCR] = SA_Stoc_I1I2_Scaled_traj(PP, numTrajectories);
end
% end
save Data_Main_traj_GC.mat