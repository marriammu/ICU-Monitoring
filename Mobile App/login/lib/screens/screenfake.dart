
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
// import 'package:web_socket_channel/io.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import "dart:developer";
import 'package:flutter_loginpage/palatte.dart';
import '../widgets/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebSocketLed(),
    );
  }
}

class WebSocketLed extends StatefulWidget {
  const WebSocketLed({Key key}) : super(key: key);
  @override
  _WebSocketLed createState() => _WebSocketLed();
}

class _WebSocketLed extends State<WebSocketLed> {
   List<LiveData> chartData;
   List<LiveRead> chartRead;
   List<LiveNum> chartNum;
   ChartSeriesController _chartSeriesController;
   ChartSeriesController _chartReadController;
   ChartSeriesController _chartNumController;
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

  

 

  @override
  void initState() {
    chartData = getChartData();
    chartRead = getChartRead();
    chartNum = getChartNum();

    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        
        SafeArea(
          
      child: Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //     title: Text("Patient Rooms",style: kHeading)),
          body: FittedBox(
            fit: BoxFit.fitHeight,
            
            child: Container(
              alignment: Alignment.topCenter, //inner widget alignment to center
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Patient Rooms',
                        style: kHeading,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    
                    child:  Row(children: [
                       Column(children: [
                         Container(
                           height:200,
                           width:700,
                           child:Scaffold(
                          body: SfCartesianChart(
                              series: <LineSeries<LiveRead, int>>[
                        LineSeries<LiveRead, int>(
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartReadController = controller;
                          },
                          dataSource: chartRead,
                          color: const Color.fromRGBO(50, 20, 100, 1),
                          xValueMapper: (LiveRead sales, _) => sales.time,
                          yValueMapper: (LiveRead sales, _) => sales.temp,
                        )
                      ],
                              primaryXAxis: NumericAxis(
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                                  interval: 3,
                                  title: AxisTitle(text: 'Time (seconds)')),
                              primaryYAxis: NumericAxis(
                                  axisLine: const AxisLine(width: 0),
                                  majorTickLines: const MajorTickLines(size: 0),
                                  title: AxisTitle(text: 'Humidity (%)'))))
                         ),
                         Container(
                    width:150,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                    child: FlatButton(
                      onPressed: () {Navigator.pushNamed(context, '/second');},
                      child: Text('Patient 1',style: kBodyText),
                    ),
                  ),
                         ],

                    ),
                            SizedBox(
                    width: 60,
                  ),
                    Column(children: [
                         Container(
                           height:200,
                           width:700,
                           child:Scaffold(
                          body: SfCartesianChart(
                              series: <LineSeries<LiveNum, int>>[
                        LineSeries<LiveNum, int>(
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartNumController = controller;
                          },
                          dataSource: chartNum,
                          color: const Color.fromRGBO(192, 108, 132, 1),
                          xValueMapper: (LiveNum sales, _) => sales.time,
                          yValueMapper: (LiveNum sales, _) => sales.hum,
                        )
                      ],
                              primaryXAxis: NumericAxis(
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                                  interval: 3,
                                  title: AxisTitle(text: 'Time (seconds)')),
                              primaryYAxis: NumericAxis(
                                  axisLine: const AxisLine(width: 0),
                                  majorTickLines: const MajorTickLines(size: 0),
                                  title: AxisTitle(text: 'Temprature (C)'))))
                         ),
                         Container(
                    width:150,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                    child: FlatButton(
                      onPressed: () {Navigator.pushNamed(context, '/sixth');},
                      child: Text('Patient 2',style: kBodyText),
                    ),
                  ),
                         ],

                    )
                    ],
                    )   
                    ),
                            SizedBox(
                    height: 30,
                  ),
                  Container(
                    height:200,
                    width:700,
                    alignment: Alignment.center,

                      child: Scaffold(
                          body: SfCartesianChart(
                              series: <LineSeries<LiveData, int>>[
                        LineSeries<LiveData, int>(
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesController = controller;
                          },
                          dataSource: chartData,
                          color: Color.fromARGB(255, 116, 192, 108),
                          xValueMapper: (LiveData sales, _) => sales.time,
                          yValueMapper: (LiveData sales, _) => sales.speed,
                        )
                      ],
                              primaryXAxis: NumericAxis(
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                                  interval: 3,
                                  title: AxisTitle(text: 'Time (seconds)')),
                              primaryYAxis: NumericAxis(
                                  axisLine: const AxisLine(width: 0),
                                  majorTickLines: const MajorTickLines(size: 0),
                                  title: AxisTitle(text: 'Temprature (C)'))))),

                         
                  
                  Container(
                    width:150,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                    child: FlatButton(
                      onPressed: () {Navigator.pushNamed(context, '/fifth');},
                      child: Text('Patient 3',style: kBodyText),
                    ),
                  ),
                  Container(
                    width:150,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                    child: FlatButton(
                      onPressed: () {Navigator.pushNamed(context, '/second');},
                      child: Text('Back',style: kBodyText),
                    ),
                  ),
                  
                ],
              )))),
        ),
      ],
      
    );
  }

  int time = 3;
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);

        chartRead.add(LiveRead(time++, (math.Random().nextInt(60) + 30)));
    chartRead.removeAt(0);
    _chartReadController.updateDataSource(
        addedDataIndex: chartRead.length - 1, removedDataIndex: 0);

      chartNum.add(LiveNum(time++, (math.Random().nextInt(60) + 30)));
    chartNum.removeAt(0);
    _chartNumController.updateDataSource(
        addedDataIndex: chartNum.length - 1, removedDataIndex: 0);
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


  List<LiveNum> getChartNum() {
    return <LiveNum>[
      LiveNum(0, 10),
      LiveNum(1, 15),
      LiveNum(2, 22),
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

class LiveNum {
  LiveNum(this.time, this.hum);
  final int time;
  final num hum;
}