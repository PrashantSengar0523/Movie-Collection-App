import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/constants/form_validation.dart';
import 'package:my_app/controllers/signup_controller.dart';
import 'package:my_app/login&Signup/login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              image: DecorationImage(
                image: const CachedNetworkImageProvider(
                    'https://i.postimg.cc/W46TCLY3/movie.jpg'), // Replace with your image path
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), // Adjust opacity here
                  BlendMode.darken,
                ),
              ),
            ),
            child: const Stack(
              children: [
                Center(
                  child: Text(
                    "",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24.0, left: 24.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.firstName,
                          validator: (value) => FormValidator.validateRequiredField(value!, 'firstName'),
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            prefixIcon: Icon(Icons.person, color: Colors.black54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: controller.lastName,
                          validator: (value) => FormValidator.validateRequiredField(value!, 'lastName'),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person, color: Colors.black54),
                            labelText: 'Last Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: controller.email,
                    validator: (value) => FormValidator.validateEmail(value!),
                    decoration: const InputDecoration(
                      prefixIcon:
                          Icon(Icons.email_rounded, color: Colors.black54),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: false,
                    controller: controller.password,
                    validator: (value) => FormValidator.validatePassword(value!),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black54,
                      ),
                      suffixIcon: Icon(Icons.remove_red_eye_rounded,
                          color: Colors.black54),
                      labelText: 'Create Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: controller.phone,
                    validator: (value) => FormValidator.validatePhoneNumber(value!),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone, color: Colors.black54),
                      labelText: 'Phone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.redAccent),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        side: MaterialStateProperty.all<BorderSide>(
                            BorderSide.none),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          controller.registerUser();
                        }
                      },
                      child: const Text('Create Account'),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://i.postimg.cc/nzwtX2VK/icons8-phone-50.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://i.postimg.cc/pLrmmGBr/google-icon.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LoginScreen()), // Replace NextScreen with your actual screen widget
                          );
                        },
                        child: const Text(
                          " Login in",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
