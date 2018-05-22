<%-- 
    Document   : backjump
    Created on : 2018/5/22, 上午 12:24:31
    Author     : 林哲宏
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String host = config.getInitParameter("host");
    String path = request.getPathInfo();
    if (path == null) {
        request.getRequestDispatcher("/ErrorPage").forward(request, response);
    }
    if (path.equals("/")) {
        request.getRequestDispatcher("/ErrorPage").forward(request, response);
    }
    String[] path_array = path.split("/");
    String author = path_array[1];
    //檢查使用者
    HttpSession hs = request.getSession();
    if (hs.getAttribute("auth") != null) {
        
        String auth_name = (String) hs.getAttribute("name");
        if (!auth_name.equals(author)) {
            response.sendRedirect(host + "back/" + auth_name);
            return;
        }
    } else {
        response.sendRedirect(host + "login");
        return;
    }
    request.setAttribute("author", author);
    request.setAttribute("host", host);
    if (path_array.length == 2) {
        //顯示文章列表
        int page_number = 1;
        if (request.getParameter("page") != null) {
            try {
                page_number = Integer.parseInt(request.getParameter("page"));
            } catch (Exception e) {
                request.getRequestDispatcher("/ErrorPage").forward(request, response);
            }
        }
        request.setAttribute("type", "list");
        request.setAttribute("page_number", page_number);
        request.getRequestDispatcher("/WEB-INF/jsp/back.jsp").forward(request, response);
    }
    if (path_array.length == 3) {
        //新增或修改
        if (path_array[2].equals("new")) {
            request.setAttribute("type", "new");
        } else if (path_array[2].equals("edit")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("type", "edit");
                request.setAttribute("id", id);
            } catch (Exception e) {
                request.getRequestDispatcher("/ErrorPage").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("/ErrorPage").forward(request, response);
        }
        request.getRequestDispatcher("/WEB-INF/jsp/back.jsp").forward(request, response);
    }
    if (path_array.length > 4) {
        //ErrorAccess
        request.getRequestDispatcher("/ErrorPage").forward(request, response);
    }

%>