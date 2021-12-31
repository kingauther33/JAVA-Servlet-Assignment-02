package com.example.javaservletassignment02.util;

import com.example.javaservletassignment02.entity.Food;
import com.example.javaservletassignment02.repository.JpaRepository;

import java.util.List;

public class Example {
    public static void main(String[] args) {
        JpaRepository<Food> jpaRepository = new JpaRepository<>(Food.class);
        List<Food> list = jpaRepository.where("price", ">=", "10000");
        for (Food p :
                list) {
            System.out.println(p.toString());
        }
    }

    // cảnh báo cho thằng gọi hàm này có thể có lỗi
    static void proactiveHandleError(String name) throws Exception {
        if (name.equals("Hung")) {
            // chủ động quăng lỗi
            throw new Exception("Ko choi voi Hung");
        }
        System.out.println(name);
    }
}
