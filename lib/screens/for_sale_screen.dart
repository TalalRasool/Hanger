import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hanger/constants/app_images.dart'; 
import 'package:hanger/screens/item_detail_screen.dart';

class ForSaleScreen extends StatelessWidget {
  const ForSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> _forSaleItems = [
      {
        'image': AppImages.photo1, 
        'name': 'Essential Brown Tee',
        'brand': 'Fear of God'
      },
      {
        'image': AppImages.photo2,
        'name': 'Black Puffer Jacket',
        'brand': 'The North Face'
      },
    ];

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
                    "For sale", 
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            Expanded(
              child: _forSaleItems.isEmpty
                  ? Center(
                      child: Text(
                        "No items listed for sale yet.",
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      ),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, 
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 20.h,
                        childAspectRatio: 0.75, 
                      ),
                      itemCount: _forSaleItems.length,
                      itemBuilder: (context, index) {
                        final item = _forSaleItems[index];
                        return InkWell(
                          onTap: () {
                            Get.to(() => const ItemDetailScreen());
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.r),
                                    child: Image.asset(
                                      item['image']!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => 
                                          const Icon(Icons.image_not_supported, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                item['name']!,
                                style: TextStyle(
                                  fontSize: 14.sp, 
                                  fontWeight: FontWeight.w600, 
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                item['brand']!,
                                style: TextStyle(
                                  fontSize: 12.sp, 
                                  color: Colors.grey.shade600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}