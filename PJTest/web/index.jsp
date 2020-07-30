<%@ page import="java.io.PrintWriter" %>
<%@ page import="Servlets.JdbcUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Claudia
  Date: 2020/7/15
  Time: 15:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang='en'>
  <head>
    <title>index</title>
      <link rel="stylesheet" type="text/css" href="Resources/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
      <script src="Resources/bootstrap-3.3.7-dist/js/jquery-3.5.1.min.js" type="text/javascript" charset="utf-8"></script>
      <script src="Resources/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
  </head>
  <body>
  <div class="indexPage">
      <h1><b>Travel</b><small>share and enjoy!</small></h1>
      <div class="navPart" role="navigation">
          <ul class="nav nav-pills" >
              <li role="presentation" class="active"><a href="#"><span class="glyphicon glyphicon-home"></span> Home</a></li>
              <li role="presentation"><a href="Frontend/Search.jsp"><span class="glyphicon glyphicon-search"></span> Search</a></li>
              <%

                  //已登录状态
                  if(session.getAttribute("status")=="successfullyLogin"){
                  %>
              <li role="presentation" class="dropdown">
                  <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                     <span class="glyphicon glyphicon-user"></span> ${sessionScope.user} <span class="caret"></span>
                      <ul class="dropdown-menu">
                          <li><a href="Frontend/MyCollection.jsp">My Collection</a></li>
                          <li><a href="Frontend/Upload.jsp">Upload</a></li>
                          <li><a href="Frontend/MyPhotos.jsp">My Photos</a></li>
                          <li><a href="Frontend/MyFriends.jsp">My Friends</a></li>
                          <li role="separator" class="divider"></li>
                          <li ><a href="#">Quit</a></li>
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
                          <li><a href="Frontend/Login.jsp">Login</a></li>
                          <li role="separator" class="divider"></li>
                          <li><a href="Frontend/Register.jsp">Create a new account</a></li>
                      </ul>
                  </a>

              </li>
              <%
                  }
              %>


          </ul>
      </div>

      <div class="Newest">
          <h2 style="color: red;font-family: 'Comic Sans MS'">Hottest</h2>
          <div id="myCarousel" class="carousel slide">
              <!-- 轮播（Carousel）指标 -->
              <ol class="carousel-indicators">
                  <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                  <li data-target="#myCarousel" data-slide-to="1"></li>
                  <li data-target="#myCarousel" data-slide-to="2"></li>
              </ol>
              <!-- 轮播（Carousel）项目 -->
              <div class="carousel-inner">


                  <%
                  //按照最热的排序
                      //①建立连接，并写好sql语句
                      JdbcUtil util = new JdbcUtil();
                      Connection conn = util.getConnection();

                      //查询该用户上传的所有作品 select * from * where uid＝4 order by heat decs//降序， 升序是asc
                      String sql="SELECT * From photos order by heat DESC";
                      PreparedStatement pst = null;
                      ResultSet rs = null;

                      try{
                          pst = conn.prepareStatement(sql);
                          rs = pst.executeQuery();
                          int i=3;
                          while(rs.next()&&i>0){
                              //迭代器
                              // System.out.println(rs.getString("topic"));


                              String address=rs.getString("localAddress").substring(3);
                              if(i==3){
                                  %>
                  <div class="item active">
                      <a href="Frontend/Details.jsp?id=<%=rs.getInt("PID")%>">
                      <img src="<%=address%>" alt="slide">
                      </a>
                  </div>
                               <%
                              }
                              else{
                               %>
                  <div class="item">
                      <a href="Frontend/Details.jsp?id=<%=rs.getInt("PID")%>">
                      <img src="<%=address%>" alt="Second slide">
                      </a>
                  </div>
                          <%
                              }
                                  i--;
                          }

                      } catch (SQLException e) {
                          e.printStackTrace();
                      }finally{
                          util.close(rs,pst,conn);
                      }


                  %>

              </div>
              <!-- 轮播（Carousel）导航 -->
              <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                  <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                  <span class="sr-only">Previous</span>
              </a>
              <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                  <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                  <span class="sr-only">Next</span>
              </a>
          </div>
      </div>

      <div class="Latest">
          <h2 style="color: #ffb700;font-family: 'Comic Sans MS'">Newest</h2>
          <%
              //按照最新的排序
              JdbcUtil util1 = new JdbcUtil();
              Connection conn1 = util1.getConnection();

              //查询该用户上传的所有作品 select * from * where uid＝4 order by heat decs//降序， 升序是asc
              String sql1="SELECT * From photos order by date DESC";
              PreparedStatement pst1 = null;
              ResultSet rs1 = null;

              try{
                  pst1 = conn1.prepareStatement(sql1);
                  rs1 = pst1.executeQuery();
                  int j=3;
                  while(rs1.next()&&j>0){
                      //迭代器

                     // System.out.println(rs1.getString("topic"));
                      String address1=rs1.getString("localAddress").substring(3);

          %>
          <div class="lt">
              <a href="Frontend/Details.jsp?id=<%=rs1.getInt("PID")%>">
              <img src="<%=address1%>">
              </a>
              <div class="info">
                  <p>Author:<span class="fancyFont"><%=rs1.getString("author")%></span></p>
                  <p>Topic:<span class="fancyFont"><%=rs1.getString("topic")%></span></p>
                  <p>Date:<span class="fancyFont"><%=rs1.getString("date")%></span></p>
              </div>
          </div>
              <%
                      j--;
                  }

              } catch (SQLException e) {
                  e.printStackTrace();
              }finally{
                  util.close(rs1,pst1,conn1);
              }
          %>
      </div>
  </div>
  </body>
</html>
<script type="text/javascript">

</script>
<style>
    body{
        background-color: #FFFFCC;
    }
    .indexPage{
        padding-left: 10%;
        padding-right: 10%;
        padding-top: 2%;
    }
    /* Make the image fully responsive */
    .carousel-inner img {
        width: 100%;
        height: 100%;
        margin:2px;
        padding:2px;
        border-radius: 2px;box-shadow: 0 2px 4px rgba(0, 0, 0, .44), 0 0 6px rgba(0, 0, 0, .44);color: #0c5460;color: black;
        background-color: white;
    }
    .Newest{
        padding: 5%;
    }

    .navPart{
        float:right;
    }
    .Latest img{
        width:260px;
        height:200px;
        margin:2px;
        padding:2px;
        border-radius: 2px;box-shadow: 0 2px 4px rgba(0, 0, 0, .44), 0 0 6px rgba(0, 0, 0, .44);color: #0c5460;color: black;
        background-color: white;
    }
    .lt{
        float:left;
        width:30%;
        height:30%;
        padding:5%;
    }
    .fancyFont{
        color: #8a6d3b;
        font-family: "Comic Sans MS";
    }
    .info{
        margin:5%;
        padding:5%;
    }

</style>
