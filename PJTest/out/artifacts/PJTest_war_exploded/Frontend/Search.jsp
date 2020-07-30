<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="Servlets.JdbcUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
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
    <title>Search</title>
    <link rel="stylesheet" type="text/css" href="../Resources/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <script src="../Resources/bootstrap-3.3.7-dist/js/jquery-3.5.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../Resources/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<div class="searchPage">
    <h1><b>Travel</b><small>share and enjoy!</small></h1>
    <div class="navPart" role="navigation">
        <ul class="nav nav-pills">
            <li role="presentation" ><a href="../index.jsp"><span class="glyphicon glyphicon-home"></span> Home</a></li>
            <li role="presentation" class="active"><a href="#"><span class="glyphicon glyphicon-search"></span> Search</a></li>
            <%

                //已登录状态
                if(session.getAttribute("status")=="successfullyLogin"){
            %>
            <li role="presentation" class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                    <span class="glyphicon glyphicon-user"></span>${sessionScope.user} <span class="caret"></span>
                      <ul class="dropdown-menu">
                          <li><a href="MyCollection.jsp">My Collection</a></li>
                          <li><a href="Upload.jsp">Upload</a></li>
                          <li><a href="MyPhotos.jsp">My Photos</a></li>
                          <li><a href="MyFriends.jsp">My Friends</a></li>
                          <li role="separator" class="divider"></li>
                          <li ><a id="quitReg">Quit</a></li>
                      </ul>
                </a>
            </li>
            <%
            }
            //未登录状态
            else{

            %>
            <li role="presentation" class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Not logged <span class="caret"></span>
                    <ul class="dropdown-menu">
                        <li><a href="Login.jsp">Login</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="Register.jsp">Create a new account</a></li>
                    </ul>
                </a>

            </li>
            <%
                }
            %>


        </ul>
    </div>


    <div class="searchBox">
        <div class="col-lg-6">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Enter the picture's label or topic...">
                <span class="input-group-btn">
                    <%
                        String keyword="b";
                        String firstOrder="topic";
                        String secondOrder="heat";
                        String he="/PJTest_war_exploded/Frontend/SearchServlet?keyword="+keyword+"&&firstOrder="+firstOrder+"&&secondOrder="+secondOrder;
                    %>
                    <a href="<%=he%>">
                         <button class="btn btn-primary" type="button" id="searchButton">Go!</button>
                    </a>
             </span>
            </div>
        </div>
    </div>

    <div class="showArea">
        <div class="radioGroup" style="float:right">
            <div class="radio">
                <label class="orderFont">First Order:</label>
                <label>
                    <input type="radio" name="optionsRadios" id="optionsRadios1" value="" checked>Topic
                </label>
                <label>
                    <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">Label
                </label>
            </div>

            <div class="radio">
                <label class="orderFont">Second Order:</label>
                <label>
                    <input type="radio" name="optionsRadios2" id="optionsRadios3" value="option1" checked>Heat
                </label>
                <label>
                    <input type="radio" name="optionsRadios2" id="optionsRadios4" value="option2">Date
                </label>
            </div>
        </div>
        <nav aria-label="Page navigation" >
            <ul class="pagination">
                <li>
                    <a href="#" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <li><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li>
                    <a href="#" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>

        <div class="pictureArea">
    <%
        List<Integer>searchList= (List<Integer>) request.getAttribute("searchResult");
        if(searchList!=null){
            for(int i=0;i<searchList.size();i++){
                int searchedId=searchList.get(i);
                JdbcUtil util = new JdbcUtil();
                Connection conn = util.getConnection();

                String sql = "SELECT * From photos WHERE PID='"+searchedId+"'";
                PreparedStatement pst = null;
                ResultSet rs = null;

                try{
                    pst = conn.prepareStatement(sql);
                    rs = pst.executeQuery();
                    if(rs.next()){//迭代器
    %>
            <div class="specificPic">
                <a href="Details.jsp?id=<%=searchedId%>">
                    <img src="<%=rs.getString("localAddress")%>">
                </a>

                <div class="info">
                    <p>Author:<span class="fancyFont"></span><%=rs.getString("author")%></p>
                    <p>Topic:<span class="fancyFont"></span><%=rs.getString("topic")%></p>
                    <p>Date:<span class="fancyFont"></span><%=rs.getString("date")%></p>

                </div>
            </div>

            <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }finally{
                            util.close(rs,pst,conn);
                        }

                    }
        }

    %>




        </div>

    </div>


</div>
</body>
</html>
<script>
    $(function () {
        $('#quitReg').on("click", function () {
            $.ajax({
                type: "POST",
                url: "/PJTest_war_exploded/Frontend/QuitServlet",
                success: function () {
                    confirm("Are you Sure to quit");
                    history.go(0);
                }
            })

        })
    })
</script>
<style>
    body{
        background-color: #FFFFCC;
    }
    .searchPage{
        padding-left: 10%;
        padding-right: 10%;
        padding-top: 2%;
    }
    .navPart{
        float:right;
    }
    .searchBox{
        padding:5%;
    }
    .orderFont{
        font-family: "Comic Sans MS";
        color: #8a6d3b;
    }
    .specificPic img{
        width:300px;
        height:200px;
        margin:2px;
        padding:2px;
        border-radius: 2px;box-shadow: 0 2px 4px rgba(0, 0, 0, .44), 0 0 6px rgba(0, 0, 0, .44);color: #0c5460;color: black;
        background-color: white;
    }
    .info{
        margin:2%;
        padding:5%;
    }
    .fancyFont{
        color: #8a6d3b;
        font-family: "Comic Sans MS";
    }
    .specificPic{
        float:left;
        width:33%;
        height:33%;
        padding:2%;
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