clear all; 

load('RTNorm.mat');
exemplars(1,:) = NormalRT;
load('RTTaboo.mat');
exemplars(2,:) = TabooRT;

%1. Define a range of possible feature values
stepsize = 0.1; % stepsize
T = 1:stepsize:1000; % from 0 to 1000

% Width of Gaussian kernel
h = 20; 

% ######################################
% #####  NON-PARAMETRIC INFERENCE  #####
% ######################################

for cati = 1:2
    
    data = exemplars(cati,:);
    % 2. Apply the Gaussian kernel for each observation
    for i = 1:length(data)
        % Apply the Gaussian kernel
        KernVals(i,:) = normpdf(T,data(i),h); %exp((-(T-NormalRT(i)).^2)/(2*h^2));   
    end

    % 3. Sum up kernel values over all observations
    K = sum(KernVals,1); % sum across the first dimension

    % 4. Normalization to approximate P(RT|Category)
    CatDist(cati,:) = K/sum(K*stepsize);
    
end


%5. Compute the probability of a test trial showing a normal word, P(category 1 | RT). 
priorcat1 = 0.5;
priorcat2 = 1-priorcat1;

testval = [200,  460, 560, 600, 763];

% WRITE YOUR OWN CODE
for i = 1:length(testval)
    prob_cat1 = CatDist(1,testval(i)*10)*priorcat1;
    prob_cat2 = CatDist(2,testval(i)*10)*priorcat2;
    post_nonparam_normal_testval(i) = prob_cat1/(prob_cat1+prob_cat2);
end


% ######################################
% #####  PARAMETRIC INFERENCE  #####
% ######################################

%%1. Assume Gaussian distribution for each category. Use the sample mean and
%% the sample variance from exemplars to compute P(RT | Category)
% WRITE YOUR OWN CODE
mean_normal = mean(exemplars(1,:));
std_normal = std(exemplars(1,:));

mean_taboo = mean(exemplars(2,:));
std_taboo = std(exemplars(2,:));

%2. Compute the probability of a test trial showing a normal word, P(category 1 | RT). 
post_param_normal = normpdf(T,mean_normal,std_normal);
post_param_taboo = normpdf(T,mean_taboo,std_taboo);

%3. find category for observed data
for i = 1:length(testval)
    prob_cat1 = post_param_normal(testval(i)*10)*priorcat1;
    prob_cat2 = post_param_taboo(testval(i)*10)*priorcat2;
    post_param_normal_testval(i) = prob_cat1/(prob_cat1+prob_cat2);
end


%% compare category estimation from non-parametric, parametric methods
disp(post_nonparam_normal_testval);
disp(post_param_normal_testval);


% ######################
% #####  PLOTTING  #####
% ######################
% Plotting parameters
figure('Name','Parametric inference');
bins = 10;
xrange = [min(T) max(T)];

%% The exemplar RTs from Normal word category
subplot(2,2,1);
hist(NormalRT,bins);
h = findobj(gca,'Type','patch'); h.FaceColor = 'r';h.EdgeColor = 'w';
ylabel('RT histogram (Normal)');
xlim(xrange);

%% The exemplar RTs from Taboo word category
subplot(2,2,2);
hist(TabooRT,bins); 
h = findobj(gca,'Type','patch'); h.FaceColor = 'b';h.EdgeColor = 'w';
ylabel('RT histogram (Taboo)');
xlim(xrange);
% 

%% P(RT|category) from nonparametric method
subplot(2,2,3);
plot(T,CatDist(1,:),'r'); hold on;
plot(T,CatDist(2,:),'b'); 
ylabel('P( RT | Category )');
title('NonParametric');
xlim(xrange);

%% P(RT|category) from parametric method
subplot(2,2,4);
plot(T,post_param_normal,'r'); hold on;
plot(T,post_param_taboo,'b'); 
ylabel('P( RT | Category )');
title('Parametric');
xlim(xrange);
