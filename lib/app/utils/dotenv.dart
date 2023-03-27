import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotEnvUtil {
  static String get fileName =>
      kReleaseMode ? '.env.production' : '.env.development';

  static String get backendApi =>
      dotenv.env['BACKEND_API_KEY'] ?? 'BACKEND_API_KEY';
}
