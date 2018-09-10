package com.max.controller;

import com.max.domain.Role;
import com.max.domain.User;
import com.max.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/user")
public class UserController {

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    private UserService userService;

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping
    public String listUser(Model model) {

        model.addAttribute("users", userService.findAll());

        return "user/userList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("{user}")
    public String editUserForm(@PathVariable User user, Model model) {

        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());

        return "user/userEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping
    public String userSave(
            @RequestParam String username,
            @RequestParam Map<String, String> form,
            @RequestParam("userId") User user
    ) {

        userService.saveUser(user, username, form);

        return "redirect:/user";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("delete/{id}")
    public String deleteUserById(@PathVariable Long id) {

        userService.deleteUser(id);

        return "redirect:/user";
    }

    @GetMapping("profile")
    public String profile(@AuthenticationPrincipal User user, Model model) {

        model.addAttribute("user", user);
        return "user/profile";
    }

    @PostMapping(headers = "content-type=multipart/*", value = "profile")
    public String updateProfile(
                                @AuthenticationPrincipal User user,
                                @RequestParam String password,
                                @RequestParam("password2") String newPassword,
                                @RequestParam  String firstname,
                                @RequestParam String lastname,
                                @RequestParam String username,
                                @RequestParam String email,
                                @RequestParam("file") MultipartFile file,


                                Model model) throws IOException {

            saveFile(user, file);
            userService.updateProfile(user, password, newPassword, firstname, lastname, username, email);


        return "redirect:/user/profile";
    }

    private void saveFile(@Valid User user, @RequestParam("file") MultipartFile file) throws IOException {
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
            user.setFilename(resultFileName);
        }
    }

    //подписка
    @GetMapping("subscribe/{user}")
    public String subscribe(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user) {

        userService.subscribe(currentUser, user);
        return "redirect:/photos/user-messages/" + user.getId();
    }
    //отписка
    @GetMapping("unsubscribe/{user}")
    public String unsubscribe(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user) {

        userService.unsubscribe(currentUser, user);
        return "redirect:/photos/user-messages/" + user.getId();
    }

    //выведем страницу с подспиками (кто - на кого)
    @GetMapping("{type}/{user}/list")
    public String userListSub(
            Model model,
            @PathVariable User user,
            @PathVariable String type
    ) {

        model.addAttribute("userChannel", user);
        model.addAttribute("type", type);

        //список (подписчиков / подписок)
        if("subscriptions".equals(type)) {
            model.addAttribute("users", user.getSubscriptions());
        }else {
            model.addAttribute("users", user.getSubscribers());

        }
        return "subscriptions";
    }
}
