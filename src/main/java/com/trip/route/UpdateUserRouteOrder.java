package com.trip.route;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.test.util.DBUtil;
import com.trip.member.model.UserDTO;

@WebServlet("/route/updateUserRouteOrder.do")
public class UpdateUserRouteOrder extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        JSONObject jsonResponse = new JSONObject();

        // 1. 로그인 상태 확인
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

        // 2. 요청 본문(body)에서 JSON 데이터 읽기
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = req.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        Long userRouteId = null;
        JSONObject updatedDays = null;

        try {
            JSONParser parser = new JSONParser();
            JSONObject jsonRequest = (JSONObject) parser.parse(sb.toString());
            userRouteId = (Long) jsonRequest.get("userRouteId");
            updatedDays = (JSONObject) jsonRequest.get("updatedDays");
            if (userRouteId == null || updatedDays == null) {
                throw new Exception();
            }
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            jsonResponse.put("success", false);
            jsonResponse.put("message", "요청 데이터 형식이 잘못되었습니다.");
            out.print(jsonResponse.toJSONString());
            return;
        }

        // 3. 데이터베이스 처리 (트랜잭션)
        Connection conn = null;
        PreparedStatement pstat = null;
        DBUtil util = new DBUtil();

        try {
            conn = util.open();
            conn.setAutoCommit(false); // 트랜잭션 시작

            // TODO: 이 경로의 소유자가 현재 로그인한 사용자인지 확인하는 로직 추가 필요

            String sql = "UPDATE tblUserRouteStop SET user_route_day = ?, user_route_stop_order = ? WHERE user_route_stop_id = ? AND user_route_id = ?";
            pstat = conn.prepareStatement(sql);

            for (Object dayKeyObj : updatedDays.keySet()) {
                String dayKey = (String) dayKeyObj;
                int day = Integer.parseInt(dayKey);
                JSONArray stopIdsForDay = (JSONArray) updatedDays.get(dayKey);

                for (int i = 0; i < stopIdsForDay.size(); i++) {
                    long stopId = (Long) stopIdsForDay.get(i);
                    int newOrder = i + 1;

                    pstat.setInt(1, day); // Set user_route_day
                    pstat.setInt(2, newOrder); // Set user_route_stop_order
                    pstat.setLong(3, stopId); // WHERE user_route_stop_id
                    pstat.setLong(4, userRouteId);
                    pstat.addBatch();
                }
            }

            pstat.executeBatch();
            conn.commit(); // 트랜잭션 완료

            jsonResponse.put("success", true);
            jsonResponse.put("message", "경로 순서가 성공적으로 저장되었습니다.");

        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException se) {
                se.printStackTrace();
            }
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.put("success", false);
            jsonResponse.put("message", "순서 저장 중 오류가 발생했습니다: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try { if (pstat != null) pstat.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        out.print(jsonResponse.toJSONString());
        out.close();
    }
}
