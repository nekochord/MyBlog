<%-- 
    Document   : article
    Created on : 2018/5/21, 下午 05:33:40
    Author     : 林哲宏
--%>

<%@page import="blog.article.Article"%>
<%@page import="blog.article.XArticleManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String author = (String) request.getAttribute("author");
    String host = (String) request.getAttribute("host");
    String viewer_type = (String) request.getAttribute("viewer_type");
    int id;
    try {
        Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) {
        response.sendError(404);
        return;
    }
    id = Integer.parseInt(request.getParameter("id"));
    XArticleManager manager = new XArticleManager();
    if (!manager.openArticles(author)) {
        response.sendError(404);
        return;
    }
    Article article = manager.getArticleByID(id);
    if (article == null) {
        request.getRequestDispatcher("/ErrorPage").forward(request, response);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title><%=article.get_title()%>-<%=author%></title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <style>
            div.card-header{
                font-size: 22px;
                font-weight: bold;
                color:#4d004d;
            }
            div.card-body{
                font-size: 18px;
            }
            div.mydate{
                text-align: right;
                font-size: 14px;
                font-weight: bold;
                color:#6600cc;
            }
            div.mypicture{
                float:right;
                padding-right: 80px;
                padding-top: 10px;
                padding-bottom: 10px;
            }
            div.mypicture > img{
                height: 100px;
                width:200px;
            }
            a.article-link{
                font-size: 16px;
                font-weight: bold;
                padding-bottom: 0px;
                padding-left: 300px;
            }
            .myfloat::after{
                content: "";
                clear: both;
                display: table;
            }
            .myjumbotron{
                height:25vh;
                background-color:#2d8659;
            }
            .mynav{
                height:7vh;
                background-color: #262626;
            }
            .mynav::after{
                content: "";
                clear: both;
                display: table;
            }
            .myarticle{
                padding-left: 30px;
                padding-top:20px;
                font-size: 20px;
                font-weight:bold;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="myjumbotron">
                <div style="height:5vh;"></div>
                <h1 style="color:white;padding-left:30px;">My Blog</h1>
                <p style="color:white;padding-left:30px;">Hard work for better</p>
            </div>
            <div class="mynav">
                <div style="float:left;padding-left:10px;padding-top:2vh;">
                    <img src="<%=host%>image/paper.png" style="height:30px;">
                    <a style="padding-left:10px;color:white;"><%=author%></a>
                    <%
                        //指定首頁按鈕連結
                        String main_page_link = host + "/user/" + author + "/";
                    %>
                    <a class="badge badge-success" style="color:white;font-size:20px" href="<%=main_page_link%>">
                        首頁
                    </a>
                </div>
                <div class="btn-group"  style="float:right;padding-top:2vh;padding-right:10px;">
                    <button class="btn btn-info btn-sm dropdown-toggle" type="button" id="sortButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        用戶
                    </button>
                    <div class="dropdown-menu" aria-labelledby="sortButton">
                        <%
                            //是匿名者
                            if (viewer_type.equals("Anonymous")) {
                        %>
                        <a class="dropdown-item" href="<%=host%>login">登入</a>

                        <%
                            //是OwnerOther
                        } else {
                            String user = (String) request.getSession().getAttribute("name");
                            String back_link = host+"back/"+user;
                        %>
                        <h6 class="dropdown-header"><%=user%></h6>
                        <a class="dropdown-item" href="<%=host%>LogoutButton?author=<%=user%>">登出</a>
                        <a class="dropdown-item" href="<%=back_link%>">後台管理</a>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>

            <div style="height:30px;"></div>
            <div class="row">
                <div class="col-sm-9">
                    <h2 style="border-bottom:5px solid #8c8c8c;"><%=article.get_title()%></h2>
                    <%
                        String tag_link=host+"user/"+author+"/1?tag="+article.get_tag();
                    %>
                    <a class="badge badge-info" style="color:white;" href="<%=tag_link%>"><%=article.get_tag()%></a>
                    <%
                        if (viewer_type.equals("Owner")) {
                            String article_edit_link = host+"back/"+author+"/edit?id="+id;
                    %>
                    <a class="badge badge-warning" style="color:white" href="<%=article_edit_link%>"><img src="<%=host%>image/config.png" style="height:15px;border:0;"></a>
                        <%
                            }
                        %>
                    <div class="myarticle">
                        <!--在這裡插入文章-->
                        <%=article.get_context()%>
                    </div>

                </div>
                <div class="col-sm-3">
                    <p style="border-bottom:5px solid black;font-weight:bold;">系列文章</p>
                    <div class="list-group">
                        <%
                            String[] tag_array = manager.getArticleTags();
                            for (String i : tag_array) {
                                int tag_number = manager.getArticleIDsByTag(i).length;
                                String tag_url = host + "user/" + author + "/" + 1 + "?sort=" + manager.NEW_OLD_SORT + "&tag=" + i;
                        %>
                        <!--標籤模板-->
                        <a style="font-size:16px;font-weight:bold;" href="<%=tag_url%>"><%=i%>(<%=tag_number%>)</a>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
