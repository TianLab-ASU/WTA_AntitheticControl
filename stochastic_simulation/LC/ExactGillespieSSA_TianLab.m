function [t,X,r0]=ExactGillespieSSA_TianLab(DefineReactions,tspan, IC)
%Implementation of Gillespie Exact Stochastic Algorithm.

%set the uniform random number generator
% rng('default'); 
% rng('shuffle');
t=zeros(99999999,1);
X=zeros(99999999,length(IC));
nRC  = 0;  %reaction counter
t(1) = tspan(1);
maxT = tspan(2);
X(1,:)= IC;  % initialize the matrix of chemicals
r0=[];
%------------------------------------------------------------
while (t(nRC+1)<maxT && any(X(nRC+1,:))) 
  
    [S, P, K] = DefineReactions(t,X(nRC+1,:)); % defines reaction stoichiometry
%     [R, C] = size(S);
    %step 1: Calculate a's (reaction rates given system state)
    R_num0=S.*repmat(X(nRC+1,:),length(S),1);
    R_num=R_num0;
    R_num(~S)=1; 
    a=K.*prod(R_num,2);

    a0 = sum(a); % a0 is the total rate of change of system
    if a0 == 0 % system can't change; finish and exit;
%         X(end+1,:) = X(end,:);
%         t =[t; maxT]; 
        t(nRC)=maxT;
        X(nRC+1,:)=X(nRC,:);
        break;
    end 
    %Step 2: calculate tau and r using random number generators
    % determine time of next reaction:
    p1  = rand;  tau = (1/a0)*log(1/p1);
    % determine which next reaction is:
    p2 = rand;
    r=find(cumsum(a)/a0>=p2,1,'first');
 
    %Step 3: carry out the reaction
    nRC = nRC + 1       ; % nRC is number of reactions so far.
%     t =[t; t(end) + tau];  % t is time array; add last entry to it.
%     X(end+1,:)=X(end,:)-S(r,:)+P(r,:);
    t(nRC+1)=t(nRC) + tau;
    X(nRC+1,:)=X(nRC,:)-S(r,:)+P(r,:);

end
 
index=find(t(2:end)==0,1);
t=t(1:index-1);
X=X(1:index-1,:); 
