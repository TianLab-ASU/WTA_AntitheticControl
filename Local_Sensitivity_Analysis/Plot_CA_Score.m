clear
clc
matfiles = dir('*.mat') ;
N = length(matfiles) ;
mydata = cell(1, N);

for k = 1:N
    myfilename = sprintf('Data_Antithetic_Local%d.mat', k); % To build sequential file names, use sprintf.
    mydata{k} = importdata(myfilename);
end

ans2=zeros(3,N);

for i=1:N
    ans2(1,i) = mydata{1,i}.CA_score_LC; % CA score for LC 
    ans2(2,i) = mydata{1,i}.CA_score_GC; % CA score for GC
    ans2(3,i) = mydata{1,i}.CA_score_NCR; % CA score for NCR 
end

for j=1:length(ans2)/2
    data_LC(1,j)=ans2(1,2*j-1);
    data_LC(2,j)=ans2(1,2*j);
    data_GC(1,j)=ans2(2,2*j-1);
    data_GC(2,j)=ans2(2,2*j);
    data_NCR(1,j)=ans2(3,2*j-1);
    data_NCR(2,j)=ans2(3,2*j);
end
%%
subplot(3,1,3)

bar((data_NCR(1,:)),'FaceColor',[0.85,0.33,0.10],'EdgeColor',[1.00,0.41,0.16],'LineWidth',1.5);
hold on
b=bar((data_NCR(2,:)),'FaceColor',[0.00,0.45,0.74],'EdgeColor',[0.07,0.62,1.00],'LineWidth',1.5);
b(1).BaseValue = 0.4342;
xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16])
set(gca,'XTickLabel',{'Qc_{1}','Qc_{2}','Qbc_{1}','Qbc_{2}',...
    'Kc_{1}','Kc_{2}','\lambda_C_R_C','vc_{1}','vc_{2}','CNc'...
    ,'dc','Tc_{1}','Tc_{2}','Tc_{3}','Tc_{4}','Tc_{5}'});
ylabel('CA-Score');
set(gca,'fontweight','bold','FontSize',14);
xtickangle(90);
set(gca,'LineWidth',2);
box on;
title(['NCR'])

subplot(3,1,1)

bar((data_LC(1,:)),'FaceColor',[0.85,0.33,0.10],'EdgeColor',[1.00,0.41,0.16],'LineWidth',1.5);
hold on
b=bar((data_LC(2,:)),'FaceColor',[0.00,0.45,0.74],'EdgeColor',[0.07,0.62,1.00],'LineWidth',1.5);
b(1).BaseValue = 0.3668;
xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16])
% set(gca,'XTickLabel',{'Qc_{1}','Qc_{2}','Qbc_{1}','Qbc_{2}',...
%     'Kc_{1}','Kc_{2}','\lambda_C_R_C','vc_{1}','vc_{2}','CNc'...
%     ,'dc','Tc_{1}','Tc_{2}','Tc_{3}','Tc_{4}','Tc_{5}'});
ylabel('CA-Score');
set(gca,'fontweight','bold','FontSize',14);
xtickangle(90);
set(gca,'LineWidth',2);
box on;
title(['LC'])

subplot(3,1,2)

bar((data_GC(1,:)),'FaceColor',[0.85,0.33,0.10],'EdgeColor',[1.00,0.41,0.16],'LineWidth',1.5);
hold on
b=bar((data_GC(2,:)),'FaceColor',[0.00,0.45,0.74],'EdgeColor',[0.07,0.62,1.00],'LineWidth',1.5);
b(1).BaseValue = 0.2079;
xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16])
% set(gca,'XTickLabel',{'Qc_{1}','Qc_{2}','Qbc_{1}','Qbc_{2}',...
%     'Kc_{1}','Kc_{2}','\lambda_C_R_C','vc_{1}','vc_{2}','CNc'...
%     ,'dc','Tc_{1}','Tc_{2}','Tc_{3}','Tc_{4}','Tc_{5}'});
ylabel('CA-Score');
set(gca,'fontweight','bold','FontSize',14);
xtickangle(90);
set(gca,'LineWidth',2);
box on;
title(['GC'])