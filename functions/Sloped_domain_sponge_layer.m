function [ filename ] = Sloped_domain_sponge_layer( BW_dir,slope_filename )
% Sloped_domain_sponge_layer imports default sponge and sloped domain then
% relocates the new sponge layer and wrights file. 

%get reference filename
fid = fopen(BW_dir);
InputText=textscan(fid,'%s',318,'delimiter','\n');
BW_template=InputText{1};
ref_sponge_file=['D:\Charles Greenwood\BW\Simplified_WEC' BW_template{136}(22:end-1)];

%import sponge data
ref_sponge=read_dfs2(ref_sponge_file)';

%import domain
ref_domain_file=['D:\Charles Greenwood\BW\Simplified_WEC\Mesh\' slope_filename];
ref_domain=read_dfs2(ref_domain_file)';

%domain backwall index
end_domian_idx=min(find(ref_domain(2,2:end) == 10));

%get backwall sponge values
back_sponge_val=ref_sponge(2,end-50:end);

%set sponge value in front of backwall
cell_diff=size(ref_sponge,2)-end_domian_idx;
sponge_profile=[ref_sponge(2,1:end_domian_idx-51) back_sponge_val ...
    zeros(1,cell_diff)+10];

for n=1:size(ref_sponge,1); slope_sponge(n,:)=sponge_profile; end
 slope_sponge([1 end],:)=10;


%create filename and write dfs2 file
filename=['Sponge_700x750_2m' slope_filename(end-13:end) ];
Output_file=[ref_sponge_file(1:62) filename];
import_save_dfs2( ref_sponge_file,Output_file,slope_sponge,1 ) 

fprintf('\nFile created: ''%s''\n',filename);


end

