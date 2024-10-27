function [P1_det, P2_det, P1_stoch, P2_stoch, SN, I1_values] = SA_Stoc_I1I2_Scaled_traj(PP, numTrajectories)

    PP = num2cell(PP(:));
    [I1, I2, Tc, lambda_RC, lambda_Glob, lambda_NCR, lambda_CRC, vc1, vc2, dm, dc, vm1, vm2, vp1, vp2, dp, Qm1, Qm2, Qbm1, Qbm2, Qc1, Qc2, Qbc1, Qbc2, Qp1, Qp2, KI1, KI2, Kc1, Kc2, CNm, CNc, n] = deal(PP{:});
    
    I1=0;I2=0;

    PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
    sol=ode45(@(t,y) Antithetic_ODE(t,y,PP),[0 100000], [0 0 0 0 0 0]);
    y0=sol.y(:,end);

    delta_I = 0.1; 
    I2 = 0.0;
    P1_SN = zeros(1, 601);
    
    % Calculate the optimal I1 value (SN)
    for i = 1:601
        I1 = (i - 1) * delta_I;
        PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
        sol = ode45(@(t, y) Antithetic_ODE(t, y, PP), [0 100000], y0);
        P1_SN(i) = sol.y(5, end);
    end
    
    [~, SN] = max(diff(P1_SN)); 
    SN = (SN - 1) * delta_I;

    Nx = 11;
    I2 = SN * 2;
    P1_det = zeros(Nx);
    P2_det = zeros(Nx);
    P1_stoch = zeros(Nx, numTrajectories);
    P2_stoch = zeros(Nx, numTrajectories);
    I1_values = zeros(Nx, 1);  % Array to save I1 values

    % Vary I1 and run multiple trajectories
    for i = 1:Nx
        I1 = (i - 1) * 3 * SN / (Nx - 1);  % Update I1 for current iteration
        I1_values(i) = I1;  % Save the current I1 value
        PP=[I1 I2 Tc lambda_RC lambda_Glob lambda_NCR lambda_CRC vc1 vc2 dm dc vm1 vm2 vp1 vp2 dp Qm1 Qm2 Qbm1 Qbm2 Qc1 Qc2 Qbc1 Qbc2 Qp1 Qp2 KI1 KI2 Kc1 Kc2 CNm CNc n];
              
        % Solve the deterministic ODE
        sol = ode45(@(t, y) Antithetic_ODE(t, y, PP), [0 20000], y0);
        P1_det(i) = sol.y(5, end);
        P2_det(i) = sol.y(6, end);

        for traj = 1:numTrajectories
%             y0 = initial_conditions(PP);  % Get the initial conditions
            i, traj
            Omega = 50;
            [t, y] = ExactGillespieSSA_TianLab(@(t, y) Antithetic_SDE(t, y, PP), [0 20000], round(y0 * Omega));
            P1_stoch(i, traj) = y(end, 5) / Omega;  
            P2_stoch(i, traj) = y(end, 6) / Omega;
        end
    end

    % Average results across trajectories
%     P1_det = mean(P1_det, 2);  % Average deterministic P1 across trajectories
%     P2_det = mean(P2_det, 2);  % Average deterministic P2 across trajectories
    P1_stoch = mean(P1_stoch, 2);  % Average stochastic P1 across trajectories
    P2_stoch = mean(P2_stoch, 2);  % Average stochastic P2 across trajectories

end

% function y0 = initial_conditions(PP)
%     % Initialize initial conditions
%     sol = ode45(@(t, y) Antithetic_ODE(t, y, PP), [0 100000], [0 0 0 0 0 0]);
%     y0 = sol.y(:, end);
% end
