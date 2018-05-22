<%-- 
    Document   : back
    Created on : 2018/5/22, 下午 03:10:35
    Author     : 林哲宏
--%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="blog.article.Article"%>
<%@page import="blog.article.XArticleManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
      public String myAlert(String text) {
        String answer = "<div class='alert alert-danger alert-dismissible fade show' role='alert' style='font-size:16px;font-weight:bold;'>"
                + text
                + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"
                + "<span aria-hidden='true'>&times;</span>"
                + "</button>"
                + "</div>";
        return answer;
    }
%>
<%
    String author = (String) request.getAttribute("author");
    String host = (String) request.getAttribute("host");
    String type = (String) request.getAttribute("type");
    XArticleManager manager = new XArticleManager();
    manager.openArticles(author);
    String alert="";
    String code=request.getParameter("code");
    if(code!=null){
        if(code.equals("101")){
            alert=myAlert("密碼錯誤!");
        }
    }
%>

<!doctype html>
<html>
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <title>後台管理</title>
        <style>
            .mynav{
                height:7vh;
                background-color: #262626;
                width:100vw;
            }
            .mynav::after{
                content: "";
                clear: both;
                display: table;
            }
            label{
                font-weight:bold;
            }
            input{
                font-weight:bold;
            }
            option{
                font-weight:bold;
            }
        </style>
        <script>
            function delete_button(id){
                var pass=prompt("請輸入密碼:");
                var myform=document.createElement("form");
                myform.setAttribute("action","<%=host+"DeleteButton"%>");
                myform.setAttribute("method","POST");
                var in1=document.createElement("input");
                var in2=document.createElement("input");
                in1.setAttribute("name","id");
                in1.setAttribute("value",id);
                 in2.setAttribute("name","pass");
                in2.setAttribute("value",pass);
                myform.appendChild(in1);
                myform.appendChild(in2);
                if(pass!==null){
                    document.body.appendChild(myform);
                    myform.submit();
                }
                
            }
        </script>
    </head>
    <body>
        <%=alert%>
        <div class="mynav">
            <div style="float:left;padding-left:10px;padding-top:2vh;">
                <img src="<%=host%>image/paper.png" style="height:30px;">
                <a style="padding-left:10px;color:white;">後台管理</a>
            </div>
            <div class="btn-group"  style="float:right;padding-top:2vh;padding-right:60px;">
                <button class="btn btn-info btn-sm dropdown-toggle" type="button" id="sortButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    用戶
                </button>
                <div class="dropdown-menu" aria-labelledby="sortButton">
                    <h6 class="dropdown-header"><%=author%></h6>
                    <a class="dropdown-item" href="<%=host%>/LogoutButton?author=<%=author%>">登出</a>
                </div>
            </div>
            <script>
                function back_front() {
                    window.location = "<%=host + "user/" + author%>";
                }
                function new_article() {
                    window.location = "<%=host + "back/" + author + "/new"%>";
                }
                function list_article() {
                    window.location = "<%=host + "back/" + author%>";
                }
            </script>
            <div class="btn-group"  style="float:right;padding-top:2vh;padding-right:60px;">
                <button type="button" class="btn btn-info btn-sm" onclick="back_front()">返回前台</button>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-2" style="background-color:#e6e6e6;height:100vh">
                    <br>
                    <ul class="list-group">
                        <button type="button" onclick="new_article()" class="list-group-item list-group-item-action" style="font-weight:bold;">新增文章</button>
                        <button type="button" onclick="list_article()" class="list-group-item list-group-item-action" style="font-weight:bold;">文章列表</button>
                    </ul>
                </div>
                <div class="col-sm-10">
                    <br>
                    <%
                        if (type.equals("new")) {
                    %>
                    <p style="border-bottom:5px solid black;font-weight:bold;color:#800080;">新增文章</p>
                    <br>
                    <form action="<%=host + "NewArticleButton"%>" method="POST" accept-charset="UTF-8">
                        <div class="form-group" >
                            <label for="title" style="font-weight:bold;">文章標題</label>
                            <input type="text" class="form-control" style="font-weight:bold;" id="title" name="title" placeholder="請輸入標題">
                        </div>
                        <div class="form-group">
                            <label for="tag" style="font-weight:bold;">標籤</label>
                            <input type="text" class="form-control" style="font-weight:bold;" id="tag" name="tag" placeholder="請輸入標籤">
                        </div>
                        <div class="form-group">
                            <label for="picture">選擇圖片</label>
                            <select class="form-control" id="picture" name="picture">
                                <option>獅子</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="article" style="font-weight:bold;">文章區塊</label>
                            <textarea class="form-control" style="font-weight:bold;" id="article" rows="20" name="article"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary mb-2">發布文章</button>
                    </form>
                    <%
                        }
                    %>
                    <%
                        if (type.equals("edit")) {
                            int id = (int) request.getAttribute("id");
                            Article x = manager.getArticleByID(id);
                    %>
                    <!--修改文章區塊-->
                    <p style="border-bottom:5px solid black;font-weight:bold;color:#800080;">修改文章</p>
                    <br>
                    <form action="<%=host + "EditArticleButton"%>" method="POST" accept-charset="UTF-8">
                        <div class="form-group">
                            <label for="title" style="font-weight:bold;">文章標題</label>
                            <input type="text" class="form-control" style="font-weight:bold;" id="title" name="title" placeholder="請輸入標題" value="<%=x.get_title()%>">
                            <br>
                            <p style="font-weight:bold;">id:</p>
                            <input type="number" class="form-control" style="font-weight:bold;" id="id" name="id" value="<%=id%>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="tag" style="font-weight:bold;">標籤</label>
                            <input type="text" class="form-control" style="font-weight:bold;" id="tag" name="tag" placeholder="請輸入標籤" value="<%=x.get_tag()%>">
                        </div>
                        <div class="form-group">
                            <label for="picture">選擇圖片</label>
                            <select class="form-control" id="picture" name="picture">
                                <option>獅子</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="article" style="font-weight:bold;">文章區塊</label>
                            <textarea class="form-control" style="font-weight:bold;" id="article" name="article" rows="20"><%=x.get_context()%></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary mb-2">修改文章</button>
                    </form>
                    <!--修改文章區塊-->
                    <%
                        }
                    %>
                    <!--文章列表區塊-->
                    <%
                        if (type.equals("list")) {
                            int page_number = (int) request.getAttribute("page_number");
                            int[] myarticles = manager.getArticleIDsSortedByDate();
                            int page_range = myarticles.length / 6;
                            if ((myarticles.length % 6) > 0) {
                                page_range++;
                            }
                            if (page_number < 1 || page_number > page_range) {
                                response.sendError(404);
                                return;
                            }
                    %>             
                    <table class="table table-striped table-bordered table-sm">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">文章標題</th>
                                <th scope="col">標籤</th>
                                <th scope="col">瀏覽數</th>
                                <th scope="col">發布時間</th>
                                <th scope="col"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (int i = (page_number - 1) * 6; i < myarticles.length && i < page_number * 6; i++) {
                                    Article k = manager.getArticleByID(myarticles[i]);
                            %>
                            <tr>
                                <th scope="row"><%=myarticles[i]%></th>
                                <td><%=k.get_title()%></td>
                                <td><%=k.get_tag()%></td>
                                <td><%=k.getviews()%></td>
                                <td>
                                    <%
                                        DateFormat format = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.MEDIUM, Locale.TAIWAN);
                                        String date = format.format(k.get_date());
                                    %>
                                    <%=date%>
                                </td>
                                <td>
                                    <a href="<%=host + "article/" + author + "?id=" + myarticles[i]%>" style="font-weight:bold;" class="btn btn-info btn-sm">觀看</a>
                                   <a href="<%=host + "back/" + author + "/edit?id=" + myarticles[i]%>" style="font-weight:bold;" class="btn btn-warning btn-sm">編輯</a>
                                   <a style="font-weight:bold;" class="btn btn-danger btn-sm" onclick="delete_button(<%=myarticles[i]%>)">刪除</a>
                                </td>
                            </tr>
                            <%
                                }
                            %>

                        </tbody>
                    </table>
                    <nav aria-label="listpagenav" style="padding-left:30%;">
                        <ul class="pagination">
                            <%
                                if (page_number > 1) {
                                    String pre_link = host + "back/" + author + "?page=" + (page_number - 1);
                            %>
                            <li class="page-item"><a class="page-link" href="<%=pre_link%>">Previous</a></li>
                                <%
                                    }
                                %>
                            <li class="page-item"><a class="page-link"><%=page_number%></a></li>
                                <%
                                    if (page_number + 1 <= page_range) {
                                        String next_link = host + "back/" + author + "?page=" + (page_number + 1);
                                %>
                            <li class="page-item"><a class="page-link" href="<%=next_link%>">Next</a></li>
                                <%
                                    }
                                %>

                            <li class="page-item">
                                <div class="btn-group dropup">
                                    <button type="button" class="btn btn-outline-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    </button>
                                    <div class="dropdown-menu">
                                        <%
                                            for (int i = 1; i <= page_range; i++) {
                                                String u = host + "back/" + author + "?page=" + i;
                                        %>
                                        <a class="dropdown-item" href="<%=u%>"><%=i%></a>
                                        <%
                                            }
                                        %>

                                    </div>
                                </div>
                            </li>
                        </ul>
                    </nav>
                    <!--文章列表區塊-->
                    <%
                        }
                    %>
                    <br>
                    <br>
                    <br>
                </div>
            </div>
        </div>
        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>

