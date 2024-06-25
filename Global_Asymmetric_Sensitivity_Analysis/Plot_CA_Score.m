clear
clc
matfiles = dir('*.mat') ; 
N = length(matfiles) ; 
mydata = cell(1, N);

for k = 1:N
  myfilename = sprintf('Data_Antithetic_Global_Asym%d.mat', k); % To build sequential file names, use sprintf.
  mydata{k} = importdata(myfilename);
end

ans2=zeros(3,N);
for i=1:N
ans2(1,i) = mydata{1,i}.CA_score_LC; % CA score for LC 
ans2(2,i) = mydata{1,i}.CA_score_GC; % CA score for GC
ans2(3,i) = mydata{1,i}.CA_score_NCR; % CA score for NCR
end
%%
figure()
histogram(ans2(1,:),'LineWidth',1.5,'FaceColor',[1 0 0],'FaceAlpha',0.5,'EdgeColor',[1 0 0],'DisplayName','LC')
hold on;
histogram(ans2(2,:),'LineWidth',1.5,'FaceColor',[0 0.4470 0.7410],'FaceAlpha',0.5,'EdgeColor',[0 0.4470 0.7410],'DisplayName','GC')
hold on;
histogram(ans2(3,:),'LineWidth',1.5,'FaceColor',[0.9290 0.6940 0.1250],'FaceAlpha',0.5,'EdgeColor',[0.9290 0.6940 0.1250],'DisplayName','NCR')
xlabel('CA-Score');
ylabel('Counts');
set(gca,'LineWidth',2);
box on;
set(gca,'fontweight','bold','FontSize',14);