function [points, intensities] = disparityToPointCloud(...
    disp_img, K, baseline, left_img)
% points should be 3xN and intensities 1xN, where N is the amount of pixels
% which have a valid disparity. I.e., only return points and intensities
% for pixels of left_img which have a valid disparity estimate! The i-th
% intensity should correspond to the i-th point.
[m,n]=size(left_img);
K_inv = inv(K);
points=zeros(3,n,m);
intensities=zeros(1,n,m);
for i = 1:m
    pts=zeros(3,n);
    its=zeros(1,n);
    for j = 1:n
        d=disp_img(i,j);
        if j-d>0
%             lambda=[0 0]'
            p0=[j,i,1]';
            p1=[j-d,i,1]';
            A=[K_inv*p0, K_inv*p1];
            b=[baseline 0 0]';
            
            ATA=A'*A;
            lambda=ATA\(A'*b);
            lambda_val=lambda(1);
            pt=lambda_val*K_inv*p0;
            pt_i=left_img(i,j);
            
            
            pts(:,j)=pt;
            its(:,j)=pt_i;
            
        end
%             ind=sub2ind(size(left_img),i,1);
            points(:,:,i)=pts;
            intensities(:,:,i)=its;
    end
    
end
points=reshape(points,3,m*n);
intensities=reshape(intensities,1,m*n);
end