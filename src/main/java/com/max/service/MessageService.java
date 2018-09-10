package com.max.service;

import com.max.repo.MessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MessageService  {

    @Autowired
    private MessageRepo messageRepo;

    public void delete(long id) {
        messageRepo.deleteById(id);
    }
}
