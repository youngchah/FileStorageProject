package com.file.storage.mapper;

import java.util.List;

import com.file.storage.vo.StorageVO;

public interface IStorageMapper {

	List<StorageVO> getStorageFileList(String type);

	int insertFile(StorageVO storage);



}
