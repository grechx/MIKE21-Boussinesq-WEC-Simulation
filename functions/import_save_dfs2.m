function [ output_args ] = import_save_dfs2( template,Output_file,data,number_of_files )
% Import_save_dfs2 imports a reference file and uses it to create a .dfs2 file
% with the same properties where the data is added at the end.

NET.addAssembly('DHI.Generic.MikeZero.DFS');
NET.addAssembly('DHI.Generic.MikeZero.EUM');
import DHI.Generic.MikeZero.DFS.*;
import DHI.Generic.MikeZero.DFS.dfs123.*;
import DHI.Generic.MikeZero.*

dfs_in = DfsFileFactory.Dfs2FileOpen(template);
saxis = dfs_in.SpatialAxis;
datatype = dfs_in.FileInfo.DataType;
proj = dfs_in.FileInfo.Projection;
x_el_dim = dfs_in.SpatialAxis.XCount;
y_el_dim = dfs_in.SpatialAxis.YCount;


%item info
iname = dfs_in.ItemInfo.Item(0).Name;
iquantity = dfs_in.ItemInfo.Item(0).Quantity;
itype = dfs_in.ItemInfo.Item(0).DataType;
ivaltype = dfs_in.ItemInfo.Item(0).ValueType;

% Create an empty dfs2 file object
factory = DfsFactory();
builder = Dfs2Builder.Create('Matlab dfs2 file','Matlab DFS',0);


% Set up the header
builder.SetDataType(datatype);
builder.SetGeographicalProjection(proj);
%time
builder.SetTemporalAxis(dfs_in.FileInfo.TimeAxis);
%Axis
builder.SetSpatialAxis(dfs_in.SpatialAxis);

%builder.AddCustomBlock(dfs_in.FileInfo.CustomBlocks);
builder.AddCustomBlock(dfsCreateCustomBlock(factory, 'M21_Misc', [1 7 0 0 0 10 0 0 0], 'System.Single'));

% Add items
builder.AddDynamicItem(iname,iquantity,itype,ivaltype);

% Create the file ready for data
builder.CreateFile(Output_file);

% Get the file
dfs_out = builder.GetFile();

for n=1:number_of_files
    S_5=data(:,:,n)';
    dfs_out.WriteItemTimeStepNext(0, NET.convertArray(single( S_5(:))));

end

dfs_out.Close();
%fprintf('\nFile created: ''%s''\n',Output_file);

end

