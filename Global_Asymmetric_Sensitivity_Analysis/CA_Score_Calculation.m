clear
clc
for fileIndex = 1:1000
    % Assuming your files are named ...
    % Data_Antithetic_Global_Asym1.mat, Data_Antithetic_Global_Asym2.mat, ..., Data_Antithetic_Global_Asym1000.mat
    filename = ['Data_Antithetic_Global_Asym', num2str(fileIndex), '.mat'];
    load(filename);

    Nx = 201;
    I1 = (0:Nx-1)*3/(Nx-1);
    I2 = (0:Nx-1)*3/(Nx-1);

    CA_score_GC = HeatMap_Plot(I1, I2, P1s_GC, P2s_GC);
    CA_score_LC = HeatMap_Plot(I1, I2, P1s_LC, P2s_LC);
    CA_score_NCR = HeatMap_Plot(I1, I2, P1s_NCR, P2s_NCR);

    % Save CA scores to the same file
    save(filename, 'CA_score_GC', 'CA_score_LC', 'CA_score_NCR', '-append');
end