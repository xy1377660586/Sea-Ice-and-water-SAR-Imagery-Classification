%***********************************************************************
%load files 
%***********************************************************************

hhname=importdata('HHname.txt');
hhname=cell2mat(hhname);

hvname=importdata('HVname.txt');
hvname=cell2mat(hvname);

incident_angle=importdata('IAg.txt');
incident_angle=cell2mat(incident_angle);

ice_chart=importdata('IA_im.txt');
ice_chart=cell2mat(ice_chart);

patch_name=importdata('pname.txt');
patch_name=cell2mat(patch_name);
count=0;
 count_1=0;
qq=1;
for q13=25
q13
HV = imread(hvname(q13,:));
HH = imread(hhname(q13,:));
IAg = imread(incident_angle(q13,:));
IA =double(imread(ice_chart(q13,:)));


[m,n]=size(IA);
%set ice analysis to 1 or 0 and set land to nan
for i=1:m
    for j=1:n
   if    IA(i,j)==11;
       IA(i,j)=NaN;      
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
 if IA(i,j)>3
            IA(i,j)=1;
        end;
 
       end;
    end;


for i1=45:m-45
    for j1=45:n-45
        qq=qq+1;
        D=[]; 
ic=IA((i1-22):(i1+22),(j1-22):(j1+22));
a=HV((i1-22):(i1+22),(j1-22):(j1+22));
b=HH((i1-22):(i1+22),(j1-22):(j1+22));
c=IAg((i1-22):(i1+22),(j1-22):(j1+22));  
count=count+1; 


icc=isnan(ic);
    if sum(sum(icc))==0
        
        D(:,:,1)=b;
        D(:,:,2)=a;
        D(:,:,3)=c; 
        D=uint8(D);
        wwww=patch_name(q13,:);
        w=IA(i1,j1);

        fname=strcat(num2str(w),num2str(wwww),num2str(count),'.jpg');
        imwrite(D,fname,'jpg');  
        count_1=count_1+1;
        count_1
    end;
    
    end;
end;

 
end;
