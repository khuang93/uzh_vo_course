function d=blocksave(ext_data,block_struct)
%     d=reshape(block_struct.data,[],1);
%     ext_data=block_struct.data;
    d=ext_data.*block_struct.data;
    
end
