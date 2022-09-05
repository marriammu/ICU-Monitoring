
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
      home: FifthPage(),
    );
  }
}

class FifthPage extends StatefulWidget {
  const FifthPage({Key key}) : super(key: key);
  @override
  _FifthPage createState() => _FifthPage();
}

class _FifthPage extends State<FifthPage> {
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
      var jasonObj = json.decode(res.body) as List<dynamic>;
      return jasonObj;
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
          body: 
            
             Container(
              alignment: Alignment.center, //inner widget alignment to center
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Patient 3',
                        style: kHeading,
                      ),
                    ),
                  ),
                
                            SizedBox(
                    height: 30,
                  ),
                  Expanded(
                      child: Scaffold(
                          body: SfCartesianChart(
                              series: <LineSeries<LiveData, int>>[
                        LineSeries<LiveData, int>(
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesController = controller;
                          },
                          dataSource: chartData,
                          color: Color.fromARGB(255, 19, 162, 14), 
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
                      onPressed: () async {
                  await http.post(Uri.parse('http://192.168.1.9:3000/Toggle'));
                },
                      child: Text('ON/OFF',style: kBodyText),
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
                      onPressed: () {Navigator.pushNamed(context, '/third');},
                      child: Text('Back',style: kBodyText),
                    ),
                  ),
                  
                ],
              ))),
        ),
      ],
      
    );
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
