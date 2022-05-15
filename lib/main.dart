// ignore_for_file: use_key_in_widget_constructors, unused_local_variable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supaone/app/controllers/auth_controller.dart';

import 'app/routes/app_pages.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Supabase supa = await Supabase.initialize(
    url: "https://oepsdzhounkgjmdgjoez.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9lcHNkemhvdW5rZ2ptZGdqb2V6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTI0OTI0NTgsImV4cCI6MTk2ODA2ODQ1OH0.THzVMFpUO-DON0JCYbtQYaYb1gkTLVwMpGKXm4YCU0s",
  );

  // await supa.client.auth.signOut();

  final authC = Get.put(
    AuthController(),
    permanent: true,
  );

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SupaOne",
      initialRoute:
          supa.client.auth.currentUser == null ? Routes.LOGIN : Routes.HOME,
      getPages: AppPages.routes,
    ),
  );
}
