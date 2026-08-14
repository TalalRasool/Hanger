import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanger/routes/routes_names.dart';
 
class AuthController extends GetxController {
  var isLoading = false.obs;
 
  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;
 
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
 
      Get.snackbar(
        "Success",
        "Account created successfully!",
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
 
      Get.offAllNamed(AppRoutes.personal);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        _mapAuthError(e),
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to sign up: $e",
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
 
  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
 
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
 
      Get.snackbar(
        "Welcome Back",
        "Logged in successfully!",
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
 
      Get.offAllNamed(AppRoutes.mainScreen);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Login Failed",
        _mapAuthError(e),
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Login Failed",
        "Invalid email or password",
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
 
  Future<void> forgetPassword(String email) async {
    try {
      isLoading.value = true;
 
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
 
      Get.snackbar(
        "Link Sent",
        "Password reset link has been sent to your email.",
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
 
      Get.toNamed(AppRoutes.resetLinkSent, arguments: email);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        _mapAuthError(e),
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Could not send reset link. Please try again.",
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
 
  Future<void> logout() async {
    try {
      isLoading.value = true;
 
      await FirebaseAuth.instance.signOut();
 
      Get.offAllNamed(AppRoutes.signUp);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to logout: $e",
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
 
  // Maps FirebaseAuthException codes to user-friendly messages
  String _mapAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return "The email address is not valid.";
      case 'user-disabled':
        return "This account has been disabled.";
      case 'user-not-found':
        return "No account found with this email.";
      case 'wrong-password':
        return "Incorrect password. Please try again.";
      case 'email-already-in-use':
        return "This email is already registered.";
      case 'weak-password':
        return "Password is too weak.";
      case 'network-request-failed':
        return "Network error. Check your internet connection.";
      default:
        return e.message ?? "Something went wrong. Please try again.";
    }
  }
}
 