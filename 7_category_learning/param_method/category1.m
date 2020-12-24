clear all; close all; home;

% Defining all necessary parameters;
% Variability in Response time
variance = 1600;
sd = sqrt(variance);

% Observations
NormalRT = [594 483 672 491];

% #################################################################
% ##### Part 1:   Discretize-space method   
% #################################################################

% Define space
stepsize = 1;
Mu = 1:stepsize:1500;

% 1. Prior with unif distribution
prior = ones(1,length(Mu))/length(Mu);
prior = prior/sum(prior*stepsize);

% 2. Likelihood: compute the likelihood for each observation, and then comppute the product across observations 
for i = 1:length(NormalRT)
    L(i,:) = normpdf(NormalRT(i),Mu,sd);
end
Lprod = prod(L,1);

% 3. Compute the posterior distribution of mu
Posterior = Lprod.*prior;
Posterior = Posterior/sum(Posterior*stepsize);

% Plot the likelihood functions and the posterior distribution of mu
figure('Name','Discretize-Space');
for i = 1:length(NormalRT)
    plot(Mu,L(i,:),'g','Linewidth',2);
    hold on;
end
plot(Mu,Posterior,'r','Linewidth',2);
xlabel('\mu');


% 4. Compute the expected value of variance of mu using posterior distriution
PostMean = sum(Mu.*Posterior*stepsize);
PostVar = sum((Mu-PostMean).^2.*Posterior*stepsize);

% ###############################################################################
% ##### Part 2:   sampling method   #####
% ###############################################################################
% define number of samples
N = 50000;

% draw random samples from prior distribution
prior_s = unifrnd(1,1500,1,N);

% Compute the likelihood for each sample, and then use the likelihood to compute the weight for
% each sample
for i = 1:length(NormalRT)
    L_s(i,:) = normpdf(NormalRT(i),prior_s,sd);
end
L_s_prod = prod(L_s,1);
L_weights = L_s_prod/sum(L_s_prod);

% 5. redraw the random sample from the posterior distribution
% Use the randsample() function to resample based on Weights computed above.
posterior_sample = randsample(prior_s,N,true,L_weights);


% % plotting: prior and posterior samples. use hist() function to plot histograms
figure('Name','Sampling method');
subplot(2,1,1); hist(prior_s,100);
subplot(2,1,2); hist(posterior_sample,100);


% 6. Compute the mean and variance from posterior samples
PostMean_s = mean(posterior_sample);
PostVar_s = var(posterior_sample);


