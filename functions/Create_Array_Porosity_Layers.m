function  Create_Array_Porosity_Layers(Porosity_template, Porosity_values, WEC_dimension, Wavedir, T)
%Create_Porosity_Layers uses a reference porosity layer and applies the
%relative porosity value for the given cell dimensions. The porosity layer
%is then written the porosity test folder. 
%Note: filenames are written to 3 decimal places and therefore any same
%named files are overwritten and not duplicated

WEC_lat = WEC_dimension.WEC_lat;
WEC_long= WEC_dimension.WEC_long;
P_height= WEC_dimension.P_height;
P_width = WEC_dimension.P_width;
Number_devices=WEC_dimension.Number_devices;
WEC_separation=WEC_dimension.WEC_separation;

Porosity_layer=read_dfs2(Porosity_template)';
%Clear all porosity structures
y_idx=2:size(Porosity_layer,1)-1;
x_idx=2:size(Porosity_layer,2)-1;
Porosity_layer(y_idx,x_idx)=1;

P_lat=WEC_lat:WEC_lat+P_width;
%P_long=round(WEC_long-P_height/2:WEC_long+P_height/2);

offset=(Number_devices-1)/2*WEC_separation;
WEC_center=linspace(-offset,offset,Number_devices)+WEC_long;
P_long=[];

for n=1:Number_devices
    var(n,:)=['P_long' sprintf('%02.0f',n)]; %create list of variables

    part1=['round(' sprintf('%02.f',WEC_center(n)) '-' sprintf('%02.f',P_height) '/2:'];
    part2=[sprintf('%02.f',WEC_center(n)) '+' sprintf('%02.f',P_height) '/2);'];
    eval([var(n,:) '=' part1  part2 ])
    
    eval(['P_long =[ P_long,' var(n,:) '];']) %add all P_long variables
end

%Create porosity directory
mkdir([Wavedir(1:end-16) 'Porosity']);
mkdir([Wavedir(1:end-16) 'Porosity\Porosity_test' sprintf('%02.f',T)]);

for n=1:length(Porosity_values)   
    P_value=Porosity_values(n);
    Porosity_layer(P_long,P_lat+1)=P_value;
    temp_Porosity_layer=Porosity_layer';
    %save_dfs2
    Output_file=[Wavedir(1:end-16) 'Porosity\Porosity_test' sprintf('%02.f',T) '\Porosity_Array' sprintf('%.3f',Porosity_values(n)) '.dfs2' ] ;    
    import_save_dfs2( Porosity_template,Output_file,temp_Porosity_layer',1 )  
end
end

