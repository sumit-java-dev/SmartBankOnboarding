<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Digital Account Gateway | Create Account</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: #eef3fb;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
            overflow-x: hidden;
        }

        .container {
            width: 1180px;
            max-width: 100%;
            max-height: 90vh;
            background: #fff;
            border-radius: 28px;
            overflow: hidden;
            display: flex;
            box-shadow: 0 25px 60px rgba(0, 0, 0, .15);
        }

        .left-panel {
            width: 38%;
            background: linear-gradient(180deg, #12448b, #1565d8, #16a9d6);
            color: #fff;
            padding: 60px 45px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .logo {
            width: 80px;
            height: 80px;
            background: rgba(255, 255, 255, .15);
            border-radius: 18px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 34px;
            margin-bottom: 30px;
        }

        .left-panel h1 {
            font-size: 25px;
            font-weight: 700;
            line-height: 1.2;
            margin-bottom: 20px;
        }

        .left-panel p {
            font-size: 17px;
            line-height: 30px;
            opacity: .95;
            margin-bottom: 40px;
        }

        .features {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        .feature {
            display: flex;
            align-items: center;
            gap: 15px;
            font-size: 17px;
            font-weight: 500;
        }

        .feature i {
            font-size: 20px;
        }

        .right-panel {
            width: 62%;
            padding: 45px 55px;
            background: #fff;
            overflow-y: auto;
            max-height: 90vh;
        }

        .title {
            text-align: center;
            margin-bottom: 30px;
        }

        .title h2 {
            font-size: 38px;
            color: #11408a;
            font-weight: 700;
        }

        .title p {
            margin-top: 8px;
            color: #666;
            font-size: 15px;
        }

        .row {
            display: flex;
            gap: 20px;
        }

        .input-group {
            flex: 1;
            min-width: 0;
            margin-bottom: 18px;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 15px;
            font-weight: 600;
            color: #333;
        }

        .input-group input {
            width: 100%;
            height: 45px;
            border: 1px solid #d9d9d9;
            border-radius: 12px;
            padding: 0 16px;
            font-size: 15px;
            transition: .3s;
            outline: none;
            background: #fff;
        }

        .input-group input:focus {
            border-color: #1565d8;
            box-shadow: 0 0 0 4px rgba(21, 101, 216, .15);
        }

        .password-box {
            position: relative;
        }

        .password-box input {
            padding-right: 45px;
        }

        .password-box i {
            position: absolute;
            right: 18px;
            top: 15px;
            color: #777;
            cursor: pointer;
        }

        .error-msg {
            background: #fde2e2;
            color: #d8000c;
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }

        small.error {
            color: #dc3545;
            display: block;
            margin-top: 5px;
            font-size: 13px;
            font-weight: 500;
        }

        input.error {
            border-color: #dc3545 !important;
        }

        input.valid {
            border-color: #28a745 !important;
        }

        .register-btn {
            width: 100%;
            height: 55px;
            border: none;
            border-radius: 12px;
            background: #1565d8;
            color: #fff;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: .3s;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-top: 8px;
        }

        .register-btn:hover {
            background: #114cb3;
            transform: translateY(-2px);
        }

        .register-btn:disabled {
            opacity: .7;
            cursor: wait;
        }

        .loader {
            width: 18px;
            height: 18px;
            border: 3px solid rgba(255, 255, 255, .4);
            border-top: 3px solid white;
            border-radius: 50%;
            display: none;
            animation: spin .8s linear infinite;
        }

        @keyframes spin {
            100% {
                transform: rotate(360deg);
            }
        }

        .login-link {
            margin-top: 22px;
            text-align: center;
            font-size: 15px;
            color: #555;
        }

        .login-link a {
            text-decoration: none;
            color: #1565d8;
            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .right-panel::-webkit-scrollbar {
            width: 8px;
        }

        .right-panel::-webkit-scrollbar-thumb {
            background: #1565d8;
            border-radius: 20px;
        }

        .right-panel::-webkit-scrollbar-track {
            background: #eee;
        }

        @media (max-width: 991px) {
            .container {
                flex-direction: column;
            }

            .left-panel,
            .right-panel {
                width: 100%;
            }

            .left-panel {
                padding: 45px 30px;
            }

            .right-panel {
                padding: 35px 25px;
                max-height: none;
            }

            .row {
                flex-direction: column;
                gap: 0;
            }

            .title h2 {
                font-size: 30px;
            }
        }

        @media (max-width: 576px) {
            body {
                padding: 15px;
                align-items: flex-start;
            }

            .container {
                border-radius: 20px;
            }

            .left-panel {
                padding: 25px 20px;
                text-align: center;
            }

            .logo {
                width: 55px;
                height: 55px;
                font-size: 24px;
                margin: 0 auto 18px;
            }

            .left-panel h1 {
                font-size: 22px;
            }

            .left-panel p,
            .features {
                display: none;
            }

            .right-panel {
                padding: 25px 18px;
            }

            .title h2 {
                font-size: 26px;
            }

            .title p,
            .login-link {
                font-size: 12px;
            }

            .input-group input {
                height: 44px;
                font-size: 13px;
            }

            .register-btn {
                height: 48px;
                font-size: 15px;
            }
        }
    </style>
</head>

<body>
    <div class="container">

        <div class="left-panel">
            <div class="logo">
                <i class="fa-solid fa-building-columns"></i>
            </div>

            <h1>Join <br> Digital Account Gateway</h1>

            <p>
                Start your digital banking journey.<br>
                Create your account securely and access
                Digital Account Gateway services.
            </p>

            <div class="features">
                <div class="feature">
                    <i class="fa-solid fa-circle-check"></i>
                    Easy Registration
                </div>

                <div class="feature">
                    <i class="fa-solid fa-lock"></i>
                    Secure Banking
                </div>

                <div class="feature">
                    <i class="fa-solid fa-mobile-screen-button"></i>
                    Digital Account Access
                </div>

                <div class="feature">
                    <i class="fa-solid fa-bolt"></i>
                    Fast Services
                </div>

                <div class="feature">
                    <i class="fa-solid fa-headset"></i>
                    24×7 Support
                </div>
            </div>
        </div>

        <div class="right-panel">
            <div class="title">
                <h2>Create Account</h2>
                <p>Register to access Digital Account Gateway</p>
            </div>

            <!-- Server-side registration error -->
            <c:if test="${not empty error}">
                <div class="error-msg" role="alert">
                    <c:out value="${error}" />
                </div>
            </c:if>

            <form id="registerForm"
                  action="${pageContext.request.contextPath}/auth/register"
                  method="post">

                <div class="row">
                    <div class="input-group">
                        <label for="fullName">Full Name</label>
                        <input type="text"
                               name="name"
                               id="fullName"
                               placeholder="Enter Full Name"
                               autocomplete="name"
                               required
                               minlength="3">
                    </div>

                    <div class="input-group">
                        <label for="email">Email</label>
                        <input type="email"
                               name="email"
                               id="email"
                               placeholder="Enter Email"
                               autocomplete="email"
                               required>
                    </div>
                </div>

                <div class="row">
                    <div class="input-group">
                        <label for="mobile">Mobile Number</label>
                        <input type="text"
                               name="mobile"
                               id="mobile"
                               placeholder="Enter Mobile Number"
                               autocomplete="tel"
                               inputmode="numeric"
                               pattern="[0-9]{10}"
                               minlength="10"
                               maxlength="10"
                               required>
                    </div>
                </div>

                <div class="row">
                    <div class="input-group">
                        <label for="password">Password</label>

                        <div class="password-box">
                            <input type="password"
                                   name="password"
                                   id="password"
                                   placeholder="Enter Password"
                                   autocomplete="new-password"
                                   minlength="6"
                                   required>

                            <i class="fa-solid fa-eye togglePassword"
                               data-target="password"
                               aria-label="Show or hide password"></i>
                        </div>
                    </div>

                    <div class="input-group">
                        <label for="confirmPassword">Confirm Password</label>

                        <div class="password-box">
                            <input type="password"
                                   name="confirmPassword"
                                   id="confirmPassword"
                                   placeholder="Confirm Password"
                                   autocomplete="new-password"
                                   required>

                            <i class="fa-solid fa-eye togglePassword"
                               data-target="confirmPassword"
                               aria-label="Show or hide confirm password"></i>
                        </div>
                    </div>
                </div>

                <button type="submit" class="register-btn">
                    <span class="btn-text">Create Account</span>
                    <span class="loader" aria-hidden="true"></span>
                </button>

                <div class="login-link">
                    Already have an account?
                    <a href="${pageContext.request.contextPath}/auth/login">
                        Login Here
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>

    <script>
        $(document).ready(function () {

            $(".togglePassword").click(function () {
                const target = $("#" + $(this).data("target"));
                const showPassword = target.attr("type") === "password";

                target.attr("type", showPassword ? "text" : "password");

                $(this).toggleClass("fa-eye", !showPassword);
                $(this).toggleClass("fa-eye-slash", showPassword);
            });

            $("#registerForm").validate({
                rules: {
                    name: {
                        required: true,
                        minlength: 3
                    },
                    email: {
                        required: true,
                        email: true
                    },
                    mobile: {
                        required: true,
                        digits: true,
                        minlength: 10,
                        maxlength: 10
                    },
                    password: {
                        required: true,
                        minlength: 6
                    },
                    confirmPassword: {
                        required: true,
                        equalTo: "#password"
                    }
                },

                messages: {
                    name: {
                        required: "Please enter your full name",
                        minlength: "Minimum 3 characters required"
                    },
                    email: {
                        required: "Please enter your email",
                        email: "Enter a valid email"
                    },
                    mobile: {
                        required: "Please enter mobile number",
                        digits: "Only digits allowed",
                        minlength: "Mobile must be 10 digits",
                        maxlength: "Mobile must be 10 digits"
                    },
                    password: {
                        required: "Please enter password",
                        minlength: "Password must be at least 6 characters"
                    },
                    confirmPassword: {
                        required: "Please confirm password",
                        equalTo: "Passwords do not match"
                    }
                },

                errorElement: "small",

                errorPlacement: function (error, element) {
                    error.appendTo(element.closest(".input-group"));
                },

                highlight: function (element) {
                    $(element).addClass("error").removeClass("valid");
                },

                unhighlight: function (element) {
                    $(element).removeClass("error").addClass("valid");
                },

                submitHandler: function (form) {
                    $(".btn-text").text("Creating...");
                    $(".loader").show();
                    $(".register-btn").prop("disabled", true);
                    form.submit();
                }
            });
        });
    </script>
</body>
</html>