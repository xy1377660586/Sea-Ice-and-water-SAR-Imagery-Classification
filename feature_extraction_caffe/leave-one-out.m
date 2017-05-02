%***********************************************************************
%load files 
%***********************************************************************
clear ;
clc;
close all;

labels=importdata('labels.txt');
labels=cell2mat(labels);


features=importdata('featurelist.txt');
features=cell2mat(features);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for leave_one=1:24 ; %change variables here by deciding which one to leave as test sample 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=[];
b=[];
temp_label=[];
temp_feature=[];

for i=1:24
    if i~= leave_one;
        temp_label= load(labels(i,:));
        temp_label= temp_label.data;
       
        temp_feature=load(features(i,:));
        temp_feature=temp_feature.data;
   
        temp_feature=[a;temp_feature];
        temp_label=[b;temp_label];          
      %  train_feature=train_feature+temp_label;
    end;
     b=temp_label;
     a=temp_feature; 
end;
route1=strcat('/home/lein/yan2/feature_leave-one_out/',num2str(leave_one),'_train_fea.mat');
route2=strcat('/home/lein/yan2/feature_leave-one_out/',num2str(leave_one),'_train_labels.mat');

save(route1,'a');
save(route2,'b');

end;
