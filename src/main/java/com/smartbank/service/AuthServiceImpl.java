package com.smartbank.service;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smartbank.dto.User_Dto;
import com.smartbank.entity.User_Entity;
import com.smartbank.enum_package.Enum_File;
import com.smartbank.exception.LoginException;
import com.smartbank.repository.AuthRepository;
import com.smartbank.util.PasswordUtil;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    private ModelMapper modelMapper;

    private final AuthRepository authRepository;

    public AuthServiceImpl(AuthRepository authRepository) {
        this.authRepository = authRepository;
    }

    // REGISTER
    @Override
    public void register(User_Dto dto) {

        User_Entity userData =
                modelMapper.map(dto, User_Entity.class);

        User_Entity existingUser = authRepository
                .findByEmail(userData.getEmail())
                .orElse(null);

        if (existingUser != null) {
            throw new IllegalArgumentException(
                    "Email already registered. Please use another email."
            );
        }

        userData.setPassword(
                PasswordUtil.encrypt(userData.getPassword())
        );

        userData.setRole(Enum_File.CUSTOMER);

        authRepository.save(userData);
    }

    // LOGIN
    @Override
    public User_Dto login(User_Dto dto) {

        User_Entity user = authRepository
                .findByEmail(dto.getEmail())
                .orElse(null);

        if (user == null) {
            throw new LoginException("Email is not registered.");
        }

        boolean passwordMatches = PasswordUtil.matches(
                dto.getPassword(),
                user.getPassword()
        );

        if (!passwordMatches) {
            throw new LoginException("Incorrect password.");
        }

        return modelMapper.map(user, User_Dto.class);
    }

    // FIND USER BY EMAIL
    @Override
    public User_Entity findByEmail(String email) {
        return authRepository.findByEmail(email).orElse(null);
    }

    // UPDATE PASSWORD
    @Override
    public void updatePassword(String email, String password) {

        User_Entity user = authRepository
                .findByEmail(email)
                .orElse(null);

        if (user != null) {
            user.setPassword(PasswordUtil.encrypt(password));
            authRepository.save(user);
        }
    }

    // GET USER BY ID
    @Override
    public User_Dto getUserById(Integer user_id) {

        User_Entity user = authRepository
                .findById(user_id)
                .orElseThrow(() ->
                        new IllegalArgumentException("User not found.")
                );

        return modelMapper.map(user, User_Dto.class);
    }

    // UPDATE USER
    @Override
    public boolean updateUser(User_Dto dto) throws Exception {

        User_Entity userData = authRepository
                .findById(dto.getUserId())
                .orElseThrow(() -> new Exception("User not found."));

        userData.setName(dto.getName());
        userData.setEmail(dto.getEmail());
        userData.setMobile(dto.getMobile());

        if (dto.getPassword() != null
                && !dto.getPassword().isBlank()) {

            userData.setPassword(
                    PasswordUtil.encrypt(dto.getPassword())
            );
        }

        authRepository.save(userData);
        return true;
    }
}