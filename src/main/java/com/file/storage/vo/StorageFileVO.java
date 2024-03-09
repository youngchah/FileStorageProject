package com.file.storage.vo;

import java.util.Date;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class StorageFileVO {
	private MultipartFile item;
	private int fileNo;
	private String fileName;
	private String fileType;
	private long fileSize;
	private String fileFancysize;
	private String fileContent;
	private String filePath;
	private Date fileDate;
	
	public StorageFileVO() {}
	
	//3개의 파일 중 1개로 아래 값을 자동으로 만드는 중(이름/크기/타입/팬시크기)
	public StorageFileVO(MultipartFile item) {
		this.item = item;
		this.fileName = item.getOriginalFilename();
		this.fileSize = item.getSize();
		this.fileType = item.getContentType();
		this.fileFancysize = FileUtils.byteCountToDisplaySize(fileSize);
	}
	
}
