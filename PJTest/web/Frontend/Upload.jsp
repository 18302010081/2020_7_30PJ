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
    <title>Upload</title>
    <link rel="stylesheet" type="text/css" href="../Resources/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="../Resources/bootstrap-3.3.7-dist/css/bootstrapValidator.min.css"/>
<%--    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>--%>
    <script src="../Resources/bootstrap-3.3.7-dist/js/jquery-3.5.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../Resources/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../Resources/bootstrap-3.3.7-dist/js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../Resources/bootstrap-3.3.7-dist/js/bootstrapValidator.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<div class="uploadPage">
    <h1><b>Travel</b><small>share and enjoy!</small></h1>
    <div class="navPart" role="navigation">
        <ul class="nav nav-pills">
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
<%--     图片上传表单--%><br><br>
    <div class="uploadForm">
        <form action="UploadServlet" method="post" id="uploadForm">
            <div class="form-group">
                <p>Topic: <input type="text" name="topic" value=""
                                    class="form-control" placeholder="Enter your topic..." required></p>
            </div>
            <div class="form-group">
                <p>Author: <input type="text" name="author" value=""
                                 class="form-control" placeholder="Enter the author..." required></p>
            </div>
            <div class="form-group">
                <p>Label: <input type="text" name="label" value=""
                                 class="form-control" placeholder="What's your label..." required></p>
            </div>
            <div class="form-group">
                <p>Introduction: <input type="text" name="introduction" value=""
                                 class="form-control" placeholder="Introduce it to us..." required></p>
            </div>
            <div class="form-group">
                <p>Country: <input type="text" name="country" value=""
                                 class="form-control" placeholder="Country..." required></p>
            </div>
            <div class="form-group">
                <p>City: <input type="text" name="city" value=""
                                 class="form-control" placeholder="City..." required></p>
            </div>
            <div style="align:centre;padding-top: 5%">
                <button type="submit" class="btn btn-success"
                        style="font-family: 'Comic Sans MS'">Upload</button>
            </div>
        </form>
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
    .uploadPage{
        padding-left: 10%;
        padding-right: 10%;
        padding-top: 2%;
    }
    .uploadForm{
        background-color: white;
        padding: 10%;
        margin:2px;
        border-radius: 2px;box-shadow: 0 2px 4px rgba(0, 0, 0, .44), 0 0 6px rgba(0, 0, 0, .44);color: #0c5460;color: black;
    }
    p{
        font-family: "Comic Sans MS";
    }
    input{
        color: #0f0f0f;
        border-radius: 2px;
    }
</style>
