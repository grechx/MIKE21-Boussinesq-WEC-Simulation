function [S ] = JONSWAP( WaveData )
%JONSWAP creates frequencys spectrum using a Hm0 and Tp 

%Extract WaveData
Hm0 = WaveData(1,1);
Tp = WaveData(1,2);
Tmin = WaveData(1,3);
Tdelta = WaveData(1,4);
Tsteps = WaveData(1,5);
gamma = WaveData(1,6);
sigma_a = WaveData(1,7);
sigma_b = WaveData(1,8);

%Period/Freq range
Tmax=Tmin+(Tdelta*Tsteps);
T=Tmin:Tdelta:Tmax;  
f=1./T;
fp=1./Tp;

%Gravity
g=9.81;

%Calculate JONSWAP spectrum
A=(5/16)*Hm0^2/Tp^4;
B=(5/4)*(1/Tp^4);

for n=1:length(f) %loop over all frequencies
if f(n)<fp
    sigma=0.07;
elseif f(n)>fp
    sigma=0.09;
end

a=exp(-0.5*((f(n)-fp)/(sigma*fp))^2); %from Mike21 Toolbox litrature

Spec(n)=A*f(n)^(-5)*exp(-B*f(n)^(-4))*gamma^a;
end

%Normalization (given Hm0/calulated Hm0)
N=(Hm0^2/16)/trapz(Spec,f);
Spec=Spec*N; 

%Create output variable 
S.S=Spec';
S.freq=f';




end

