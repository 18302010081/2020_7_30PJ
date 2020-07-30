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
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "SearchServlet")
public class SearchServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应内容类型
        response.setContentType("text/html;charset=UTF-8");
        //处理中文
        String keyword =new String(request.getParameter("keyword").getBytes("ISO-8859-1"),"UTF-8");
        String firstOrder =new String(request.getParameter("firstOrder").getBytes("ISO-8859-1"),"UTF-8");
        String secondOrder =new String(request.getParameter("secondOrder").getBytes("ISO-8859-1"),"UTF-8");


        System.out.println("keyword："+keyword);
       System.out.println("firstOrder："+firstOrder);
       System.out.println("secondOrder："+secondOrder);



         //①建立连接
        JdbcUtil util = new JdbcUtil();
        Connection conn = util.getConnection();
        String sql;
        //确定排序方式
        if(firstOrder.equals("topic")){
            if(secondOrder.equals("heat")){
                sql="SELECT * From photos WHERE topic LIKE '%"+keyword+"%'order by heat DESC";
                //System.out.println("topic+heat");
            }
            else{
                sql="SELECT * From photos WHERE topic LIKE '%"+keyword+"%'order by date DESC";
                //System.out.println("topic+date");
            }
        }
        else{
            if(secondOrder.equals("heat")){
                sql="SELECT * From photos WHERE label LIKE '%"+keyword+"%'order by heat DESC";
                //System.out.println("label+heat");
            }
            else{
                sql="SELECT * From photos WHERE label LIKE '%"+keyword+"%'order by date DESC";
                //System.out.println("label+date");
            }
        }
        //查询相关数据

        PreparedStatement pst = null;
        ResultSet rs = null;

        try{
            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();
           // request.setAttribute("searchResult",rs);
            List<Integer> list=new ArrayList<>();
            while(rs.next()){//迭代器
                //response.getWriter().write(rs.getString("topic")+"|");
                list.add(rs.getInt("PID"));
                System.out.println("查询结果："+rs.getString("topic"));
                System.out.println("request的Attribute:"+request.getAttribute("searchResult"));
            }
            request.setAttribute("searchResult",list);

        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            util.close(rs,pst,conn);
        }
        request.getRequestDispatcher("Search.jsp").forward(request,response);
        //response.sendRedirect("Search.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         doPost(request, response);
    }
}
