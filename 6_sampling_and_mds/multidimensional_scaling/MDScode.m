clear all; % close all; home;

% point of this lab: visualizing similarity using shepard's universal
% typically MDS uses distance matrices, but using shepard's theory,
% we can instead plug in similarity matrices, given that similarity
% is represented by 'psychological distance.'

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Colors %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

% load the input of similarity data from human study
load('colour.mat');

% MDS 
[Y,eigvals] = mdscale(s,2); %mdscale = non-metric, cmdscale = classic/metric

% Plotting
figure('name','color');
plot(Y(:,1),Y(:,2),'.');
text(Y(:,1)+0.01,Y(:,2),labs)
axis auto square;

% color summary:
% cmdscale looks similar to the cie's color space, especially
% on the corners of the graph.

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sport%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
% load the input of similarity data from human study
load('sport.mat');

% MDS 
[Y,eigvals] = mdscale(s,2);

% Plotting
figure('name','sport');
plot(Y(:,1),Y(:,2),'.');
text(Y(:,1)+0.01,Y(:,2),labs)
axis auto square;

% sport summary:
% i think the two axes mean nothing themselves, they just represent
% x,y for the 'similarity matrix.' that is, in the graph, the closer
% that sports are to each other, the more 'related' they are.



%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fruits%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

% load the input of similarity data from human study
load('fruits.mat');

% MDS 
[Y,eigvals] = mdscale(s,2);

% Plotting
figure('name','fruit');
plot(Y(:,1),Y(:,2),'.');
text(Y(:,1)+0.01,Y(:,2),labs)
axis auto square;

% fruit summary
% i think the two axes mean
% it's interesting that 'fruit' is right in the center of the space. it
% makes sense because we are looking at many fruits, so they all have
% the same 'similarity' to the actual term 'fruit'




