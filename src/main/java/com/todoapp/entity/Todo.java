package com.todoapp.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "todolist")
public class Todo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "task")
    private String task;

    @Column(name = "status")
    private String status;

    @Column(name = "created_at", updatable = false, insertable = false)
    private java.sql.Timestamp createdAt;

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTask() { return task; }
    public void setTask(String task) { this.task = task; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public java.sql.Timestamp getCreatedAt() { return createdAt; }
}
