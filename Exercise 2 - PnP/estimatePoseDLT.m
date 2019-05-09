function [M] = estimatePoseDLT(p,P,K)
%ESTIMATEPOSEDLT Summary of this function goes here
%Input: 2D p_i and 3D P_i point correspondences.
%Return M :=[R|t]
%t_z=M_34 must be positive

num = length(p);
p_c_homog_ = [p, ones(num,1)];
p_c_homog=K\p_c_homog_';
p_c_homog=p_c_homog';
p_c=p_c_homog(:,1:2);
P_W_homog = [P, ones(num,1)];
M_col=zeros(12,1);
Q_tmp_left=[P_W_homog';zeros(8,num);P_W_homog'];
Q_left=reshape(Q_tmp_left,8,[]);
Q_left=Q_left';
Q_right_first = reshape(p_c',[],1);
Q_right_second_tmp=[P_W_homog';P_W_homog'];
Q_right_second=reshape(Q_right_second_tmp,4,[]);
Q_right_second=Q_right_second';
Q_right=-Q_right_first.*Q_right_second;
Q=[Q_left Q_right];

%Q*M_col=0 solve after M (non trivial solution)
[U,S,V]=svd(Q); %S and V sorted in order of descending Eigenvalues
%search smallest:
M_col=V(:,end);
M_col=M_col*sign(M_col(end));
M=reshape(M_col,4,[]);
M=M';

R_tmp=M(:,1:3);
t_tmp=M(:,4);
[Ur,Sr,Vr]=svd(R_tmp);
R=Ur*Vr';
alpha=norm(R,'fro')/norm(R_tmp,'fro');

M=[R,alpha*t_tmp];

end

