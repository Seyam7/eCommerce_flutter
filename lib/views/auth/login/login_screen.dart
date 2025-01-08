import 'package:e_commerce_flutter/controllers/auth_controller.dart';
import 'package:e_commerce_flutter/views/auth/register/register_screen.dart';
import 'package:e_commerce_flutter/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: controller.loginKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.emailController,
                validator: (value){
                  if(value!.isEmpty){
                    return 'This field can not be empty';
                  }
                },
                decoration: InputDecoration(hintText: 'Email'),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.passwordController,
                validator: (value){
                  if(value!.isEmpty){
                    return 'This field can not be empty';
                  }
                },
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(
                height: 10,
              ),
              Obx((){
                return ElevatedButton(
                  onPressed: () {
                    controller.login();
                  },
                  child: Text(controller.isLoading.value? 'Loading...':'Login',),
                );
              }),
              TextButton(
                onPressed: () {
                  Get.to(()=>RegisterScreen());
                },
                child: Text('Register',),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
