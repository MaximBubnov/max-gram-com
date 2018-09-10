package com.max.service;

import com.max.domain.Role;
import com.max.domain.User;
import com.max.repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private MailSender mailSender;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        User user = userRepo.findByUsername(username);

        if(user == null) {
            throw new UsernameNotFoundException("User not found");
        }

        return user;
    }

    public boolean addUser(User user) {

        User userFromBD = userRepo.findByUsername(user.getUsername());

        if(userFromBD != null) {
            return false;
        }

        user.setActive(false);
        user.setRoles(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());

        userRepo.save(user);

        sendMessage(user);

        return true;
    }

    public List<User> findAll() {
        return userRepo.findAll();
    }

    public void deleteUser(Long id) {
        userRepo.deleteById(id);
    }

    public void saveUser(User user, String username, Map<String, String> form) {
        user.setUsername(username);

        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());

        user.getRoles().clear();

        for (String key : form.keySet()) {
            if(roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userRepo.save(user);
    }

    public void updateProfile(User user, String oldPassword, String newPassword, String firstname, String lastname, String username, String email) {

        //получаем емаил изначальные
        String userEmail = user.getEmail();

        //изменен ли емаил
        boolean isEmailChanged = ((email != null && !email.equals(userEmail)) ||
                (userEmail!=null && !userEmail.equals(email)));

        //если да
        if(isEmailChanged) {
            user.setEmail(email); // то устанавливаем новый
            //если он установил новый емаил
            if(!StringUtils.isEmpty(email)) {
                user.setActivationCode(UUID.randomUUID().toString()); // генерируем ему новый код
            }
        }

        if(!StringUtils.isEmpty(firstname))
            user.setFirstname(firstname);

        //----------------------------------------------------
        user.setLastname(lastname);

        //----------------------------------------------------
        List<User> users = findAll();
        List<String> names = new ArrayList<>();

        for (User user1 : users) {
            names.add(user1.getUsername());
        }

        if(!names.contains(username))
            user.setUsername(username);

        //----------------------------------------------------
       if(!StringUtils.isEmpty(oldPassword) && user.getPassword().equals(oldPassword) && !StringUtils.isEmpty(newPassword))
           user.setPassword(newPassword);

        //----------------------------------------------------
        userRepo.save(user);

        if (isEmailChanged) {
            sendMessage(user);
        }
    }

    //отправка сообщения с активационным кодом
    private void sendMessage(User user) {
        if(!StringUtils.isEmpty(user.getEmail())) {

            String message = String.format(
                    "Hello! \n" +
                            "Welcome to Maxyyygram!\n" +
                            "Please, visit next link : http://localhost:8080/activate/%s",
                    user.getActivationCode()
            );

            mailSender.send(user.getEmail(), "Activation code. Maxyyygram", message);
        }
    }

    //пользователь активирован или нет
    public boolean activateUser(String code) {
        //возвращаем пользователя по определенному коду
        User user = userRepo.findByActivationCode(code);

        if(user == null) {
            return false;
        }
        //если все ок - код = 0
        user.setActivationCode(null);
        user.setActive(true);
        userRepo.save(user);

        return true;
    }

    //подписаться на пользователя
    public void subscribe(User currentUser, User user) {
        user.getSubscribers().add(currentUser);

        userRepo.save(user);
    }

    //отписаться от пользователя
    public void unsubscribe(User currentUser, User user) {
        user.getSubscribers().remove(currentUser);

        userRepo.save(user);
    }
}
