// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_note_controller.dart';

import '../../../modules/home/controllers/home_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  final homeC = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD NOTE'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              controller: controller.titleC,
              decoration: InputDecoration(
                labelText: "judul",
                hintText: "Masukkan judul anda",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller.descC,
              decoration: InputDecoration(
                labelText: "deskripsi",
                hintText: "Masukkan deskripsi anda",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoad.isFalse) {
                    // eks addNote
                    bool resp = await controller.addNote();

                    if (resp == true) {
                      await homeC.getAllNotes();
                      Get.back();
                    }
                  }
                },
                child: Text(
                  controller.isLoad.isFalse ? "Masukkan Item" : "Loading...",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
