function [P_im] = project_w2c_distorted(P_w,K,R,T,D)
%PROJECT_W2C Summary of this function goes here
%   Detailed explanation goes here
% P_im=[0 0]';
P_w_homog = [P_w ; 1];
P_c_homog = [R T]*P_w_homog;
P_c_norm = P_c_homog/P_c_homog(3);
P_c_norm=P_c_norm(1:2);
r_sq=P_c_norm(1)^2+P_c_norm(2)^2;
dist_factor=1+D(1)*r_sq+D(2)*r_sq^2;
P_c_distort=dist_factor*P_c_norm;

P_im_homog = K*[P_c_distort;1];
P_im = P_im_homog/P_im_homog(3);
P_im = round(P_im(1:2));
end

