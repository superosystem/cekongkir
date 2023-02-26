import 'package:cekongkir/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

Future<void> main() async {
  // To load the .env file contents into dotenv.
  await dotenv.load(fileName: ".env");
  runApp(GetMaterialApp(
    title: "Shipping Cost Checker",
    debugShowCheckedModeBanner: false,
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
  ));
}
