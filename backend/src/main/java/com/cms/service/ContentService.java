package com.cms.service;

import com.cms.entity.Content;
import com.cms.repository.ContentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ContentService {

    private final ContentRepository contentRepository;

    public Content findById(Long id) {
        return contentRepository.findById(id);
    }

    public List<Content> findAll() {
        return contentRepository.findAll();
    }

    public List<Content> findByStatus(String status) {
        return contentRepository.findByStatus(status);
    }

    public List<Content> findByAuthorId(Long authorId) {
        return contentRepository.findByAuthorId(authorId);
    }

    public Content create(Content content) {
        contentRepository.insert(content);
        return content;
    }

    public Content update(Content content) {
        contentRepository.update(content);
        return content;
    }

    public void deleteById(Long id) {
        contentRepository.deleteById(id);
    }
}
