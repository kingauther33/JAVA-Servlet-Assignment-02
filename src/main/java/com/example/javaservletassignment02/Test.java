package com.example.javaservletassignment02;

import com.example.javaservletassignment02.entity.Food;
import com.example.javaservletassignment02.repository.JpaRepository;

public class Test {
    public static void main(String[] args) {
        JpaRepository<Food> foodJpaRepository = new JpaRepository<>(Food.class);
//        List<Food> list = foodJpaRepository.findByPage(3, 5);
//        for (Food item:
//             list) {
//            System.out.println(item.toString());
//        }
//
//        int totalRecords = foodJpaRepository.countAllRecords();
//        System.out.println(totalRecords);

        Food food = foodJpaRepository.findById(1);
        foodJpaRepository.delete(1);
    }
}
