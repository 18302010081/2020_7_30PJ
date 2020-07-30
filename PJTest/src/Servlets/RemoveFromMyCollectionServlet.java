package Servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "RemoveFromMyCollectionServlet")
public class RemoveFromMyCollectionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应内容类型
        response.setContentType("text/html;charset=UTF-8");
        //处理中文
        String pid =new String(request.getParameter("pid").getBytes("ISO-8859-1"),"UTF-8");
        String uid =new String(request.getParameter("uid").getBytes("ISO-8859-1"),"UTF-8");
        int pidn = Integer.parseInt(pid);
        int uidn = Integer.parseInt(uid);
         System.out.println("pid:"+pid);
         System.out.println("uid:"+uid);
        JdbcUtil util = new JdbcUtil();
        Connection conn = util.getConnection();

        String sql = "DELETE FROM collectioncorresponding WHERE UID='"+uidn+"' AND PID='"+pidn+"'";
        PreparedStatement pst = null;
        ResultSet rs = null;

        try{
            pst = conn.prepareStatement(sql);
            pst.executeUpdate();
            response.getWriter().write("You have removed it from your Collection!");
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            util.close(rs,pst,conn);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
