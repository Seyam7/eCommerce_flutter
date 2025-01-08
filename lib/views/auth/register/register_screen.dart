import 'package:e_commerce_flutter/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.phoneController,
                decoration: InputDecoration(hintText: 'Phone'),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.confirmPassController,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Confirm Password'),
              ),
              SizedBox(
                height: 10,
              ),
              Obx((){
                return ElevatedButton(
                  onPressed: () {
                    controller.register();
                  },
                  child: Text(controller.isLoading.value? 'Loading...' : 'Register'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
