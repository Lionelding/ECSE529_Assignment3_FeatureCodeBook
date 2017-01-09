
%{
I = imread('E:\Coding\GithubSpace\ECSE529_Assignment3_FeatureCodeBook\CroppedYale\yaleB01\yaleB01_P00A+000E+00.pgm');
LBP = extractLBPFeatures(I,'CellSize',[12,12]);
LBP_cell=reshape(LBP,[16*14,59]);
%{
figure(1)
bar(LBP_cell);
title('All');
xlabel('LBP Histogram Bins');
%}
idx = kmeans(LBP_cell,12,'Distance','cityblock');

hist=zeros(1,12);
for i=1:224
    hist(idx(i))=hist(idx(i))+1;
end
hist=uint8(hist');

Hist_tot=uint8(zeros(1,12)');
Hist_tot=[Hist_tot hist];
%}

%bag = bagOfFeatures(I,'Verbose',false);
%featureVector = encode(idx3,I);


A=[2,3,4,5;1,2,100,100;20,50,60,70]

[sortedValues,sortIndex] = sort(A(:),'descend');  %# Sort the values in
                                                  %#   descending order
maxIndex = sortIndex(1:3);  %# Get a linear index into A of the 5 largest values

B=uint8(ones(300,300)*1);
imshow(B);



