clear all; close all; 

%% 
% ###################################
% ########    PARAMETERS    #########
% ###################################

% For defining the range of possible locations
tmin = -20;     % minimum t
tmax = 20;      % maximum t
stepsize = 0.1; 

% Prior
Mprior = 0;     % mean (represent what your prior belief is)
SDprior = 8;    % standard deviation (represents uncertainty in the prior belief)

% Observation
x = [7 3 -1 8];          % observed location (represent signal from your sensor)
SDx = 4;        % standard deviation for observation (represents uncertainty in the sensor)

%%
% % ##########################
% % #####   Discretize-space method   #####
% % ##########################

% % 1. Define the range of all possible target locations
T = tmin:stepsize:tmax; % T: from tmin to tmax, with spacing = stepsize


% % 2. Compute prior probabilities for each hypothesized location
% %     and normalize them
prior = normpdf(T, Mprior, SDprior);
prior = prior/sum(prior*stepsize);


% % 3. Compute the likelihood of obtaining the current observation,
% %     for each hypothesized location
likelihood_x = normpdf(T, 7, SDx).*normpdf(T, 3, SDx).*normpdf(T, -1, SDx).*normpdf(T, 8, SDx);

% % 4. Compute posterior probabilities for each hypothesized location
% %     by multiplying priors and likelihoods, and then normalize the products
posterior = prior.*likelihood_x;
posterior = posterior/sum(posterior*stepsize);


% % 5. Obtain an estimate from the posterior
% %    This time, we use the expected value of the posterior.
% %      i.e., E(t) = Integrate {t * P( t | x )} dt
% %    We're approximating this integral using summation (the Riemann sum)
% %       Integration --> Summation
% %                dt --> stepsize
estimate = sum(T.*posterior.*stepsize);


% % =================================
% % 6. Plotting
% % =================================
% % plot prior and posterior
figure;
hold on;
plot(T, prior);
plot(T, posterior);


% % plot likelihood
figure;
plot(T, likelihood_x);
