function [im_undistort] = undistort_img(im_distort,K,D)
%UNDISTORT_IMG Summary of this function goes here
%   Detailed explanation goes here
im_size=size(im_distort);
im_undistort=zeros(im_size);
for u=1:im_size(1)
    for v=1:im_size(2)
%         [u,v]
        p_dist = undistort_img_pt([v u]',K,D); %row, col
        if 0<p_dist(1)&&p_dist(1)<im_size(2) && 0<p_dist(2)&&p_dist(2)<im_size(1)
%             pix_floor=floor(p_dist);
%             pix_ceil=ceil(p_dist);
% 
%             values = im_distort(pix_floor(2):pix_ceil(2),pix_floor(1):pix_ceil(1));
%             x_coords = [pix_floor(2) pix_ceil(2)]';
%             y_coords = [pix_floor(1) pix_ceil(1)]';
%             pix_val=interp2(x_coords,y_coords,values,p_dist(2),p_dist(1));
%             im_undistort(u,v)=pix_val;
            p_dist=round(p_dist);
          im_undistort(u,v)=im_distort(p_dist(2),p_dist(1));
            
        end
    end
end

