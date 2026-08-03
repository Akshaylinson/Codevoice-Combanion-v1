import 'dart:async';

import 'package:flutter/widgets.dart';

import 'core/di/service_locator.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
}
