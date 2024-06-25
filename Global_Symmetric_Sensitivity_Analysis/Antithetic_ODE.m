% ODE file for antithetic control model
function dydt = Antithetic_ODE(t,y,PP) 
 
PP=num2cell(PP(:)); 

[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc Qbc Qp1 Qp2 KI1 KI2 Kc CNm CNc n]=deal(PP{:});

% Assign each variable to system of ODEs
M1=y(1);
M2=y(2);
C1=y(3);
C2=y(4);
P1=y(5);
P2=y(6);

% Circuit input formulation
IP1=I1.*P1;
IP2=I2.*P2;

% Define fraction of active promoters 
Rm1=IP1.^n./(IP1.^n+KI1.^n);  
Rm2=IP2.^n./(IP2.^n+KI2.^n); 
Rc1=P1.^n./(P1.^n+Kc.^n);
Rc2=P2.^n./(P2.^n+Kc.^n);

% Define resource competitive terms
PFm=1+lambda_RC*(CNm*(Rm1/Qm1+Rm2/Qm2+1/Qbm1+1/Qbm2)+lambda_CRC*CNc*(Rc1/Qc+Rc2/Qc+1/Qbc+1/Qbc));
PFp=1+lambda_RC.*(M1./Qp1+M2./Qp2);
  

% Define ODE for each variable in the system of ODEs
dydt=[vm1.*(CNm.*(Rm1./Qm1+1./Qbm1)./PFm)-dm.*M1-Tc.*C1.*M1-lambda_Glob.*Tc.*C2.*M1; %M1
      vm2.*(CNm.*(Rm2./Qm2+1./Qbm2)./PFm)-dm.*M2-Tc.*C2.*M2-lambda_Glob.*Tc.*C1.*M2; %M2
      vc.*(CNc.*(Rc1./Qc+1./Qbc)./PFm)-dc.*C1-Tc.*C1.*M1-lambda_Glob.*Tc.*C1.*M2-lambda_NCR.*Tc.*C1.*C2; %C1
      vc.*(CNc.*(Rc2./Qc+1./Qbc)./PFm)-dc.*C2-Tc.*C2.*M2-lambda_Glob.*Tc.*C2.*M1-lambda_NCR.*Tc.*C1.*C2; %C2
      vp1.*((M1./Qp1)./PFp)-dp.*P1; %P1
      vp2.*((M2./Qp2)./PFp)-dp.*P2; %P2
     ];
end