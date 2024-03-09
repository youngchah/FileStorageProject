package com.file.storage.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.file.storage.ServiceResult;
import com.file.storage.service.IStorageService;
import com.file.storage.vo.StorageFileVO;
import com.file.storage.vo.StorageVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/storage")
@Slf4j
public class StorageController {
	
	@Resource(name = "path")
	private String path;
	
	@Inject
	private IStorageService storageService;
	
	@GetMapping("/main.do")
	public String main(Model model) throws Exception {
		File file = new File(path);
		String downloadPath = "/resources/upload/";
		
		File[] files = file.listFiles();
		List<StorageVO> storageList = new ArrayList<>();
		for (File f : files) {
			String filePath = path + f.getName();
			Path p = Paths.get(filePath);
			String mimeType = Files.probeContentType(p);
			
			System.out.println("NAME : " + f.getName());
			System.out.println("SIZE : " + f.length());
			System.out.println("TYPE : " + mimeType);
			StorageVO vo = new StorageVO();
			vo.setFilePath(downloadPath + f.getName());
			vo.setFileName(f.getName().split("_")[1]);
			vo.setFileSize(f.length());
			vo.setFileFancySize(FileUtils.byteCountToDisplaySize(f.length()));
			vo.setFileType(mimeType);
			
			storageList.add(vo);
		}
		
		model.addAttribute("storageList", storageList);
		
		return "filestorage";
	}
	
	@GetMapping("/uploadForm.do")
	public String uploadForm() {
		return "uploadform";
	}
	
//	@PostMapping("/uploadForm.do")
//	public String upload(MultipartFile formFile, String fileContent) {
//		
//		log.info("name : " + formFile.getOriginalFilename());
//		log.info("size : " + formFile.getSize());
//		log.info("type : " + formFile.getContentType());
//		log.info("content : " + fileContent);
//		
//		log.info("path : " + path);
//		
//		if(formFile != null && formFile.getOriginalFilename() != null && !formFile.getOriginalFilename().equals("")) {
//			String fileName = UUID.randomUUID().toString() + "_";
//			fileName += formFile.getOriginalFilename();
//			
//			File file = new File(path);
//			
//			if(!file.exists()) {
//				file.mkdirs();
//			}
//			
//			String uploadPath = path + "/" + fileName;
//			try {
//					
//				formFile.transferTo(new File(uploadPath));
//				
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
//		
//		return "redirect:main.do";
//	}
	
	@PostMapping("/uploadForm.do")
	public String upload(
			MultipartFile formFile,
			StorageFileVO fileVO, Model model) {
		
		log.info("name : " + fileVO.getFileName());
		log.info("size : " + fileVO.getFileSize());
		log.info("type : " + fileVO.getFileType());
		log.info("content : " + fileVO.getFileContent());
		
		log.info("path : " + path);
		
		if(formFile != null && formFile.getOriginalFilename() != null && !formFile.getOriginalFilename().equals("")) {
			String fileName = UUID.randomUUID().toString() + "_";
			fileName += formFile.getOriginalFilename();
			
			File file = new File(path);
			
			if(!file.exists()) {
				file.mkdirs();
			}
			
			String uploadPath = path + "/" + fileName;
			try {
					
				formFile.transferTo(new File(uploadPath));
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		storageService.insertFile(fileVO);
		model.addAttribute("fileVO", fileVO)
;		
		
		return "redirect:main.do";
		
	}
	
	
	// type별 정렬
	@PostMapping("/changeImage.do")
	public ResponseEntity<List<String>> imageChange(
			@RequestBody StorageVO vo
			){
		List<String> typeImageList = new ArrayList<String>();
		List<StorageVO> storageList;
	
	
		return new ResponseEntity<List<String>>(typeImageList,HttpStatus.OK);
		
	}
	
	
}
 