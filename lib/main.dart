import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/views/HomePage.dart';

Future<void> main() async {
  // To load the .env file contents into dotenv.
  await dotenv.load(fileName: ".env");
  runApp(const CekOngkir());
}

class CekOngkir extends StatelessWidget {
  const CekOngkir({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shipping Cost Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Shipping Cost Checker'),
    );
  }
}
