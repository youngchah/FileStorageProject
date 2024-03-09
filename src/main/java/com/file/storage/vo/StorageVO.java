package com.file.storage.vo;

import lombok.Data;

@Data
public class StorageVO {
	private static int sequence = 1;
	private int fileNo;
	private String fileName;
	private String fileType;
	private long fileSize;
	private String fileFancySize;
	private String fileContent;
	private String filePath;
	
	
	public StorageVO() {
		this.fileNo = sequence++;
	}
}
