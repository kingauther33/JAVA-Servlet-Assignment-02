package com.example.javaservletassignment02.controller.category;

import com.example.javaservletassignment02.entity.Category;
import com.example.javaservletassignment02.repository.JpaRepository;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;

public class CreateCategoryServlet extends HttpServlet {
    private JpaRepository<Category> categoryJpaRepository = new JpaRepository<>(Category.class);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/admin/category/form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");
            String name = req.getParameter("name");
            int status = Integer.parseInt(req.getParameter("status"));
            // validate data.

            // tạo ra đối tượng của lớp category.
            Category category = new Category(name, status);
            // kiểm tra tính hợp lệ bằng hàm isValidate
            if (category.isValid()) {
                categoryJpaRepository.save(category);
                resp.sendRedirect("/admin/category/list");
            } else {
                // trong trường hợp lỗi thì,
                // trả về lại chính form đó,
                // kèm theo thông tin lỗi
                HashMap<String, String> errors = category.getErrors();

                req.setAttribute("errors", errors);
                // trả về thông tin food đang bị lỗi để show lại cho người dùng.
                req.setAttribute("category", category);
                req.getRequestDispatcher("/admin/category/form.jsp").forward(req, resp);
            }
        } catch (Exception ex) {
            resp.getWriter().println("Bad Request");
            System.out.println(ex.getMessage());
        }
    }
}
