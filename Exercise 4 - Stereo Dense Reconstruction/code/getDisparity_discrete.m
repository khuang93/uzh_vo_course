function disp_img = getDisparity_discrete(...
    left_img, right_img, patch_radius, min_disp, max_disp)
% left_img and right_img are both H x W and you should return a H x W
% matrix containing the disparity d for each pixel of left_img. Set
% disp_img to 0 for pixels where the SSD and/or d is not defined, and for d
% estimates rejected in Part 2. patch_radius specifies the SSD patch and
% each valid d should satisfy min_disp <= d <= max_disp.
disp_space=min_disp:max_disp;
ld=length(disp_space);
[m,n]=size(left_img);

all_SSD_img = zeros(m,n,length(disp_space));

right_img_pad=padarray(right_img,[0 max_disp],'pre');

disp_img=zeros(size(left_img));
istart=patch_radius+1;
iend=m-patch_radius;
parfor (i=istart:1:iend)
    patch_R_all_all=zeros(n-patch_radius*2+max_disp,(2*patch_radius+1)^2); %pre calc all patches in this line
    for j = patch_radius+1:n-patch_radius+max_disp
        patch_R_all_all(j,:)=...
            reshape(...
            right_img_pad(i-patch_radius:i+patch_radius,...
            j-patch_radius:j+patch_radius),1,[]);
        patch_R_all_all=single(patch_R_all_all);
    end
    disp_img_i=zeros(1,n);
    for j = patch_radius+1:n-patch_radius
        patch_L=left_img(i-patch_radius:i+patch_radius,j-patch_radius:j+patch_radius);
        patch_L=single(reshape(patch_L,1,[]));
        patch_R_all=patch_R_all_all(j:j+ld-1,:);
%         patch_R_all=zeros(ld,length(patch_L));
%         for k=1:ld
%             d=disp_space(k);
%             right_j=j+max_disp;
%             patch_R_all(k,:)=reshape(right_img_pad(i-patch_radius:i+patch_radius,max(1,right_j-d-patch_radius):max(1,right_j-d+patch_radius)),1,[]);
%         end
        D=pdist2(patch_L,patch_R_all,'squaredeuclidean');
        [minD,minD_idx]=min(D);
        %apply ambigous match threshold %apply bound
        ambig_th=1.5*minD;
        if (minD_idx~=1 && minD_idx~=ld &&sum(D<ambig_th)<2 && minD~=0)
            disp_img_i(j)=max_disp-minD_idx+1;
        end   
        
        
    end
    disp_img(i,:)=disp_img_i;
end


end


    