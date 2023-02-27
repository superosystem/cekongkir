import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:postage_checker/environment.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  // To load the .env.development file contents into dotenv.
  await dotenv.load(fileName: Environment.fileName);

  runApp(
    GetMaterialApp(
      title: "Postage Checker",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
