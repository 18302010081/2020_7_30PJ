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
import java.util.Date;


@WebServlet(name = "RegisterServlet")
public class RegisterServlet extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应内容类型
        response.setContentType("text/html;charset=UTF-8");
        //处理中文
        String username =new String(request.getParameter("username").getBytes("ISO-8859-1"),"UTF-8");
        String email =new String(request.getParameter("email").getBytes("ISO-8859-1"),"UTF-8");
        String password =new String(request.getParameter("password").getBytes("ISO-8859-1"),"UTF-8");
      //System.out.println(username);
           //①建立连接，并写好sql语句
            JdbcUtil util = new JdbcUtil();
            Connection conn = util.getConnection();
            // 创建日期的语法： Date date1= new Date();

        String sql1= "SELECT username FROM users WHERE username='"+username+"'";
        //String sql1= "SELECT * FROM users WHERE username LIKE '%"+username+"%'";
        PreparedStatement pst1 = null;
        ResultSet rs1 = null;

        try{
            pst1 = conn.prepareStatement(sql1);
            rs1 = pst1.executeQuery();
            //判断用户名是否重复

            HttpSession session=request.getSession();
            if(rs1.next()){
                System.out.print("用户名重复");
                System.out.print("用户:"+username);
               // 把表单里面之前的数据存下来
                session.setAttribute("RegisterStatus","This username has been used before,please choose another one!");
                session.setAttribute("registerUsername",username);
                session.setAttribute("registerPassword",password);
                session.setAttribute("registerEmail",email);
                response.sendRedirect("Register.jsp");
            }
            else{

               //向数据库中插入数据
                String sql2="INSERT INTO users(username,password,registerEmail) VALUES('"+username+"','"+password+"','"+email+"')";
                PreparedStatement pst2 = null;
                ResultSet rs2 = null;
                try{
                    pst2 = conn.prepareStatement(sql2);
                    pst2.executeUpdate();
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

                } catch (SQLException e) {
                    System.out.print("数据库错误");
                    e.printStackTrace();
                }
                finally{
                    util.close(rs2,pst2,conn);
                }
                //存好session，并以此账号登录
                session.setAttribute("user",username);
                session.setAttribute("status","successfullyLogin");
                session.setAttribute("RegisterStatus","");
                response.sendRedirect("../index.jsp");
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally{
            util.close(rs1,pst1,conn);
        }
    }




    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
