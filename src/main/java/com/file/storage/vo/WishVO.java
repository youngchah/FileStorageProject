package com.file.storage.vo;

import lombok.Data;

@Data
public class WishVO {
	private int wishNo;
	private int userNo;
	private int fileNo;
	private String wishDate;
	
	private StorageVO storage;
}
