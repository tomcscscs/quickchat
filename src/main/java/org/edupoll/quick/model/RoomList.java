package org.edupoll.quick.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class RoomList {
	private String roomId;
	private Date createdAt;
	private String title;
	private String openerName;
	private String userId;
	
	

}
