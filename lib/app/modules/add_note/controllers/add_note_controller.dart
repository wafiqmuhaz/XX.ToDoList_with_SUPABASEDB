import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddNoteController extends GetxController {
  RxBool isLoad = false.obs;
  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  Future<bool> addNote() async {
    if (titleC.text.isNotEmpty && descC.text.isNotEmpty) {
      isLoad.value = true;
      PostgrestResponse<dynamic> user =
          await client.from("users").select("id").match({
        "uid": client.auth.currentUser!.id,
      }).execute();

      int id = (user.data as List).first["id"];

      await client.from("notes").insert({
        "user_id": id,
        "title": titleC.text,
        "desc": descC.text,
        "created_at": DateTime.now().toIso8601String(),
      }).execute();
      isLoad.value = false;
      return true;
    } else {
      return false;
    }
  }
}
