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

public class ListFoodServlet extends HttpServlet {
    private JpaRepository<Food> foodJpaRepository = new JpaRepository<>(Food.class);
    private JpaRepository<Category> categoryJpaRepository = new JpaRepository<>(Category.class);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        int pageSize = 5;
        String pageReq = req.getParameter("page");
        String pageSizeReq = req.getParameter("pageSize");
        if (pageReq != null) {
            page = Integer.parseInt(pageReq);
        }
        if (pageSizeReq != null) {
            pageSize = Integer.parseInt(pageSizeReq);
        }
        int totalRecords = foodJpaRepository.countAllRecords();
        List<Food> listFood = foodJpaRepository.findByPage(page, pageSize);
        List<Category> listCategory = categoryJpaRepository.findAll();

        req.setAttribute("listFood", listFood);
        req.setAttribute("listCategory", listCategory);
        req.setAttribute("page", page);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("totalRecords", totalRecords);
        req.getRequestDispatcher("/admin/food/list.jsp").forward(req, resp);
    }
}
