import 'package:get/get.dart';
import 'package:hanger/routes/routes_names.dart';
import 'package:hanger/screens/ResetLinkSentScreen.dart';
import 'package:hanger/screens/camera_screen.dart';
import 'package:hanger/screens/forgot_password.dart';
import 'package:hanger/screens/main_screen.dart';
import 'package:hanger/screens/personal_screen.dart';
import 'package:hanger/screens/sign_up_screen.dart';
import 'package:hanger/screens/signin_screen.dart';
import 'package:hanger/screens/welcome_screen.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomeScreen(),
      transition: Transition.fadeIn, 
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SigninScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUpScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgetPassword(),
      transition: Transition.rightToLeft,
    ),
GetPage(
  name: AppRoutes.resetLinkSent, 
  page: () => ResetLinkSentScreen(
    email: Get.arguments as String? ?? "user@example.com",
  ),
  transition: Transition.rightToLeft,
),
GetPage(
      name: AppRoutes.mainScreen,
      page: () => const MainScreen(), 
      transition: Transition.rightToLeft, 
    ),
  GetPage(
      name: AppRoutes.personal, 
      page: () => const PersonalInfoScreen(), 
      transition: Transition.rightToLeft,
    ),
    GetPage(name: AppRoutes.camera, page: () => const CameraScreen(), transition: Transition.rightToLeft),
     /*
    GetPage(
      name: AppRoutes.personal,
      page: () => const PersonalScreen(),
      transition: Transition.rightToLeft,
    ),
    */
  ];
}