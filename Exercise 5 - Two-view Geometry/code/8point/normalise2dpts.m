function [newpts, T] = normalise2dpts(pts)
% NORMALISE2DPTS - normalises 2D homogeneous points
%
% Function translates and normalises a set of 2D homogeneous points 
% so that their centroid is at the origin and their mean distance from 
% the origin is sqrt(2).
%
% Usage:   [newpts, T] = normalise2dpts(pts)
%
% Argument:
%   pts -  3xN array of 2D homogeneous coordinates
%
% Returns:
%   newpts -  3xN array of transformed 2D homogeneous coordinates.
%   T      -  The 3x3 transformation matrix, newpts = T*pts

%
mean_pts=mean(pts,2);
stddev=std(pts,0,2);
sigma=norm(stddev(1:2));
s_j=sqrt(2)/sigma;
T=[s_j, 0 , -s_j*mean_pts(1); 0 s_j -s_j*mean_pts(1); 0 0 1];
newpts=T*pts;

