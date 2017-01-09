%% Initialize Variables
clc;
close all;
clear;
Path='E:\Coding\GithubSpace\ECSE529_Assignment3_FeatureCodeBook\CroppedYale\yaleB';
Filename='yaleB01_P00A+000E+00.pgm';
Example='E:\Coding\GithubSpace\ECSE529_Assignment3_FeatureCodeBook\CroppedYale\yaleB01\yaleB01_P00A+000E+00.pgm';
count=0;
numNeighbors = 8;
numBins = numNeighbors*(numNeighbors-1)+3;
LBP_matrix=1:59;
codeword_num=256;

%% Load Images
for i=1:39
    
    % Case 1 when i is between 1 and 9
    if i<10
        index=num2str(i);    
        Picture=strcat(Path,'0',index,'\','yaleB','0',index,'_P00A+000E+00.pgm');
        I=imread(Picture);   
        lbpFeatures = extractLBPFeatures(I,'Normalization','None');
        %lbpCellHists = reshape(lbpFeatures,numBins,[]);
        LBP_matrix=[LBP_matrix;lbpFeatures];
        count=count+1;
    end
     
    % Case 2 for the rest number except 14, which does not exist
    if (i>9 && i~=14)
        index=num2str(i);
        Picture=strcat(Path,index,'\','yaleB',index,'_P00A+000E+00.pgm');
        I=imread(Picture);
        lbpFeatures = extractLBPFeatures(I,'Normalization','None');
        %lbpCellHists = reshape(lbpFeatures,numBins,[]);
        LBP_matrix=[LBP_matrix;lbpFeatures];
        count=count+1;
    end
end

%% use all of the extracted features from all images 
% to create a single codebook using a “Bag of Words” approach.

LBP_matrix=LBP_matrix(2:39,1:59);
LBP_hist = reshape(LBP_matrix,1,[]);
%LBP_hist = normr(LBP_hist);
LBP_hist_order = sort(LBP_hist, 'descend');

codebook=LBP_hist_order(1:codeword_num);



%% Assign a color to each one of the 256 code words. 
% Also assign any old texture pattern or image to all the words 
% that are not included in the first 256.




%% Display any 5 original faces using the codebook of 256+1 codewords 
% that are associated with the Bag of Words referred to above. 
% Do this by assigning the appropriate codeword color (1 out of 257) to each pixel in each image.

I=imread(Example);
[row,col]=size(I);

LBP_exam = extractLBPFeatures(I,'Normalization','None');

color=[0,0,0,0,0,0,0];
aaa = [0,0,0,0,0,0,0];
count_same=1;

for i=1:59
    for j=1:codeword_num
        if LBP_exam(i)==codebook(j)
            
            aaa(count_same)=i;
            color(count_same)=j;
            count_same = count_same+1;           
        end
    end
end

LBP=LBP(I);

num=sum(sum(find(LBP==128)));









%{
for i=1:row
    for j=1:col
    end
end
%}


figure(1)
bar(codebook)
title('All')
xlabel('LBP Histogram Bins')
%}

figure(50)
bar(LBP_exam);
title('Example');
xlabel('LBP Histogram Bins');
