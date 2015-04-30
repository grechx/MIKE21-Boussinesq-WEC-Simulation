function [Phase_data, Base_data, tstep_idx, min_distance] = freq_dependant_data_selection( resultslist,out_dir,Baseline,Baselist,Nresults, WEC_lat  )
%freq_dependant_data_selection calculates the time period for each wave to
%propagate across the domain and provide a time step index for frequency.

    %sort Baselist & resultslist
    temp.one=cellstr(Baselist(:,1:21)); temp.two=cellstr(Baselist(:,22:33));
    temp.three=cellstr(Baselist(:,34:end));
    Basenamelist=cat(2,temp.one,temp.two,temp.three);
    
    temp.one=cellstr(resultslist(:,1:21)); temp.two=cellstr(resultslist(:,22:33));
    temp.three=cellstr(resultslist(:,34:end));
    testname=cat(2,temp.one,temp.two,temp.three);
    
    Basefilelist=sortrows(Basenamelist,3);
    testfilelist=sortrows(testname,3);
    
    %combine test & Base file lists 
    for n=1:Nresults
    result_list(n,:)=[testfilelist{n,1} testfilelist{n,2}  testfilelist{n,3}];
    Base_list(n,:)=[Basefilelist{n,1} Basefilelist{n,2}  Basefilelist{n,3}];
    end

    %Calculate wave speed
    str_idx2=strfind(result_list(1,:),'sec');
    T_char=result_list(:,str_idx2-5:str_idx2-1);
    T= str2num(T_char(:,:));
    for n=1:length(T); L(n)=wavelength( T(n),10 );end;
    Wspeed=L'./T;
    k=2*pi./L;
    d=10;
    n=0.5*(1+((2*k*d)./sinh(2*k*d)));
    Wgspeed=Wspeed.*n';
    
    %Get distance +tiem from center to boundary 
    domain_ref=read_dfs2([out_dir '\' result_list(1,:) '\Phase_averaged.dfs2']);
    half_domain_size=size(domain_ref,2)/2;
    x_wave_time=((WEC_lat*2)./Wgspeed)/60;
    y_wave_time=((half_domain_size*1.5*2)./Wgspeed)/60;
    
      
    tstep_idx=floor(x_wave_time+y_wave_time)+0;
    %add percentage time step
    %tstep_idx= round(tstep_idx + (tstep_idx/100*20));
    
    %distance [m]
     min_distance= min(Wgspeed .* (tstep_idx*60)); 
     max_distance= max(Wgspeed .* (tstep_idx*60));
    %Import simulation data
    for n=1:Nresults
        raw_phase_data=read_dfs2([out_dir '\' result_list(n,:) '\Phase_averaged.dfs2']);
        raw_base_phase=read_dfs2([out_dir(1:end-2) sprintf('%02.f',Baseline)  '\' Base_list(n,:) '\Phase_averaged.dfs2']);
        Phase_data(:,:,n)=raw_phase_data(:,:,tstep_idx(n));
        Base_data(:,:,n)=raw_base_phase(:,:,tstep_idx(n));
    end
    
end

