%% Initialization
clc;
clear;
image_num=38;
codewords_num=256;
visual_word_num=50;
Hist_tot=uint8(zeros(1,visual_word_num)');
idx_tot=uint8(zeros(224,1));
LBP_cell_tot=single(zeros(224,59,image_num));
codebook=single(zeros(codewords_num,59));
Example='E:\Coding\GithubSpace\ECSE529_Assignment3_FeatureCodeBook\Lab\yaleB01_P00A+000E+00.pgm';
Thresh=0.8;
%% Read all of the files 
thisFolder = 'E:\Coding\GithubSpace\ECSE529_Assignment3_FeatureCodeBook\Lab';
filePattern = sprintf('%s/*.pgm', thisFolder);
baseFileNames = dir(filePattern);
numberOfImageFiles = length(baseFileNames);



for f = 1 : numberOfImageFiles
    fullFileName = fullfile(thisFolder, baseFileNames(f).name);
    I_ind=uint8(imread(fullFileName));

    % Extract keypoint using LBP
    LBP = extractLBPFeatures(I_ind,'CellSize',[12,12]);
    LBP_cell=reshape(LBP,[16*14,59]);
    LBP_cell_tot(:,:,f)=LBP_cell;
    
    idx = uint8(kmeans(LBP_cell,visual_word_num,'Distance','cityblock'));
    idx_tot = [idx_tot, idx];
    hist=uint8(zeros(1,visual_word_num));
    
    for i=1:224
        hist(idx(i))=uint8(hist(idx(i))+1);

    end

    hist=hist';
    Hist_tot=[Hist_tot hist];
end

%% Order the codewords in the codebook according to 
% the frequency of their occurrence (from highest to lowest).
idx_tot=idx_tot(1:224,2:image_num+1);
Hist_tot=Hist_tot(1:50,2:image_num+1);
Hist_vec = reshape(Hist_tot,1,[]);
Hist_vec = sort(Hist_vec, 'descend');
cbook=Hist_vec(1:codewords_num);



% Sort the values in descending order and Get a linear index
[sortedValues,sortIndex] = sort(Hist_tot(:),'descend');                               
cbook_idx = sortIndex(1:256);  


for i=1:codewords_num
    R=mod(cbook_idx(i),visual_word_num);
    
    if R==0
        R=50;
    end
    
    
    Q=fix(cbook_idx(i)/visual_word_num);
    column=idx_tot(:,Q+1);
    for j=1:224
        if (column(j)==R)
            codebook(i,:)=single(LBP_cell_tot(j,:,Q+1));
        end
    end
    
    
end

%% Read a testing image file
Example=imread(Example);
LBP_example = extractLBPFeatures(Example,'CellSize',[12,12]);
LBP_example_cell=reshape(LBP_example,[16*14,59]);

figure(1)
imshow(Example);
title('Initial');

%% Compare every patch of the new image file with the visual codewords in the codebook
Compare=zeros(codewords_num,1);
Color_tot1=uint8(zeros(224,1));
for i=1:224
    for j=1:codewords_num
        Compare(j)=sum((LBP_example_cell(i,:)-codebook(j,:)).^2);
    end
    
    % find the closet one
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

% Map the visual codewords to the orignial image
for i=1:192
    for j=1:168
        if (Good(i,j)~=0)
            Example(i,j)=Good(i,j);
        end
    end
end


figure(2)
imshow(Example);
title('Processed by LBP')






