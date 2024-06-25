function [P1s, P2s]=SA_HeatMap_I1I2_Scaled(PP)


PP=num2cell(PP(:));
[I1 I2 Tc1 Tc2 Tc3 Tc4 Tc5 lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n]=deal(PP{:});

I1=0;I2=0;

PP=[I1 I2 Tc1 Tc2 Tc3 Tc4 Tc5 lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
sol=ode45(@(t,y) Antithetic_ODE(t,y,PP),[0 100000], [0 0 0 0 0 0]);
y0=sol.y(:,end);

delta_I=0.1;
I2=0;
P1_SN=zeros(1,101);
parfor i=1:601
    I1=(i-1)*delta_I;
    PP=[I1 I2 Tc1 Tc2 Tc3 Tc4 Tc5 lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
    sol=ode45(@(t,y) Antithetic_ODE(t,y,PP),[0 100000], y0);
    P1_SN(i)=sol.y(5,end);
end

delta_I=0.1;
I1=0;
P2_SN=zeros(1,101);
parfor i=1:601
    I2=(i-1)*delta_I;
    PP=[I1 I2 Tc1 Tc2 Tc3 Tc4 Tc5 lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
    sol=ode45(@(t,y) Antithetic_ODE(t,y,PP),[0 100000], y0);
    P2_SN(i)=sol.y(6,end);
end

[~, SN_1]=max(diff(P1_SN)); 
SN_1=(SN_1-1)*delta_I;

[~, SN_2]=max(diff(P2_SN)); 
SN_2=(SN_2-1)*delta_I;

Nx=201;

P1s=zeros(Nx,Nx);
P2s=zeros(Nx,Nx);
parfor i=1:Nx*Nx
    ii=floor((i-1)/Nx)+1;
    jj=mod(i-1,Nx)+1;
    I1=(ii-1)*3*SN_1/(Nx-1);
    I2=(jj-1)*3*SN_2/(Nx-1);
    PP=[I1 I2 Tc1 Tc2 Tc3 Tc4 Tc5 lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
    sol=ode45(@(t,y) Antithetic_ODE(t,y,PP),[0 100000], y0);
    P1s(i)=sol.y(5,end);
    P2s(i)=sol.y(6,end);
end
P1s=P1s';
P2s=P2s';