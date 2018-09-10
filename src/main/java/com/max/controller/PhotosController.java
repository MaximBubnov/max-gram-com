package com.max.controller;

import com.max.controller.utils.ControllerUtils;
import com.max.domain.Message;
import com.max.domain.User;
import com.max.repo.MessageRepo;
import com.max.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

@Controller
@RequestMapping("/photos")
public class PhotosController {

    @Autowired
    private MessageRepo messageRepo;

    @Autowired
    private MessageService messageService;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/main")
    public String mainPagePhotos(@RequestParam(required = false, defaultValue = "") String filter, Model model) {

        List<Message> messages = messageRepo.findAll();

        if(filter != null && !filter.isEmpty()) {
            messages = messageRepo.findByTag(filter);
        }
        else {
            messages = messageRepo.findAll();
        }

        model.addAttribute("filter", filter);
        model.addAttribute("messages", messages);

        return "photos";
    }

    @PostMapping("/main")
    public String addMessage(@AuthenticationPrincipal User user,
                             @Valid Message message,
                             BindingResult bindingResult,
                             Model model,
                             @RequestParam("file")MultipartFile file) throws IOException {

        //если у нас есть ошибки то сразу будем их обрабатывать
        if(bindingResult.hasErrors()) {// создадим мапу в которую будем записывать наши ошибки
            Map<String, String> errorMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorMap);
            model.addAttribute("message", message);
        } else {
            message.setAuthor(user);

            saveFile(message, file);

            //если валидация прошла успешно, то месседж (в нем будут наши ошибки) нужно очистить
            model.addAttribute("message", null);

            messageRepo.save(message);
        }
        Iterable<Message> messages = messageRepo.findAll();

        model.addAttribute("messages", messages);

        return "photos";
    }

    private void saveFile(@Valid Message message, @RequestParam("file") MultipartFile file) throws IOException {
        if (file != null && !file.getOriginalFilename().isEmpty()) {

            File uploadDir = new File(uploadPath);
            //если дериктория  не существует - создадим ее
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            //обезопасим себя от коллизий
            String uuidFile = UUID.randomUUID().toString();

            //это будет имя файла, котое мы будем ложить в месседж
            String resultFileName = uuidFile + "." + file.getOriginalFilename();

            //теперь этот файл нужно загрузить
            file.transferTo(new File(uploadPath + "/" + resultFileName));
            message.setFilename(resultFileName);
        }
    }

    @GetMapping("/user-messages/{user}")
    public String userPhotos(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            Model model,
            @RequestParam(required = false) Message message

    ) {

        Set<Message> messages = user.getMessages();

        model.addAttribute("messages", messages);
        model.addAttribute("message", message);

        model.addAttribute("userChannel", user);
        model.addAttribute("subscriptionsCount", user.getSubscriptions().size());
        model.addAttribute("subscribersCount", user.getSubscribers().size());

        model.addAttribute("isSubscriber", user.getSubscribers().contains(currentUser));//является ли текущий юзер подписчиком того юзера к которому мы пришли


        model.addAttribute("user", user);

        model.addAttribute("isCurrentUser", currentUser.equals(user));

        return "userPhotos";
    }


    @PostMapping("/user-messages/{user}")
    public String updateMessage(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long user,
            @RequestParam("id") Message message,
            @RequestParam("text") String text,
            @RequestParam("tag") String tag,
            @RequestParam("file") MultipartFile file
    ) throws IOException {
        //юзер может только свои сообщения,
        if (message.getAuthor().equals(currentUser)) {
            if (!StringUtils.isEmpty(text)) { //меняем текст
                message.setText(text);
            }

            if (!StringUtils.isEmpty(tag)) {  //меняем тег
                message.setTag(tag);
            }

            saveFile(message, file);  //меняем файл

            messageRepo.save(message);
        }

        return "redirect:/photos/user-messages/" + user;
    }


    @PostMapping("delete/{id}")
    public String deletePhotos(@PathVariable Long id, @AuthenticationPrincipal User user) {
        messageRepo.deleteById(id);
        return "redirect:/photos/user-messages/" + user.getId();
    }

}
