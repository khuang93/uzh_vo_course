%Kailin Huang 2019 May
%%
%Load data
K = load('K.txt');
D = load('D.txt');
im_rgb=imread('data\images\img_0001.jpg');
im_gray=rgb2gray(im_rgb);
im_undist = uint8(undistort_img(im_gray,K,D));
imshow(im_undist);
