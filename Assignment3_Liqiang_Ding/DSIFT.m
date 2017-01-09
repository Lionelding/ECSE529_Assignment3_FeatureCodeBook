%% Initialization
clc;
clear;
image_num=38;
codewords_num=256;
visual_word_num=50;
Hist_tot=uint8(zeros(1,visual_word_num)');
idx_tot=uint8(zeros(224,1));
LBP_cell_tot=single(zeros(224,59,image_num));
SIFT_cell_tot=single(zeros(2,29097,image_num));
codebook=single(zeros(codewords_num,59));
Example='E:\Coding\GithubSpace\ECSE529_Assignment3_FeatureCodeBook\CroppedYale\yaleB01\yaleB01_P00A+000E+00.pgm';
Thresh=0.5;
%% Read all of the files 
thisFolder = 'E:\Coding\GithubSpace\ECSE529_Assignment3_FeatureCodeBook\Lab';
filePattern = sprintf('%s/*.pgm', thisFolder);
baseFileNames = dir(filePattern);
numberOfImageFiles = length(baseFileNames);


for f = 1 : numberOfImageFiles
    fullFileName = fullfile(thisFolder, baseFileNames(f).name);
    I_ind=single(imread(fullFileName));

    % Extract keypoint using LBP
    %LBP = extractLBPFeatures(I_ind,'CellSize',[12,12]);
    [SIFT_location,SIFT]=vl_dsift(I_ind);
    
    SIFT=uint8(SIFT);
    %LBP_cell=reshape(LBP,[16*14,59]);
    %LBP_cell_tot(:,:,f)=LBP_cell;
    %SIFT_cell_tot(:,:,f)=SFIT
    
    %idx = uint8(kmeans(LBP_cell,visual_word_num,'Distance','cityblock'));
    
    idx = uint8(kmeans(SIFT,visual_word_num,'Distance','cityblock'));
    
    %idx_tot = [idx_tot, idx];
    %hist=uint8(zeros(1,visual_word_num));
    
    % Extract keypoint using DSIFT
    


    
   
    
    
    

    for i=1:224
        SIFT_hist(idx(i))=uint8(SIFT_hist(idx(i))+1);

    end

    SFIT_hist=SFIT_hist';
    SFITHist_tot=[SFIT_Hist_tot SFIT_hist];

end



Example=imread(Example);
LBP_example = extractLBPFeatures(Example,'CellSize',[12,12]);
LBP_example_cell=reshape(LBP_example,[16*14,59]);

figure(1)
imshow(Example);
title('Initial');

Compare=zeros(codewords_num,1);
Color_tot1=uint8(zeros(224,1));
for i=1:224
    for j=1:codewords_num
    Compare(j)=sum((LBP_example_cell(i,:)-codebook(j,:)).^2);

    end
    
    minimum=min(Compare);
    if minimum < Thresh
        color=find(Compare==minimum);
    else
        color=0;
    end
    
    Color_tot1(i)=color(1);
end


Color_tot2=reshape(Color_tot1,[16,14]);
Good = repelem(Color_tot2,12,12);


for i=1:192
    for j=1:168
        if (Good(i,j)~=0)
            Example(i,j)=Good(i,j);
        end
    end
end


figure(2)
imshow(Example);
title('Processed by HoG')
