package com.smartbank.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smartbank.dto.User_Dto;
import com.smartbank.entity.User_Entity;
import com.smartbank.enum_package.Enum_File;
import com.smartbank.exception.InvalidOtpException;
import com.smartbank.exception.LoginException;
import com.smartbank.exception.PasswordMismatchException;
import com.smartbank.exception.UserNotFoundException;
import com.smartbank.service.AuthService;
import com.smartbank.service.EmailService;
import com.smartbank.util.OTPGenerator;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @Autowired
    private EmailService emailService;

    // REGISTER PAGE
    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("user", new User_Entity());
        return "auth/register";
    }

    // REGISTER
    @PostMapping("/register")
    public String register(
            @ModelAttribute User_Dto dto,
            @RequestParam("confirmPassword") String confirmPassword,
            Model model) {

        if (dto.getPassword() == null
                || dto.getPassword().isBlank()
                || confirmPassword == null
                || confirmPassword.isBlank()) {

            model.addAttribute("error", "Password is required.");
            return "auth/register";
        }

        if (!dto.getPassword().equals(confirmPassword)) {
            model.addAttribute(
                    "error",
                    "Password and Confirm Password do not match."
            );
            return "auth/register";
        }

        try {
            authService.register(dto);
            return "redirect:/auth/login";

        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            return "auth/register";
        }
    }

    // LOGIN PAGE
    @GetMapping("/login")
    public String loginPage(Model model) {
        model.addAttribute("loginDTO", new User_Dto());
        return "auth/login";
    }

    // LOGIN
    @PostMapping("/login")
    public String login(
            @ModelAttribute User_Dto dto,
            Model model,
            HttpSession session,
            HttpServletRequest request) {

        if (dto.getEmail() == null
                || dto.getEmail().isBlank()) {

            model.addAttribute("message", "Email is required.");
            return "auth/login";
        }

        if (dto.getPassword() == null
                || dto.getPassword().isBlank()) {

            model.addAttribute("message", "Password is required.");
            return "auth/login";
        }

        try {
            User_Dto loginDTO = authService.login(dto);
            String role = loginDTO.getRole();

            request.changeSessionId();

            session.removeAttribute("userId");
            session.removeAttribute("name");
            session.removeAttribute("useremail");

            session.removeAttribute("adminUserId");
            session.removeAttribute("adminName");
            session.removeAttribute("adminemail");
            session.removeAttribute("adminRole");

            session.removeAttribute("role");

            if (Enum_File.CUSTOMER.name().equalsIgnoreCase(role)) {

                session.setAttribute("userId", loginDTO.getUserId());
                session.setAttribute("name", loginDTO.getName());
                session.setAttribute("useremail", loginDTO.getEmail());
                session.setAttribute("role", "CUSTOMER");

                return "redirect:/user/dashboard";
            }

            if (Enum_File.ADMIN.name().equalsIgnoreCase(role)) {

                session.setAttribute("adminUserId", loginDTO.getUserId());
                session.setAttribute("adminName", loginDTO.getName());
                session.setAttribute("adminemail", loginDTO.getEmail());
                session.setAttribute("adminRole", "ADMIN");

                return "redirect:/admin/dashboard";
            }

            model.addAttribute("message", "Invalid user role.");
            return "auth/login";

        } catch (LoginException e) {
            model.addAttribute("message", e.getMessage());
            return "auth/login";
        }
    }

    // FORGOT PASSWORD PAGE
    @GetMapping("/forgotpassword")
    public String forgotPassword() {
        return "auth/forgotpassword";
    }

    // SEND OTP
    @PostMapping("/sendOtp")
    public String sendOtp(
            @RequestParam String email,
            HttpSession session) {

        if (email == null || email.isBlank()) {
            throw new UserNotFoundException("Email is required.");
        }

        User_Entity user = authService.findByEmail(email);

        if (user == null) {
            throw new UserNotFoundException(
                    "No account found with this email."
            );
        }

        String otp = OTPGenerator.generateOTP();

        emailService.sendOtp(user.getEmail(), otp);

        session.setAttribute("otp", otp);
        session.setAttribute("email", email);

        return "auth/verifyotp";
    }

    // VERIFY OTP
    @PostMapping("/verifyOtp")
    public String verifyOtp(
            @RequestParam String otp,
            HttpSession session) {

        String sessionOtp = (String) session.getAttribute("otp");

        if (sessionOtp == null) {
            throw new InvalidOtpException(
                    "OTP has expired. Please request a new OTP."
            );
        }

        if (otp == null || otp.isBlank()) {
            throw new InvalidOtpException("Please enter OTP.");
        }

        if (!sessionOtp.equals(otp)) {
            throw new InvalidOtpException(
                    "Invalid OTP. Please enter the correct OTP."
            );
        }

        return "auth/resetpassword";
    }

    // RESET PASSWORD
    @PostMapping("/resetPassword")
    public String resetPassword(
            @RequestParam String password,
            @RequestParam String confirmPassword,
            HttpSession session) {

        if (password == null || password.isBlank()) {
            throw new PasswordMismatchException(
                    "Password is required."
            );
        }

        if (confirmPassword == null || confirmPassword.isBlank()) {
            throw new PasswordMismatchException(
                    "Confirm Password is required."
            );
        }

        if (!password.equals(confirmPassword)) {
            throw new PasswordMismatchException(
                    "Password and Confirm Password do not match."
            );
        }

        String email = (String) session.getAttribute("email");

        if (email == null || email.isBlank()) {
            throw new UserNotFoundException(
                    "Session expired. Please restart the password reset process."
            );
        }

        authService.updatePassword(email, password);

        session.removeAttribute("otp");
        session.removeAttribute("email");

        return "redirect:/auth/login";
    }

    // UPDATE USER PROFILE
    @PostMapping("/updateUser_Logic")
    public String updateUser_Logic(
            @ModelAttribute User_Dto dto,
            RedirectAttributes redirectAttributes) {

        try {
            authService.updateUser(dto);

            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "User updated successfully"
            );

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    e.getMessage()
            );
        }

        return "redirect:/user/profile";
    }
}