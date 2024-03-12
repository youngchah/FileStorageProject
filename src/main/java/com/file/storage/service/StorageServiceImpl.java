package com.file.storage.service;

import java.awt.Stroke;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
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
			String uploadPath = path + File.separator + datePath;
			System.out.println(uploadPath);
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
		
		StorageVO targetStorage = mapper.selectStorageFile(storage.getFileNo());
		
		int result = 0;
		
		MultipartFile uploadFile = storage.getFile();
		String path = req.getServletContext().getRealPath(resourcePath);
		String datePath = getCalPath();
		String uploadPath = path + File.separator + datePath;	// upload2024 이런식으로 붙어버려서 구분자넣어줌 
		
		if(targetStorage != null && StringUtils.isNotBlank(targetStorage.getFileName())) {
			boolean isDelete = realFileRemove(req.getServletContext().getRealPath(""),targetStorage.getFilePath());
		
			if(!isDelete) {
				throw new RuntimeException();
			}
		}
		
		File file = new File(uploadPath);
		
		if(!file.exists()) {
			file.mkdirs();
		}
		
		String fileName = System.currentTimeMillis() + "_";
		fileName += uploadFile.getOriginalFilename();
		
	
		try {
			FileCopyUtils.copy(uploadFile.getBytes(), new File(uploadPath, fileName));
			
			storage.setFileName(uploadFile.getOriginalFilename());
			storage.setFileSize(uploadFile.getSize());
			storage.setFileFancysize(FileUtils.byteCountToDisplaySize(uploadFile.getSize()));
			storage.setFileType(uploadFile.getContentType());
			storage.setFilePath(resourcePath + datePath + File.separator + fileName);
		
			result = mapper.updateFile(storage);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result > 0 ? true : false;
	}
	// DB 지우기
	@Override
	public boolean removeFile(HttpServletRequest req, int fileNo) {
		boolean isRemove = false;
		int result = 0;
		
		StorageVO storage = mapper.selectStorageFile(fileNo);
		String path = req.getServletContext().getRealPath("");
		
		isRemove = realFileRemove(path, storage.getFilePath());
		
		if(isRemove) {
			result = mapper.removeFile(fileNo);
		}
		
		return result > 0 ? true : false;
	}

	// 남아있는 진짜 파일 지우기 
	private boolean realFileRemove(String path, String filePath) {
		boolean isRemove = false;
		
		path += filePath.substring(1);
		String targetName = path.substring(path.lastIndexOf("\\")+1);
		path = path.substring(0, path.lastIndexOf("\\") + 1);
		
		if(path != null && StringUtils.isNotBlank(path)) {
			File file = new File(path);
			
			if(file.exists()) {
				File[] files = file.listFiles();
				
				for(int i = 0; i < files.length; i++) {
					if(files[i].isFile()) {
						String fileName = files[i].getName();
						
						if(fileName.equals(targetName)) {
							files[i].delete();
							isRemove = true;
						}
					}
				}
			}
		}
		
		return isRemove;
	}

	private String getCalPath() {
		return new SimpleDateFormat("yyyy/MM/dd").format(new Date());
	}

	@Override
	public StorageVO selectStorageFile(int fileNo) {
		
		return mapper.selectStorageFile(fileNo);
	}

	@Override
	public List<StorageVO> searchFile(Map<String, String> searchMap) {
		return mapper.searchFile(searchMap);
	}


	
	
	
	
}
