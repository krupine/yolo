package com.mycom.member;

import java.util.List;

import javax.annotation.Resource;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.mycom.cancle.CancleModel;
import com.mycom.reservation.ReservModel;

@Service
public class MemberService implements MemberDao {
	
	@Resource
	private SqlSessionTemplate sqlSessionTemplate;
	
	//회원가입
	@Override
	public Object insertMember (MemberModel memberModel) {
		return sqlSessionTemplate.insert("member.insertMember", memberModel);
	}
	
	//아이디 중복확인
	@Override
	public String idCheck (String member_id) {
		return sqlSessionTemplate.selectOne("member.idCheck", member_id);
	}
	
	//아이디 찾기
	@Override
	public String findId (MemberModel memberModel) {
		return sqlSessionTemplate.selectOne("member.findId", memberModel);
	}
	
	//비밀번호 찾기
	@Override
	public String findPw (MemberModel memberModel) {
		return sqlSessionTemplate.selectOne("member.findPw", memberModel);
	}
	
	//로그인처리
	@Override
	public MemberModel login (MemberModel memberModel) {
		return sqlSessionTemplate.selectOne("member.login", memberModel);
	}
	
	//개인정보 보기
	@Override
	public MemberModel memberInfo (String member_id) {
		return sqlSessionTemplate.selectOne("member.memberInfo", member_id);
	}
	
	//개인정보 수정
	@Override
	public int memberModify (MemberModel memberModel) {
		return sqlSessionTemplate.update("member.memberModify", memberModel);
	}
	
	@Override
	public int pwModify (MemberModel memberModel) {
		return sqlSessionTemplate.update("member.pwModify", memberModel);
	}
	
	//회원 탈퇴
	@Override
	public int deleteMember (String member_id) {
		return sqlSessionTemplate.update("member.deleteMember", member_id);
	}
	
	//가장 최근 예약 정보 보기
	@Override
	public List<ReservModel> selectRecentReserv (String member_id) {
		return sqlSessionTemplate.selectList("reserv.selectRecentReserv", member_id);
	}
	
	//예약정보 리스트
	@Override
	public List<ReservModel> reservList (String member_id) {
		return sqlSessionTemplate.selectList("reserv.reservList", member_id);
	}
	
	//예약정보 상세보기
	@Override
	public ReservModel reservView (int reserv_no) {
		return sqlSessionTemplate.selectOne("reserv.reservView", reserv_no);
	}
	
	//예약 취소
	@Override
	public Object insertCancle(CancleModel cancleModel) {
		return sqlSessionTemplate.insert("cancle.insertCancle", cancleModel);
	}

}
