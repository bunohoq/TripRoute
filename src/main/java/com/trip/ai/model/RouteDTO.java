package com.trip.ai.model;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RouteDTO {
	
	//tblAiRoute 테이블과 매핑
	private long ai_route_id;
	private long user_id;
	private long conversation_id;
	
	private String ai_route_title;
	private int ai_route_days;
	private Date ai_route_created;
	private String ai_route_region;
	private String ai_route_startdate;
	private String ai_route_enddate;
	private String weather_consideration;
    
    
    //tblAiRouteStop 테이블과 매핑 (하나의 루트는 여러 개의 경유지를 가짐)
    private List<RouteStopDTO> stops;

}
