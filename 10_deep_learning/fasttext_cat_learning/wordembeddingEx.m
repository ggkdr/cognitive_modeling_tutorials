clear all; close all;

load('wordsinput.mat'); 
load('testwordsinput.mat');

cat1num = 15;  % # of exemplars for fruit category
cat2num = 15;  % # of exemplars for vegetable category

% part A: MDS
% use pdist function to compute cosine distances
wordinput = [wordvec; testwordvec];
distvec = pdist(wordinput,'cos');
distmat = squareform(distvec);

% use nonmetric MDS
[Ymsd,eigvals] = mdscale(distmat,2);

% Plotting
figure('name','MDSresult');
plot(Ymsd(1:cat1num,1),Ymsd(1:cat1num,2),'.r'); hold on;
plot(Ymsd(cat1num+1:cat1num+cat2num,1),Ymsd(cat1num+1:cat1num+cat2num,2),'.b'); hold on;
plot(Ymsd(cat1num+cat2num+1:end,1),Ymsd(cat1num+cat2num+1:end,2),'+g'); hold on;
for i = 1:size(wordinput,1)
    if i<cat1num+1
        text(Ymsd(i,1)+0.01,Ymsd(i,2),wordlist{i},'Color','r');
    elseif i<cat1num+cat2num+1
        text(Ymsd(i,1)+0.01,Ymsd(i,2),wordlist{i},'Color','b'); 
    else
        text(Ymsd(i,1)+0.01,Ymsd(i,2),testwordlist{i-30},'Color','g');   
    end;
end;
axis auto square;

% Part B: categorization with parametric method of prototype theory
% input 2d feature data of 15 exemplars in each category
cat1data = Ymsd(1:cat1num,:);       % fruits
cat2data = Ymsd(cat1num+1:cat1num+cat2num,:);   % veg.
testdata = Ymsd(cat1num+cat2num+1:end,:);  

% learn prototype represenations from exemplars
catmean1 = mean(cat1data); 
catmean2 = mean(cat2data); 

catcov1 = cov(cat1data); 
catcov2 = cov(cat2data); 

% Part C: Categorization task for test data
priorcat1 = 0.5;
priorcat2 = 1-0.5;

for ti = 1:size(testdata,1)
    probcat1 = mvnpdf(testdata(ti,:), catmean1, catcov1);
    probcat2 = mvnpdf(testdata(ti,:), catmean2, catcov2);
    
    postprobcat1(ti) = (probcat1*priorcat1)/(probcat1*priorcat1 + probcat2*priorcat2);
end;

testwordlist;
postprobcat1;
