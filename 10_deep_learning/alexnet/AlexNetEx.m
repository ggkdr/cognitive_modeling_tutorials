clear all; close all; 

% load pre-trained model
net = alexnet;
net.Layers
inputSize = net.Layers(1).InputSize  % input image size: 227 * 227 * 3

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 1: classify an image using AlexNet
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

testimg = imread('img3.png');
testimginput = testimg(1:inputSize(1),1:inputSize(2),1:inputSize(3));
[label_testimg,scores] = classify(net,testimginput);
figure
imshow(testimginput)
title([label_testimg num2str(max(scores))])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % step 2: Feature extraction using AlexNet, and then use MDS show the similarity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
unzip('MerchData.zip'); 

% read in dataset
imds = imageDatastore('MerchData', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
numImagesTrain = numel(imds.Labels);
labellist = cellstr(imds.Labels);

% display some sample images from the data set
indx = 3:3:numImagesTrain;
for i = 1:length(indx)
    I{i} = readimage(imds,indx(i));
end
figure
imshow(imtile(I));

% Test dataset
augimdsdata = augmentedImageDatastore(inputSize(1:2),imds);

layers = ["fc7", "conv2", "conv5"]
figure('name','MDSresult');
for i = 1:length(layers)
    layer = layers(i);
    
    % extract fecture vectors from AlexNet layer
    featureVecs = activations(net,augimdsdata,layer,'OutputAs','rows');
    
    % part A: MDS
    % use pdist function to compute cosine distances
    distvec = pdist(featureVecs,'cos');
    DistMat = squareform(distvec);

    % use nonmetric MDS
    [Ymsd,eigvals] = mdscale(DistMat,2);

    % Plotting
    subplot(1,3,i);
    colorindx = kron([1 2 3 4 5],ones(1,15));
    colorvec = {'r','g','b','m','k'};
    for i = 1:length(labellist)
        plot(Ymsd(i,1),Ymsd(i,2),'x','MarkerEdgeColor',colorvec{colorindx(i)}); hold on;
    end;
    title(layer);
    
    for i = 1:15:length(labellist)
        text(Ymsd(i,1)+0.01,Ymsd(i,2),labellist{i}(11:end),'Color',colorvec{colorindx(i)});
    end;

    axis auto square;
end