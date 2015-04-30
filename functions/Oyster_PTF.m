function [ simulated_y ] = Oyster_PTF( freqi)
%Oyster_PTF gets data from D.Clabby et al (2012) and creates a PTF using 
% the data from the pre determined frequencies intervals. 

cd('D:\Charles Greenwood\BW\Simplified_WEC\Small_Devices\Adpted_Porosity\Matlab_Test_Toolbox');
rawdata=load('PowerCapture_freqy_varying_data.mat');

%linear space detailed and course data sets
freq_idx=linspace(0,0.4,300);
freq_idx2=linspace(0,0.4,50);

x=rawdata.xy(:,1);
y=rawdata.xy(:,2);

%interpolate data sets and set max at 0.2
y_idx=interp1(x,y,freq_idx)*0.2;
y_idx2=interp1(x,y,freq_idx2)*0.2;

%get list of x and y's for point plotting
simulted_x= freqi;
for n=1:length(simulted_x)
[temp, idx(n)] = min(abs(freq_idx2-simulted_x(n)));
end
simulated_y=y_idx2(idx);


% figure
% plot(freq_idx,y_idx)
% hold on
% plot(freq_idx2,y_idx2,'r')
% scatter(simulted_x,simulated_y,'MarkerFaceColor','k','MarkerEdgeColor','k')
% xlabel('Frequency [Hz]')
% ylabel('Power Capture')
% legend('D. Clabby et al (2012)','Smoothed','Frequency intervals')


end

