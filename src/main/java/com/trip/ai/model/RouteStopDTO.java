package com.trip.ai.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
//AI 루트의 각 경유지(stops) 정보를 담는 내부 DTO 클래스
public class RouteStopDTO {
	
	private long ai_route_stop_id;
    private long ai_route_id;

    // DB 컬럼명과 일치시킨 필드
    private int ai_route_day;
    private int ai_route_stop_order;
    private double ai_route_lat;
    private double ai_route_long;
    private String ai_route_description;
    
    // AI가 생성하고 DB에 저장할 추가 정보 필드
    private String activity_code;
    private int duration_in_minutes;
    private String restaurant_category;
    
    // 헬스케어 관련 정보 (DB에는 저장하지 않음)
    // 이 값들은 AiDAO에서 칼로리 계산 후 tblHealthCareLog에 별도로 저장됩니다.
    private Double walking_distance_km;
    private Integer walking_steps_count;
	
	
}
