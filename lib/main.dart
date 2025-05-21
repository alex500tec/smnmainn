import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:smn/MainApp.dart';

import 'package:firebase_core/firebase_core.dart';
import 'utils/firebase_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es', null);
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  runApp(MainApp());
}
