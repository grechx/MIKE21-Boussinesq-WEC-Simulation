function [ WEC_lat, WEC_long, Device_thickness ] = WEC_location( D,T )
%WEC_location uses porosity file to sind the WEC's location and dimensions

%Get WEC location
Porosity_path= [D '\Porosity\Porosity_test' sprintf('%02.f',T)];
Porosity_list=dir(fullfile(Porosity_path, '*Porosity_*'));
Porosity_names=char({Porosity_list.name});
multiple_P_value=str2num(Porosity_names(:,end-9:end-5));
P_value=min(multiple_P_value);

%create filename
P_filename=[Porosity_names(1,1:end-10) num2str(P_value) '.dfs2'];
%import porosity lay and find location of P_value
Porosity_map=read_dfs2([Porosity_path '\' P_filename]);
%rounds on 3rd decimal place
Porosity_map2=round(Porosity_map/0.001)*0.001;

 [r c]=find( Porosity_map2 == P_value);
 P_x=unique(r);
 P_y=unique(c);
  
WEC_lat=P_y(round(length(P_y)/2));
WEC_long=min(P_x);
Device_thickness=length(P_x);


end

