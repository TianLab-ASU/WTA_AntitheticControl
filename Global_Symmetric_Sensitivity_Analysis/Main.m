clc
clear

Parameter

Tc=8e-4; 

PP0=[Qc Qbc Kc lambda_CRC vc CNc dc Tc];

num_Samples = 1000; 

Parameter_change=PP0.*ones(num_Samples,length(PP0));

variable_Range = [Parameter_change(1,:)*0.8; Parameter_change(1,:)*1.2]; % 20% varience

rng default % For reproducibility
[lhs] = lhsdesign(num_Samples, length(PP0)); % Generate Latin Hypercube Sample
[Parameter_Rand] = [lhs] .* (variable_Range(2,:) - variable_Range(1,:)) + variable_Range(1,:);


parfor run = 1:length(Parameter_Rand)

    Parameter_temp=num2cell(Parameter_Rand(run,:)); % define the column that will be chosen randomly
    [Qc Qbc Kc lambda_CRC vc CNc dc Tc]=deal(Parameter_temp{1:8});% define the column that will be chosen randomly
     
    tic
    lambda_RC=1; lambda_Glob=0; lambda_NCR=0; % local controller 
    PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc Qbc Qp1 Qp2 KI1 KI2 Kc CNm CNc n];
    [P1s_LC, P2s_LC, SN_LC] = SA_HeatMap_I1I2_Scaled(PP); 
    toc


    lambda_RC=1; lambda_Glob=1; lambda_NCR=0; % global controller  
    PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc Qbc Qp1 Qp2 KI1 KI2 Kc CNm CNc n];
    [P1s_GC, P2s_GC, SN_GC]=SA_HeatMap_I1I2_Scaled(PP); 
   

    lambda_RC=1; lambda_Glob=0; lambda_NCR=1; % NCR controller 
    PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc Qbc Qp1 Qp2 KI1 KI2 Kc CNm CNc n];
    [P1s_NCR, P2s_NCR, SN_NCR]=SA_HeatMap_I1I2_Scaled(PP); 
    
    parsave(sprintf('Data_Antithetic_Global_Sym%d.mat', run), P1s_LC, P2s_LC, SN_LC,...
        P1s_GC, P2s_GC, SN_GC, P1s_NCR, P2s_NCR, SN_NCR);

end

function parsave(fname, P1s_LC, P2s_LC, SN_LC,...
        P1s_GC, P2s_GC, SN_GC, P1s_NCR, P2s_NCR, SN_NCR)
save(fname, 'P1s_LC', 'P2s_LC', 'SN_LC',...
        'P1s_GC', 'P2s_GC', 'SN_GC', 'P1s_NCR', 'P2s_NCR', 'SN_NCR')
end

%%