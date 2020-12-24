clear all; close all; home;

%% 
% ######################
% ##### Parameters #####
% ######################

% v/b = Average use rate
%   The default setting (v=2, b=100) assumes that, 
%   on average, items are used 2 times within 100 time units.
v = 2;
b = 100;

% Suppose an item has been used n times within the past t time units
n = 1;

% time interval
t = 1;

%pt2
a = .4;
N = 1000;

T = 1:100;
% sampling
d = exprnd(a,1,N);

for i = 1:length(T)
    t = T(i);
    
    % calculate P(A|Ha)
    Mt = (1 - exp(-d.*t))./d; % exp(x) gives you e^x
    Elambda = (v+n)./(b+Mt);
    Decay = exp(-d.*t);

    P_A_HA(i) = sum(Elambda.*Decay)/N;
end

plot(T,P_A_HA);
