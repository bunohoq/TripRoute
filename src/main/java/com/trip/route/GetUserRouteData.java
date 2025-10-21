package com.trip.route;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.test.util.DBUtil;

@WebServlet("/route/getUserRouteData.do")
public class GetUserRouteData extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        resp.setContentType("application/json; charset=UTF-8");
        PrintWriter out = resp.getWriter();

        String userRouteIdStr = req.getParameter("id");
        int userRouteId = -1;

        try {
            userRouteId = Integer.parseInt(userRouteIdStr);
        } catch (Exception e) {
            System.out.println("❌ 잘못된 id 값: " + userRouteIdStr);
            out.write("[]");
            return;
        }

        DBUtil util = new DBUtil();
        Connection conn = null;
        PreparedStatement pstat = null;
        ResultSet rs = null;

        JSONArray arr = new JSONArray();

        try {
            conn = util.open();
            String sql = "SELECT user_route_stop_id AS stopId, user_route_day AS day, user_route_stop_order AS \"order\", "
                    + "user_route_description AS name, user_route_lat AS lat, user_route_long AS lng "
                    + "FROM tblUserRouteStop "
                    + "WHERE user_route_id = ? "
                    + "ORDER BY user_route_day, user_route_stop_order";

            pstat = conn.prepareStatement(sql);
            pstat.setInt(1, userRouteId);

            rs = pstat.executeQuery();

            while (rs.next()) {
                JSONObject obj = new JSONObject();
                obj.put("stopId", rs.getInt("stopId"));
                obj.put("day", rs.getInt("day"));
                obj.put("order", rs.getInt("order"));
                obj.put("name", rs.getString("name"));
                obj.put("lat", rs.getDouble("lat"));
                obj.put("lng", rs.getDouble("lng"));
                arr.add(obj);
            }

            out.print(arr.toJSONString());

        } catch (Exception e) {
            e.printStackTrace();
            out.print("[]");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstat != null) pstat.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
