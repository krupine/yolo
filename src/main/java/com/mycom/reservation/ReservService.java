package com.mycom.reservation;

import java.util.List;

import javax.annotation.Resource;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.mycom.room.RoomModel;

@Service
public class ReservService implements ReservDao {
	
	@Resource
	private SqlSessionTemplate sqlSessionTemplate;
	
	//예약하기
	@Override
	public Object insertReserv (ReservModel reservModel) {
		return sqlSessionTemplate.insert("reserv.insertReserv", reservModel);
	}
	
	//예약 리스트 전체 불러오기(예약 가능 여부 확인)
	@Override
	public List<ReservModel> adReservList() {
		return sqlSessionTemplate.selectList("reserv.adReservList");
	}
	
	//방 이름 보여주기 용 방 정보 가져오기
	@Override
	public RoomModel selectRoom(int room_no) {
		return sqlSessionTemplate.selectOne("room.selectRoom", room_no);
	}

}
