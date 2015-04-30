function [ Kt, Kt_data ] = Calculate_WEC_Kt_( file_path, reference_Hm0,WEC_lat,WEC_long,x )
%Calculate_Kt calculates energy transmition based on the ratio between
%behind device wave height and and pre-device wave height
%ref_Hm0= incident wave height
%x=device dimension

data=read_dfs2([file_path '\Phase_averaged.dfs2']);
data=data(:,:,end);

%Kt possision
x=WEC_lat+x+1;
y=WEC_long+1;

Kt_data=data(x,y);

Kt=Kt_data/reference_Hm0;

end

