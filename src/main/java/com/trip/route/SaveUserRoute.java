package com.trip.route;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.test.util.DBUtil;
import com.trip.member.model.UserDTO;

@WebServlet("/route/saveUserRoute.do")
public class SaveUserRoute extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        JSONObject jsonResponse = new JSONObject();

        // 1. 로그인 상태 확인 (세션에서 user_id 가져오기)
        HttpSession session = req.getSession();
        Object userObj = session.getAttribute("user");

        if (userObj == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            jsonResponse.put("success", false);
            jsonResponse.put("message", "로그인이 필요합니다.");
            out.print(jsonResponse.toJSONString());
            return;
        }
        UserDTO userDto = (UserDTO) userObj;
        int userId = (int) userDto.getUserId(); // UserDTO에 getUserId() 메서드가 있다고 가정

        // 2. 파라미터로 넘어온 ai_route_id 가져오기
        String aiRouteIdStr = req.getParameter("aiRouteId");
        int aiRouteId = -1;
        try {
            aiRouteId = Integer.parseInt(aiRouteIdStr);
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            jsonResponse.put("success", false);
            jsonResponse.put("message", "잘못된 AI 경로 ID입니다.");
            out.print(jsonResponse.toJSONString());
            return;
        }

        // 3. 데이터베이스 처리 (트랜잭션 사용)
        Connection conn = null;
        PreparedStatement pstat = null;
        ResultSet rs = null;
        DBUtil util = new DBUtil();
        
        try {
            conn = util.open();
            conn.setAutoCommit(false); // 트랜잭션 시작

            // A. tblAiRoute에서 원본 데이터 읽기
            String sqlSelectAiRoute = "SELECT * FROM tblAiRoute WHERE ai_route_id = ?";
            pstat = conn.prepareStatement(sqlSelectAiRoute);
            pstat.setInt(1, aiRouteId);
            rs = pstat.executeQuery();

            if (rs.next()) {
                // B. tblUserRoute에 데이터 복사
                String sqlInsertUserRoute = "INSERT INTO tblUserRoute (user_route_id, user_id, source_ai_route_id, user_route_title, user_route_days, user_route_saved, user_route_region, user_route_startdate, user_route_enddate) VALUES (seqUserRoute.nextVal, ?, ?, ?, ?, SYSDATE, ?, ?, ?)";
                
                String generatedColumns[] = { "user_route_id" };
                PreparedStatement pstatInsertRoute = conn.prepareStatement(sqlInsertUserRoute, generatedColumns);
                
                pstatInsertRoute.setInt(1, userId);
                pstatInsertRoute.setInt(2, aiRouteId);
                pstatInsertRoute.setString(3, rs.getString("ai_route_title"));
                pstatInsertRoute.setInt(4, rs.getInt("ai_route_days"));
                pstatInsertRoute.setString(5, rs.getString("ai_route_region"));
                pstatInsertRoute.setDate(6, rs.getDate("ai_route_startdate"));
                pstatInsertRoute.setDate(7, rs.getDate("ai_route_enddate"));
                
                pstatInsertRoute.executeUpdate();
                
                // C. 방금 생성된 user_route_id 가져오기
                ResultSet generatedKeys = pstatInsertRoute.getGeneratedKeys();
                int newUserRouteId = -1;
                if (generatedKeys.next()) {
                    newUserRouteId = generatedKeys.getInt(1);
                }
                pstatInsertRoute.close();

                if (newUserRouteId == -1) {
                    throw new SQLException("새로운 사용자 경로 ID를 가져오는데 실패했습니다.");
                }

                // D. tblAiRouteStop에서 경유지 정보 읽기
                String sqlSelectAiStops = "SELECT * FROM tblAiRouteStop WHERE ai_route_id = ? ORDER BY ai_route_day, ai_route_stop_order";
                PreparedStatement pstatSelectStops = conn.prepareStatement(sqlSelectAiStops);
                pstatSelectStops.setInt(1, aiRouteId);
                rs.close(); // 이전 ResultSet 닫기
                rs = pstatSelectStops.executeQuery();

                // E. tblUserRouteStop에 경유지 정보 복사 (Batch Update 사용)
                String sqlInsertUserStops = "INSERT INTO tblUserRouteStop (user_route_stop_id, user_route_id, user_route_day, user_route_stop_order, user_route_lat, user_route_long, user_route_description) VALUES (seqUserRouteStop.nextVal, ?, ?, ?, ?, ?, ?)";
                PreparedStatement pstatInsertStops = conn.prepareStatement(sqlInsertUserStops);

                while (rs.next()) {
                    pstatInsertStops.setInt(1, newUserRouteId);
                    pstatInsertStops.setInt(2, rs.getInt("ai_route_day"));
                    pstatInsertStops.setInt(3, rs.getInt("ai_route_stop_order"));
                    pstatInsertStops.setDouble(4, rs.getDouble("ai_route_lat"));
                    pstatInsertStops.setDouble(5, rs.getDouble("ai_route_long"));
                    pstatInsertStops.setString(6, rs.getString("ai_route_description"));
                    pstatInsertStops.addBatch();
                }
                pstatInsertStops.executeBatch();
                pstatSelectStops.close();
                pstatInsertStops.close();

                conn.commit(); // 트랜잭션 완료

                jsonResponse.put("success", true);
                jsonResponse.put("newUserRouteId", newUserRouteId);

            } else {
                throw new Exception("ID가 " + aiRouteId + "인 AI 경로를 찾을 수 없습니다.");
            }

        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback(); // 에러 발생 시 롤백
            } catch (SQLException se) {
                se.printStackTrace();
            }
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.put("success", false);
            jsonResponse.put("message", e.getMessage());
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstat != null) pstat.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        out.print(jsonResponse.toJSONString());
        out.close();
    }
}
