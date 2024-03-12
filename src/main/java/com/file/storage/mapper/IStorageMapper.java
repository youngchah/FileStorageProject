package com.file.storage.mapper;

import java.util.List;
import java.util.Map;

import com.file.storage.vo.StorageVO;

public interface IStorageMapper {

	List<StorageVO> getStorageFileList(String type);

	int insertFile(StorageVO storage);

	StorageVO selectStorageFile(int fileNo);

	int removeFile(int fileNo);

	int updateFile(StorageVO storage);

	List<StorageVO> searchFile(Map<String, String> searchMap);



}
