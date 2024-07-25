import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/constants/form_validation.dart';
import 'package:my_app/controllers/login_controller.dart';
import 'package:my_app/login&Signup/forgot_password_screen.dart';
import 'package:my_app/login&Signup/signup_screen.dart';

import '../controllers/google_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final googleController = Get.put(GoogleSignInController());
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(right: 24.0, left: 24.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const Text(
                "Welcome Back !",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 2),
              const Text(
                "Immerse yourself in a world of cinematic delights and effortless movie selection.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: controller.email,
                validator: (email) => FormValidator.validateEmail(email!),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                controller: controller.password,
                validator: (value) => FormValidator.validatePassword(value!),
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.lock,
                    color: Colors.black54,
                  ),
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ForgotPasswordScreen());
                    },
                    child: const Text(
                      "Forgot Password",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.redAccent),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.redAccent),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      LoginController.instance.loginUser(controller.email.text.trim(),
                          controller.password.text.trim());
                      controller.email.clear();
                      controller.password.clear();
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.black38,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Or Sign In with",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black38,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://i.postimg.cc/nzwtX2VK/icons8-phone-50.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      googleController.signInWithGoogle();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: 'https://i.postimg.cc/pLrmmGBr/google-icon.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SignupScreen()), // Replace NextScreen with your actual screen widget
                        );
                      },
                      child: const Text(
                        " Register now",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
