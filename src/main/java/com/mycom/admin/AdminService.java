package com.mycom.admin;

import java.util.List;

import javax.annotation.Resource;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.mycom.cancle.CancleModel;
import com.mycom.member.MemberModel;
import com.mycom.reservation.ReservModel;
import com.mycom.room.RoomModel;

@Service
public class AdminService implements AdminDao {
	
	@Resource
	private SqlSessionTemplate sqlSessionTemplate;
	
	///////////////////////회원관리///////////////////////
	
	//회원 리스트 보여주기
	@Override
	public List<MemberModel> memberlist(){
		return sqlSessionTemplate.selectList("member.memberList");
	}
	
	//회원 상세정보 보기
	@Override
	public MemberModel memberInfo(String member_id) {
		return sqlSessionTemplate.selectOne("member.memberInfo", member_id);
	}
	
	//회원정보 변경
	@Override
	public int memberModify(MemberModel memberModel) {
		return sqlSessionTemplate.update("member.memberModify", memberModel);
	}
	
	//회원 삭제
	@Override
	public int deleteMember(MemberModel memberModel) {
		return sqlSessionTemplate.update("member.deleteMember", memberModel);
	}
	
	//회원 검색-이름
	@Override
	public List<MemberModel> searchMemberN(String searchKeyword){
		return sqlSessionTemplate.selectList("member.searchMemberN", searchKeyword);
	}
	
	//회원 검색-아이디
	@Override
	public List<MemberModel> searchMemberI(String searchKeyword) {
		return sqlSessionTemplate.selectList("member.searchMemberI", searchKeyword);
	}
	
	//회원 검색-전화번호
	@Override
	public List<MemberModel> searchMemberP(String searchKeyword) {
		return sqlSessionTemplate.selectList("member.searchMemberP", searchKeyword);
	}
	
	//회원 검색-이메일
	@Override
	public List<MemberModel> searchMemberE(String searchKeyword) {
		return sqlSessionTemplate.selectList("member.searchMemberE", searchKeyword);
	}
	
	///////////////////////객실관리///////////////////////
	
	//객실 등록
	@Override
	public int insertRoom(RoomModel roomModel) {
		return sqlSessionTemplate.insert("room.insertRoom", roomModel);
	}
	
	public List<RoomModel> selectRecentRoom() {
		return sqlSessionTemplate.selectList("room.selectRecentRoom");
	}
	
	//객실 사진 업로드
	@Override
	public int uploadFile(RoomFileModel roomFileModel) {
		return sqlSessionTemplate.insert("roomFile.uploadFile", roomFileModel);
	}
	
	//객실 리스트
	@Override
	public List<RoomModel> adRoomList() {
		return sqlSessionTemplate.selectList("room.adRoomList");
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
	
	//객실정보 수정하기
	@Override
	public int roomModify(RoomModel roomModel) {
		return sqlSessionTemplate.update("room.roomModify", roomModel);
	}
	
	//객실 사진 실제 삭제
	@Override
	public RoomFileModel files(int file_no) {
		return sqlSessionTemplate.selectOne("roomFile.files", file_no);
	}
	
	//객실 사진 업데이트(사진 삭제 후 신규 사진 갱신)
	@Override
	public int fileDelete(int room_no) {
		return sqlSessionTemplate.delete("roomFile.fileDelete", room_no);
	}
	
	//객실 삭제하기
	@Override
	public int deleteRoom(int room_no) {
		return sqlSessionTemplate.update("room.deleteRoom", room_no);
	}
	
	///////////////////////예약관리///////////////////////
	
	//예약 리스트 보여주기
	@Override
	public List<ReservModel> adReservList() {
		return sqlSessionTemplate.selectList("reserv.adReservList");
	}
	
	//예약 상세보기
	@Override
	public ReservModel reservView(int reserv_no) {
		return sqlSessionTemplate.selectOne("reserv.reservView", reserv_no);
	}
	
	//예약 정보 수정하기
	@Override
	public int reservModify (ReservModel reservModel) {
		return sqlSessionTemplate.update("reserv.reservModify", reservModel);
	}
	
	//입금 확인하기
	@Override
	public int reservPayCheck (int reserv_no) {
		return sqlSessionTemplate.update("reserv.reservPayCheck", reserv_no);
	}
	
	//예약 상태 변경하기
	@Override
	public int reservStatusModify (ReservModel reservModel) {
		return sqlSessionTemplate.update("reserv.reservStatusModify", reservModel);
	}
	
	///////////////////////예약관리///////////////////////
	
	//예약 취소 리스트
	@Override
	public List<CancleModel> adCancleList() {
		return sqlSessionTemplate.selectList("cancle.adCancleList");
	}
	
	//예약 취소 상세보기
	@Override
	public CancleModel selectCancle(int cancle_no) {
		return sqlSessionTemplate.selectOne("cancle.selectCancle", cancle_no);
	}
	
	//예약 취소 상태변경
	@Override
	public int cancleStatusModify(CancleModel cancleModel) {
		return sqlSessionTemplate.update("cancle.cancleStatusModify", cancleModel);
	}

}
