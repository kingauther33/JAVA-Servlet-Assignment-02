package com.example.javaservletassignment02.controller.food;

import com.example.javaservletassignment02.entity.Category;
import com.example.javaservletassignment02.entity.Food;
import com.example.javaservletassignment02.repository.JpaRepository;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class GetDetailFoodServlet extends HttpServlet {
    private JpaRepository<Food> foodJpaRepository = new JpaRepository<>(Food.class);
    private JpaRepository<Category> categoryJpaRepository = new JpaRepository<>(Category.class);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Food food = foodJpaRepository.findById(id);
            List<Category> listCategory = categoryJpaRepository.findAll();

            req.setAttribute("listCategory", listCategory);
            if (food == null) {
                resp.getWriter().println("Food is not found.");
            } else {
                req.setAttribute("food", food);
                req.getRequestDispatcher("/admin/food/detail.jsp").forward(req, resp);
            }

        } catch(Exception ex ) {
            ex.printStackTrace();
            resp.getWriter().println("Bad Request!");
        }
    }
}
