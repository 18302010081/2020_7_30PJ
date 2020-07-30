<%--
  Created by IntelliJ IDEA.
  User: 魏文婕
  Date: 2020/7/15
  Time: 16:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang='en'>
<head>
    <title>MyFriends</title>
    <link rel="stylesheet" type="text/css" href="../Resources/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <script src="../Resources/bootstrap-3.3.7-dist/js/jquery-3.5.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../Resources/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<div class="myFriends">
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
    <div class="searchFriend">
        <form action="FriendRequestServlet" method="post">
            <p>Enter User's ID: <input type="text" name="userID" class="form-control" value="${sessionScope.loginUsername}"> </p>
<%
    if(request.getAttribute("searchedUser")!=null){
        %>
            <p>搜索到用户：<%=request.getAttribute("searchedUser")%></p>
            <a>

            </a>
                <button type="submit" class="btn btn-warning" >发送好友请求</button>


            <%
    }
    else{
            %>
            <p>暂无结果</p>
            <%
    }
%>
            <input type="submit" class="btn btn-success" style="font-family: 'Comic Sans MS'" value="Search">
        </form>
    </div>
    <br><br>
    <div class="showArea">
        <div class="info">
            <p><span class="glyphicon glyphicon-user"> Name:</span><span class="fancyFont">Augusto</span></p>
            <p><span class="glyphicon glyphicon-envelope"> Email:</span><span class="fancyFont">2344@qq.com</span></p>
            <p>RegisterDate:<span class="fancyFont">2020-4-19</span></p>
        </div>

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
    .myFriends{
        padding-left: 10%;
        padding-right: 10%;
        padding-top: 2%;
    }
    .info{
        margin:2%;
        padding:5%;
        border-radius: 2px;box-shadow: 0 2px 4px rgba(0, 0, 0, .44), 0 0 6px rgba(0, 0, 0, .44);color: #0c5460;color: black;
        background-color: white;
    }
    .fancyFont{
        color: #8a6d3b;
        font-family: "Comic Sans MS";
    }
    form{
        padding: 10%;
        margin:2px;
        border-radius: 2px;box-shadow: 0 2px 4px rgba(0, 0, 0, .44), 0 0 6px rgba(0, 0, 0, .44);color: #0c5460;color: black;
    }
</style>
