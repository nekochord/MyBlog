/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package myservlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import blog.certification.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

/**
 *
 * @author 林哲宏
 */
public class LoginButton extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginButton</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Access Error!</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name=request.getParameter("name");
        String pass=request.getParameter("pass");
        if(name==null || pass==null){
            //有null
            request.setAttribute("code", 101);
            RequestDispatcher dispatcher=request.getRequestDispatcher("/login");
            dispatcher.forward(request, response);
        }
        if(name.equals("")||pass.equals("")){
            //有一欄為空
            request.setAttribute("code", 101);
            RequestDispatcher dispatcher=request.getRequestDispatcher("/login");
            dispatcher.forward(request, response);
        }else{
            Xman man =new Xman();
            boolean result=man.login(name, pass);
            if(result){
                HttpSession nowhs=request.getSession();
                nowhs.setAttribute("name", name);
                nowhs.setAttribute("auth", true);
                RequestDispatcher dispatcher=request.getRequestDispatcher("/content");
                dispatcher.forward(request, response);
            }else{
                request.setAttribute("code", 102);
                RequestDispatcher dispatcher=request.getRequestDispatcher("/login");
                dispatcher.forward(request, response);
            }
        }   
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
