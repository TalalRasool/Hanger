import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        CameraDescription? selectedCamera;
        for (var camera in cameras) {
          if (camera.lensDirection == CameraLensDirection.front) {
            selectedCamera = camera;
            break;
          }
        }
        
        selectedCamera ??= cameras.first;

        _cameraController = CameraController(
          selectedCamera,
          ResolutionPreset.high,
          enableAudio: false,
        );

        await _cameraController!.initialize();

        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close, color: Colors.black),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Icon(Icons.flash_on_outlined, color: Colors.black),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: _isCameraInitialized
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: CameraPreview(_cameraController!),
                      )
                    : const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.h, top: 10.h),
              child: Column(
                children: [
                  Text("Snap it", style: TextStyle(fontSize: 14.sp, color: Colors.black)),
                  SizedBox(height: 15.h),
                  InkWell(
                    onTap: () async {
                      if (_isCameraInitialized && _cameraController != null) {
                        try {
                          final image = await _cameraController!.takePicture();
                          Get.back(result: image.path);
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      }
                    },
                    child: Container(
                      height: 70.w,
                      width: 70.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade400, width: 2),
                      ),
                      child: Center(
                        child: Container(
                          height: 55.w,
                          width: 55.w,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}