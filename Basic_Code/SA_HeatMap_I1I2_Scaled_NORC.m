function [P1s, P2s, SN]=SA_HeatMap_I1I2_Scaled_NORC(PP)


PP=num2cell(PP(:));
[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n lambda_CRC]=deal(PP{:});

I1=0;I2=0;

PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n lambda_CRC];
sol=ode45(@(t,y) Antithetic_ODE(t,y,PP),[0 100000], [0 0 0 0 0 0]);
y0=sol.y(:,end);

delta_I=0.01;
I2=0;
P1_SN=zeros(1,101);
for i=1:601
    I1=(i-1)*delta_I
    PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n lambda_CRC];
    sol=ode45(@(t,y) Antithetic_ODE(t,y,PP),[0 100000], y0);
    P1_SN(i)=sol.y(5,end);
end
[~, SN]=max(diff(P1_SN));
SN=(SN-1)*delta_I;


Nx=201;

P1s=zeros(Nx,Nx);
P2s=zeros(Nx,Nx);
for i=1:Nx*Nx
    ii=floor((i-1)/Nx)+1;
    jj=mod(i-1,Nx)+1;
    I1=(ii-1)*3*SN/(Nx-1);
    I2=(jj-1)*3*SN/(Nx-1);
    PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n lambda_CRC];
    sol=ode45(@(t,y) Antithetic_ODE(t,y,PP),[0 100000], y0);
    P1s(i)=sol.y(5,end);
    P2s(i)=sol.y(6,end);
end
P1s=P1s';
P2s=P2s';