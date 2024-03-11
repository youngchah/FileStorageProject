package com.file.storage.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.file.storage.mapper.IUserMapper;

@Service
public class UserServiceImpl implements IUserService {
	
	@Inject
	private IUserMapper userMapper;
}
