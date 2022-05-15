// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:get/get.dart';
import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supaone/app/routes/app_pages.dart';

class AuthController extends GetxController {
  Timer? authTimer;

  SupabaseClient client = Supabase.instance.client;

  Future<void> autoLog() async {
    print("MENJALANKAN AUTO LOGOUT");
    if (authTimer != null) {
      authTimer!.cancel();
    }
    authTimer = Timer(
      Duration(seconds: 3600),
      () async {
        await client.auth.signOut();
        Get.offAllNamed(Routes.LOGIN);
      },
    );
  }

  Future<void> reset() async {
    if (authTimer != null) {
      authTimer!.cancel();
      authTimer = null;
    }
  }
}
