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
	public void insertFile(StorageFileVO fileVO) {
		
		mapper.insertFile(fileVO);
		
	} 
	
	
	
}
