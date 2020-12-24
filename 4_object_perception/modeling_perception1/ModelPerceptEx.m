clear all; close all; clc;

% Define the range of all possible locations, theta
%   [Hint: define stepsize as a variable for later use]
stepsize = 0.1;
theta = -20:stepsize:20;

% Define Prior as the sum of two Gaussians
%   [Hint:  Simply add up two normpdf()]
%   [       Remember to normalize it afterward]
%   [       To normalize a distribution P, divide it by sum(P*stepsize)]
prior = normpdf(theta, -3, 2) + normpdf(theta, 7, 2);
prior = prior/sum(prior*stepsize);

% Compute Likelihood based on the Gaussian distribution
%   [Hint: Simply use the normpdf()]
likelihood = normpdf(theta, 3, 2);

% Comptue Posterior
%   [Hint:  Multiply Prior with Likelihood, elementwise]
%   [       Normalize the Posterior afterward]
posterior = prior.*likelihood;
posterior = posterior/sum(posterior*stepsize);

% Find the maximum a posteriori (MAP) estimate of location, theta
%   [Hint:  Use max() to find what and where the maximum value is in Posterior]
%   [       Retrieve the value in the theta vector corresponding to the MAP position]
[value, index] = max(posterior);
MAP_location = theta(index);
MAP_value = value;


% Plot Prior, Likelihood and Posterior on the same graph
% [Hint: You may find the following two lines helpful]
% figure;   % To open a new figure window
% hold on;  % To enable multiple lines plotting on the same figure
% Then, just go ahead and plot them one by one:
%   plot(theta, WhateverYouWantToPlot);
% To use different colors for different lines, try this:
%   plot(X,Y,'r'); % plots the line in RED
%
%   Type "doc linespec" in the Command Window 
%       for more info on line specifications!

figure;
hold on;
plot(theta, prior);
plot(theta, likelihood);
plot(theta, posterior);
