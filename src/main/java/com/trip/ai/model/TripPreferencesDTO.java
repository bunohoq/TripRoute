package com.trip.ai.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TripPreferencesDTO {
	
	private String city;
    private String duration;
    private String travelStyle;
    private String activityTime;
    private String budget;
    private String preferredArea;
    private String transportation;
    private String activityType;
    private String companion;
    
    private String startDate;
    private String endDate;
    
    // 헬스케어 정보 (중첩된 객체)
    private PhysicalInfo physicalInfo;
    private String healthGoal;
    private String foodPreference;
    private String healthCondition;
    
    @Getter
    @Setter
    @ToString
    public static class PhysicalInfo {
    	private String gender;
    	private double height;
    	private double weight;
    }
	
	

}
