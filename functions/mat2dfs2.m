function [ output_args ] = mat2dfs2( input_var, outfile )
%mat2dfs2 save matlab variable to dfs2 file

x=size(input_var,1);
y=size(input_var,2);
number_of_files=size(input_var,3);
gridspacing=2;


NET.addAssembly('DHI.Generic.MikeZero.DFS');
NET.addAssembly('DHI.Generic.MikeZero.EUM');
import DHI.Generic.MikeZero.DFS.*;
import DHI.Generic.MikeZero.DFS.dfs123.*;
import DHI.Generic.MikeZero.*

filename =outfile;

x=size(input_var,1);
y=size(input_var,2);
gridspacing=2;

factory = DfsFactory();
builder = Dfs2Builder.Create('Matlab dfs2 file','Matlab DFS',0);

%Data type
builder.SetDataType(1);

%Projection = projection - Long - Lat - Orentation
builder.SetGeographicalProjection(factory.CreateProjectionGeoOrigin('UTM-29', 0, 0,0));

%Time = (Year - Month - Day - HH - MM - SS) - Start time offset or Firsttime step index - Time Step (seconds)
builder.SetTemporalAxis(factory.CreateTemporalEqCalendarAxis(eumUnit.eumUsec,System.DateTime(2012,03,01,0,00,0),0,1800));
%eval(['builder.SetTemporalAxis(factory.CreateTemporalEqCalendarAxis(eumUnit.eumUsec,System.DateTime(' starttime.year ',' starttime.month ',' starttime.day ',' starttime.hour ',' starttime.min ',00),0,1800));'])

%Axis = XCount(x axis number of bins) - X zero - Dx (x grid spacing) - YCount(y axis number of bins) - Y zero - DY (Y grid spacing)
builder.SetSpatialAxis(factory.CreateAxisEqD2(eumUnit.eumUmeter,y,0,gridspacing,x,0,gridspacing));
builder.DeleteValueFloat = single(-1e-30);

% builder.AddCustomBlock(dfs_in.FileInfo.CustomBlocks);
builder.AddCustomBlock(dfsCreateCustomBlock(factory, 'M21_Misc', [1 7 0 0 0 10 0 0 0], 'System.Single'));

%Creates item info
builder.AddDynamicItem('Wave Energy Dencity', eumQuantity.Create(eumItem.eumIWaveEnergy, eumUnit.eumUm2), DfsSimpleType.Float, DataValueType.Instantaneous);
%load('\\Lef030-01\d$\Charles Greenwood\Pre-processing\wave data\iquantity')
%builder.AddDynamicItem('Wave Energy Dencity', eumItem.eumIWaveEnergyDensity, eumUnit.eumUm2SecPerRad, DfsSimpleType.Float, DataValueType.Instantaneous);

% Create the file ready for data
builder.CreateFile(filename);
dfs = builder.GetFile();

for n=1:number_of_files
    S_5=input_var(:,:,n)';
    dfs.WriteItemTimeStepNext(0, NET.convertArray(single( S_5(:))));

end

dfs.Close();
fprintf('\nFile created: ''%s''\n',filename);


end

