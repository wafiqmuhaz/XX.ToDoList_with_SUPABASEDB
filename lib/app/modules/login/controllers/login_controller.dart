// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  RxBool isLoad = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  Future<bool?> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      // eks
      isLoad.value = true;
      GotrueSessionResponse res =
          await client.auth.signIn(email: emailC.text, password: passC.text);
      isLoad.value = false;

      if (res.error == null) {
        // tidak ada error -> berhasil login

        //LANGSUNG MASUK
        return true;
      } else {
        Get.snackbar(
          "Terjadi Kesalahan",
          "Tidak dapat registrasi = ${res.error!.message}",
        );
      }
    } else {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Email dan Password belum diisi",
      );
    }
  }
}
