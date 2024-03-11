package com.file.storage.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.file.storage.mapper.IWishMapper;
import com.file.storage.vo.WishVO;

@Service
public class WishServiceImpl implements IWishService {

	@Inject
	private IWishMapper wishMapper;
	

	@Override
	public List<WishVO> getLikeListThree(int userNo) {
		return wishMapper.getLikeListThree(userNo);
	}

}
