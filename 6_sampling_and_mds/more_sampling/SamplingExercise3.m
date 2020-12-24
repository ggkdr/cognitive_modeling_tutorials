% an exercise with three observations

clear all; close all; clc;

%% 
% ###################################
% ########    PARAMETERS    #########
% ###################################

% Prior
m1 = -3;     % first peak in prior
m2 = 7;      % second peak in prior 
s = 2;      % standard deviation (represents uncertainty in the prior belief)

% Observation
x = [3 3.4 2.6];          % observed location (represent signal from your sensor)
sx = 2;         % standard deviation for observation (represents uncertainty in the sensor)

% Number of samples (for the Sampling method)
N = 10000;

%% 
% ########################
% #####   SAMPLING   #####
% ########################

% =============================================================
% Step 1:
% Goal: Sample from the prior distribution
% 1. Define the range of all possible target locations
tmin = -20;     % minimum t
tmax = 20;      % maximum t
stepsize = .01; 
t = tmin : stepsize : tmax; % T: from tmin to tmax, with spacing = stepsize


% [WRITE YOUR CODES BELOW]
% 2. Compute prior probabilities for each possible location
prior = normpdf(t,m1,s) + normpdf(t,m2,s);
prior_weights = prior/sum(prior);

% 3: draw random samples according to the prior distribution
prior_sample = randsample(t,N,true,prior_weights); %first param is t, not prior, because we just needed weights

% =============================================================
% Step 2:
% Goal: Compute the likelihood for each sampled t(i) using normpdf(X,M,SD) function
% At observation x, we assume the likelihood probability
%  to be obtained from a normal distribution at x, 
%  with mean = t(i) and standard deviation = SDx

% [WRITE YOUR CODES BELOW]
for i = 1:length(x)
    likelihood_loc(i,:) = normpdf(x(i),prior_sample,sx);
end
likelihood = prod(likelihood_loc,1);

% =============================================================
% Step 3:
% Goal: Compute the weight for each sampled t(i)

% MATLAB syntax:
% Simply divide each likelihood by the sum of all likelihoods,
%  and assign the output to a vector called Weights, or anything you like.

% [WRITE YOUR CODES BELOW]
weights = likelihood/sum(likelihood);


% =============================================================
% Step 4:
% Goal: Resample from all t's, based on Weights computed in Step 3.
% This step is equivalent to sampling from the posterior distribution.
% 

% MATLAB syntax:
% To obtain samples from an existing vector, 
%  use the randsample() function.
% E.g.,    randsample(SOURCE, K, true, W)
%  draws K random samples from all elements in vector SOURCE
%   with each element being weighted by the weight vector W


% [WRITE YOUR CODES BELOW]
posterior_sample = randsample(prior_sample,N,true,weights);

% =============================================================
% Step 5:
% Goal: Obtain an estimate from the posterior samples
%  To be consistent with the Analytical method, 
%  we use the mean of the posterior distribution as an estimate.

% MATLAB syntax:
% Use the mean() function
% E.g.,  mean(S)  returns the mean across all elements in vector S
% Use the median() function
% E.g.,  median(S)  returns the median across all elements in vector S
mean_estimate = mean(posterior_sample);
median_estimate = median(posterior_sample);


% ##################################
% ##### (2)REPORTING RESULTS   #####
% ##################################

% [WRITE YOUR CODES BELOW]



% % ##################################
% % #####  (3)DISTRIBUTION PLOT  #####
% % ##################################
% Define figure properties
figure('Name','Model Results');     % open a new figure window, with the name "Model Results"
plotrow = 3;                        % number of rows of plots in the figure
plotcol = 1;                        % number of columns of plots in the figure
a = zeros(1,plotrow*plotcol);       % declare vector a, for storing all axis indices for later formatting

a(1) = subplot(plotrow,plotcol,1); % define subplot location
% Plot the HISTOGRAM of all samples from the Prior sampling
% This should resemble the prior distribution

% Fill in the blank: a vector containing samples from the PRIOR distribution
hist(prior_sample,200);
ylabel('Prior');


a(2) = subplot(plotrow,plotcol,2); % define subplot location
% Plot the likelihood computed for each prior sample
% This should resemble the likelihood probabilities from analytical method

% X axis: the vector containing samples from the PRIOR distribution
% Y axis: the vector containing LIKELIHOOD probabily for each sample
plot(prior_sample, likelihood,'.');
ylabel('Likelihood');


a(3) = subplot(plotrow,plotcol,3); % define subplot location
% Plot the HISTOGRAM for the posterior sampling
% This should resemble the posterior distribution

% Fill in the blank: a vector containing samples from the POSTERIOR distribution
hist(posterior_sample,200);
ylabel('Posterior');

% ...........................
% ... Formatting the axis ...
% ...........................

% Set X axis limits to [tmin tmax], for all axes indexed in a
set(a,'Xlim',[tmin tmax]);


% #####################################
% #####   (4)COMPUTE PROBABILITY  #####
% #####################################
% use the posterior samples to compute the relative frequency that samples
% take values with the range of 3 to 5.

% [WRITE YOUR CODES BELOW]
relative_frequency_values = posterior_sample(3<posterior_sample & posterior_sample<5);
relative_frequency = length(relative_frequency_values)/N;


% ########################################
% #####   (5)COMPUTE MODEL EVIDENCE  #####
% ########################################
% use the likelihoods for samples to compute model evidence

% [WRITE YOUR CODES BELOW]
model_evidence = sum(likelihood)/N;

disp(mean_estimate);
disp(median_estimate);
disp(relative_frequency);
disp(model_evidence);



