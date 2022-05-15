// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supaone/app/routes/app_pages.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              controller: controller.nameC,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: "nama",
                hintText: "Masukkan nama anda",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
                onPressed: () {
                  if (controller.isLoad.isFalse) {
                    //eks reg
                    controller.signup();
                  }
                },
                child: Text(
                  controller.isLoad.isFalse ? "Daftar" : 'Loading...',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Sudah punya akun ?",
                ),
                SizedBox(
                  width: 5,
                ),
                TextButton(
                  onPressed: () => Get.offAllNamed(
                    Routes.LOGIN,
                  ),
                  child: Text("Masuk"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
