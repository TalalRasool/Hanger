import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hanger/constants/app_icon.dart';
import 'package:hanger/constants/app_images.dart';
import 'package:hanger/routes/routes_names.dart';
import 'package:hanger/weidgets/common/common_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordHidden = true; 
  
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              // Top Bar Refactored
              Padding(
                padding: EdgeInsets.only(top: 15.h, left: 20.w, right: 20.w),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(AppIcon.backArrow),
                      ),
                    ),
                    Image.asset(AppImages.container),
                  ],
                ),
              ),
              
              Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: const Center(
                  child: Text(
                    "WELCOME BACK",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              
              SizedBox(height: 10.h),
                            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: const Center(
                  child: Text(
                    "Be the first to join Hanger, sign in your\nway, as easy as tapping 'Add to Cart'",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              
              Center(
                child: Image.asset(
                  AppImages.signin, 
                  height: 300.h,
                  width: 300.w,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Email Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w), 
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Enter email",
                  ),
                ),
              ),
              
              SizedBox(height: 15.h), 
              
              // Password Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _isPasswordHidden, 
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              
              // Sign Up Button
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: commonButton( 
                    text: "sign up",
                    color: Colors.black,
                    width: 350.w, 
                    onPressed: () {
Get.toNamed(AppRoutes.personal);                    }
                  ),
                ),
              ),
              
              SizedBox(height: 15.h),
                            Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  const Text("Have an account? "),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              
              SizedBox(height: 20.h), 
            ],
          ),
        ),
      ),
    );
  }
}