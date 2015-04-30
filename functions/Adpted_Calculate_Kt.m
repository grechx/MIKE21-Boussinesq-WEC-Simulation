function [ Kt ] = Adpted_Calculate_Kt( file_path, reference_Hm0,x )
%Calculate_Kt calculates energy transmition based on the ratio between
%behind device wave height and and pre-device wave height
%ref_Hm0= incident wave height
%x=device dimension

data=read_dfs2([file_path '\Phase_averaged.dfs2']);
data=data(:,:,end);

%Kt possision
x=205+x+1;
y=100+1;

Kt_data=data(x,y);

Kt=reference_Hm0/Kt_data;

end

