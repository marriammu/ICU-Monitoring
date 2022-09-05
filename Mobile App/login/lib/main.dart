import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './screens/login-page.dart';
import './screens/screen2.dart';
import './screens/screen3.dart';
import './screens/screen5.dart';
// import './screens/screenfake.dart';
import './screens/screen6.dart';
import './screens/screen7.dart';
import './screens/screen4.dart';
// import 'screens/mobile4.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter LoginPage',
      theme: ThemeData(
        textTheme:
            GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      /// Define the app routes
       initialRoute: '/',
       routes: {
         '/second': (context) => const SecondPage(),
         '/third': (context) => const WebSocketLed(),
         '/fifth': (context) => const FifthPage(),
         '/sixth': (context) => const Test(),
         
        //  '/third': (context) => const Alaa(),//mobile
      }
    );
  }
}
 

