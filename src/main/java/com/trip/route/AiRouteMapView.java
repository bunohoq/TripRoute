package com.trip.route;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import com.test.util.DBUtil;

@WebServlet("/route/aiMapView.do")
public class AiRouteMapView extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json; charset=UTF-8");
        PrintWriter out = resp.getWriter();

        String id = req.getParameter("id");
        int aiRouteId = 0;

        try {
            aiRouteId = Integer.parseInt(id);
        } catch (Exception e) {
            System.out.println("❌ 잘못된 id 값: " + id);
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
            String sql = "SELECT ai_route_day AS day, ai_route_stop_order AS \"order\", "
                    + "ai_route_description AS name, ai_route_lat AS lat, ai_route_long AS lng "
                    + "FROM tblAiRouteStop "
                    + "WHERE ai_route_id = ? "
                    + "ORDER BY ai_route_day, ai_route_stop_order";

            pstat = conn.prepareStatement(sql);
            pstat.setInt(1, aiRouteId);

            rs = pstat.executeQuery();

            while (rs.next()) {
                JSONObject obj = new JSONObject();
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
            try { rs.close(); } catch (Exception e) {}
            try { pstat.close(); } catch (Exception e) {}
            try { conn.close(); } catch (Exception e) {}
        }
    }
}
