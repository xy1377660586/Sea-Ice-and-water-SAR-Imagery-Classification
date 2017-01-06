clear
clc
IA=importdata('20140210_103911.tif');
name=importdata('name_4.mat');
pred=importdata('pred_4.mat');
label=importdata('label_4.mat')
water=0;
ice=0;
w_t=0;
i_t=0;  
to=0;

[dd,rr]=size(name);
for i6=1:dd
    if label(i6,1)==0
        water=water+1;
        if pred(i6,1)==label(i6,1)
            w_t=w_t+1;
        end;
    end;
    if  label(i6,1)==1
        ice=ice+1;
        if pred(i6,1)==label(i6,1)
            i_t=i_t+1;
        end;
    end; 
    if pred(i6,1)==label(i6,1)
        to=to+1;
    end;
end;
ice_accuracy=(w_t/water);
water_accuracy=(i_t/ice);
total_accuracy=to/dd;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for ii=1:dd
    
    char=name(ii,:);
    
    schar=char(19:(rr-4));
   
    if schar(2)=='.'
        schar(2)=' ';
        schar(3)=' ';
        schar(4)=' ';
        schar(5)=' ';
        schar(6)=' '; 
    end;
    if schar(3)=='.'
        schar(3)=' ';
        schar(4)=' ';
       schar(5)=' ';
       schar(6)=' '; 
    end;
    if schar(4)=='.'
       schar(4)=' ';
       schar(5)=' ';
       schar(6)=' ';
    end;
    if schar(5)=='.'
       schar(5)=' ';
       schar(6)=' ';
    end;
    if schar(6)=='.'
       schar(6)=' ';
    end; 

    
    q(ii,:)=schar;
end;


    
    
for ii=1:dd
  ww=q(ii,:);
    www=str2num(ww);
    qq(ii,:)=www;
if pred(ii,1)==1
    pred(ii,1)=255;%255 represent ice 
end ;
C(ii,1)=qq(ii,1);
C(ii,2)=pred(ii,1);%C contains pred_results and patch number.

end;

CC= sortrows(C);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[m,n]=size(IA);
;pred_im=zeros(m,n);
pred_im(:,:)=100;%100 represent 


    
    ct=0;
for i1=45:m-45
    for j1=45:n-45
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
    
    pred_im(row,column)=CC(i2,2);
        end;
        
        
    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % %set ice analysis to 1 or 0 and set land to nan

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
            IAa(i,j)=70;
        end;
 
       end;
end

ice=IAa;
wwws=isnan(IAa);   
    for i=1:m
    for j=1:n
   if    wwws(i,j)==1;
       pred_im(i,j)=200;      
    end;
    end;
end;

%image boundary
pred_im(1:45,:)=100;
pred_im(m-45:m,:)=100;
 pred_im(:,1:45)=100;
 pred_im(:,n-45:n)=100;
 
pred_im(:,1:290)=[];
imshow(pred_im,[]);
colormap('jet');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HH SAR image refine 

HH=importdata('20140210_103911-HH-8by8-mat.tif');
[m,n]=size(HH);

HH(1:45,:)=80;
HH(m-45:m,:)=80;
 HH(:,1:45)=80;
 HH(:,n-45:n)=80;

 HH(:,1:290)=[];
 
  figure; imshow(HH)
