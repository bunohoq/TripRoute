package com.trip.notice.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeDTO {
	
	private String notice_post_id;
	private String admin_id;
	private String notice_header;
	private String notice_content;
	private String notice_view_count;
	private String notice_regdate;
	

	//DB에는 없지만, 화면 출력을 위해 필요한 멤버 변수
	private String rnum; 
	private String isnew;

}
