function descriptors = describeKeypoints(img, keypoints, r)
% Returns a (2r+1)^2xN matrix of image patch vectors based on image
% img and a 2xN matrix containing the keypoint coordinates.
% r is the patch "radius".
N=length(keypoints);
descriptors=zeros((2*r+1)^2,N);
pad_img=padarray(img,[r r],'both');
for i = 1:N
    idx=keypoints(:,i);
    patch=pad_img(idx(1):idx(1)+2*r,idx(2):idx(2)+2*r);
    descriptors(:,i)=reshape(patch,[],1);
end
