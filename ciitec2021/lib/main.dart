import 'package:ciitec2021/presentation/screen/visitor_list_screen.dart';
import 'package:flutter/material.dart';
import 'presentation/di/di_module.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CIITEC 2021',
      debugShowCheckedModeBanner: false,
      home: AttendeeListScreen(),
    );
  }
}
