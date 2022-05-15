// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supaone/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  RxBool isLoad = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  void signup() async {
    if (nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        passC.text.isNotEmpty) {
      // eks
      isLoad.value = true;
      GotrueSessionResponse res =
          await client.auth.signUp(emailC.text, passC.text);
      isLoad.value = false;

      if (res.error == null) {
        // tidak ada error -> berhasil
        // print(res.data);

        // INSERT DATA USER KE TABLE USERS
        await client.from("users").insert(
          {
            "email": emailC.text,
            "name": nameC.text,
            "created_at": DateTime.now().toIso8601String(),
            "uid": res.user!.id,
          },
        ).execute();

        //LANGSUNG MASUK
        Get.offAllNamed(Routes.HOME);

        //FITUR EMAIL VERIFICATION
        // Get.defaultDialog(
        //   barrierDismissible: false,
        //   title: "BERHASIL REGISTER",
        //   middleText: "Periksa email anda !",
        //   actions: [
        //     TextButton(
        //       onPressed: () {
        //         Get.back();
        //       },
        //       child: Text(
        //         'Okay',
        //       ),
        //     ),
        //   ],
        // );
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
