%% DEMO

clear all; clc; close all;

%% Consider all possible hypotheses

% define possible theta values for hypothesis
theta = 0:0.05:1;

%% Compute the likelihood term P(D|h) for each possible hypothesis
% define data
Nh = 3; % arbitrary, based on lecture
Nt = 2; 

% define likelihood
likelihood = (theta.^Nh).*((1-theta).^Nt)

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


%% Q1

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

