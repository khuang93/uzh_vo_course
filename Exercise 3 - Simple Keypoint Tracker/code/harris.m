%Kailin Huang May 2019
function scores = harris(img, patch_size, kappa)

conv_x = reshape([-1 -2 -1 0 0 0 1 2 1],3,3);
conv_y= reshape([-1 -2 -1 0 0 0 1 2 1],3,3)';
I_x = conv2(img,conv_x,'valid');
I_x_2 = I_x.*I_x;
I_y = conv2(img,conv_y,'valid');
I_y_2 = I_y.*I_y;
I_x_I_y=I_x.*I_y;

I_patch=ones(patch_size);
sigma_I_x_2 = conv2(I_x_2,I_patch,'valid');
sigma_I_y_2 = conv2(I_y_2,I_patch,'valid');
sigma_I_x_I_y = conv2(I_x_I_y,I_patch,'valid');
% sIx2=reshape(sigma_I_x_2,[],1);
% sIy2=reshape(sigma_I_y_2,[],1);
% sIxIy=reshape(sigma_I_x_I_y,[],1);

% M=reshape([sIx2 sIxIy  sIxIy sIy2 ]',[2,2,376,1241]);

detM=sigma_I_x_2.*sigma_I_y_2-sigma_I_x_I_y.*sigma_I_x_I_y;
traceM=sigma_I_x_2+sigma_I_x_2;
R=detM-kappa*traceM.^2;
to_patch=(patch_size-1)/2+1;
scores=padarray(R,[to_patch,to_patch],'both');

