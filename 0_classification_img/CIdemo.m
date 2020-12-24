% function [ output_args ] = CIdemo( input_args )
%CIDEMO Summary of this function goes here
%   Detailed explanation goes here

% show red/green blocks on a grid, ask observers to select one location on the
% grid, and  repond if they see a red block at the selected location in
% each trial

clear all; close('all');

trialnum = 10;

gridsize = 5;
blocksize = 50; 

img_r = zeros(gridsize,gridsize);
img_g = zeros(gridsize,gridsize);
count_r = 0;
count_g = 0;

fig1 = figure(1);
% fig2 = figure(2);
for i = 1:trialnum
    img = binornd(1,1/2,gridsize,gridsize);  % 1 for red, and 0 for green
    img1(:,:,1) = kron(img,ones(blocksize,blocksize));
    img1(:,:,2) = 1-kron(img,ones(blocksize,blocksize));
    img1(:,:,3) = img1(:,:,2)*0;
    
    % add grid here
    img1(1:blocksize:end,:,1)=0;
    img1(:,1:blocksize:end,1)=0;
    img1(1:blocksize:end,:,2)=0;
    img1(:,1:blocksize:end,2)=0;
    img1(1:blocksize:end,:,3)=0;
    img1(:,1:blocksize:end,3)=0;
    figure(fig1); imagesc(img1); title(['trial ' num2str(i)]);
    axis square;
    
    reply = input([sprintf('trial %d:',i)], 's');
    if strcmp(reply,'r')
        img_r = img_r+img;
        count_r = count_r+1;
    else
        img_g = img_g+img;
        count_g = count_g+1;
    end;
    if count_r>0 & count_g>0
        avgimg = img_r/count_r - img_g/count_g;
    end;
    
    if i==trialnum
        maxval = max(max(avgimg));
        [locrow,loccol]=find(avgimg==maxval);

        if maxval < 1
            fprintf('You may have made a mistake in your responses.\n');
        end
        
        if length(locrow) == 1
            fprintf('The location you''ve picked is [Row %d Column %d].\n',locrow,loccol);
        else
            fprintf('There are multiple possible locations. They are: \n');
            for j = 1:length(locrow)
                fprintf('  [Row %d Column %d]\n',locrow(j),loccol(j));
            end;
        end
%         figure(fig2); imagesc(avgimg); axis square;
    end;    
end;
   