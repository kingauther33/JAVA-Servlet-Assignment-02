package com.example.javaservletassignment02.controller.food;

import com.example.javaservletassignment02.entity.Food;
import com.example.javaservletassignment02.repository.JpaRepository;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteFoodServlet extends HttpServlet {

    private final JpaRepository<Food> foodJpaRepository = new JpaRepository<>(Food.class);

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Food food = foodJpaRepository.findById(id);
            if (food == null) {
                resp.getWriter().println("Food is not found!");
            } else {
                foodJpaRepository.delete(id);
                resp.getWriter().println("Delete Okay");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
