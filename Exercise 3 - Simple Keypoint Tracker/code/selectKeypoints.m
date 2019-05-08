function keypoints = selectKeypoints(scores, num, r)
% Selects the num best scores as keypoints and performs non-maximum 
% supression of a (2r + 1)*(2r + 1) box around the current maximum.
scores_size=size(scores);
keypoints=zeros(2,num);
for i = 1:num
   [max_val, max_ind] = max(reshape(scores,[],1));
   [I,J]=ind2sub(scores_size,max_ind);
   keypoints(:,i)=[I J]';
   top=max(1,I-r);
   bottom=min(scores_size(1),I+r);
   left=max(1,J-r);
   right=min(scores_size(2),J+r);
   scores(top:bottom,left:right)=zeros(bottom-top+1,right-left+1);
%    scores(I-r:I+r,J-r:J+r)=padarray(scores(I,J),[r r],'both');
    
    
end