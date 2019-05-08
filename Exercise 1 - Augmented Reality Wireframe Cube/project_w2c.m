function [P_im] = project_w2c(P_w,K,R,T)
%PROJECT_W2C Summary of this function goes here
%   Detailed explanation goes here
P_im=[0 0]';
P_w_homog = [P_w ; 1];
P_c_homog = [R T]*P_w_homog;
P_im_homog = K*P_c_homog;
P_im = P_im_homog/P_im_homog(3);
P_im = round(P_im(1:2));
end

