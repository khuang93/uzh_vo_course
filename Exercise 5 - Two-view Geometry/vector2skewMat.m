function [M] = vector2skewMat(v)
%VECTOR2SKEWMAT Summary of this function goes here
%   Detailed explanation goes here
[dim, samples]=size(v);
M=zeros(dim,dim,samples);

M(1,2,:)=-v(3,:);
M(1,3,:)=v(2,:);
M(2,1,:)=v(3,:);
M(2,3,:)=-v(1,:);
M(3,1,:)=-v(2,:);
M(3,2,:)=v(1,:);
end

