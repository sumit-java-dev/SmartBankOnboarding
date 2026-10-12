# SmartBank Onboarding

A Spring MVC web application for customer onboarding, manual KYC review, and bank account creation.

## Features

- Customer registration and login with BCrypt password hashing and HTTP sessions.
- Separate customer and admin dashboards.
- KYC submission with personal details, Aadhaar/PAN document uploads, and face-video capture.
- Admin approval, rejection, and correction requests with field-specific feedback.
- Customer status tracking and correction resubmission.
- Account creation for approved customers and display of account number, type, branch, IFSC, balance, and status.
- Profile updates and MySQL persistence through Spring Data JPA and Hibernate.

Documents and face videos are reviewed manually; this application does not integrate with official identity verification services or perform automated face recognition. Email OTP/password-reset code is included, but end-to-end email testing is pending. This is a learning/demo application, not a production banking service.

## Stack

Java 17+ (also run locally with Java 21), Spring Boot 4.0.7, Spring MVC, JSP/JSTL, Spring Data JPA, Hibernate, MySQL, Maven, Lombok, ModelMapper, and Spring Mail. Maven builds a WAR file. The frontend uses JSP; authentication uses sessions.

## Local setup

1. Install a compatible JDK and MySQL. In MySQL, create the database:

   ```sql
   CREATE DATABASE IF NOT EXISTS smartbankdb;
   ```

2. Set environment variables. In Windows PowerShell:

   ```powershell
   $env:DB_USERNAME = "root"
   $env:DB_PASSWORD = "YOUR_LOCAL_MYSQL_PASSWORD"
   # Optional: override the default localhost database connection.
   # $env:DB_URL = "jdbc:mysql://localhost:3306/smartbankdb?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
   # Required only when testing email delivery:
   # $env:MAIL_USERNAME = "YOUR_EMAIL"
   # $env:MAIL_PASSWORD = "YOUR_MAIL_APP_PASSWORD"
   .\mvnw.cmd spring-boot:run
   ```

   On Linux/macOS, export the same variables and run `./mvnw spring-boot:run`.
   The application does not automatically load `.env` files.

3. Open http://localhost:8787/auth/register or http://localhost:8787/auth/login.
   Hibernate updates the local schema through `spring.jpa.hibernate.ddl-auto=update`.

### Eclipse

Import as an Existing Maven Project and configure Lombok in Eclipse if required. Add the environment variables under Run Configurations > Environment, then run `SmartBankOnboardingApplication` as a Java/Spring Boot application.

### Local demo admin

Registration creates CUSTOMER users. For local demonstration, register a separate demo user and promote only that user in your local database:

```sql
UPDATE `user` SET role = 'ADMIN' WHERE email = 'admin@example.com';
```

Log out and log back in after the update. Use fictitious data and test documents.

## Build

```powershell
.\mvnw.cmd clean package -DskipTests
```

The default context-load test needs a configured database. A build with `-DskipTests` does not verify application behavior.

## Source structure

- `controller`: request handling and view navigation.
- `service`: business logic.
- `repository`: database access.
- `entity` / `dto`: persistence models and transfer objects.
- `Config`, `aop`, `util`, `exception`: configuration and shared functionality.
- `src/main/webapp/WEB-INF/views`: JSP pages.

## Data and credentials

Database and mail credentials are supplied through environment variables. Runtime uploads are stored in the working directory's `uploads` folder and excluded from Git. Do not publish real customer records, identity documents, videos, database dumps, or local credentials.
