import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hanger/constants/app_images.dart';
import 'package:image_picker/image_picker.dart';


class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  dynamic _image1;
  dynamic _image2;
  final ImagePicker _picker = ImagePicker();

  late final TextEditingController _itemNameController;
  late final TextEditingController _brandController;
  late final TextEditingController _purchaseLinkController;

  String? _selectedColour;
  String? _selectedCategory;

  bool _isListedForSale = false;

  final List<String> _dummyGallery = [
    AppImages.photo,
    AppImages.photo1,
    AppImages.photo2,
    AppImages.photo3,
    AppImages.photo4,
    AppImages.photo5,
    AppImages.photo6,
    AppImages.photo7,
    AppImages.photo8,
    AppImages.photo9,
    AppImages.photo10,
    AppImages.photo11,
    AppImages.photo12,
    AppImages.photo13,
    AppImages.photo14,
    AppImages.photo15,
    AppImages.photo16,
    AppImages.photo17,
    AppImages.photo18,
    AppImages.photo19,
    
  ];

  final List<String> _categories = [
    'Tops', 'Bottoms', 'Outerwear', 'Shoes', 'Accessories', 'Eyewear', 'Headwear'
  ];

  final List<Map<String, dynamic>> _colours = [
    {'name': 'White', 'color': Colors.white},
    {'name': 'Black', 'color': Colors.black},
    {'name': 'Brown', 'color': Colors.brown},
    {'name': 'Red', 'color': Colors.red},
    {'name': 'Green', 'color': Colors.green},
    {'name': 'Blue', 'color': Colors.blue},
    {'name': 'Yellow', 'color': Colors.yellow},
    {'name': 'Purple', 'color': Colors.purple},
    {'name': 'Orange', 'color': Colors.orange},
    {'name': 'Pink', 'color': Colors.pink},
    {'name': 'Teal', 'color': Colors.teal},
    {'name': 'Grey', 'color': Colors.grey},
  ];

  @override
  void initState() {
    super.initState();
    _itemNameController = TextEditingController();
    _brandController = TextEditingController();
    _purchaseLinkController = TextEditingController();
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _brandController.dispose();
    _purchaseLinkController.dispose();
    super.dispose();
  }


  void _showCustomGallery(int imageIndex) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.65, // Screen ka 65% hissa
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Photos", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.close, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: GridView.builder(
                    itemCount: _dummyGallery.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Ek line mein 3 pictures
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                      childAspectRatio: 1, // Square shape
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (imageIndex == 1) {
                              _image1 = _dummyGallery[index];
                            } else {
                              _image2 = _dummyGallery[index];
                            }
                          });
                          Get.back(); 
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.asset(
                            _dummyGallery[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  void _showImagePicker(int imageIndex) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Add photo", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.photo_library_outlined, color: Colors.black),
                title: Text("Choose from library", style: TextStyle(fontSize: 16.sp)),
                onTap: () {
                  Get.back(); 
                  _showCustomGallery(imageIndex); 
                },
              ),
              
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.camera_alt_outlined, color: Colors.black),
                title: Text("Take a photo", style: TextStyle(fontSize: 16.sp)),
                onTap: () async {
                  Get.back();
                  final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() {
                      if (imageIndex == 1) _image1 = File(image.path);
                      else _image2 = File(image.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }


  void _showColourSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Colour", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  InkWell(onTap: () => Get.back(), child: const Icon(Icons.close, color: Colors.black)),
                ],
              ),
              SizedBox(height: 20.h),
              Wrap(
                spacing: 15.w,
                runSpacing: 15.h,
                children: _colours.map((colorData) {
                  return InkWell(
                    onTap: () {
                      setState(() { _selectedColour = colorData['name']; });
                      Get.back();
                    },
                    child: Container(
                      width: 70.w,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 24.w, height: 24.w,
                            decoration: BoxDecoration(
                              color: colorData['color'],
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black12),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(colorData['name'], style: TextStyle(fontSize: 12.sp)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }

  void _showCategorySheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Category", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  InkWell(onTap: () => Get.back(), child: const Icon(Icons.close, color: Colors.black)),
                ],
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(_categories[index], style: TextStyle(fontSize: 16.sp)),
                      onTap: () {
                        setState(() { _selectedCategory = _categories[index]; });
                        Get.back();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 20.w, bottom: 20.h, right: 20.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  SizedBox(width: 20.w),
                  Text("Add item", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
                ],
              ),
            ),

            // Form Area
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildImagePickerBox(image: _image1, onTap: () => _showImagePicker(1)),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: _buildImagePickerBox(image: _image2, onTap: () => _showImagePicker(2)),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),

                    // Inputs
                    _buildTextField(controller: _itemNameController, hintText: "Item name"),
                    
                    InkWell(
                      onTap: _showColourSheet,
                      child: IgnorePointer(
                        child: _buildTextField(
                          controller: TextEditingController(text: _selectedColour),
                          hintText: "Colour",
                          suffixIcon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: _showCategorySheet,
                      child: IgnorePointer(
                        child: _buildTextField(
                          controller: TextEditingController(text: _selectedCategory),
                          hintText: "Category",
                          suffixIcon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                        ),
                      ),
                    ),

                    _buildTextField(controller: _brandController, hintText: "Brand"),
                    _buildTextField(controller: _purchaseLinkController, hintText: "Purchase link"),

                    SizedBox(height: 20.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Listed for sale/charity", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
                            SizedBox(height: 4.h),
                            Text("See the rules behind this", style: TextStyle(fontSize: 12.sp, color: Colors.grey, decoration: TextDecoration.underline)),
                          ],
                        ),
                        CupertinoSwitch(
                          value: _isListedForSale,
                          activeColor: Colors.black,
                          onChanged: (value) {
                            setState(() { _isListedForSale = value; });
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 40.h),

                    InkWell(
                      onTap: () {
                        Get.back(); 
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
                          "Hang up",
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

  Widget _buildImagePickerBox({required dynamic image, required VoidCallback onTap}) {
    ImageProvider? imageProvider;
    if (image is String) {
      imageProvider = AssetImage(image); 
    } else if (image is File) {
      imageProvider = FileImage(image); 
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15.r),
          image: imageProvider != null
              ? DecorationImage(image: imageProvider, fit: BoxFit.cover)
              : null,
        ),
        child: imageProvider == null
            ? const Center(child: Icon(Icons.add, color: Colors.black, size: 30))
            : null,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller, 
    required String hintText,
    Widget? suffixIcon,
  }) {
    return SizedBox(
      height: 50.h,
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 14.sp, color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black54, fontSize: 14.sp),
          suffixIcon: suffixIcon,
          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        ),
      ),
    );
  }
}