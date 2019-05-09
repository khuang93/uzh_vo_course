function [p_reproj] = reprojectPoints(P,M,K)
%REPROJECTPOINTS Summary of this function goes here
num = length(P);
p_tmp = K*M*[P';ones(1,num)];
p_tmp=p_tmp./p_tmp(3,:);
p_reproj=p_tmp(1:2,:)';
end

