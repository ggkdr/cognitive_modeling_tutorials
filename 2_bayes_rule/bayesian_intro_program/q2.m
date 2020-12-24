%% Q2

clear all; clc; close all;

%% Consider all possible hypotheses

% define possible theta values for hypothesis
stepSize = 0.01;
theta = 0:stepSize:1;

%% Compute the likelihood term P(D|h) for each possible hypothesis
% define data
Nh = 3; % arbitrary, based on lecture
Nt = 2; 

% define likelihood
likelihood = (theta.^Nh).*((1-theta).^Nt);

% display the array of theta and corresponding likelhood values
[theta' likelihood']

% plot the likelihood as a function of theta
figure('Name','likelihood');
plot(theta, likelihood);
xlabel('\theta'); ylabel('Likelihood');


% MLE estimation
[MaxL, MaxID] = max(likelihood);

% display the MLE estimate
disp('MLE estimate: theta =');
MLEest = theta(MaxID);
disp(MLEest);

%% Compute the prior distribution P(h) for each possible hypothesis
% define parameters for priors
Vh = 10;
Vt = 10; 
aval = Vh+1;
bval = Vt+1;

% compute the prior distribution
prior = ((theta.^(aval-1)).*((1-theta).^(bval-1)))/beta(aval,bval);

% plot the prior distribution
figure('Name','Prior');
plot(theta, prior); 
xlabel('\theta'); ylabel('Prior');
sum(prior*0.05); %sanity check, should == 1.00

% compute the posterior distribution P(h|D) by combining likelihood and prior
post = likelihood.*prior;
[MaxP, MaxID] = max(post);

% MAP estimate
disp('MAP estimate: theta =');
MAPest = theta(MaxID);
disp(MAPest);

% plot
figure('Name','Posterior');
plot(theta, post); 
xlabel('\theta'); ylabel('Posterior');

%% Reflections on step size
% I toyed with the provided data, as well as with the 'fairness' of the
% priors and the stepsize, and I saw that they all changed my results
% significantly. Specifically, when I changed the step size, I saw two
% things. The distribution was smoother, and actually the MAP estimate
% changed from 0.55 to 0.52 for a mostly 'fair' coin (i.e. originally provided data).
% It seems like the more hypotheses that are accounted for, the better
% the estimation of MLE, MAP. 

