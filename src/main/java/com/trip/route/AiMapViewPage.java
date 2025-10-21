package com.trip.route;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/route/aiMapViewPage.do")
public class AiMapViewPage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String id = req.getParameter("id");
        System.out.println("⭐ AiMapViewPage id = " + id); // 로그 확인용

        // ✅ JSP에서 꺼낼 수 있도록 Attribute로 저장
        req.setAttribute("id", id);

        RequestDispatcher dispatcher =
            req.getRequestDispatcher("/WEB-INF/views/route/aiMapView.jsp");
        dispatcher.forward(req, resp);
    }
    

}
