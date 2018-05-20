<%-- 
    Document   : content
    Created on : 2018/5/19, 下午 09:36:25
    Author     : 林哲宏
--%>

<%@page import="java.util.Locale"%>
<%@page import="java.text.DateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="blog.article.*" %>
<%!
    public String getIntroduce(Article x) {
        String con = x.get_context();
        if (con.length() >= 8) {
            return con.substring(0, 8);
        } else {
            return con;
        }
    }
%>
<%
    //這個頁面是用來轉發的，所以attribute一定有值，而且作者存在
    String author = (String) request.getAttribute("author");
    String tag = (String) request.getAttribute("tag");
    int sort = (int) request.getAttribute("sort");
    int page_number = (int) request.getAttribute("page_number");
    XArticleManager manager = new XArticleManager();
    manager.openArticles(author);
    int[] myArticleIDs;
    //判斷tag是否為null
    String tag_msg = "";
    if (tag == null) {
        myArticleIDs = manager.getArticleIDsBySort(sort);
    } else {
        myArticleIDs = manager.getArticleIDsByTagAndSort(tag, sort);
        tag_msg = tag;
    }
    String empty_msg = "";
    if (myArticleIDs == null || myArticleIDs.length == 0) {
        empty_msg = "還沒有發布任何文章喔!";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title><%=author%>My Blog</title>
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
            div.myarticle{
                float:left;
            }
            div.myarticle > p{
                font-size: 16px;
                font-weight: bold;
                color:#404040;
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
                    <img src="<%=config.getInitParameter("host")%>image/paper.png" style="height:30px;">
                    <a style="padding-left:10px;color:white;"><%=author%></a>
                </div>
                <div class="btn-group"  style="float:right;padding-top:2vh;padding-right:10px;">
                    <button class="btn btn-info btn-sm dropdown-toggle" type="button" id="sortButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        用戶
                    </button>
                    <div class="dropdown-menu" aria-labelledby="sortButton">
                        <a class="dropdown-item" href="<%=config.getInitParameter("host")%>login">登入</a>
                    </div>
                </div>
                <div class="btn-group"  style="float:right;padding-top:2vh;padding-right:10px;">
                    <button class="btn btn-danger btn-sm dropdown-toggle" type="button" id="sortButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        排列
                    </button>
                    <div class="dropdown-menu" aria-labelledby="sortButton">
                        <%
                            String newToOld, oldToNew, hotToCold, coldToHot;
                            if (tag == null) {
                                newToOld = config.getInitParameter("host") + "user/" + author + "/" + page_number + "?sort=" + manager.NEW_OLD_SORT;
                                oldToNew = config.getInitParameter("host") + "user/" + author + "/" + page_number + "?sort=" + manager.OLD_NEW_SORT;
                                hotToCold = config.getInitParameter("host") + "user/" + author + "/" + page_number + "?sort=" + manager.HOT_COLD_SORT;
                                coldToHot = config.getInitParameter("host") + "user/" + author + "/" + page_number + "?sort=" + manager.COLD_HOT_SORT;
                            } else {
                                newToOld = config.getInitParameter("host") + "user/" + author + "/" + page_number + "?sort=" + manager.NEW_OLD_SORT + "&tag=" + tag;
                                oldToNew = config.getInitParameter("host") + "user/" + author + "/" + page_number + "?sort=" + manager.OLD_NEW_SORT + "&tag=" + tag;
                                hotToCold = config.getInitParameter("host") + "user/" + author + "/" + page_number + "?sort=" + manager.HOT_COLD_SORT + "&tag=" + tag;
                                coldToHot = config.getInitParameter("host") + "user/" + author + "/" + page_number + "?sort=" + manager.COLD_HOT_SORT + "&tag=" + tag;
                            }
                        %>
                        <a class="dropdown-item" href="<%=newToOld%>">依照日期(新-->舊)</a>
                        <a class="dropdown-item" href="<%=oldToNew%>">依照日期(舊-->新)</a>
                        <a class="dropdown-item" href="<%=hotToCold%>">依照熱門程度(熱-->冷)</a>
                        <a class="dropdown-item" href="<%=coldToHot%>">依照熱門程度(冷-->熱)</a>
                    </div>
                </div>
            </div>

            <div style="height:30px;"></div>
            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-8">
                    <h3 style="font-weight:bold;color:#b3b3b3;"><%=empty_msg%></h3>
                    <h4 style="font-weight:bold;color:#b3b3b3;"><%=tag_msg%></h4> 
                    <%
                        if (myArticleIDs != null) {
                            for (int i = (page_number - 1) * 4; i < myArticleIDs.length && i < page_number * 4; i++) {
                    %>
                    <!--文章模板-->
                    <div class="card">
                        <div class="card-header">
                            <%=manager.getArticleByID(myArticleIDs[i]).get_title()%>
                        </div>
                        <div class="card-body">
                            <div class="mydate">
                                <%
                                    DateFormat format = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.MEDIUM, Locale.TAIWAN);
                                    String date = format.format(manager.getArticleByID(myArticleIDs[i]).get_date());
                                %>
                                <%=date%>
                            </div>
                            <div class="myfloat">
                                <div class="myarticle">
                                    <p>
                                        <%=getIntroduce(manager.getArticleByID(myArticleIDs[i]))%>
                                        <br>
                                        %$#*&/^#@
                                        <br>
                                        <br>
                                    </p>
                                    <a class="article-link" href="#">繼續閱讀...</a>
                                </div>
                                <div class="mypicture"><img class="img-rounded" src="<%=config.getInitParameter("host")%>image/lion.png"></div>
                                <br/>
                            </div>
                            <div>
                                <span class="badge badge-secondary">
                                    人氣<%=manager.getArticleByID(myArticleIDs[i]).getviews()%>
                                </span>
                                <%
                                    String tag_url = config.getInitParameter("host") + "user/" + author + "/" + 1 + "?sort=" + manager.NEW_OLD_SORT + "&tag=" + manager.getArticleByID(myArticleIDs[i]).get_tag();
                                %>
                                <a class="badge badge-info" style="color:white" href="<%=tag_url%>">
                                    <%=manager.getArticleByID(myArticleIDs[i]).get_tag()%>
                                </a>
                            </div>
                        </div>
                    </div>
                    <br>
                    <!--文章模板-->
                    <%                            }
                        }
                    %>

                    <nav aria-label="blogpagenav" style="padding-left:30%;">
                        <ul class="pagination">
                            <%
                                int page_range = myArticleIDs.length / 4;
                                if (myArticleIDs.length % 4 > 0) {
                                    page_range++;
                                }
                                String pre_link_page, next_link_page, hide_pre = "", hide_next = "";
                                if (tag == null) {
                                    pre_link_page = config.getInitParameter("host") + "user/" + author + "/" + (page_number - 1) + "?sort=" + sort;
                                    next_link_page = config.getInitParameter("host") + "user/" + author + "/" + (page_number + 1) + "?sort=" + sort;
                                } else {
                                    pre_link_page = config.getInitParameter("host") + "user/" + author + "/" + (page_number - 1) + "?sort=" + sort + "&&tag=" + tag;
                                    next_link_page = config.getInitParameter("host") + "user/" + author + "/" + (page_number + 1) + "?sort=" + sort + "&&tag=" + tag;
                                }
                                if (page_number - 1 < 1) {
                                    hide_pre = "hidden='true'";
                                }
                                if (page_number + 1 > page_range) {
                                    hide_next = "hidden='true'";
                                }


                            %>
                            <li class="page-item" <%=hide_pre%> ><a class="page-link" href="<%=pre_link_page%>">Previous</a></li>
                            <li class="page-item"><a class="page-link"><%=page_number%></a></li>
                            <li class="page-item" <%=hide_next%>><a class="page-link" href="<%=next_link_page%>">Next</a></li>
                            <li class="page-item">
                                <div class="btn-group dropup">
                                    <button type="button" class="btn btn-outline-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    </button>
                                    <div class="dropdown-menu">
                                        <%
                                            for (int i = 1; i <= page_range; i++) {
                                                String href;
                                                if (tag == null) {
                                                    href = config.getInitParameter("host") + "user/" + author + "/" + i + "?sort=" + sort;
                                                } else {
                                                    href = config.getInitParameter("host") + "user/" + author + "/" + i + "?sort=" + sort + "&&tag=" + tag;
                                                }
                                        %>
                                        <a class="dropdown-item" href="<%=href%>"><%=i%></a>
                                        <%
                                            }
                                        %>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </nav>

                </div>
                <div class="col-sm-3">
                    <p style="border-bottom:5px solid black;font-weight:bold;">系列文章</p>
                    <div class="list-group">
                        <!--標籤模板-->
                        <a style="font-size:16px;font-weight:bold;" href="#">標籤</a>
                        <!--標籤模板-->
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>

