package com.mycom.member;

import java.util.List;

import com.mycom.cancle.CancleModel;
import com.mycom.reservation.ReservModel;

public interface MemberDao {
	
	public Object insertMember (MemberModel memberModel);
	public String idCheck (String member_id);
	public String findId (MemberModel memberModel);
	public String findPw (MemberModel memberModel);
	public MemberModel login (MemberModel memberModel);
	public MemberModel memberInfo (String member_id);
	public int memberModify (MemberModel memberModel);
	public int pwModify(MemberModel memberModel);
	public int deleteMember (String member_id);
	public List<ReservModel> selectRecentReserv (String member_id);
	public List<ReservModel> reservList (String member_id);
	public ReservModel reservView (int reserv_no);
	public Object insertCancle(CancleModel cancleModel);

}
