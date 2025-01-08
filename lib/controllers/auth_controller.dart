import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController{
  final _auth = FirebaseAuth.instance;
  final loginKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmPassController = TextEditingController();

  void login()async{
    if(loginKey.currentState!.validate()){

      isLoading.value=true;

      try{
        await _auth.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
        );

      }on FirebaseAuthException catch(error){
        Get.snackbar('Error', error.message!);

      }catch(e){
        print(e);
      }finally{
        isLoading.value=false;
      }
    }
  }

  void register()async{
    if(loginKey.currentState!.validate()){

      isLoading.value=true;

      try{
        final userData = await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Get.snackbar('Seccess', 'Your account has been created');

      }on FirebaseAuthException catch(error){
        Get.snackbar('Error', error.message!);

      }catch(e){
        print(e);
      }finally{
        isLoading.value=false;
      }
    }
  }
}