import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_flutter/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController{
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

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
        Get.offAll(()=>HomeScreen());

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
        await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        ).then((userC)async{
          //create data
          //doc(user.user!.email); this the alternate way, 1set user is model 2nd user id the current active user
          await _fireStore.collection('users').doc(emailController.text).set({
            'name' : nameController.text,
            'phone' : phoneController.text,
            'email' : emailController.text,
            'password' : passwordController.text
          });
          Get.snackbar('Success', 'Your account has been created');

          Get.offAll(()=>HomeScreen());
        });

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