clear all; 

% load exemplar RT inputs
load('RTTaboo.mat');

% Define a range of possible feature values
stepsize = 0.1; % stepsize
T = 1:stepsize:1000; % from 0 to 1000

% Width of Gaussian kernel
h = 20; 

% ########################################################
% #####  NON-PARAMETRIC INFERENCE  WITH KERNEL METHOD#####
% ########################################################

% 1. Apply the Gaussia kernel for each observation
for i = 1:length(TabooRT)
    for j = 1:length(T)
        k(i,j) = exp(-1*((T(j)-TabooRT(i))^2)/(2*(h^2)));
    end
end

% 2. Sum up kernel values over all observations
kernel_sum = sum(sum(k)); % scalar sum of matrix ~ target RT distribution

% 3. Normalization for P(RT|normal word category)
k = k/kernel_sum; % normalize entire matrix
k = sum(k); % collapse observation-dimension to get distribution for each T(i)

% 4. Compute mean and SD of your inferred distributions
Mean = sum(T.*k);
Variance = sum((T-Mean).^2.*k);

% could also use sampling method


% ######################
% #####  PLOTTING  #####
% ######################
% Plotting parameters
figure;
bins = 100;
xrange = [min(T) max(T)];

% The sampled RTs
subplot(2,1,1);
hist(TabooRT,bins);
ylabel('Histogram of exemplar RTs');
xlim(xrange);

%% plot P(RT|normal word category)
subplot(2,1,2);
plot(T,k);
ylabel('P( RT | Taboo words )');
xlim(xrange);


%%% What do I see?
% a graph with three humps
% 7x as much varaince
% similar mean

%%% What does this mean?
% maybe it's more difficult to categorize taboo words -> more spread from
% "average" category
%
% maybe there are three distinct categories of taboo words?

