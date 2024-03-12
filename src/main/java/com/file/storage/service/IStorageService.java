package com.file.storage.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.file.storage.ServiceResult;
import com.file.storage.vo.StorageVO;

public interface IStorageService {

	List<StorageVO> getStorageFileList(String type);

	boolean insertFile(HttpServletRequest req, StorageVO storage);

	boolean updateFile(HttpServletRequest req, StorageVO storage);

	StorageVO selectStorageFile(int fileNo);

	boolean removeFile(HttpServletRequest req, int fileNo);

	List<StorageVO> searchFile(Map<String, String> searchMap);

}
