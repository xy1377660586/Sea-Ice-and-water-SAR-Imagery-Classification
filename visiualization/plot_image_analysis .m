clear;
clc

IA=importdata('20140210_103911.tif');
IAa=double(IA);

%set ice analysis to 1 or 0 and set land to nan
[m,n]=size(IAa);
for i=1:m
    for j=1:n
   if    IAa(i,j)==11;
       IAa(i,j)=NaN;      
    end;
    end;
end;

 for i=1:m
    for j=1:n 
     if IAa(i,j)<=3
            IAa(i,j)=0;
        end;
   
    end;
  end;
  
for i=1:m
    for j=1:n 
 if IAa(i,j)>3 & IAa(i,j)<11
            IAa(i,j)=255;
        end;
 
       end;
end

ice=IAa;

count=0
    for i1=45:m-45
    for j1=45:n-45
      
        ic=[]; 
ic=IAa((i1-22):(i1+22),(j1-22):(j1+22));
count=count+1; 

icc=isnan(ic);
su=sum(sum(icc));
D(count,:)=su;
    if (0-su)*(2025-su)<0 
        ice(i1,j1)=80;
    end;
    
%     if su==2025
%        IAa((i1-22):(i1+22),(j1-22):(j1+22))=40; 
%       end;
    
    end;
    end;
 wwws=isnan(IAa);   
    for i=1:m
    for j=1:n
   if    wwws(i,j)==1;
       ice(i,j)=200;      
    end;
    end;
end;
%image border:
ice(1:45,:)=80;
ice(m-45:m,:)=80;
 ice(:,1:45)=80;
 ice(:,n-45:n)=80;
    
% figure; imshow(IAa,[]);
ice(:,1:290)=[];

figure; imshow(ice,[]);
colormap('jet');
