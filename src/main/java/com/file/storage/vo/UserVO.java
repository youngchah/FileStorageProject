package com.file.storage.vo;

import java.util.List;

import lombok.Data;

@Data
public class UserVO {
	private int userNo;
	private String userId;
	private String userPw;
	private String nickname;
	
	private List<WishVO> wishList;
	
}
