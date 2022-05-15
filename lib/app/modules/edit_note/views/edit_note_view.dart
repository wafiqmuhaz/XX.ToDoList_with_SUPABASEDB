// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_note_controller.dart';
import '../../../data/models/notes_model.dart';
import '../../../modules/home/controllers/home_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  final homeC = Get.find<HomeController>();
  Notes note = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.titleC.text = note.title!;
    controller.descC.text = note.desc!;
    return Scaffold(
      appBar: AppBar(
        title: Text('EditNoteView'),
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
                    bool resp = await controller.editNote(note.id!);

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
