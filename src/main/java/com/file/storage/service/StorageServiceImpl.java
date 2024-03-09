package com.file.storage.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.file.storage.ServiceResult;
import com.file.storage.mapper.IStorageMapper;
import com.file.storage.vo.StorageFileVO;

@Service
public class StorageServiceImpl implements IStorageService {

	@Inject
	private	IStorageMapper mapper;

	@Override
	public ServiceResult insertFile(StorageFileVO fileVO) {
		ServiceResult result = null;
		
		int status = mapper.insertFile(fileVO);
		
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	} 
	
	
	
}
