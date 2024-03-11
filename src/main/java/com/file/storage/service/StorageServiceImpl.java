package com.file.storage.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.file.storage.ServiceResult;
import com.file.storage.mapper.IStorageMapper;
import com.file.storage.vo.StorageVO;

@Service
public class StorageServiceImpl implements IStorageService {

	@Inject
	private	IStorageMapper mapper;
	
	@Resource(name = "path")
	private String resourcePath;
	
	@Override
	public List<StorageVO> getStorageFileList(String type) {
		return mapper.getStorageFileList(type);
	}

	@Override
	public boolean insertFile(HttpServletRequest req, StorageVO storage) {
		String path = req.getServletContext().getRealPath(resourcePath);
		
		if(storage != null && StringUtils.isNotBlank(storage.getFile().getOriginalFilename())) {
			MultipartFile uploadFile = storage.getFile();
			String datePath = getCalPath();
			String uploadPath = path + datePath;
			File file = new File(uploadPath);
			
			if(!file.exists()) {
				file.mkdirs();
			}
			
//			 방법 1. UUID.randomUUID().toString()
			
//			 방법 2. System.currentTimeMillis()
			String fileName = System.currentTimeMillis() + "_";
			fileName += uploadFile.getOriginalFilename();
			
//			방법 1. [Spring.util] FileCopyUtils
//			try {
//				byte[] fileData = storage.getFile().getBytes();
//				FileCopyUtils.copy(fileData, new File(uploadPath, fileName));
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
			
//			방법 2. [Java NIO] Files
//			try {
//				Path targetDir = Paths.get(uploadPath + File.separator + fileName);
//				Files.write(targetDir, storage.getFile().getBytes());
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
			
//			방법 3. [MultipartFile] TransferTo
			
			
			try {
				uploadFile.transferTo(new File(uploadPath + File.separator + fileName));
				long fileSize = uploadFile.getSize();
				
				storage.setFileName(uploadFile.getOriginalFilename());
				storage.setFileType(uploadFile.getContentType());
				
				storage.setFileSize(fileSize);
				storage.setFileFancysize(FileUtils.byteCountToDisplaySize(fileSize));
				storage.setFilePath(resourcePath + datePath + File.separator + fileName);
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		int result = mapper.insertFile(storage);
		
		return result > 0 ? true : false;
	}

	@Override
	public boolean updateFile(HttpServletRequest req, StorageVO storage) {
		
		return false;
	}

	private String getCalPath() {
		return new SimpleDateFormat("yyyy/MM/dd").format(new Date());
	}
	
	
	
	
}
