<%@ page import="Servlets.JdbcUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: 魏文婕
  Date: 2020/7/15
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang='en'>
<head>
    <title>Details</title>
    <link rel="stylesheet" type="text/css" href="../Resources/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <script src="../Resources/bootstrap-3.3.7-dist/js/jquery-3.5.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../Resources/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<%
    //判别是哪个用户
    //这里出问题！！！
    int sessionID;
    if(session.getAttribute("sessionID")!=null){
        sessionID= (int) session.getAttribute("sessionID");
    }
    else{
        sessionID=0;
    }


%>
 <div class="detailPage">
     <h1><b>Travel</b><small>share and enjoy!</small></h1>
     <div class="navPart" role="navigation">
         <ul class="nav nav-pills" >
             <li role="presentation" ><a href="../index.jsp"><span class="glyphicon glyphicon-home"></span> Home</a></li>
             <li role="presentation" ><a href="Search.jsp"><span class="glyphicon glyphicon-search"></span> Search</a></li>
             <li role="presentation" class="dropdown">
                 <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                     Logged <span class="caret"></span>
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
     <%
         //①建立连接，并写好sql语句
         JdbcUtil util = new JdbcUtil();
         Connection conn = util.getConnection();

         String idd= request.getParameter("id");
         int pid = Integer.parseInt(idd);
         %>
<%--     <p>idd=<%=idd%></p>--%>
<%--     <p>a=<%=a%></p>--%>
     <%

         //查询该用户上传的所有作品 select * from * where uid＝4 order by heat decs//降序， 升序是asc
         String sql="SELECT * From photos WHERE PID="+pid+" order by heat DESC";
         PreparedStatement pst = null;
         ResultSet rs = null;

         try{
             pst = conn.prepareStatement(sql);
             rs = pst.executeQuery();
             while(rs.next()){
                 //迭代
     %>
     <div class="leftPart">
         <img src="<%=rs.getString("localAddress")%>">
         <div class="btnGroup">



             <%


                 if(sessionID!=0){
//                 判断用户到底收藏没
                 JdbcUtil util2 = new JdbcUtil();
                 Connection conn2 = util2.getConnection();

                 String sql2 = "SELECT UID,PID FROM collectioncorresponding WHERE UID='"+sessionID+"' AND PID='"+pid+"'";;
                 PreparedStatement pst2 = null;
                 ResultSet rs2 = null;

                 try{
                     pst2 = conn2.prepareStatement(sql2);
                     rs2 = pst2.executeQuery();

                     if(rs2.next()){//迭代器
                         %>
<%--             <p>收藏过了</p>--%>
             <button type="button" class="btn btn-danger" id="removeFromMyCollection">
                 Remove from My Collection</button>
             <script>
                 $(function () {
                     $('#removeFromMyCollection').on("click", function () {
                         $.ajax({
                             type: "POST",
                             url: "/PJTest_war_exploded/Frontend/RemoveFromMyCollectionServlet?pid="+ <%=pid%> +"&uid="+ <%=sessionID%>,
                             success: function (data) {
                                 alert(data);
                                 history.go(0);
                             }
                         })

                     })
                 })
             </script>
             <%

                 }else{
             %>
<%--             <p>没收藏过</p>--%>
             <button type="button" class="btn btn-success" id="addToMyCollection">Collect</button>
             <script>
                 $(function () {
                     $('#addToMyCollection').on("click", function () {
                         $.ajax({
                             type: "POST",
                             url: "/PJTest_war_exploded/Frontend/AddToMyCollectionServlet?pid="+ <%=pid%> +"&uid="+ <%=sessionID%>,
                             success: function (data) {
                                 alert(data);
                                 history.go(0);
                             }
                         })

                     })
                 })
             </script>
             <%

                     }
                 } catch (SQLException e) {
                     e.printStackTrace();
                 }finally{
                     util.close(rs2,pst2,conn2);
                 }
                 //                 判断用户到底收藏没
                 }
             else{
                 %>
             <p>未登录状态~</p>
             <%
                 }%>

         </div>
     </div>
     <div class="details">
         <table class="table table-hover">
             <caption>Photo's properties</caption>
             <thead>
             <tr>
                 <th class="photoProperty">Author</th>
                 <th><%=rs.getString("author")%></th>
             </tr>
             </thead>
             <tbody>
             <tr>
                 <td class="photoProperty">Topic</td>
                 <td><%=rs.getString("topic")%></td>
             </tr>
             <tr>
                 <td class="photoProperty">Label</td>
                 <td><%=rs.getString("label")%></td>
             </tr>
             <tr>
                 <td class="photoProperty">Introduction</td>
                 <td><%=rs.getString("introduction")%></td>
             </tr>
             <tr>
                 <td class="photoProperty">Heat</td>
                 <td><%=rs.getInt("heat")%></td>
             </tr>
             <tr>
                 <td class="photoProperty">Country</td>
                 <td><%=rs.getString("country")%></td>
             </tr>
             <tr>
                 <td class="photoProperty">City</td>
                 <td><%=rs.getString("city")%></td>
             </tr>
             <tr>
                 <td class="photoProperty">Date</td>
                 <td><%=rs.getString("date")%></td>
             </tr>
             </tbody>
         </table>
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

</body>
</html>

<style>
    body{
        background-color: #FFFFCC;
    }
    .detailPage{
        padding-left: 10%;
        padding-right: 10%;
        padding-top: 2%;
    }
    .navPart{
        float:right;
    }
    img{
        width:100%;
        height:100%;
    }
    .leftPart{
        float:left;
        width: 50%;
        height:50%;
    }
    .details{
        float:right;
        width: 40%;
        height:45%;
    }
    .photoProperty{
        font-family: "Comic Sans MS";
        color: #8a6d3b;
    }
    .btnGroup{
        padding-left: 20%;
        padding-right: 20%;
        padding-top: 3%;
    }
    img{
        width:500px;
        height:350px;
        margin:2px;
        padding:2px;
        border-radius: 2px;box-shadow: 0 2px 4px rgba(0, 0, 0, .44), 0 0 6px rgba(0, 0, 0, .44);color: #0c5460;color: black;
        background-color: white;
    }

</style>
