// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supaone/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';
import '../../../controllers/auth_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile User'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await controller.logout();
              await authC.reset();
              Get.offAllNamed(Routes.LOGIN);
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
            future: controller.getProfile(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
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
                    readOnly: true,
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
                  Text(
                    "Last Login: ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  Obx(() => Text(
                        "${controller.lastLog}",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoad.isFalse) {
                          //eks update
                          await controller.updateProfile();
                          if (controller.passC.text.isNotEmpty &&
                              controller.passC.text.length > 5) {
                            await controller.logout();
                            await authC.reset();
                            Get.offAllNamed(Routes.LOGIN);
                          }
                        }
                      },
                      child: Text(
                        controller.isLoad.isFalse ? "Update" : 'Loading...',
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
