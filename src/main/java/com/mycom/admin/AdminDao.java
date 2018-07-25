package com.mycom.admin;

import java.util.List;

import com.mycom.cancle.CancleModel;
import com.mycom.member.MemberModel;
import com.mycom.reservation.ReservModel;
import com.mycom.room.RoomModel;

public interface AdminDao {
	
	///////////////////////회원관리///////////////////////
	public List<MemberModel> memberlist();
	public MemberModel memberInfo(String member_id);
	public int memberModify(MemberModel memberModel);
	public int deleteMember(MemberModel memberModel);
	public List<MemberModel> searchMemberN(String searchKeyword);
	public List<MemberModel> searchMemberI(String searchKeyword);
	public List<MemberModel> searchMemberP(String searchKeyword);
	public List<MemberModel> searchMemberE(String searchKeyword);
	
	///////////////////////객실관리///////////////////////
	public int insertRoom(RoomModel roomModel);
	public List<RoomModel> selectRecentRoom();
	public int uploadFile(RoomFileModel roomFileModel);
	public List<RoomModel> adRoomList();
	public RoomModel selectRoom(int room_no);
	public List<RoomFileModel> fileSelect(int room_no);
	public int roomModify(RoomModel roomModel);
	public RoomFileModel files(int file_no);
	public int fileDelete(int room_no);
	public int deleteRoom(int room_no);
	
	///////////////////////예약관리///////////////////////
	public List<ReservModel> adReservList();
	public ReservModel reservView(int reserv_no);
	public int reservModify (ReservModel reservModel);
	public int reservPayCheck (int reserv_no);
	public int reservStatusModify (ReservModel reservModel);
	
	///////////////////////예약취소관리///////////////////////
	public List<CancleModel> adCancleList();
	public CancleModel selectCancle(int cancle_no);
	public int cancleStatusModify(CancleModel cancleModel);
	
}
