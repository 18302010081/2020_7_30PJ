<%@ page import="Servlets.JdbcUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: 魏文婕
  Date: 2020/7/15
  Time: 16:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang='en'>
<head>
    <title>MyPhotos</title>
    <link rel="stylesheet" type="text/css" href="../Resources/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <script src="../Resources/bootstrap-3.3.7-dist/js/jquery-3.5.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../Resources/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<div class="myPhotoPage">
    <h1><b>Travel</b><small>share and enjoy!</small></h1>
    <div class="navPart" role="navigation">
        <ul class="nav nav-pills" >
            <li role="presentation" ><a href="../index.jsp"><span class="glyphicon glyphicon-home"></span> Home</a></li>
            <li role="presentation" ><a href="Search.jsp"><span class="glyphicon glyphicon-search"></span> Search</a></li>
            <li role="presentation" class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                    <span class="glyphicon glyphicon-user"></span> ${sessionScope.user} <span class="caret"></span>
                    <ul class="dropdown-menu">
                        <li><a href="MyCollection.jsp">My Collection</a></li>
                        <li><a href="Upload.jsp">Upload</a></li>
                        <li><a href="MyPhotos.jsp">My Photos</a></li>
                        <li><a href="MyFriends.jsp">My Friends</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="#">Quit</a></li>
                    </ul>
                </a>

            </li>

        </ul>
    </div>
    <br><br><br>
    <h2>My Photos</h2>
    <div class="showArea">
        <%
            //①建立连接，并写好sql语句
            JdbcUtil util = new JdbcUtil();
            Connection conn = util.getConnection();

            int sessionID= (int) session.getAttribute("sessionID");
            %>
<%--        <p>sessionID:<%=sessionID%></p>--%>
        <%

            //查询该用户上传的所有作品 select * from * where uid＝4 order by heat decs//降序， 升序是asc
            String sql="SELECT * From photos WHERE UID="+sessionID+" order by heat DESC";
            PreparedStatement pst = null;
            ResultSet rs = null;

            try{
                pst = conn.prepareStatement(sql);
                rs = pst.executeQuery();
                while(rs.next()){
                    //迭代器
                   // System.out.println(rs.getString("topic"));
                    %>
        <div class="specificPic">
            <a href="Details.jsp?id=<%=rs.getInt("PID")%>">
                <img src="<%=rs.getString("localAddress")%>">
            </a>
            <div class="info">
                <button class="btn btn-danger">Remove from My Photos</button>
                <button class="btn btn-warning">Edit</button>
            </div>
        </div>
                  <%
                          }

            } catch (SQLException e) {
                e.printStackTrace();
            }finally{
                util.close(rs,pst,conn);
            }


        %>
    </div>
</div>

</body>
</html>
<style>
    body{
        background-color: #FFFFCC;
    }
    .navPart{
        float:right;
    }
    .myPhotoPage{
        padding-left: 10%;
        padding-right: 10%;
        padding-top: 2%;
    }
    .specificPic{
        float:left;
        width:33%;
        height:33%;
        padding:2%;
    }
    .info{
        margin:2%;
        padding:5%;
    }
    img{
        width:300px;
        height:200px;
        margin:2px;
        padding:2px;
        border-radius: 2px;box-shadow: 0 2px 4px rgba(0, 0, 0, .44), 0 0 6px rgba(0, 0, 0, .44);color: #0c5460;color: black;
        background-color: white;
    }
</style>
