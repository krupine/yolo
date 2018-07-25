package com.mycom.room;

import java.util.List;

import javax.annotation.Resource;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.mycom.admin.RoomFileModel;

@Service
public class RoomService implements RoomDao {
	
	@Resource
	private SqlSessionTemplate sqlSessionTemplate;
	
	//객실 리스트(메뉴용)
	@Override
	public List<RoomModel> roomList() {
		return sqlSessionTemplate.selectList("room.roomList");
	}
		
	//객실 상세보기
	@Override
	public RoomModel selectRoom(int room_no) {
		return sqlSessionTemplate.selectOne("room.selectRoom", room_no);
	}
	
	//객실 상세보기-사진
	@Override
	public List<RoomFileModel> fileSelect(int room_no) {
		return sqlSessionTemplate.selectList("roomFile.fileSelect", room_no);
	}

}
