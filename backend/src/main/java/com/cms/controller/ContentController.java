package com.cms.controller;

import com.cms.dto.ApiResponse;
import com.cms.entity.Content;
import com.cms.service.ContentService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/content")
@RequiredArgsConstructor
public class ContentController {

    private final ContentService contentService;

    @GetMapping("/list")
    public ApiResponse<List<Content>> list() {
        List<Content> contents = contentService.findAll();
        return ApiResponse.success(contents);
    }

    @GetMapping("/{id}")
    public ApiResponse<Content> getById(@PathVariable Long id) {
        Content content = contentService.findById(id);
        if (content == null) {
            return ApiResponse.error("Content not found");
        }
        return ApiResponse.success(content);
    }

    @PostMapping("/create")
    public ApiResponse<Content> create(@RequestBody Content content) {
        Content created = contentService.create(content);
        return ApiResponse.success(created);
    }

    @PutMapping("/update")
    public ApiResponse<Content> update(@RequestBody Content content) {
        Content updated = contentService.update(content);
        return ApiResponse.success(updated);
    }

    @DeleteMapping("/{id}")
    public ApiResponse<Void> delete(@PathVariable Long id) {
        contentService.deleteById(id);
        return ApiResponse.success(null);
    }
}
