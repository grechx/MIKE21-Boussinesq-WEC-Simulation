function [ Kr ] = Calculate_Kr_period( file_path, t )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


[ wg1 ] = read_dfs0([file_path '\point1.dfs0']);
[ wg2 ] = read_dfs0([file_path '\point2.dfs0']);

%wave gauge possition
x1=180;
x2=175;
grid_spacing=2;
l=(x2-x1)*grid_spacing;
%wave gauge data
data1=wg1;
data2=wg2;

data1=data1(400:end);
data2=data2(400:end);

tstep=0.15;


[A1, B1] = Fourier_coefficents( data1, t, tstep);
[A2, B2] = Fourier_coefficents( data2, t, tstep);

L=wavelength( t,10 );
k=(2*pi)/L;

%Incident wave
ai=(1/(2*abs(sin(k*l))))*((A2-A1*cos(k*l)-B1*sin(k*l))^2+(B2+A1*sin(k*l)-B1*cos(k*l))^2)^0.5;
%Reflected wave
ar=(1/(2*abs(sin(k*l))))*((A2-A1*cos(k*l)+B1*sin(k*l))^2+(B2-A1*sin(k*l)-B1*cos(k*l))^2)^0.5;

Kr=ar/ai;


end

