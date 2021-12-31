package com.example.javaservletassignment02.entity;

import com.example.javaservletassignment02.annotation.Column;
import com.example.javaservletassignment02.annotation.Entity;
import com.example.javaservletassignment02.annotation.ForeignKey;
import com.example.javaservletassignment02.annotation.Id;
import com.example.javaservletassignment02.util.SQLDataTypes;

import java.util.Date;
import java.util.HashMap;

@Entity(tableName = "foods")
public class Food {

    @Id(autoIncrement = true)
    @Column(columnName = "id", columnType = SQLDataTypes.INTEGER)
    private int id;
    @Column(columnName = "name", columnType = SQLDataTypes.VARCHAR50)
    private String name;
    @Column(columnName = "description", columnType = SQLDataTypes.VARCHAR255)
    private String description;
    @Column(columnName = "thumbnail", columnType = SQLDataTypes.TEXT)
    private String thumbnail;
    @Column(columnName = "price", columnType = SQLDataTypes.DOUBLE)
    private double price;
    @Column(columnName = "sell_date", columnType = SQLDataTypes.DATETIME)
    private Date sellDate;
    @Column(columnName = "edit_date", columnType = SQLDataTypes.DATETIME)
    private Date editDate;
    @Column(columnName = "status", columnType = SQLDataTypes.INTEGER)
    private int status;
    @Column(columnName = "is_deleted", columnType = SQLDataTypes.SMALL_INTEGER)
    private int isDeleted;

    @Column(columnName = "categoryId", columnType = SQLDataTypes.INTEGER)
    @ForeignKey(referenceColumn = "id",referenceTable = "categories")
    private int categoryId;

    public Food() {
        this.name = "";
        this.description = "";
        this.thumbnail = "";
        this.price = 0;
        this.sellDate = new Date();
        this.editDate = new Date();
        this.status = 1;
        this.isDeleted = 0;
    }

    public Food(String name, String description, String thumbnail, double price, Date sellDate, Date editDate, int status, int categoryId) {
        this.name = name;
        this.description = description;
        this.thumbnail = thumbnail;
        this.price = price;
        this.sellDate = sellDate;
        this.editDate = editDate;
        this.status = status;
        this.isDeleted = 0;
        this.categoryId = categoryId;
    }

    @Override
    public String toString() {
        return "Food{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", thumbnail='" + thumbnail + '\'' +
                ", price=" + price +
                ", sellDate=" + sellDate +
                ", editDate=" + editDate +
                ", status=" + status +
                ", isDeleted=" + isDeleted +
                ", categoryId=" + categoryId +
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Date getSellDate() {
        return sellDate;
    }

    public void setSellDate(Date sellDate) {
        this.sellDate = sellDate;
    }

    public Date getEditDate() {
        return editDate;
    }

    public void setEditDate(Date editDate) {
        this.editDate = editDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(int isDeleted) {
        this.isDeleted = isDeleted;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    // kiểm tra đối tượng có hợp lệ hay không.
    public boolean isValid() {
        return getErrors().size() == 0;
    }

    // trả về danh sách lỗi
    public HashMap<String, String> getErrors() {
        HashMap<String, String> errors = new HashMap<>();
        if (name == null || name.length() == 0) {
            errors.put("name", "Vui lòng nhập tên thức ăn");
        } else if (name.length() <= 7) {
            errors.put("name", "Vui lòng nhập tên thức ăn với ít nhất 7 kí tự");
        }
        if (price <=  0) {
            errors.put("price", "Giá bán phải lớn hơn 0");
        }
        return errors;
    }
}
