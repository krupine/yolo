package com.mycom.reservation;

import java.util.List;

import com.mycom.room.RoomModel;

public interface ReservDao {
	
	public Object insertReserv (ReservModel reservModel);
	public RoomModel selectRoom(int room_no);
	public List<ReservModel> adReservList();

}
