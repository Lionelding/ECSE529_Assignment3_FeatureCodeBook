
target=find(hist==max(hist));
count2average=0;
temp=zeros(1,59);
for i=1:224
    if idx(i)==target
        disp(i);
        temp=LBP_cell(i,:)+temp;
        count2average=count2average+1;   
    end
end
goodtemp=temp/count2average;

aa=[100,100];
)