package com.file.storage.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.file.storage.ServiceResult;
import com.file.storage.vo.StorageVO;

public interface IStorageService {

	List<StorageVO> getStorageFileList(String type);

	boolean insertFile(HttpServletRequest req, StorageVO storage);

	boolean updateFile(HttpServletRequest req, StorageVO storage);

}
