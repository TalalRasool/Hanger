import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hanger/constants/app_images.dart';
import 'package:hanger/routes/routes_names.dart'; 

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 20.w, bottom: 15.h, right: 20.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  SizedBox(width: 20.w),
                  Text(
                    "Yeezy Boost 350",
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Uploaded: Aug 13, 2026",
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500),
                    ),
                    SizedBox(height: 15.h),

                    Container(
                      width: double.infinity,
                      height: 380.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Image.asset(
                          AppImages.photo, 
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => 
                              const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),

                    Row(
                      children: [
                        Expanded(child: _buildDetailItem("Brand", "Adidas")),
                        Expanded(child: _buildDetailItem("Size", "UK 9 / US 9.5")),
                      ],
                    ),
                    SizedBox(height: 25.h),
                    Row(
                      children: [
                        Expanded(child: _buildColorDetail("Colour", "Black", Colors.black)),
                        Expanded(child: _buildDetailItem("Category", "Shoes")),
                      ],
                    ),
                    SizedBox(height: 25.h),

                    _buildDetailItem("Purchase link", "www.adidas.com/yeezy", isLink: true),
                    SizedBox(height: 35.h),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Listed for sale/charity",
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                          Icon(Icons.check_circle, color: Colors.green, size: 24.sp), 
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),

                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.additem); 
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          "Edit item",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value, {bool isLink = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500),
        ),
        SizedBox(height: 5.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp, 
            fontWeight: FontWeight.w600, 
            color: isLink ? Colors.blue : Colors.black,
            decoration: isLink ? TextDecoration.underline : TextDecoration.none,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildColorDetail(String title, String colorName, Color colorValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500),
        ),
        SizedBox(height: 5.h),
        Row(
          children: [
            Container(
              width: 16.w,
              height: 16.w,
              decoration: BoxDecoration(
                color: colorValue,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              colorName,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}