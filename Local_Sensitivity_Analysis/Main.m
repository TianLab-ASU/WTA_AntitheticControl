clc
clear

Parameter

Tc1=8e-4; Tc2=8e-4; Tc3=8e-4; Tc4=8e-4; Tc5=8e-4; 

PP0=[Qc1 Qc2 Qbc1 Qbc2 Kc1 Kc2 lambda_CRC vc1 vc2 CNc dc Tc1 Tc2 Tc3 Tc4 Tc5];
Parameter_Rand=PP0.*ones(length(PP0)*2,length(PP0));

for i=1:length(PP0)
    Parameter_Rand(2*i-1,i)=Parameter_Rand(2*i-1,i)*1.2; % 20% variance
    Parameter_Rand(2*i,i)=Parameter_Rand(2*i,i)*0.8; % 20% variance
end 

parfor run = 1:length(Parameter_Rand)

    Parameter_temp=num2cell(Parameter_Rand(run,:)); % define the column that will be chosen randomly
    [Qc1,Qc2,Qbc1,Qbc2,Kc1,Kc2,lambda_CRC,vc1,vc2,CNc,dc,Tc1,Tc2,Tc3,Tc4,Tc5]=deal(Parameter_temp{1:16});% define the column that will be chosen randomly
     
    tic
    lambda_RC=1; lambda_Glob=0; lambda_NCR=0; % local controller 
    PP=[I1 I2 Tc1 Tc2 Tc3 Tc4 Tc5 lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
    [P1s_LC, P2s_LC] = SA_HeatMap_I1I2_Scaled(PP); 
    toc


    lambda_RC=1; lambda_Glob=1; lambda_NCR=0; % global controller  
    PP=[I1 I2 Tc1 Tc2 Tc3 Tc4 Tc5 lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
    [P1s_GC, P2s_GC]=SA_HeatMap_I1I2_Scaled(PP); 
    

    lambda_RC=1; lambda_Glob=0; lambda_NCR=1; % NCR controller 
    PP=[I1 I2 Tc1 Tc2 Tc3 Tc4 Tc5 lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
    [P1s_NCR, P2s_NCR]=SA_HeatMap_I1I2_Scaled(PP); 
    
    parsave(sprintf('Data_Antithetic_Local%d.mat', run), P1s_LC, P2s_LC,...
        P1s_GC, P2s_GC, P1s_NCR, P2s_NCR);

end

function parsave(fname, P1s_LC, P2s_LC,...
        P1s_GC, P2s_GC, P1s_NCR, P2s_NCR)
save(fname, 'P1s_LC', 'P2s_LC',...
        'P1s_GC', 'P2s_GC', 'P1s_NCR', 'P2s_NCR')
end
%%
 