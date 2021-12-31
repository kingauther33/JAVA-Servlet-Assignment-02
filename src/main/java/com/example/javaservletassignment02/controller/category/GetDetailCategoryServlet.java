package com.example.javaservletassignment02.controller.category;

import com.example.javaservletassignment02.entity.Category;
import com.example.javaservletassignment02.repository.JpaRepository;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class GetDetailCategoryServlet extends HttpServlet {
    private JpaRepository<Category> categoryJpaRepository  = new JpaRepository<>(Category.class);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Category category = categoryJpaRepository.findById(id);
            if (category == null) {
                resp.getWriter().println("Category is not found.");
            } else {
                req.setAttribute("category", category);
                req.getRequestDispatcher("/admin/category/detail.jsp").forward(req, resp);
            }

        } catch(Exception ex ) {
            ex.printStackTrace();
            resp.getWriter().println("Bad Request!");
        }
    }
}
