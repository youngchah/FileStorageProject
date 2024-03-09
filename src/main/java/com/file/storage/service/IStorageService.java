package com.file.storage.service;

import com.file.storage.ServiceResult;
import com.file.storage.vo.StorageFileVO;

public interface IStorageService {
	public ServiceResult insertFile(StorageFileVO fileVO);

}
