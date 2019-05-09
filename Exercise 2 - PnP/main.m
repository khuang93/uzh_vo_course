clear all;
close all;
% clc;
load('detected_corners.txt');
p_W_corners=0.01*load('p_W_corners.txt');
p_c_all=reshape(detected_corners,749,2,12);
p_c_1=reshape(p_c_all(1,:,:),2,[]);
p_c_1=p_c_1';
load('K.txt');
%%
%1st frame
tic;
M=estimatePoseDLT(p_c_1,p_W_corners,K);
toc
% tic;
% M2=estimatePoseDLT_sol(p_c_1,p_W_corners,K);
% toc

PP=reprojectPoints(p_W_corners,M,K)
% PP_sol=reprojectPoints_sol(p_W_corners,M,K)

