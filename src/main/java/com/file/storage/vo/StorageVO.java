package com.file.storage.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class StorageVO {
	private int fileNo;
	private String fileName;
	private String fileType;
	private long fileSize;
	private String fileFancysize;
	private String fileContent;
	private String filePath;
	private String fileDate;
	
	private MultipartFile file;
	
}
