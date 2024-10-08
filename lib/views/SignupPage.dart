// signup_page.dart
import 'dart:ui';
import 'package:audio_player_/controller/SignupController.dart';
import 'package:audio_player_/views/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (context) => SignupController(),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              child: Container(
                height: height,
                width: width,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/office_girl.jpg',
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Consumer<SignupController>(
              builder: (context, controller, child) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Create Account",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(height: height * 0.02),
                              const Text(
                                "Please fill in the details to create an account",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              SizedBox(height: height * 0.02),
                              const Text(
                                "Full Name",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(height: height * 0.01),
                              TextField(
                                controller: controller.fullNameController,
                                decoration: InputDecoration(
                                  hintText: "Enter your full name",
                                  filled: true,
                                  fillColor: Colors.white24,
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.black),
                              ),
                              SizedBox(height: height * 0.025),
                              const Text(
                                "Email",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(height: height * 0.01),
                              TextField(
                                controller: controller.emailController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white24,
                                  hintText: "example@gmail.com",
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.black),
                              ),
                              SizedBox(height: height * 0.025),
                              const Text(
                                "Password",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(height: height * 0.01),
                              TextField(
                                controller: controller.passwordController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white24,
                                  hintText: "must be 8 characters",
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      controller.togglePasswordVisibility();
                                    },
                                  ),
                                ),
                                style: const TextStyle(color: Colors.black),
                                obscureText: !controller.isPasswordVisible,
                              ),
                              SizedBox(height: height * 0.025),
                              const Text(
                                "Confirm Password",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(height: height * 0.01),
                              TextField(
                                controller:
                                    controller.confirmPasswordController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white24,
                                  hintText: "Re-enter your password",
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.isConfirmPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      controller
                                          .toggleConfirmPasswordVisibility();
                                    },
                                  ),
                                ),
                                style: const TextStyle(color: Colors.black),
                                obscureText:
                                    !controller.isConfirmPasswordVisible,
                              ),
                              SizedBox(height: height * 0.025),
                              InkWell(
                                onTap: (){
                                  controller.signUp(context);
                                },
                                child: Container(
                                  height: height * 0.08,
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.orangeAccent,
                                  ),
                                  child: controller.isLoading
                                      ? const Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                      )
                                      : const Center(child: Text("Create Account",style:  TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                          color: Colors.black,
                                        ),)),
                                ),
                              ),
                              SizedBox(height: height * 0.015),

                              Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account? ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          LoginPage(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var begin = const Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                        var curve = Curves.ease;

                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));

                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
