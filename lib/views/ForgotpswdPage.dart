import 'dart:ui';
import 'package:audio_player_/controller/FrogotPasswordController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (context) => ForgotPasswordController(),
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
            Consumer<ForgotPasswordController>(
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
                              "Forgot Password",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: height * 0.02),
                            const Text(
                              "Enter your email to reset your password",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            SizedBox(height: height * 0.02),
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
                                hintText: "example@gmail.com",
                                filled: true,
                                fillColor: Colors.white24,
                                hintStyle: const TextStyle(color: Colors.black),
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
                            if (controller.errorMessage.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  controller.errorMessage,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            SizedBox(height: height * 0.025),
                          ],
                        ),
                        controller.isLoading
                            ? const CircularProgressIndicator()
                            : InkWell(
                                onTap: () {
                                  controller.sendPasswordResetEmail(context);
                                },
                                child: Container(
                                  height: height * 0.08,
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.orangeAccent,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Send Reset Link",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(height: height * 0.038),
                        const Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.white,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "or",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.white,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Back to Login",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
