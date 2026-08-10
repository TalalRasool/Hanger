import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hanger/constants/app_images.dart'; // Aapke AppImages ka path

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                children: [
                  // Profile Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r), // Halkay se gol kinare
                    child: Image.asset(
                      AppImages.main, // Aapki request ke mutabiq
                      width: 50.w,
                      height: 50.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  
                  // Name & Handle
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jamain Gordon",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "@Jamain",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  
                  const Spacer(), // Baqi space fill karne ke liye
                  
                  // Top Menu Icon
                  Icon(
                    Icons.menu,
                    size: 28.sp,
                    color: Colors.black,
                  ),
                ],
              ),
            ),

            // 2. Center Body
            Expanded(
              child: Center(
                child: Text(
                  "Don't leave us hanging.\nTap + to stock your closet.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    height: 1.5, // Line ke darmiyan spacing
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
          padding: EdgeInsets.symmetric(vertical: 15.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r), // Rounded edges
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.9), // Halka sa shadow
                blurRadius: 15,
                spreadRadius: 1,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Icons barabar distance par
            children: [
              InkWell(
                onTap: () {},
                child: Icon(Icons.home_outlined, size: 28.sp, color: Colors.black),
              ),
              InkWell(
                onTap: () {},
                child: Icon(Icons.search, size: 28.sp, color: Colors.black),
              ),
              InkWell(
                onTap: () {},
                child: Icon(Icons.add_box_outlined, size: 28.sp, color: Colors.black),
              ),
              InkWell(
                onTap: () {},
                child: Icon(Icons.local_offer_outlined, size: 28.sp, color: Colors.black), // Tag Icon
              ),
              InkWell(
                onTap: () {},
                child: Icon(Icons.menu, size: 28.sp, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}