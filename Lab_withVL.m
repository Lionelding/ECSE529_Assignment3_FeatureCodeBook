I = imread('gantrycrane.png');
I = rgb2gray(I);
imshow(I);
lbpFeatures = extractLBPFeatures(I,'CellSize',[32 32],'Normalization','None');

numNeighbors = 8;
numBins = numNeighbors*(numNeighbors-1)+3;
lbpCellHists = reshape(lbpFeatures,numBins,[]);

lbpCellHists = bsxfun(@rdivide,lbpCellHists,sum(lbpCellHists));
lbpFeatures = reshape(lbpCellHists,1,[]);