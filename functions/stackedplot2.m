function [h] = stackedplot2( xdata, data1, data2, colour1 , colour2)
%stackedplot - takes data matrix where each coloum is a seperate line and
%plots it as a stacked line plot. The line spacing is taken into acount
%useing the largest value.  

Nresults=size(data1,1);

max_value1 = max(max(data1))*2;
max_value2 = max(max(data2))*2;

max_value = max([max_value1 max_value2]);
spacing_factor=max_value;
spacing=linspace(1,size(data1,2)*spacing_factor,size(data1,2));

for n=1:size(data1,2)
h=plot(xdata,data1(:,n)+ spacing(n),colour1);
h=plot(xdata,data2(:,n)+ spacing(n),colour2);
hold on
end

set(gca,'yTick',spacing)
set(gca,'YTickLabel',1:Nresults )


y_max=(size(data1,2)+1)*spacing_factor;
ylim([0 y_max])

end

