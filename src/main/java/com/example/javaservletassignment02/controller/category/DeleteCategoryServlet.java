package com.example.javaservletassignment02.controller.category;

import com.example.javaservletassignment02.entity.Category;
import com.example.javaservletassignment02.entity.Food;
import com.example.javaservletassignment02.repository.JpaRepository;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class DeleteCategoryServlet extends HttpServlet {

    private final JpaRepository<Category> categoryJpaRepository = new JpaRepository<>(Category.class);
    private final JpaRepository<Food> foodJpaRepository = new JpaRepository<>(Food.class);

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Category category = categoryJpaRepository.findById(id);
            List<Food> listFoodByCategoryId = foodJpaRepository.findByForeignKeyId(id);
            if (category == null) {
                resp.getWriter().println("Category is not found!");
            } else if (listFoodByCategoryId == null) {
                categoryJpaRepository.delete(id);
                resp.getWriter().println("Delete Okay");
            } else {
                for (Food food:
                        listFoodByCategoryId) {
                    foodJpaRepository.delete(food.getId());
                }
                categoryJpaRepository.delete(id);
                resp.getWriter().println("Delete Okay");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
