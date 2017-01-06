clear
clc
IA=importdata('20140208_095758.tif');

name=importdata('name_2.mat');
pred=importdata('pred_2.mat');
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for ii=1:size(pred)
    
    char=name(ii,:);
    
    schar=char(19:22);
   
    if schar(2)=='.'
        schar(2)=' ';
        schar(3)=' ';
        schar(4)=' ';
    end;
    if schar(3)=='.'
        schar(3)=' ';
        schar(4)=' ';
    end;
    if schar(4)=='.'
       schar(4)=' ';
    end;
    q(ii,:)=schar;
end;
%%%%%



for ii=1:size(pred)
  ww=q(ii,:);
    www=str2num(ww);
    qq(ii,:)=www;
if pred(ii,1)==1
    pred(ii,1)=255;
end ;
C(ii,1)=qq(ii,1);
C(ii,2)=pred(ii,1);%C contains pred_results and patch number.

end;

CC= sortrows(C);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[m,n]=size(IA);
pred_im=zeros(m,n);
pred_im(:,:)=100;

    ct=0;
for i1=45:20:m-45
    for j1=45:20:n-45
        ct=ct+1;
       
  E(ct,1)=i1;
  E(ct,2)=j1;
    end;
end;
  
for i2=1:size(pred)
    CC(i2,3)=E(CC(i2,1),1);
    CC(i2,4)=E(CC(i2,1),2);
   

    row=CC(i2,3);
    column= CC(i2,4);
    for i4=(row-22):(row+22)
        for j4=(column-22):(column+22)
            pred_im(i4,j4)=CC(i2,2);
        end;
    end;
end;

imshow(pred_im,[])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0
% %set ice analysis to 1 or 0 and set land to nan
for i=1:m
    for j=1:n
   if    IA(i,j)==11;
       IA(i,j)=100;      
    end;
    end;
end;

 for i=1:m
    for j=1:n 
     if IA(i,j)<=3
            IA(i,j)=0;
        end;
   
    end;
  end;
  
for i=1:m
    for j=1:n 
 if IA(i,j)>3 & IA(i,j)<11
            IA(i,j)=255;
        end;
 
       end;
    end;
    
    
figure; imshow(IA,[]);
end;
