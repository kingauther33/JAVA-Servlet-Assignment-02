package com.example.javaservletassignment02.entity;

import com.example.javaservletassignment02.annotation.Column;
import com.example.javaservletassignment02.annotation.Entity;
import com.example.javaservletassignment02.annotation.Id;
import com.example.javaservletassignment02.util.SQLDataTypes;

import java.util.Date;
import java.util.HashMap;

@Entity(tableName = "categories")
public class Category {
    @Id(autoIncrement = true)
    @Column(columnName = "id", columnType = SQLDataTypes.INTEGER)
    private int id;
    @Column(columnName = "name", columnType = SQLDataTypes.VARCHAR50)
    private String name;
    @Column(columnName = "status", columnType = SQLDataTypes.INTEGER)
    private int status;
    @Column(columnName = "edit_date", columnType = SQLDataTypes.DATETIME)
    private Date editDate;
    @Column(columnName = "is_deleted", columnType = SQLDataTypes.SMALL_INTEGER)
    private int isDeleted;

    public Category() {
        this.name = "";
        this.status = 1;
        this.isDeleted = 0;
        this.editDate = new Date();
    }

    public Category(String name, int status) {
        this.name = name;
        this.status = status;
        this.isDeleted = 0;
        this.editDate = new Date();
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", status=" + status +
                ", editDate=" + editDate +
                ", isDeleted=" + isDeleted +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getEditDate() {
        return editDate;
    }

    public void setEditDate(Date editDate) {
        this.editDate = editDate;
    }

    public int getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(int isDeleted) {
        this.isDeleted = isDeleted;
    }

    // kiểm tra đối tượng có hợp lệ hay không.
    public boolean isValid() {
        return getErrors().size() == 0;
    }

    // trả về danh sách lỗi
    public HashMap<String, String> getErrors() {
        HashMap<String, String> errors = new HashMap<>();
        if (name == null || name.length() == 0) {
            errors.put("name", "Vui lòng nhập tên loại thức ăn");
        }

        if (status == 0) {
            errors.put("status", "Vui lòng nhập trạng thái cho loại thức ăn");
        }
        return errors;
    }
}
