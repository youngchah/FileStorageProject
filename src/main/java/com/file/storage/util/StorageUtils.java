package com.file.storage.util;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import com.file.storage.vo.StorageVO;

public class StorageUtils {
	
	public static MediaType getMediaType(String fileType) {
		
		MediaType mediaType = null;
		switch (fileType) {
			case "image/jpg":
			case "image/jpeg":
				mediaType = MediaType.IMAGE_JPEG;
				break;
			case "image/png":
				mediaType = MediaType.IMAGE_PNG;
				break;
			case "image/gif":
				mediaType = MediaType.IMAGE_GIF;
				break;
			case "text/plain":
				mediaType = MediaType.TEXT_PLAIN;
				break;
			case "application/pdf":
				mediaType = MediaType.APPLICATION_PDF;
				break;
			case "application/xml":
				mediaType = MediaType.APPLICATION_XML;
				break;
			default:
				mediaType = MediaType.APPLICATION_OCTET_STREAM;
				break;
		}
		return mediaType;
	}
	
	
	public static ResponseEntity<byte[]> getFileEntity(HttpServletRequest req, StorageVO storage, boolean addHeader){
		
		ResponseEntity<byte[]> entity = null;
		
		String fileType = storage.getFileType();
		
		MediaType type = StorageUtils.getMediaType(fileType);
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(type);
		
		String path = req.getServletContext().getRealPath("");
		String downloadPath = path + storage.getFilePath();
		File file = new File(downloadPath);
		
		try {
			byte[] fileData = FileUtils.readFileToByteArray(file);
			
			if(addHeader) {
				headers.add(headers.CONTENT_DISPOSITION, "attachment; filename="
					+ new String(storage.getFileName().getBytes(StandardCharsets.UTF_8), StandardCharsets.ISO_8859_1));
			}
			
			entity = new ResponseEntity<byte[]>(fileData, headers, HttpStatus.CREATED);
			
		} catch (IOException e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>	(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
