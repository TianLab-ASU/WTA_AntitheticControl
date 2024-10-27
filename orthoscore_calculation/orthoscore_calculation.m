function orthoscore=orthoscore_calculation(I1,I2,P1s,P2s,P1s_Base,P2s_Base)
 


[~, SN]=max(diff(P1s_Base(:,1))); 
threshold= P1s_Base(SN,1);
  
PP1_Base=zeros(size(P1s_Base)); 
PP1_Base(P1s_Base<threshold & P2s_Base<threshold)=0;  
PP1_Base(P1s_Base>=threshold & P2s_Base>=threshold)=1;  
PP1_Base(P1s_Base<threshold & P2s_Base>=threshold)=2;  
PP1_Base(P1s_Base>=threshold & P2s_Base<threshold)=3;  

subplot(2,2,1) 
imagesc(I1, I2, PP1_Base')

[~, SN]=max(diff(P1s(:,1))); 
threshold= P1s(SN,1);
  
PP1=zeros(size(P1s)); 
PP1(P1s<threshold & P2s<threshold)=0;  
PP1(P1s>threshold & P2s>threshold)=1;  
PP1(P1s<threshold & P2s>threshold)=2;  
PP1(P1s>threshold & P2s<threshold)=3;  
 
subplot(2,2,2) 
imagesc(I1, I2, PP1')
 
orthoscore=sum(sum((PP1_Base-PP1==0)))/length(PP1_Base)^2;