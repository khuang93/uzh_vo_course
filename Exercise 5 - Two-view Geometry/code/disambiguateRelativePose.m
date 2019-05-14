function [R,T] = disambiguateRelativePose(Rots,u3,p1,p2,K1,K2)
% DISAMBIGUATERELATIVEPOSE- finds the correct relative camera pose (among
% four possible configurations) by returning the one that yields points
% lying in front of the image plane (with positive depth).
%
% Arguments:
%   Rots -  3x3x2: the two possible rotations returned by decomposeEssentialMatrix
%   u3   -  a 3x1 vector with the translation information returned by decomposeEssentialMatrix
%   p1   -  3xN homogeneous coordinates of point correspondences in image 1
%   p2   -  3xN homogeneous coordinates of point correspondences in image 2
%   K1   -  3x3 calibration matrix for camera 1
%   K2   -  3x3 calibration matrix for camera 2
%
% Returns:
%   R -  3x3 the correct rotation matrix
%   T -  3x1 the correct translation vector
%
%   where [R|t] = T_C1_C0 = T_C1_W is a transformation that maps points
%   from the world coordinate system (identical to the coordinate system of camera 0)
%   to camera 1.
%
R1=Rots(:,:,1);
R2=Rots(:,:,1);
M1=[eye(3) zeros(3,1)];
M2_all=zeros(3,4,4);
M2_1=[R1 u3];
M2_2=[R2 u3];
M2_3=[R1 -u3];
M2_4=[R2 -u3];
M2_all(:,:,1)=M2_1;
M2_all(:,:,2)=M2_2;
M2_all(:,:,3)=M2_3;
M2_all(:,:,4)=M2_4;


P1=linearTriangulation(p1,p2,M1,M2_1);
P2=linearTriangulation(p1,p2,M1,M2_2);
P3=linearTriangulation(p1,p2,M1,M2_3);
P4=linearTriangulation(p1,p2,M1,M2_4);

count=zeros(4,1);
count(1)=sum(P1(3,:)>0);
count(2)=sum(P2(3,:)>0);
count(3)=sum(P3(3,:)>0);
count(4)=sum(P1(3,:)>0);
[~,idx]=max(count);
R=M2_all(:,1:3,idx);
T=M2_all(:,4,idx);
end
