<%-- 
    Document   : login
    Created on : 2018/5/19, 下午 02:14:38
    Author     : 林哲宏
--%>

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
    String result = "";
    Object code = request.getAttribute("code");
    if (code == null) {
        System.out.println("no problem");
    } else {
        switch ((int) code) {
            case 101:
                result = myAlert("使用者名稱或密碼欄位為空");
                break;
            case 102:
                result = myAlert("使用者名稱或密碼錯誤!!!");
                break;
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
        <style>
            #a{
                text-align: center;
                position: absolute;
            }
        </style>
        <title>登入</title>
        <script>
            function check_empty() {
                var name = document.getElementById("name").value;
                var pass = document.getElementById("pwd").value;
                if (name !== '' && pass !== '') {
                    document.getElementById("login").disabled = false;
                } else {
                    document.getElementById("login").disabled = true;
                }
            }
        </script>
    </head>
    <body>
        <%=result%>
        <div class="container">
            <div class="row">
                <div class="col"></div>
                <div class="col">
                    <div style="height:5vh;"></div>
                    <div style="height:25vh;font-size:70px;" class="text-center">Blog</div>
                    <form action="LoginButton" method="POST">
                        <div class="form-group">
                            <label for="name" class="text-primary" style="font-weight:bold;">使用者名稱</label>
                            <input type="text" class=form-control name="name"  id="name" placeholder="輸入名稱" onchange="check_empty()"></input>
                        </div>
                        <div class="form-group">
                            <label for="pwd" class="text-primary" style="font-weight:bold;" >密碼</label>
                            <input type="password" class=form-control name="pass" id="pwd" placeholder="輸入密碼" onchange="check_empty()"></input>
                        </div>
                        <button  type="submit" class="btn btn-primary" disabled="true" id='login'>登入</button>
                        <a href="register" class="btn btn-outline-info" style="position: absolute;right:5px;">註冊</a>
                    </form>
                </div>
                <div class="col"></div>
            </div>
        </div>

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
