// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supaone/app/controllers/auth_controller.dart';
import 'package:supaone/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              controller: controller.emailC,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: "email",
                hintText: "Masukkan email anda",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => TextField(
                obscureText: controller.isHidden.value,
                controller: controller.passC,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "password",
                  hintText: "Masukkan password anda",
                  suffixIcon: IconButton(
                    onPressed: () => controller.isHidden.toggle(),
                    icon: controller.isHidden.isTrue
                        ? Icon(
                            Icons.remove_red_eye,
                          )
                        : Icon(
                            Icons.remove_red_eye_outlined,
                          ),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoad.isFalse) {
                    //eks loading
                    bool? cek = await controller.login();
                    if (cek != null && cek == true) {
                      authC.autoLog();
                      Get.offAllNamed(
                        Routes.HOME,
                      );
                    }
                  }
                },
                child: Text(
                  controller.isLoad.isFalse ? "Masuk" : 'Loading...',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Belum punya akun ?",
                ),
                SizedBox(
                  width: 5,
                ),
                TextButton(
                  onPressed: () => Get.offAllNamed(
                    Routes.REGISTER,
                  ),
                  child: Text(
                    "Daftar",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
