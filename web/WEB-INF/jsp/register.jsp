<%-- 
    Document   : register
    Created on : 2018/5/19, 下午 02:45:29
    Author     : 林哲宏
--%>
<%!
    public String myAlert(String text) {
        String answer = "<div class='alert alert-info alert-dismissible fade show' role='alert' style='font-size:16px;font-weight:bold;'>"
                + text
                + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"
                + "<span aria-hidden='true'>&times;</span>"
                + "</button>"
                + "</div>";
        return answer;
    }
%>
<%
    Object code=request.getAttribute("code");
    String canjump="";
    String msg="";
    String jump_url="<a href='http://localhost:8084/MyBlog/login'>沒有反應的話請點我~</a>";
    if(code!=null){
        switch((int)code){
            case 100:
                msg=myAlert("註冊成功! 將在3秒後跳轉至登入頁面<br>"+jump_url);
                canjump="jump_login();";
                break;
            case 101:
                msg=myAlert("註冊失敗，請聯絡網站管理員");
                break;
            case 102:
                msg=myAlert("用戶名稱已被他人註冊，請換一個");
                break;
            case 103:
                msg=myAlert("欄位不得為空!!!");
                break;
        }
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <title>註冊</title>
        <script>
            function jump_login() {
                sleep(3000);
                window.location.pathname="/MyBlog/login";
            }
            function sleep(milliseconds) {
                var start = new Date().getTime();
                while((new Date().getTime() - start)<=milliseconds );
            }
            function check_empty() {
                var name = document.getElementById("name").value;
                var pass = document.getElementById("pwd").value;
                var email = document.getElementById("email").value;
                if (name !== '' && pass !== '' && email !== '') {
                    document.getElementById("register").disabled = false;
                } else {
                    document.getElementById("register").disabled = true;
                }
            }
        </script>
    </head>
    <body onload="<%=canjump%>">
        <%=msg%>
        <div class="container">
            <div class="row">
                <div class="col"></div>
                <div class="col">
                    <div style="height:5vh;"></div>
                    <div style="height:25vh;font-size:70px;" class="text-center">註冊</div>
                    <form action="RegisterButton" method="POST">
                        <div class="form-group">
                            <label for="name" class="text-primary" style="font-weight:bold;">使用者名稱</label>
                            <input type="text" class=form-control id="name" name="name" placeholder="輸入名稱" onchange="check_empty()"></input>
                        </div>
                        <div class="form-group">
                            <label for="pwd" class="text-primary" style="font-weight:bold;">密碼</label>
                            <input type="password" class=form-control id="pwd" name="pass" placeholder="輸入密碼" onchange="check_empty()"></input>
                        </div>
                        <div class="form-group">
                            <label for="email" class="text-primary" style="font-weight:bold;">Email</label>
                            <input type="email" class=form-control id="email" name="email" placeholder="輸入Email" onchange="check_empty()"></input>
                        </div>
                        <button type="submit" class="btn btn-primary" id='register' disabled="true">註冊</button>
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
