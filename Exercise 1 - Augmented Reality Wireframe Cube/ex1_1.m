%Kailin Huang 2019 May
%%
%Load data
K = load('K.txt');
im_rgb=imread('data\images_undistorted\img_0001.jpg');
im_gray=rgb2gray(im_rgb);
%grid points
[X,Y,Z]=meshgrid(0:8,0:5,0); 
%4cm = 40mm
size_factor = 0.04; %meter
X=X*size_factor;
X=reshape(X,[],1);
Y=Y*size_factor;
Y=reshape(Y,[],1);
Z=Z*size_factor;
Z=reshape(Z,[],1);

pts=[X Y Z];

%pose
P=load('poses.txt');
P1=P(1,:);
P1_r=P1(1:3);
P1_t=P1(4:6)';
omega = norm(P1_r);
R=axang2rotm([P1_r/omega omega]);
pt_1=pts(1,:)';

pt_1_im=project_w2c(pt_1,K,R,P1_t);

pt_im_vec=zeros(length(pts),2);

for i=1:length(pts)
    pt=pts(i,:)';
    pt_im=project_w2c(pt,K,R,P1_t);
    pt_im_vec(i,:)=pt_im;
end

%%
%show
imshow(im_gray);
hold on
scatter(pt_im_vec(:,1),pt_im_vec(:,2),5,'r');

%%
%Cube
w=0.08;
start=[0 0 0];
tmp=triu(ones(4,3))';
cube_pts=w*[0 0 0; 0 0 -1; 0 1 -1; 0 1 0; 1 0 0 ; 1 0 -1; 1 1 0; 1 1 -1 ];
cube_pt_im_vec=zeros(length(cube_pts),2);
for i=1:length(cube_pts)
    pt=cube_pts(i,:)';
    pt_im=project_w2c(pt,K,R,P1_t);
    cube_pt_im_vec(i,:)=pt_im;
end

plot(cube_pt_im_vec(:,1),cube_pt_im_vec(:,2),'b');

