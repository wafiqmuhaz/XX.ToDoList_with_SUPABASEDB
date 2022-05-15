import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  RxBool isLoad = false.obs;
  RxBool isHidden = true.obs;
  RxString lastLog = "-".obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  Future<void> getProfile() async {
    PostgrestResponse<dynamic> res =
        await client.from("users").select("name,email").match({
      "uid": client.auth.currentUser!.id,
    }).execute();

    Map<String, dynamic> user =
        (res.data as List).first as Map<String, dynamic>;

    nameC.text = user["name"];
    emailC.text = user["email"];

    lastLog.value = DateFormat.yMMMEd().add_jms().format(
          DateTime.parse(client.auth.currentUser!.lastSignInAt!),
        );

    // print(res.toJson());
  }

  Future<void> logout() async {
    await client.auth.signOut();
    // Get.offAllNamed(
    //   Routes.LOGIN,
    // );
  }

  Future<void> updateProfile() async {
    if (nameC.text.isNotEmpty) {
      isLoad.value = true;
      client.from("users").update({
        "name": nameC.text,
      }).match({
        "uid": client.auth.currentUser!.id,
      }).execute();

      if (nameC.text.isNotEmpty) {
        if (passC.text.length > 5) {
          // data sekalian diupdate

          try {
            await client.auth.api.updateUser(
              client.auth.currentSession!.accessToken,
              UserAttributes(
                password: passC.text,
              ),
            );
          } catch (e) {
            Get.snackbar(
              "Terjadi Kesalahan",
              "Kesalahan = $e",
            );
          }
        } else {
          Get.snackbar(
            "Tidak Dapat Merubah Password",
            "Harus lebih dari 5 karakter ",
          );
        }

        isLoad.value = true;
        // Get.back();
      }
    }
  }
}
