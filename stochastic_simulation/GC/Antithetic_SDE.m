function [S, P, K] = SDE_RC(t,y,PP)

Omega=50;
PP=num2cell(PP(:)); 
[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n]=deal(PP{:});
% Need a row for each reaction and a column for each chemical species

S = [  % How many of each chemical is used as substractes M1=col_1, M2=col_2, C1=col_3, C2=col_4, P1=col_5, P2=col_6
    0 0 0 0 0 0% DNA  --> mRNA, GFP
    1 0 0 0 0 0% mRNA --> nothing, GFP
    0 0 0 0 0 0% nothing --> controller mRNA, GFP
    0 0 1 0 0 0% controller mRNA --> nothing, GFP
    1 0 1 0 0 0% mRNA + controller mRNA --> nothing, GFP : LC
    0 1 1 0 0 0% mRNA from RFP + controller mRNA from GFP --> nothing, : GC
    0 0 1 1 0 0% controller mRNA from GFP + controller mRNA from RFP --> nothing, : NCR
    1 0 0 0 0 0% mRNA --> P, GFP
    0 0 0 0 1 0% P --> nothing,  GFP
    0 0 0 0 0 0% DNA  --> mRNA, RFP
    0 1 0 0 0 0% mRNA --> nothing, RFP
    0 0 0 0 0 0% nothing --> controller mRNA, RFP
    0 0 0 1 0 0% controller mRNA --> nothing, RFP
    0 1 0 1 0 0% mRNA + controller mRNA --> nothing, RFP : LC
    1 0 0 1 0 0% mRNA from GFP + controller mRNA from RFP --> nothing, : GC
    0 1 0 0 0 0% mRNA --> P, RFP
    0 0 0 0 0 1% P --> nothing, RFP
    ]  ;

P = [  % How many of each chemical is used as substractes M1=col_1, M2=col_2, C1=col_3, C2=col_4, P1=col_5, P2=col_6
    1 0 0 0 0 0% DNA  --> mRNA, GFP
    0 0 0 0 0 0% mRNA --> nothing, GFP
    0 0 1 0 0 0% nothing --> controller mRNA, GFP
    0 0 0 0 0 0% controller mRNA --> nothing, GFP
    0 0 0 0 0 0% mRNA + controller mRNA --> nothing, GFP : LC
    0 0 0 0 0 0% mRNA from RFP + controller mRNA from GFP --> nothing, : GC
    0 0 0 0 0 0% controller mRNA from GFP + controller mRNA from RFP --> nothing, : NCR
    1 0 0 0 1 0% mRNA --> P, GFP
    0 0 0 0 0 0% P --> nothing,  GFP
    0 1 0 0 0 0% DNA  --> mRNA, RFP
    0 0 0 0 0 0% mRNA --> nothing, RFP
    0 0 0 1 0 0% nothing --> controller mRNA, RFP
    0 0 0 0 0 0% controller mRNA --> nothing, RFP
    0 0 0 0 0 0% mRNA + controller mRNA --> nothing, RFP : LC
    0 0 0 0 0 0% mRNA from GFP + controller mRNA from RFP --> nothing, : GC
    0 1 0 0 0 1% mRNA --> P, RFP
    0 0 0 0 0 0% P --> nothing, RFP
    ]  ;

M1=y(1)/Omega;
M2=y(2)/Omega;
C1=y(3)/Omega;
C2=y(4)/Omega;
P1=y(5)/Omega;
P2=y(6)/Omega;

% Circuit input formulation
IP1=I1*P1;
IP2=I2*P2;

% Define fraction of active promoters  
Rm1=IP1^n/(IP1^n+KI1^n);  
Rm2=IP2^n/(IP2^n+KI2^n); 
Rc1=P1^n/(P1^n+Kc1^n);
Rc2=P2^n/(P2^n+Kc2^n);

% Define resource competitive terms
PFm=1+lambda_RC*(CNm*(Rm1/Qm1+Rm2/Qm2+1/Qbm1+1/Qbm2)+lambda_CRC*CNc*(Rc1/Qc1+Rc2/Qc2+1/Qbc1+1/Qbc2));
PFp=1+lambda_RC*(M1/Qp1+M2/Qp2);

K  = [vm1*(CNm*(Rm1/Qm1+1/Qbm1)/PFm)*Omega 
    dm
    vc1*(CNc*(Rc1/Qc1+1/Qbc1)/PFm)*Omega
    dc
    Tc/Omega
    lambda_Glob*Tc/Omega
    lambda_NCR*Tc/Omega
    vp1*((1/Qp1)/PFp) 
    dp
    vm2*(CNm*(Rm2/Qm2+1/Qbm2)/PFm)*Omega
    dm
    vc2*(CNc*(Rc2/Qc2+1/Qbc2)/PFm)*Omega
    dc
    Tc/Omega
    lambda_Glob*Tc/Omega
    vp2*((1/Qp2)/PFp) 
    dp];

end