import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOnPeriodic = false;
  bool isOnDaily = false;
  int alarmIdPeriodic = 1;
  int alarmIdDaily = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: Transform.scale(
      //     scale: 2,
      //     child: Switch(
      //       value: isOnPeriodic,
      //       onChanged: (value) {
      //         setState(() {
      //           isOn = value;
      //         });
      //         if (isOn == true) {
      //           AndroidAlarmManager.periodic(
      //               Duration(seconds: 5), alarmId, fireAlarm);
      //         } else {
      //           AndroidAlarmManager.cancel(alarmId);
      //           print('Alarm Timer Canceled');
      //         }
      //       },
      //     ),
      //   ),
      // ),
      body: Body(),

    );
  }

  Body() {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Every 5secs'),
          Periodic(),
          Text('Daily'),
          Daily(),
        ],
      ),


    );
  }

  Periodic() {
    return Switch(

      value: isOnPeriodic,
      onChanged: (value) {
        setState(() {
          isOnPeriodic = value;
        });
        if (isOnPeriodic == true) {
          AndroidAlarmManager.periodic(
              Duration(seconds: 5), alarmIdPeriodic, fireAlarm);
        } else {
          AndroidAlarmManager.cancel(alarmIdPeriodic);
          print('Alarm Timer Canceled');
        }
      },
    );
  }

  Daily() {
    return Switch(
      value: isOnDaily,
      onChanged: (value) {
        setState(() {
          isOnDaily = value;
        });
        if (isOnDaily == true) {
          AndroidAlarmManager.periodic(
              Duration(milliseconds: 0), alarmIdDaily, fireDaily, startAt: _getDate());
        } else {
          AndroidAlarmManager.cancel(alarmIdDaily);
          print('Daily Alarm Timer Canceled');
        }

      },
    );
  }
}

void fireAlarm() {
  print('Alarm Fired at ${DateTime.now()}');
}

void fireDaily() {
  print('Daily Alarm Fired at ${DateTime.now()}');
}

DateTime _getDate() {
  DateTime dt = DateTime.now();
  dt.add(Duration(seconds: 5));
  return dt;
}
