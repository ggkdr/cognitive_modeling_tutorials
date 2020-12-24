clear all; close all; clc;


% ########################################################
% ###########                              ###############
% ###########          INTRODUCTION        ###############
% ###########                              ###############
% ########################################################
% Human's Task:
% A person is now t years old, how many years in total (ttotal) will he/she live?

% The Model's Goal:
% Given a number t, estimate the ttotal from human prediction

% Model specifications
% - Likelihood:   P( t | ttotal ) = 1/ttotal
% - Prior:        P( ttotal ) = normal distribution on ttotal, with a certain mean and s.d.



% ########################################################
% ##############                            ##############
% ##############     Step-by-step Guide     ##############
% ##############                            ##############
% ########################################################

% ************************************************************************
% 1. Define input t (the current age of the person)

t=80;

% ************************************************************************
% 2. Define vector ttotal (stores all possible estimates)
%    [Hint: values smaller than t must be impossible]
%    [      So, ttotal should be from t to a reasonably large value]
%     i) Define the maximum value for ttotal
%    ii) Define stepsize
%   iii) Define ttotal as an evenly spaced vector, from t to ttotalmax


ttotalmax = 150;
stepsize = 1.0;
ttotal = t:stepsize:ttotalmax;

% ************************************************************************
% 3. Compute Prior probability for each value in ttotal
%       Prior = P( ttotal )
%      i)  Define mean lifespan (Suggestion: m = 78)
%     ii)  Define standard deviation of lifespan (Suggestion: sd = 13)

m = 78;
sd = 13;

%    iii)  Prior = normal pdf computed for all ttotal, based on mean and s.d.
%           - use normpdf(ttotal, mean lifespan, standard deviation of lifespan)

prior = normpdf(ttotal, m, sd);

%     iv)  Normalize prior distribution
%           - Reason: Because prior is a probability density function (pdf)
%           - Goal: to make sum(Prior*stepsize) = 1
%           - Method: 
%              a) Compute the current value for sum(Prior*stepsize)
%              b) Divide current Prior by the sum computed in a)
%                   to obtian a normalized Prior

prior = prior/sum(prior*stepsize);


% ************************************************************************
% !! Checkpoint: Try running the script and see if everything works!!
% ************************************************************************

figure('Name','Prior');
plot(ttotal,prior);


% 4. Compute Likelihood on a given t for all possible ttotal values
%       Likelihood = P( t | ttotal )
%    We use the likelihood function below:
%     P(t|ttotal) = 0, if t>=ttotal
%     P(t|ttotal) = 1/ttotal, if 0<t<ttotal
%    [Hint: remember to use the element-wise division for 1/ttotal]

for i = 1:length(ttotal)
    if t>ttotal(i)
        likelihood(i)=0;
    else
        likelihood(i)=1/ttotal(i);
    end
end

figure('Name','Likelihood');
plot(ttotal,likelihood);

% ************************************************************************

% 5. Compute the posterior probability distribution over all possible
%      ttotal values:     Posterior = P( ttotal | t)
%
%      i) Posterior = Likelihood * Prior, element-wise
posterior = likelihood.*prior;

%     ii) Normalize Posterior (because Posterior is a pdf)
%           a) Compute the current value for sum(Posterior*stepsize)
%           b) Divide current Posterior by the sum computed in a)
%               to obtian a normalized Posterior
%           c) Plot ttotal on the x-axis and the normalized posterior on
%           the y-axis

posterior = posterior/sum(posterior*stepsize);
figure('Name','Posterior');
plot(ttotal,posterior);


% ************************************************************************
% 6. Obtain Median of Posterior as T_Estimate
%
%       i) Compute the cumulative probabilities (CP) for Posterior
%          [Hint: cumsum() is a function that returns a vector of cumulative sums]
%           If A = [2 8 3 5 1],   
%              cumsum(A) returns [2  2+8  2+8+3  2+8+3+5  2+8+3+5+1]
%           PosteriorCP should be a cumulative sum of Posterior*stepsize]

posteriorCP = cumsum(posterior*stepsize);


%      ii) Now, PosteriorCP is a vector with increasing values of probabilities
%           i.e.,  PosteriorCP(1) <= PosteriorCP(2) <= ... <= PosteriorCP(end)
%          Rationale: 
%           We know that, at the median, the cumulative prob is approximately 0.5
%           Therefore, we want to locate the value in PosteriorCP that is closest to 0.5
%           We then obtain the median value from ttotal based on that position

%           Subtract 0.5 from each value in PosteriorCP

diffCP = posteriorCP - 0.5;


%     iii) Compute the absolute value for each difference obtained in ii)
%           [Hint: absolute values of all values in X: abs(X)]

diffCP = abs(diffCP);


%      iv) Find the POSITION of the MINIMUM value in the vector obtained in iii)

[val, ind] = min(diffCP);


%       v) The Median is given by the "k-th" value in the ttotal vector,
%           where k is the position obtained in iv). Use this to find the
%           estimated age this person will live to.

median = ttotal(ind);

% ************************************************************************

