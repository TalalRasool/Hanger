
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hanger/routes/routes_names.dart';


class EditPersonalInfoScreen extends StatefulWidget {
  const EditPersonalInfoScreen({super.key});

  @override
  State<EditPersonalInfoScreen> createState() => _EditPersonalInfoScreenState();
}

class _EditPersonalInfoScreenState extends State<EditPersonalInfoScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _shopController;
  late final TextEditingController _deleteConfirmController; 

  String? _selectedLocation;
  DateTime? _selectedDate;

  final List<String> _locations = [
    'London, UK',
    'New York, USA',
    'Paris, France',
    'Tokyo, Japan',
    'Sydney, Australia',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "Jamain Gordon");
    _usernameController = TextEditingController(text: "Jamain");
    _emailController = TextEditingController(text: "email@testing.com");
    _shopController = TextEditingController();
    _deleteConfirmController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _shopController.dispose();
    _deleteConfirmController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black, 
              onPrimary: Colors.white, 
              onSurface: Colors.black, 
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showDeleteAccountModal() {
    _deleteConfirmController.clear();
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          title: Text(
            "Type DELETE to confirm. This will permanently remove your profile and wipe your wardrobe history. We'll be sad to see you go!",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          content: TextField(
            controller: _deleteConfirmController,
            decoration: InputDecoration(
              hintText: "Type here...",
              hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black54),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: EdgeInsets.only(bottom: 20.h, left: 15.w, right: 15.w),
          actions: [
            Column(
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    width: double.infinity,
                    height: 45.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      "Actually! I'll stay",
                      style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () {
                    if (_deleteConfirmController.text == "DELETE") {
                      Get.back(); 
                      Get.offAllNamed(AppRoutes.welcome); 
                    } else {
                      Get.snackbar("Error", "Please type exactly 'DELETE' to confirm.", 
                        backgroundColor: Colors.redAccent, colorText: Colors.white);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      "Delete",
                      style: TextStyle(color: Colors.red, fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 20.w, bottom: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Personal information",
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
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
                    Center(
                      child: InkWell(
                        onTap: () {
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                width: 100.w,
                                height: 100.w,
                                color: Colors.grey.shade300,
                                // child: Image.asset(AppImages.photo),
                              ),
                              Container(
                                width: 100.w,
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                child: Text(
                                  "Change photo",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    _buildTextField(controller: _nameController, hintText: "Full name"),
                    _buildTextField(controller: _usernameController, hintText: "Username"),
                    _buildTextField(controller: _emailController, hintText: "Email"),
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: IgnorePointer(
                        child: _buildTextField(
                          controller: TextEditingController(
                            text: _selectedDate == null 
                                ? "" 
                                : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                          ),
                          hintText: "Date of birth",
                          suffixIcon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                        ),
                      ),
                    ),

                    // Location Dropdown
                    SizedBox(
                      height: 50.h,
                      child: DropdownButtonFormField<String>(
                        value: _selectedLocation,
                        hint: Text("Location", style: TextStyle(color: Colors.black, fontSize: 14.sp)),
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        items: _locations.map((String location) {
                          return DropdownMenuItem<String>(
                            value: location,
                            child: Text(location, style: TextStyle(fontSize: 14.sp)),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLocation = newValue;
                          });
                        },
                      ),
                    ),

                    _buildTextField(controller: _shopController, hintText: "What's your favourite place to shop"),

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
                          "Save changes",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Center(
                      child: InkWell(
                        onTap: _showDeleteAccountModal,
                        child: Text(
                          "Delete account",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
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
          hintStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
          suffixIcon: suffixIcon,
          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        ),
      ),
    );
  }
}