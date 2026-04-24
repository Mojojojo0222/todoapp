package com.todoapp.controller;

import com.todoapp.entity.Todo;
import com.todoapp.service.TodoService;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class TodoController {

    private final TodoService service;

    public TodoController(TodoService service) {
        this.service = service;
    }

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("todos", service.getAll());
        return "index";
    }

    @PostMapping("/add")
    public String add(@RequestParam @NotBlank @Size(max = 255) String title) {
        Todo todo = new Todo();
        todo.setTask(title);
        todo.setStatus("pending");
        service.save(todo);
        return "redirect:/";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        service.delete(id);
        return "redirect:/";
    }
}
