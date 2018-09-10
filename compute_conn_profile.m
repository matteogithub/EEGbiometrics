function compute_conn_profile(inDir,band)
n_ep=5;
l_ep=12;
fs=160;
n_ch=64;
n_FC=5;
fil='*.edf';
cases=dir(fullfile(inDir,fil));
FC_profiles=zeros(length(cases),n_FC,n_ep,(n_ch*n_ch-n_ch)/2);
ind=logical(tril(ones(64,64),-1));
for i=1:length(cases)
    i
    tic
    data=importdata(strcat(inDir,cases(i).name));
    for j=1:n_ep
        end_ep=l_ep*fs*j;
        ep_data=data(:,end_ep-l_ep*fs+1:end_ep);
        %
        ep_conn=AEC(ep_data');
        ep_profile=ep_conn(ind);
        FC_profiles(i,1,j,:)=ep_profile;
        %
        ep_conn=Phase_lag_index(ep_data');
        ep_profile=ep_conn(ind);
        FC_profiles(i,2,j,:)=ep_profile;
        %
        ep_conn=abs(corr(ep_data'));
        ep_profile=ep_conn(ind);
        FC_profiles(i,3,j,:)=ep_profile;
        %
        ep_conn=AEC_noorth(ep_data');
        ep_profile=ep_conn(ind);
        FC_profiles(i,4,j,:)=ep_profile;
        %
        ep_conn=PLV(ep_data');
        ep_profile=ep_conn(ind);
        FC_profiles(i,5,j,:)=ep_profile;
    end
    toc
end

filename=strcat(inDir,band,'_FC_profiles.mat');
save(filename,'FC_profiles');
