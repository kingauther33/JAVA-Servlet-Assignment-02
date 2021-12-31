package com.example.javaservletassignment02.controller.category;

import com.example.javaservletassignment02.entity.Category;
import com.example.javaservletassignment02.repository.JpaRepository;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

public class EditCategoryServlet extends HttpServlet {
    private final JpaRepository<Category> categoryJpaRepository = new JpaRepository<>(Category.class);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Category category = categoryJpaRepository.findById(id);
            if (category == null) {
                resp.getWriter().println("Category is not found!");
            } else {
                req.setAttribute("category", category);
                req.getRequestDispatcher("/admin/category/edit.jsp").forward(req, resp);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            resp.getWriter().println("Bad request");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");
            int id = Integer.parseInt(req.getParameter("id"));
            Category category = categoryJpaRepository.findById(id);
            if (category == null) {
                resp.getWriter().println("Category is not found or has been deleted!");
            }

            String name = req.getParameter("name");
            int status = Integer.parseInt(req.getParameter("status"));
            Date editDate = new Date();

            // update gia tri
            category.setName(name);
            category.setStatus(status);
            category.setEditDate(editDate);

            // update trong db
            categoryJpaRepository.update(category);
            resp.sendRedirect("/admin/category/list");

        } catch (Exception ex) {
            ex.printStackTrace();
            resp.getWriter().println("Bad request");
        }
    }
}
