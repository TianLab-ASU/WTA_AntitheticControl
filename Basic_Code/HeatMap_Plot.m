function CA_score=HeatMap_Plot(I1,I2,P1s,P2s)
        
[~, SN_1]=max(diff(P1s(:,1))); 
threshold_1= P1s(SN_1,1);
inact_index_1=SN_1+10;

[~, SN_2]=max(diff(P2s(1,:))); 
threshold_2= P2s(1,SN_2);
inact_index_2=SN_2+10;
 
PP1=(P1s(1:inact_index_1,1:inact_index_2)-P2s(1:inact_index_1,1:inact_index_2)); 
PP1(P1s(1:inact_index_1,1:inact_index_2)<threshold_1 & P2s(1:inact_index_1,1:inact_index_2)<threshold_2)=-max(P1s(:))*(1+1/64);  

%heatmap plot
PP11=P1s-P2s;
PP11(1:inact_index_1,1:inact_index_2)=PP1;

imagesc(I1, I2, PP11')
set(gca,'YDir','normal')
a=customcolormap_preset('red-yellow-blue');
colormap(a) 

%%%CA_score
[N,E] = histcounts(P1s); 
[~,locs] = findpeaks(-N);
threshold_1= E(locs(1));

[N,E] = histcounts(P2s);
[~,locs] = findpeaks(-N);
threshold_2= E(locs(1)); 
 
Nx=length(P1s);
PP11=(P1s>threshold_1) & (P2s>threshold_2);
CA_score=sum(PP11(:))/Nx/Nx;  