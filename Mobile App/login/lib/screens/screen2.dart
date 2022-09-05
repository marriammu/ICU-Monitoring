
import 'package:flutter/material.dart';
import 'package:flutter_loginpage/palatte.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/widgets.dart';

/// Add the second screen // rooms viewer
 class SecondPage extends StatefulWidget {
   const SecondPage({Key key}) : super(key: key);
   @override
   _SecondPageState createState() => _SecondPageState();
 }

 class _SecondPageState extends State<SecondPage> {
//    @override
//    Widget build(BuildContext context) {
//      return Scaffold(
//        appBar: AppBar(
//          title: Text("Patient Rooms"),
//        ),
//        body: Center(
//          child: ElevatedButton(
//              child: Text("Go back"),
//              onPressed: () {
//                Navigator.pop(context);
//              }
//          ),
//        ),
//      );
//    }
//  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RoomBackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    child: Center(
                      child: Text(
                        'Rooms Viewer',
                        style: kHeading,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 80,
                            ),
                            Room1(
                              buttonText: 'Room1',
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            Room2(
                              buttonText: 'Room2',
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            Room3(
                              buttonText: 'Room3',
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                // bottom:
                                //     BorderSide(color: Colors.white, width: 1),
                              )),
                              // child: Text(
                              //   'CreateNewAccount',
                              //   style: kBodyText,
                              // ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
