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
import java.util.HashMap;
import java.util.List;

public class CreateFoodServlet extends HttpServlet {
    private JpaRepository<Food> foodJpaRepository = new JpaRepository<>(Food.class);
    private JpaRepository<Category> categoryJpaRepository = new JpaRepository<>(Category.class);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> listCategory = categoryJpaRepository.findAll();

        req.setAttribute("listCategory", listCategory);
        req.getRequestDispatcher("/admin/food/form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            String thumbnail = req.getParameter("thumbnail");
            double price = Double.parseDouble(req.getParameter("price"));
            SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
//            Date sellDate = formater.parse(req.getParameter("sellDate"));
            Date sellDate = new Date();
//            Date editDate = formater.parse(req.getParameter("editDate"));
            Date editDate = new Date();
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));
            int status = Integer.parseInt(req.getParameter("status"));
            // validate data.

            // t???o ra ?????i t?????ng c???a l???p product.
            Food food = new Food(name, description, thumbnail, price, sellDate, editDate, status, categoryId);
            // ki???m tra t??nh h???p l??? b???ng h??m isValidate
            if (food.isValid()) {
                foodJpaRepository.save(food);
                resp.sendRedirect("/admin/food/list");
            } else {
                // trong tr?????ng h???p l???i th??,
                // tr??? v??? l???i ch??nh form ????,
                // k??m theo th??ng tin l???i
                HashMap<String, String> errors = food.getErrors();
                List<Category> listCategory = categoryJpaRepository.findAll();

                req.setAttribute("listCategory", listCategory);
                req.setAttribute("errors", errors);
                // tr??? v??? th??ng tin food ??ang b??? l???i ????? show l???i cho ng?????i d??ng.
                req.setAttribute("food", food);
                req.getRequestDispatcher("/admin/food/form.jsp").forward(req, resp);
            }
        } catch (Exception ex) {
            resp.getWriter().println("Bad Request");
            System.out.println(ex.getMessage());
        }
    }
}
