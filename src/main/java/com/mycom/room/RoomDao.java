package com.mycom.room;

import java.util.List;

import com.mycom.admin.RoomFileModel;

public interface RoomDao {
	
	public List<RoomModel> roomList();
	public RoomModel selectRoom(int room_no);
	public List<RoomFileModel> fileSelect(int room_no);

}
