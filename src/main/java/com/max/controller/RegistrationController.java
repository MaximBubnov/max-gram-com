package com.max.controller;

import com.max.controller.utils.ControllerUtils;
import com.max.domain.User;
import com.max.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Controller
public class RegistrationController  {

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    private UserService userService;

    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }

    @PostMapping(headers = "content-type=multipart/*", value = "/registration")
    public String addUser(
            @RequestParam("password2") String passwordConfirm,
            @RequestParam("file") MultipartFile file,

            @Valid User user,
            BindingResult bindingResult,
            Model model
            ) throws IOException {

        //если пассворд2 (для проверки) не пустой
        boolean isConfirmEmpty = StringUtils.isEmpty(passwordConfirm);

        //если пассворд2 (для проверки) не пустой
        if(!isConfirmEmpty) {
            model.addAttribute("password2", "Password confirmation cannot be empty");
        }

        //сходяться ли два пароля которые ввел пользователь при регистрации
        if (user.getPassword() != null && !user.getPassword().equals(passwordConfirm)) {
            model.addAttribute("passwordError", "Passwords are different!");
        }

        //есть ли у нас ошибки валидации
        if(isConfirmEmpty || bindingResult.hasErrors() /*|| !responseDto.isSuccess()*/) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);

            return "registration";
        } else {
            saveFile(user, file);
        }

        if(!userService.addUser(user)) {
            model.addAttribute("usernameError", "User exists!");
            return "registration";
        }

        return "redirect:/login";
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
        else {
            user.setFilename("default_picture.png");
        }
    }

    //подтверждение регистрации
    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code, User user) {
        boolean isActive = userService.activateUser(code);

        if(isActive) {
            model.addAttribute("messageType", "success");
            model.addAttribute("message", "User successfully activated");

        } else {
            model.addAttribute("messageType", "danger");
            model.addAttribute("message", "Activation code is not found");
        }

        return "login";
    }

}
