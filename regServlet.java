package web;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class regServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应内容类型
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        String title = "注册成功！";
        //处理中文
        String firstName =new String(request.getParameter("FirstName").getBytes("ISO-8859-1"),"UTF-8");
        String secondName =new String(request.getParameter("SecondName").getBytes("ISO-8859-1"),"UTF-8");
        String emailAddress =new String(request.getParameter("EmailAddress").getBytes("ISO-8859-1"),"UTF-8");
        if(firstName.length()==0||secondName.length()==0||emailAddress.length()==0){

            request.setAttribute("fm", "firstName should not be null");
            request.setAttribute("sm", "secondName should not be null");
            request.setAttribute("ea", "email address should not be null");
           // request.getRequestDispatcher("/register.html").forward(request,response);
            response.sendRedirect("register.html");
            out.println("");
        }
        else {
            String docType = "<!DOCTYPE html> \n";
            out.println(docType +
                    "<html>\n" +
                    "<head><title>" + title + "</title></head>\n" +
                    "<body background-color=\"#f0f0f0\">\n" +
                    "<h1 align=\"center\">" + title + "</h1>\n" +
                    "<ul>\n" +
                    "  <li><b>First Name:</b>"
                    + firstName + "</li>\n" +
                    "  <li><b>Second Name:</b>"
                    + secondName + "</li>\n" +
                    "  <li><b>Email:</b>"
                    + emailAddress + "</li>\n" +
                    "</ul>\n" +
                    "</body></html>"

            );
        }
        out.close();
    }
}