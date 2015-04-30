function [filename, max_depth ] = Create_sloped_domain2( ref_file,WEC_lat,Domain_slope,min_depth )
% Create Beach Domain
%(this is done working in domain units (2m))

%read in exsiting domain
ref_domain=read_dfs2(ref_file)';
%max distance upwave (metres) 
max_dist=220/2;

%beach gradient
if isinf(Domain_slope)==1; Domain_slope=0;end

gradient=(Domain_slope)*2;
max_depth=-10+(-gradient*max_dist);

uh_slope=linspace(max_depth,-10-gradient,max_dist);

dh_dist=abs(-10-min_depth)/gradient;
if isnan(dh_dist)==1; dh_dist=1000;end
dh_slope=linspace(-10,min_depth,dh_dist);
slope=[uh_slope dh_slope];

%add slope to domain
flat_bathy=ones(1,WEC_lat-max_dist)*max_depth;
temp=[10 flat_bathy slope];


%fill in remaining data
if length(temp) <= length(ref_domain)
    difference=size(ref_domain,2)-length(temp);
    depth_profile=[temp zeros(1,difference)+10];

elseif length(temp) > length(ref_domain)
     depth_profile=[temp(1:size(ref_domain,2)-1) 10];
 end

%create domain 
for n=1:size(ref_domain,1); domain(:,n)=depth_profile; end
domain(:,[1 end])=10;

filename=['Bathy_650x750m_2m_grad_' mat2str(gradient/2) '.dfs2' ];
Output_file=[ref_file(1:44) filename];
import_save_dfs2( ref_file,Output_file,domain',1 ) 

fprintf('\nFile created: ''%s''\n',filename);

end

