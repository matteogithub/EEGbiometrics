function compute_performace_withinTask(FC_profiles,bandname)

profxep=zeros(size(FC_profiles,1)*size(FC_profiles,3),size(FC_profiles,4));

dist_mat=zeros(size(FC_profiles,2),size(FC_profiles,1)*size(FC_profiles,3),size(FC_profiles,1)*size(FC_profiles,3));
score_mat=zeros(size(FC_profiles,2),size(FC_profiles,1)*size(FC_profiles,3),size(FC_profiles,1)*size(FC_profiles,3));

index=[1,2,3,7,11,4,8,12,5,9,13,6,10,14];

for i=1:size(FC_profiles,2) %for each FC metric
    prof=squeeze(FC_profiles(:,i,:,:)); %get obs x nep x lprof
    prof_ord=prof;
    curr=0;
    for k=1:14
        for w=1:105
            curr=curr+1;
            prof_ord(curr,:,:)=prof(index(k)+(w-1)*14,:,:);
        end
    end
    ind=0;
    for q=1:14
        for qq=1:105
            for qqq=1:5
                ind=ind+1;
                profxep(ind,:)=prof_ord((q-1)*105+qq,qqq,:);                
            end            
        end        
    end
    
    for r=1:size(profxep,1)
        i
        r
        for c=1:size(profxep,1)
            if(r~=c)
                dist_mat(i,r,c)=norm(profxep(r,:)-profxep(c,:));
                %norm(profxep(r,:)-profxep(c,:));
                score_mat(i,r,c)=1./(1+dist_mat(i,r,c));                
            end
        end
    end
end

filename=strcat(bandname,'_score_matrix.mat');
save(filename,'score_mat');