package com.trip.ai.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.test.util.DBUtil;

public class AiDAO {

    // AiDAO 생성 시마다 커넥션을 열지 않도록 수정
    public AiDAO() { }

    public RouteDTO saveAiRoute(RouteDTO route, String userId, Long conversationId) {
        
        // 각 메서드 내에서 커넥션을 열고 닫는 것이 더 안정적입니다.
        try (Connection conn = new DBUtil().open()) {
            
            conn.setAutoCommit(false); // 트랜잭션 시작

            // 1. tblAiRoute에 마스터 데이터 INSERT
            String sqlRoute = "INSERT INTO tblAiRoute (ai_route_id, user_id, conversation_id, ai_route_title, ai_route_days, ai_route_created, ai_route_region, ai_route_startdate, ai_route_enddate, weather_consideration) "
                            + "VALUES (seqAiRoute.nextval, ?, ?, ?, ?, sysdate, ?, to_date(?, 'YYYY-MM-DD'), to_date(?, 'YYYY-MM-DD'), ?)";
            
            String generatedColumns[] = { "ai_route_id" };
            
            try (PreparedStatement pstat = conn.prepareStatement(sqlRoute, generatedColumns)) {
                
                pstat.setString(1, userId);
                
                if (conversationId != null && conversationId > 0) {
                    pstat.setLong(2, conversationId);
                } else {
                    pstat.setNull(2, java.sql.Types.NUMERIC); 
                }
                
                // DTO 필드명 규칙(camelCase)에 맞게 getter 호출
                pstat.setString(3, route.getAi_route_title());
                pstat.setInt(4, route.getAi_route_days());
                pstat.setString(5, route.getAi_route_region());
                pstat.setString(6, route.getAi_route_startdate());
                pstat.setString(7, route.getAi_route_enddate());
                pstat.setString(8, route.getWeather_consideration());

                pstat.executeUpdate();

                try (ResultSet rs = pstat.getGeneratedKeys()) {
                    long generatedRouteId = 0;
                    if (rs.next()) {
                        generatedRouteId = rs.getLong(1);
                        route.setAi_route_id(generatedRouteId); // DTO에 생성된 ID 설정
                    }
                }
            }

            // 2. tblAiRouteStop에 경유지 데이터 INSERT
            String sqlStop = "INSERT INTO tblAiRouteStop (ai_route_stop_id, ai_route_id, ai_route_day, ai_route_stop_order, ai_route_description, activity_code, duration_in_minutes, restaurant_category, ai_route_lat, ai_route_long) "
                           + "VALUES (seqAiRouteStop.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            String stopGeneratedColumns[] = { "ai_route_stop_id" };
            
            try (PreparedStatement pstat = conn.prepareStatement(sqlStop, stopGeneratedColumns)) {
                for (RouteStopDTO stop : route.getStops()) {
                    pstat.setLong(1, route.getAi_route_id());
                    pstat.setInt(2, stop.getAi_route_day());
                    pstat.setInt(3, stop.getAi_route_stop_order());
                    pstat.setString(4, stop.getAi_route_description());
                    pstat.setString(5, stop.getActivity_code());
                    pstat.setInt(6, stop.getDuration_in_minutes());
                    pstat.setString(7, stop.getRestaurant_category());
                    pstat.setDouble(8, stop.getAi_route_lat());
                    pstat.setDouble(9, stop.getAi_route_long());
                    
                    pstat.executeUpdate();
                    
                    // ★★★ (핵심 수정) 방금 생성된 ai_route_stop_id를 가져와서 DTO에 다시 설정 ★★★
                    try (ResultSet rs = pstat.getGeneratedKeys()) {
                        if (rs.next()) {
                            stop.setAi_route_stop_id(rs.getLong(1));
                        }
                    }
                }
            }

            conn.commit(); // 모든 작업이 성공하면 커밋
            
        } catch (Exception e) {
            System.out.println("AiDAO.saveAiRoute 오류 발생");
            e.printStackTrace();
            // try-with-resources가 자동으로 conn.close()를 호출하므로 rollback 불필요
        }
        
        return route;
    }
    
    public void saveHealthCareLog(RouteStopDTO stop, String userId, double userWeight, String startDate) {
        
        double mets = 0;
        switch (stop.getActivity_code()) {
            case "WALK_SLOW": mets = 2.0; break;
            case "WALK_NORMAL": mets = 3.5; break;
            case "WALK_FAST": mets = 4.3; break;
            case "HIKE_LIGHT": mets = 5.3; break;
            default: return;
        }

        double durationInHours = (double) stop.getDuration_in_minutes() / 60.0;
        double caloriesBurned = mets * userWeight * durationInHours;

        String sql = "INSERT INTO tblHealthCareLog (healthcare_id, user_id, ai_route_stop_id, healthcare_date, healthcare_distance_km, healthcare_steps_count, healthcare_calories_burned) "
                   + "VALUES (seqHealthCareLog.nextval, ?, ?, TO_DATE(?, 'YYYY-MM-DD') + ?, ?, ?, ?)";
        
        try (Connection conn = new DBUtil().open();
             PreparedStatement pstat = conn.prepareStatement(sql)) {
            
            pstat.setString(1, userId);
            pstat.setLong(2, stop.getAi_route_stop_id()); // 이제 이 ID는 NULL이 아님
            pstat.setString(3, startDate);
            pstat.setInt(4, stop.getAi_route_day() - 1);
            pstat.setDouble(5, stop.getWalking_distance_km());
            pstat.setInt(6, stop.getWalking_steps_count());
            pstat.setDouble(7, caloriesBurned);
            
            pstat.executeUpdate();

        } catch (Exception e) {
            System.out.println("AiDAO.saveHealthCareLog 오류 발생");
            e.printStackTrace();
        }
    }
    
    // 사용자 질문 저장 기능 (다음 단계에서 구현)
    public Long saveConversationAndAnswers(TripPreferencesDTO preferences, String userId) {
        return null;
    }
}