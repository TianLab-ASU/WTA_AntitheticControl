% ODE file for antithetic control model
function dydt = Antithetic_ODE(t,y,PP) 
  
PP=num2cell(PP(:)); 

[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n]=deal(PP{:});
% Assign each variable to system of ODEs
M1=y(1);
M2=y(2);
C1=y(3);
C2=y(4);
P1=y(5);
P2=y(6);

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
 
% Define ODE for each variable in the system of ODEs
dydt=[vm1*(CNm*(Rm1/Qm1+1/Qbm1)/PFm)-dm*M1-Tc*C1*M1-lambda_Glob*Tc*C2*M1; %M1
      vm2*(CNm*(Rm2/Qm2+1/Qbm2)/PFm)-dm*M2-Tc*C2*M2-lambda_Glob*Tc*C1*M2; %M2
      vc1*(CNc*(Rc1/Qc1+1/Qbc1)/PFm)-dc*C1-Tc*C1*M1-lambda_Glob*Tc*C1*M2-lambda_NCR*Tc*C1*C2; %C1
      vc2*(CNc*(Rc2/Qc2+1/Qbc2)/PFm)-dc*C2-Tc*C2*M2-lambda_Glob*Tc*C2*M1-lambda_NCR*Tc*C1*C2; %C2
      vp1*((M1/Qp1)/PFp)-dp*P1; %P1
      vp2*((M2/Qp2)/PFp)-dp*P2; %P2
     ];
end