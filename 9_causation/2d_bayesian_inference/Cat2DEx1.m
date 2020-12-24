clear all; close all; clc;

% load in the inputdata, exemplars for two categories
load('inputdata.mat'); 

% learning exemplars and test examples
testdata = [1 -2;
            2 0;
            3 2.5];
figure('Name','Input data');         
plot(cat1data(:,1), cat1data(:,2),'xr'); hold on
plot(cat2data(:,1), cat2data(:,2),'xb'); hold on;
plot(testdata(:,1),testdata(:,2),'og','MarkerFaceColor','g');
xlim([-5 10]); ylim([-10 10]); axis square; 


% step 1: Define a 2D hypothesis space
dx = 0.5;            % stepsize for the X dimension
dy = 0.5;            % stepsize for the Y dimension
AllX = -10:dx:10;   % 1D line for X
AllY = -10:dy:10;   % 1D line for Y

% Obtain a "joint space"
[Hx, Hy] = meshgrid(AllX, AllY);
H = [Hx(:), Hy(:)];


%% step 2: category learning with parametric method to learn prototypical representations
catmean1 = mean(cat1data); 
catmean2 = mean(cat2data); 

catcov1 = cov(cat1data);
catcov2 = cov(cat2data); 

%% step 3: compute and plot P(X|cat)
probdist1 = mvnpdf(H,catmean1,catcov1); % size is 1681x1
probdist2 = mvnpdf(H,catmean2,catcov2);

figure;
Plotprob1 = reshape(probdist1,size(Hx)); % size is 41x41
mesh(Hx, Hy, Plotprob1); % 3D plot of a "meshed-surface" 
hold on;

Plotprob2 = reshape(probdist2,size(Hx));
mesh(Hx, Hy, Plotprob2); % 3D plot of a "meshed-surface" 
colorbar; % show color bar on figure;

%% step 4: categorization task with new casess    
priorcat1 = 0.5;
priorcat2 = 1-0.5;

for i = 1:size(testdata)
   probdis1_t = mvnpdf(testdata(i,:), catmean1, catcov1);
   probdis2_t = mvnpdf(testdata(i,:), catmean2, catcov2);
   posterior_cat(i) = (probdis1_t*priorcat1)/(probdis1_t*priorcat1+probdis2_t*priorcat2);
end

disp(posterior_cat);





