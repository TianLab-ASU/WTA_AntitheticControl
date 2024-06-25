clear
clc

for fileIndex = 1:32
    % Assuming your files are named ...
    % Data_Antithetic_Local1.mat, Data_Antithetic_Local2.mat, ..., Data_Antithetic_Local32.mat
    filename = ['Data_Antithetic_Local', num2str(fileIndex), '.mat'];
    
    load(filename);

    Nx = 201;
    I1 = (0:Nx-1)*3/(Nx-1);
    I2 = (0:Nx-1)*3/(Nx-1);

    subplot(3,2,1)
    CA_score_GC = HeatMap_Plot(I1, I2, P1s_GC, P2s_GC);
    axis([0 3 0 3])
    xlabel('I1')
    ylabel('I2')
    title(['GC, CA_{score}=', num2str(CA_score_GC)])

    subplot(3,2,3)
    CA_score_LC = HeatMap_Plot(I1, I2, P1s_LC, P2s_LC);
    axis([0 3 0 3])
    xlabel('I1')
    ylabel('I2')
    title(['LC, CA_{score}=', num2str(CA_score_LC)])

    subplot(3,2,5)
    CA_score_NCR = HeatMap_Plot(I1, I2, P1s_NCR, P2s_NCR);
    axis([0 3 0 3])
    xlabel('I1')
    ylabel('I2')
    title(['NCR, CA_{score}=', num2str(CA_score_NCR)])

    % Save CA scores to the same file
    save(filename, 'CA_score_GC', 'CA_score_LC', 'CA_score_NCR', '-append');
end
