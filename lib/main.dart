import 'package:cekongkir/app/routes/app_pages.dart';
import 'package:cekongkir/app/utils/dotenv_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

Future<void> main() async {
  // Load environment file
  await dotenv.load(fileName: DotEnvUtil.fileName);
  runApp(
    GetMaterialApp(
      title: "CekOngkir",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
