clc
clear 

load Fig2_Cluster.mat % Load your own simulated data

% CA-Score , Ortho SCore Calculation

Nx=201;
I1=(0:Nx-1)*3/(Nx-1);
I2=(0:Nx-1)*3/(Nx-1);


OrthoScore_NORC=orthoscore_calculation(I1,I2,P1s_NORC_updated,P2s_NORC_updated,P1s_NORC_updated,P2s_NORC_updated);

OrthoScore_RC_no_controller=orthoscore_calculation(I1,I2,P1s_RC_no_controller,P2s_RC_no_controller,P1s_NORC_updated,P2s_NORC_updated);

OrthoScore_RC_open_loop=orthoscore_calculation(I1,I2,P1s_RC_open_loop,P2s_RC_open_loop,P1s_NORC_updated,P2s_NORC_updated);

OrthoScore_GC=orthoscore_calculation(I1,I2,P1s_GC,P2s_GC,P1s_NORC_updated,P2s_NORC_updated);

OrthoScore_LC=orthoscore_calculation(I1,I2,P1s_LC,P2s_LC,P1s_NORC_updated,P2s_NORC_updated);

OrthoScore_NCR=orthoscore_calculation(I1,I2,P1s_NCR,P2s_NCR,P1s_NORC_updated,P2s_NORC_updated);

OrthoScore=[OrthoScore_NORC, OrthoScore_RC_no_controller, OrthoScore_RC_open_loop, ...
    OrthoScore_GC, OrthoScore_LC, OrthoScore_NCR];
save -ascii OrthoScore_data.dat OrthoScore
