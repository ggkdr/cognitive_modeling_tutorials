clear all; close all; clc;



%% Example 1
% Number of samples
N = 10000;
% Obtain samples from a distribution
mu= 5; sigma = 10;
S = (randn(1,N)*sigma)+mu;

% Plot the histogram of S
figure;
hist(S,50);


% %% Example 2
% % Number of samples
% N = 1000;
% % % Obtain samples from a predifined source
% inputvals = [1 3 5 7 9];
% S2 = randsample(inputvals, N, true, [.5 .1 .2 .15 .05]);
% 
% % % Plot the histogram of S2
% figure;
% [n,xout]=hist(S2,inputvals);
% bar(xout,n);

%% Example 3: Bayes with sampling implementation
% % Number of samples
% N = 100;
% % % Step 1: Draw random samples according to prior distribution
% inputvals = [1 3 5 7 9];
% PriorSample = randsample(inputvals, N, true, [.5 .1 .2 .15 .05]);
% subplot(1,2,1); hist(PriorSample,inputvals); title('prior');
% 
% % % Step 2: Compute the likelihood for each sample
% x = 4;
% SDx = 1; 
% LikelihoodSample = normpdf(x, PriorSample, SDx);
%  
% % % Step 3: compute sample weights
% Weights = LikelihoodSample./sum(LikelihoodSample);
% 
% % % step 4: Resample according to sampling weights to get posterior
% PosteriorSample = randsample(PriorSample, length(PriorSample), true, Weights);
% subplot(1,2,2); hist(PosteriorSample,inputvals); title('posterior');
