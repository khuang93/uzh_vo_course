function P = linearTriangulation(p1,p2,M1,M2)
% LINEARTRIANGULATION  Linear Triangulation
%
% Input:
%  - p1(3,N): homogeneous coordinates of points in image 1
%  - p2(3,N): homogeneous coordinates of points in image 2
%  - M1(3,4): projection matrix corresponding to first image
%  - M2(3,4): projection matrix corresponding to second image
%
% Output:
%  - P(4,N): homogeneous coordinates of 3-D points
[~,N]=size(p1);
P=zeros(4,N);
p1_mat=vector2skewMat(p1);
p2_mat=vector2skewMat(p2);

A=zeros(6,4*N);
for i=1:N
    A_i=[p1_mat(:,:,i)*M1;p2_mat(:,:,i)*M2];

[U,S,V]=svd(A_i);
P_i=V(:,end);
P_i=P_i/P_i(4);
P(:,i)=P_i;
end

end
