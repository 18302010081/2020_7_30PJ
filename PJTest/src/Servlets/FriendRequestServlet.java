package Servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "FriendRequestServlet")
public class FriendRequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
// 设置响应内容类型
        response.setContentType("text/html;charset=UTF-8");
        //处理中文
        String uid =new String(request.getParameter("userID").getBytes("ISO-8859-1"),"UTF-8");

//        PrintWriter out = response.getWriter();
//        out.println("朋友请求");
//        out.println(username);
//        out.close();
        //从数据库中查询是否有这个用户的存在
        //①建立连接，并写好sql语句
        JdbcUtil util = new JdbcUtil();
        Connection conn = util.getConnection();


        String sql="SELECT * FROM users WHERE UID='"+uid+"' ";
        PreparedStatement pst = null;
        ResultSet rs = null;

        try{
            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();
            //判断用户ID存不存在数据库里
            if(rs.next()){
                System.out.println("搜索到用户:"+rs.getString("username"));
                request.setAttribute("searchedUser",rs.getString("username"));
                request.setAttribute("searchedUserID",uid);
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally{
            util.close(rs,pst,conn);
        }
        request.getRequestDispatcher("MyFriends.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            doPost(request, response);
    }
}
