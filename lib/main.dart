import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ridesense/Screens/Home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
            primary: const Color(0xff6318AF),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: Home.id,
        routes: {
          Home.id: (context) => const Home(),
        });
  }
}
 