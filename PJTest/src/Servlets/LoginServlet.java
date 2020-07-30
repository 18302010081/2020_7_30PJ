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

@WebServlet(name = "LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       // 设置响应内容类型
        response.setContentType("text/html;charset=UTF-8");
        //处理中文
        String username =new String(request.getParameter("username").getBytes("ISO-8859-1"),"UTF-8");
        String password =new String(request.getParameter("password").getBytes("ISO-8859-1"),"UTF-8");

        //从数据库中查询是否有这个用户的存在
        //①建立连接，并写好sql语句
        JdbcUtil util = new JdbcUtil();
        Connection conn = util.getConnection();


        String sql="SELECT username,password FROM users WHERE username='"+username+"' AND password='"+password+"'";
        PreparedStatement pst = null;
        ResultSet rs = null;

        try{
            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();
             //判断用户名和密码存不存在数据库里
            HttpSession session=request.getSession();
            if(rs.next()){
                System.out.println("登录成功");
                System.out.println("用户:"+username);
                System.out.println("密码:"+password);
                //获取UID
                String sql3="SELECT * FROM users WHERE username='"+username+"'";
                PreparedStatement pst3 = null;
                ResultSet rs3 = null;
                try{
                    pst3 = conn.prepareStatement(sql3);
                    rs3=pst3.executeQuery();
                    //获取UID
                    while(rs3.next()){
                        session.setAttribute("sessionID",rs3.getInt("UID"));
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                finally{
                    util.close(rs3,pst3,conn);
                }
                //获取UID
                //存好session
                session.setAttribute("user",username);
                session.setAttribute("status","successfullyLogin");
                session.setAttribute("LoginStatus","");
                response.sendRedirect("../index.jsp");
            }
            else{
                //out.println("<p>用户名或密码错误！</p>");
                System.out.print("用户名或密码错误！");
                //把表单里面之前的数据存下来
                session.setAttribute("LoginStatus","Username and Password don't match");
                session.setAttribute("loginUsername",username);
                session.setAttribute("loginPassword",password);
                response.sendRedirect("Login.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally{
            util.close(rs,pst,conn);
        }







    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
