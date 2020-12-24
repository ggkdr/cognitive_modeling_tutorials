clear all;

% Input contingency data
a = 12;  % B = 1, C = 1, E = 1
b = 4;   % B = 1, C = 1, E = 0
c = 0;   % B = 1, C = 0, E = 1
d = 16;  % B = 1, C = 0, E = 0


%% Step 1: general samples from prior distriution
samplenum = 100000;
w0 = unifrnd(0,1,1,samplenum);
w1 = unifrnd(0,1,1,samplenum);

%% Step 2: compute likelihood using noisy-or function
% B = 1, C = 1, E = 1
likeli_a = (1-(1-w0).*(1-w1)).^a;
% B = 1, C = 1, E = 0
likeli_b = ((1-w0).*(1-w1)).^b;
% B = 1, C = 0, E = 1
likeli_c = w0.^c;
% B = 1, C = 0, E = 0
likeli_d = (1-w0).^d;

likelihood = likeli_a.*likeli_b.*likeli_c.*likeli_d;

%% Step 3: Normalize likelihood to compute the sampling weights
weight = likelihood/sum(likelihood);

%% Step 4: generate the posterior random samples
postindx = randsample(1:samplenum,samplenum,true,weight);

%% Step 5: plot the histograms of posterior samples for wb and wc
postwbsample = w0(postindx);
subplot(1,2,1); 
hist(postwbsample,50); 
title('Wb hist');

postwcsample = w1(postindx);
subplot(1,2,2); 
hist(postwcsample,50);
title('Wc hist'); 


%% Step 6: Compute the median value of w1
ans = median(w1(postindx));
disp(ans);
