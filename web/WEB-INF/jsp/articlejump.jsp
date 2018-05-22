<%-- 
    Document   : articlejump
    Created on : 2018/5/21, 下午 05:35:42
    Author     : 林哲宏
--%>

<%@page import="blog.certification.Xman"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
     String path = request.getPathInfo();
    if (path == null) {
        request.getRequestDispatcher("/ErrorPage").forward(request, response);
    }
    if (path.equals("/")) {
        request.getRequestDispatcher("/ErrorPage").forward(request, response);
    }
    String[] path_array = path.split("/");
    if(path_array.length>2)response.sendError(404);
    String author;
    author = path_array[1];
    //確認是否存在該作者
    Xman man=new Xman();
    if(!man.checkExists(author)){
        request.getRequestDispatcher("/ErrorPage").forward(request, response);
    }
    request.setAttribute("author", author);
    request.setAttribute("host",config.getInitParameter("host"));
    HttpSession hs = request.getSession();
    if (hs.getAttribute("auth") == null) {
        //確認是否為登入狀態
        request.setAttribute("viewer_type", "Anonymous");
        request.getRequestDispatcher("/WEB-INF/jsp/article.jsp").forward(request, response);
    }
    String name = (String) hs.getAttribute("name");
    if (name.equals(author)) {
        //看自己的部落格
        request.setAttribute("viewer_type", "Owner");
        request.getRequestDispatcher("/WEB-INF/jsp/article.jsp").forward(request, response);
    }else{
        //看別人的部落格
        request.setAttribute("viewer_type", "Other");
        request.getRequestDispatcher("/WEB-INF/jsp/article.jsp").forward(request, response);
    }
    
%>