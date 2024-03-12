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
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.file.storage.ServiceResult;
import com.file.storage.service.IStorageService;
import com.file.storage.service.IWishService;
import com.file.storage.util.StorageUtils;
import com.file.storage.vo.StorageVO;
import com.file.storage.vo.UserVO;
import com.file.storage.vo.WishVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/storage")
@Slf4j
public class StorageController {
	
	
	@Inject
	private IStorageService service;
	
	@Inject
	private IWishService wishService;
	
	@GetMapping("/main.do")
	public String main(HttpSession session, Model model) {
		List<StorageVO> storageList = service.getStorageFileList("all");
		UserVO loginUser = session.getAttribute("LOGIN_USER") == null ? null : (UserVO) session.getAttribute("LOGIN_USER");
		if(loginUser != null) {
			List<WishVO> wishList = wishService.getLikeListThree(loginUser.getUserNo());
			model.addAttribute("wishList", wishList);
		}
		model.addAttribute("storageList", storageList);
		
		return "storage/storage";
	
	}
	
	@GetMapping("/uploadForm.do")
	public String uploadForm() {
		return "storage/upload";
	}
	
	
	@PostMapping("/upload.do")
	public String upload(HttpServletRequest req, StorageVO storage, Model model) {
		
		String goPage = "redirect:main.do";
		boolean result = false;
		
		if(storage.getFileNo() == 0) 
			result = service.insertFile(req, storage);
		else
			result = service.updateFile(req, storage);
		
		if(!result) {
			goPage = "uploadForm";
			model.addAttribute("message", "서버 에러 입니다. 파일을 다시 업로드 해주세요.");
			model.addAttribute("storage", storage);
		}
		return goPage;
	}
	
	@GetMapping("/edit.do")
	public String editForm(int fileNo, Model model) {
		StorageVO storage = service.selectStorageFile(fileNo);
		
		model.addAttribute("storage", storage);
		model.addAttribute("status", "edit");
		
		return "storage/upload";
	}
	
	@ResponseBody
	@PostMapping("/fileRemove.do")
	public String removeFile(HttpServletRequest req, int fileNo) {
		String response = "FAILED";
		
		boolean result = service.removeFile(req, fileNo);
		
		if(result)
			response = "SUCCESS";
		
		return response;
	}
	
	@ResponseBody
	@GetMapping("/main.do/{type}")
	public List<StorageVO> typeSortList(@PathVariable String type){
		List<StorageVO> storageList = service.getStorageFileList(type);
		return storageList;
	}
	
	@ResponseBody
	@GetMapping("/search.do")
	public List<StorageVO> searchFile(@RequestParam Map<String, String> searchMap){
		List<StorageVO> storageList = service.searchFile(searchMap);
		return storageList;
	}
	
	@GetMapping("/download.do")
	public ResponseEntity<byte[]> download(HttpServletRequest req, int fileNo){
		
		StorageVO storage = service.selectStorageFile(fileNo);
		
		ResponseEntity<byte[]> entity = StorageUtils.getFileEntity(req, storage, true);
		
		return entity;
	}
	
	
	
	
}





 