package Servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "UploadServlet")
public class UploadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应内容类型
        response.setContentType("text/html;charset=UTF-8");
        //处理中文
        String topic  =new String(request.getParameter("topic").getBytes("ISO-8859-1"),"UTF-8");
        String author =new String(request.getParameter("author").getBytes("ISO-8859-1"),"UTF-8");
        String label =new String(request.getParameter("label").getBytes("ISO-8859-1"),"UTF-8");
        String introduction =new String(request.getParameter("introduction").getBytes("ISO-8859-1"),"UTF-8");
        String country =new String(request.getParameter("country").getBytes("ISO-8859-1"),"UTF-8");
        String city =new String(request.getParameter("city").getBytes("ISO-8859-1"),"UTF-8");

        //①建立连接，并写好sql语句
        JdbcUtil util = new JdbcUtil();
        Connection conn = util.getConnection();
        //②sql语句
        String sql="INSERT INTO photos(author,topic,label,introduction,country,city) VALUES('"+author+"','"+topic+"','"+label+"','"+introduction+"' ,'"+country+"','"+city+"' )";

        PreparedStatement pst = null;
        ResultSet rs = null;
        try{
            pst = conn.prepareStatement(sql);
            pst.executeUpdate();

        } catch (SQLException e) {
            System.out.print("数据库错误");
            e.printStackTrace();
        }
        finally{
            util.close(rs,pst,conn);
        }
        response.sendRedirect("MyPhotos.jsp");



//        PrintWriter out = response.getWriter();
//        out.println(topic+"  "+label);
//        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            doPost(request,response);
    }
}
