clear all; close all; clc;

T=1:100; % try out many possible inputs (t's)

%only need to allocate once, save memory
ttotalmax = 150;
stepsize = 1.0;
m = 78;
sd = 13;

for i = 1:length(T)
    t = T(i);
    ttotal = t:stepsize:ttotalmax;
    
    %need to clear every time, since size shrinks by 1 every loop
    prior = [];
    prior = normpdf(ttotal, m, sd);
    prior = prior/sum(prior*stepsize);

    %figure('Name','Prior');
    %plot(ttotal,prior);
    
    likelihood = [];
    for j = 1:length(ttotal)
        if t>ttotal(j)
            likelihood(j)=0;
        else
            likelihood(j)=1/ttotal(j);
        end
    end

    %figure('Name','Likelihood');
    %plot(ttotal,likelihood);
    
    posterior = [];
    posterior = likelihood.*prior;
    posterior = posterior/sum(posterior*stepsize);
    
    %figure('Name','Posterior');
    %plot(ttotal,posterior);

    posteriorCP = cumsum(posterior*stepsize);
    diffCP = posteriorCP - 0.5;
    diffCP = abs(diffCP);

    [val, ind] = min(diffCP);
    
    ModelPred(i) = ttotal(ind);
end

figure('Name','Estimates of Lifespan for Range T');
plot(T,ModelPred);
xlim([0 100]);
ylim([0 150]);