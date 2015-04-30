function [ output_args ] = Monochromatic_wave(Hm0, T , h, Tsteps, Tinterval, out_file, Wavedir )
%Monochromatic_wave creates a monochromatic wave using a reference .m file.
%depending on wave height (Hm0), period (T), depth (metres (possitive)),
%duration (mins) and the output file name. 


load('D:\Charles Greenwood\BW\Simplified_WEC\Small_Devices\Adpted_Porosity\Matlab_Test_Toolbox\Monochromatic_toolbox_REF.mat')
%Create tempory toolbox information
temp=Monochromatic_toolbox_REF;

%#############################
%Insert Hm0 and T
temp(40,1)=cellstr([temp{40,1}(1:end-6)  mat2str(Hm0) ','  mat2str(T) ]);

%Insert h
temp(72,1)=cellstr([temp{72,1}(1:end-2)  mat2str(h)]);

%Insert time step
temp(99,1)=cellstr([temp{99,1}(1:end-4) mat2str(Tsteps)]);

%Insert time interval
temp(100,1)=cellstr([temp{100,1}(1:end-4) mat2str(Tinterval)]);

%Insert output filename
temp(101,1)=cellstr([temp{101,1}(1:end-11) Wavedir '\Wave_data\' out_file '.dfs0|']);

%#############################
%Find/Create output folders
if isdir([Wavedir '\Wave_data']) == 0
    mkdir(Wavedir, 'Wave_data')
    mkdir(Wavedir, 'Wave_toolbox')
end

%#############################
%Write new toolbox file
fid = fopen([Wavedir '\Wave_toolbox\' out_file '.21t'],'wt');
for i=1:size(temp,1)
    fprintf(fid,'%s\n',temp{i,end});
end
fclose(fid);

%Run toolbox
toolbox_path=[Wavedir '\Wave_toolbox\' out_file '.21t'];

line_data=('start /w C:\Progra~2\DHI\2012\bin\ToolboxShell -run "');

dos([line_data toolbox_path]);


end

