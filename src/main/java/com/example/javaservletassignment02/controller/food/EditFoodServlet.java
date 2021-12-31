package com.example.javaservletassignment02.controller.food;

import com.example.javaservletassignment02.entity.Category;
import com.example.javaservletassignment02.entity.Food;
import com.example.javaservletassignment02.repository.JpaRepository;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class EditFoodServlet extends HttpServlet {
    private final JpaRepository<Food> foodJpaRepository = new JpaRepository<>(Food.class);
    private final JpaRepository<Category> categoryJpaRepository = new JpaRepository<>(Category.class);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Food food = foodJpaRepository.findById(id);
            List<Category> listCategory = categoryJpaRepository.findAll();

            req.setAttribute("listCategory", listCategory);
            if (food == null) {
                resp.getWriter().println("Food is not found!");
            } else {
                req.setAttribute("food", food);
                req.getRequestDispatcher("/admin/food/edit.jsp").forward(req, resp);
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
            Food food = foodJpaRepository.findById(id);
            // CHECK nếu trong lúc sửa đã bị xóa hoặc không tìm thấy nữa
            if (food == null) {
                resp.getWriter().println("Product is not found or has been deleted!");
            }

            String name = req.getParameter("name");
            String description = req.getParameter("description");
            String thumbnail = req.getParameter("thumbnail");
            double price = Double.parseDouble(req.getParameter("price"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date editDate = new Date();
            int status = Integer.parseInt(req.getParameter("status"));
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));

            // update gia tri
            food.setName(name);
            food.setDescription(description);
            food.setThumbnail(thumbnail);
            food.setPrice(price);
            food.setEditDate(editDate);
            food.setStatus(status);
            food.setCategoryId(categoryId);

            // update trong db
            foodJpaRepository.update(food);
            resp.sendRedirect("/admin/food/list");

        } catch (Exception ex) {
            ex.printStackTrace();
            resp.getWriter().println("Bad request");
        }
    }
}
