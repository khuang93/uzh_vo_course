function [R_C_W, t_C_W, query_keypoints, all_matches, best_inlier_mask, ...
    max_num_inliers_history] = ransacLocalization(...
    query_image, database_image, database_keypoints, p_W_landmarks, K)
% query_keypoints should be 2x1000
% all_matches should be 1x1000 and correspond to the output from the
%   matchDescriptors() function from exercise 3.
% best_inlier_mask should be 1xnum_matched (!!!) and contain, only for the
%   matched keypoints (!!!), 0 if the match is an outlier, 1 otherwise.
