function matches = matchDescriptors(...
    query_descriptors, database_descriptors, lambda)
% Returns a 1xQ matrix where the i-th coefficient is the index of the
% database descriptor which matches to the i-th query descriptor.
% The descriptor vectors are MxQ and MxD where M is the descriptor
% dimension and Q and D the amount of query and database descriptors
% respectively. matches(i) will be zero if there is no database descriptor
% with an SSD < lambda * min(SSD). No two non-zero elements of matches will
% be equal.
[M,N]=size(database_descriptors);
% [D,I]=pdist2(query_descriptors',database_descriptors','euclidean','smallest',1);
[D,I]=pdist2(database_descriptors',query_descriptors','euclidean','smallest',1);
threshold=lambda*min(min(D));
% matches=I;
I(find(D>threshold))=0;
matches=I;
% for i=1:N
%     if D(i)<threshold
%         matches(i)=I(i);
%     end
% end

