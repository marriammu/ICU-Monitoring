
import 'package:flutter/material.dart';
import 'package:flutter_loginpage/palatte.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import "dart:developer";

/// Add the third screen //Patient viewer 
 class ThirdPage extends StatefulWidget {
   const ThirdPage({Key key}) : super(key: key);
   @override
   _ThirdPageState createState() => _ThirdPageState();
 }

 class _ThirdPageState extends State<ThirdPage> {
   List<LiveData> chartData;
   List<LiveRead> chartRead;
   ChartSeriesController _chartSeriesController;
   ChartSeriesController _chartReadController;
  // late Future<dynamic> _futureData;
  List<Map<String, dynamic>> data = [];

  List<Map<String, dynamic>> convertToList(List<dynamic> data) {
    List<Map<String, dynamic>> newData = [];
    var length = data.length;
    for (int i = 0; i < length; ++i) {
      newData.add({
        'ID': data[i]["id"],
        'Temperature': data[i]["Temperature"],
        'Time': data[i]["Time"]
      });
    }
    return newData;
  }

  getSensorData() async {
    var res = await http.get(Uri.parse('http://192.168.1.9:3000/SensorsData'),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });
    if (res.statusCode == 200) {
      var jasonObj = json.decode(res.body) as Map<String, dynamic>;
      return jasonObj['data'];
    }
  }

  bool Comparing(List<dynamic> NewData, List<Map<String, dynamic>> OldData) {
    if (NewData.length != OldData.length) {
      return false;
    }

    for (int i = 0; i < OldData.length; ++i) {
      if (NewData[i]["Temperature"] != NewData[i]["Temperature"]) {
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    chartData = getChartData();
    chartRead = getChartRead();
    Timer.periodic(const Duration(seconds: 1), getReadings);
    // Timer.periodic(const Duration(seconds: 1), );
    super.initState();
  }

   @override
   Widget build(BuildContext context) {
     return Stack(
      children: [
        BackgroundImage(),
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
                        'Patient Rooms',
                        style: kHeading,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
              alignment: Alignment.topCenter, //inner widget alignment to center
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Container(
                  
                  //     child: Scaffold(
                  //         body: SfCartesianChart(
                  //             series: <LineSeries<LiveData, int>>[
                  //       LineSeries<LiveData, int>(
                  //         onRendererCreated:
                  //             (ChartSeriesController controller) {
                  //           _chartSeriesController = controller;
                  //         },
                  //         dataSource: chartData,
                  //         color: const Color.fromRGBO(192, 108, 132, 1),
                  //         xValueMapper: (LiveData sales, _) => sales.time,
                  //         yValueMapper: (LiveData sales, _) => sales.speed,
                  //       )
                  //     ],
                  //             primaryXAxis: NumericAxis(
                  //                 majorGridLines:
                  //                     const MajorGridLines(width: 0),
                  //                 edgeLabelPlacement: EdgeLabelPlacement.shift,
                  //                 interval: 3,
                  //                 title: AxisTitle(text: 'Time (seconds)')),
                  //             primaryYAxis: NumericAxis(
                  //                 axisLine: const AxisLine(width: 0),
                  //                 majorTickLines: const MajorTickLines(size: 0),
                  //                 title: AxisTitle(text: 'Temprature (%)'))))),
                  // Expanded(
                  //     child: Scaffold(
                  //         body: SfCartesianChart(
                  //             series: <LineSeries<LiveRead, int>>[
                  //       LineSeries<LiveRead, int>(
                  //         onRendererCreated:
                  //             (ChartSeriesController controller) {
                  //           _chartReadController = controller;
                  //         },
                  //         dataSource: chartRead,
                  //         color: const Color.fromRGBO(50, 20, 100, 1),
                  //         xValueMapper: (LiveRead sales, _) => sales.time,
                  //         yValueMapper: (LiveRead sales, _) => sales.temp,
                  //       )
                  //     ],
                  //             primaryXAxis: NumericAxis(
                  //                 majorGridLines:
                  //                     const MajorGridLines(width: 0),
                  //                 edgeLabelPlacement: EdgeLabelPlacement.shift,
                  //                 interval: 3,
                  //                 title: AxisTitle(text: 'Time (seconds)')),
                  //             primaryYAxis: NumericAxis(
                  //                 axisLine: const AxisLine(width: 0),
                  //                 majorTickLines: const MajorTickLines(size: 0),
                  //                 title: AxisTitle(text: 'Humidity (C)'))))),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: FlatButton(
                      //button to start scanning
                      color: Color.fromARGB(255, 235, 99, 99),
                      colorBrightness: Brightness.dark,
                      onPressed: () {Navigator.pushNamed(context, '/second');},
                      child: Text('Go Back To Rooms'),
                    ),
                  ),
                ],
              ))
              ],
              ),
            ),
          ),
        ),
      ],
    ); 
      //  appBar: AppBar(
      //    title: Text("Patient Rooms"),
      //  ),
      //  body: Center(
      //    child: ElevatedButton(
      //        child: Text("Go back to Rooms"),
      //        onPressed: () {
      //          Navigator.pop(context, '/second');
      //        }
      //    ),
      //  ),
   }
   int time = 3;
  void updateDataSource(int data) {
    chartData.add(LiveData(time++, data));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
    chartRead.add(LiveRead(time++, (math.Random().nextInt(60) + 30)));
    chartRead.removeAt(0);
    _chartReadController.updateDataSource(
        addedDataIndex: chartRead.length - 1, removedDataIndex: 0);
  }

  void getReadings(Timer timer) async {
    var temp = await getSensorData();
    var length = data.length;
    if (temp.length > data.length) {
      var newLength = temp.length - data.length;
      for (int j = 0; j < newLength; j++) {
        data.add({'Temperature': temp[j + length]['Temperature']});
        updateDataSource(temp[j + length]['Temperature']);
      }
    }
    data = convertToList(temp);
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 42),
      LiveData(1, 47),
      LiveData(2, 43),
    ];
  }

  List<LiveRead> getChartRead() {
    return <LiveRead>[
      LiveRead(0, 10),
      LiveRead(1, 15),
      LiveRead(2, 22),
    ];
  }
 }
class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final num speed;
}

class LiveRead {
  LiveRead(this.time, this.temp);
  final int time;
  final num temp;
}






