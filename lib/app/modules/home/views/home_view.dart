// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unnecessary_brace_in_string_interps, prefer_is_empty

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supaone/app/data/models/notes_model.dart';
import 'package:supaone/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ALL NOTES'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.PROFILE),
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
            future: controller.getAllNotes(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Obx(
                () => controller.allNotes.length == 0
                    ? Center(
                        child: Text(
                          "Tidak ada data...",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.allNotes.length,
                        itemBuilder: (context, index) {
                          Notes note = controller.allNotes[index];
                          return Card(
                            color: Colors.blue[100],
                            child: ListTile(
                              onTap: () => Get.toNamed(
                                Routes.EDIT_NOTE,
                                arguments: note,
                              ),
                              leading: CircleAvatar(
                                child: Text("${note.id}"),
                              ),
                              title: Text("${note.title}"),
                              subtitle: Text("${note.desc}"),
                              trailing: IconButton(
                                onPressed: () =>
                                    controller.deleteNote(note.id!),
                                icon: Icon(
                                  Icons.delete,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(
          Routes.ADD_NOTE,
        ),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
