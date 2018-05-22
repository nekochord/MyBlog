<%-- 
    Document   : userjump
    Created on : 2018/5/19, 下午 08:35:53
    Author     : 林哲宏
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="blog.certification.Xman" %>
<%
    String path = request.getPathInfo();
    if (path == null) {
        request.getRequestDispatcher("/ErrorPage").forward(request, response);
    }
    if (path.equals("/")) {
        request.getRequestDispatcher("/ErrorPage").forward(request, response);
    }
    String[] path_array = path.split("/");
    String author;
    int page_number = 1;
    author = path_array[1];
    if (path_array.length == 2) {
        page_number = 1;
    }
    if (path_array.length == 3) {
        String a = path_array[2];
        try {
            page_number = Integer.parseInt(a);
        } catch (NumberFormatException nfe) {
            page_number = 1;
        }
    }
    if (path_array.length > 3) {
        page_number = 1;
    }
    String tag=request.getParameter("tag");
    int sort;
    try{
        sort=Integer.parseInt(request.getParameter("sort"));
    }catch(NumberFormatException nfe){
        sort=3;
    }
    //確認是否存在該作者
    Xman man=new Xman();
    if(!man.checkExists(author)){
        request.getRequestDispatcher("/ErrorPage").forward(request, response);
    }
    request.setAttribute("author", author);
    request.setAttribute("page_number", page_number);
    request.setAttribute("tag", tag);
    request.setAttribute("sort", sort);
    request.setAttribute("host",config.getInitParameter("host"));
    HttpSession hs = request.getSession();
    if (hs.getAttribute("auth") == null) {
        //確認是否為登入狀態
        request.setAttribute("viewer_type", "Anonymous");
        request.getRequestDispatcher("/WEB-INF/jsp/content.jsp").forward(request, response);
    }
    String name = (String) hs.getAttribute("name");
    if (name.equals(author)) {
        //看自己的部落格
        request.setAttribute("viewer_type", "Owner");
        request.getRequestDispatcher("/WEB-INF/jsp/content.jsp").forward(request, response);
    }else{
        //看別人的部落格
        request.setAttribute("viewer_type", "Other");
        request.getRequestDispatcher("/WEB-INF/jsp/content.jsp").forward(request, response);
    }

%>
