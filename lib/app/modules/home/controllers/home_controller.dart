// ignore_for_file: unnecessary_overrides, avoid_print

// import 'package:supaone/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supaone/app/data/models/notes_model.dart';

class HomeController extends GetxController {
  RxList allNotes = List<Notes>.empty().obs;
  SupabaseClient client = Supabase.instance.client;

  Future<void> getAllNotes() async {
    PostgrestResponse<dynamic> user =
        await client.from("users").select("id").match({
      "uid": client.auth.currentUser!.id,
    }).execute();

    int id = (user.data as List).first["id"];

    var notes = await client.from("notes").select().match({
      "user_id": id,
    }).execute();

    List<Notes> dataNote = Notes.fromJsonList((notes.data as List));

    allNotes(dataNote);
    allNotes.refresh();

    print(notes.toJson());
  }

  void deleteNote(int id) async {
    await client.from("notes").delete().match({
      "id": id,
    }).execute();
    await getAllNotes();
  }
}
