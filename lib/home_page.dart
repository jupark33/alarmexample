// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:alarmexample/constants.dart';
import 'package:alarmexample/util/date_util.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'data/data_single.dart';
import 'noti_service.dart';

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
  DateTime dt = DateTime(1900);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Text('Every 2minutes'),
          Periodic(),
          Text('Daily'),
          Daily(),
          SettedTime(),
          TimeSelection(),
        ],
      ),


    );
  }

  SettedTime() {
    if (dt.year == 1900) {
      return Text('시간을 선택하세요. 선택된 시간');
    } else {
      var time = formatDate(dt, [HH, ':', nn, ':', ss]);
      return Text('시간을 선택하세요. 선택된 시간 : ${time}');
    }
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
              Duration(hours: 1, minutes: 0, seconds: 0), alarmIdPeriodic, fireAlarm, startAt: DateUtil.getTimeAfterSecs(), exact: true);
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
              Duration(milliseconds: 0), alarmIdDaily, fireDaily, startAt: DateUtil.getTimeAfterSecs());
        } else {
          AndroidAlarmManager.cancel(alarmIdDaily);
          print('Daily Alarm Timer Canceled');
        }

      },
    );
  }

  TimeSelection() {
    return TextButton(
      onPressed: () {
        DatePicker.showTimePicker(
            context,
            showTitleActions: true,
            onChanged: (time) {
              // print('change ${time}');
            }, onConfirm: (time) {
              // print('confirm ${time}');
              setState(() {
                dt = time;
              });
              _cancelAndSet(time);
            }, currentTime: DateTime.now(), locale: LocaleType.ko
        );
      },
      child: Text(
        '시간 선택 하기',
        style: TextStyle(color: Colors.blue),
      )
    );
  }


}

void _cancelAndSet(DateTime time) {
  AndroidAlarmManager.cancel(AlarmIdDailyUser).then((value) {
    if (value == true) {
      _setUserDailyAlarm(time);
    }
  });
}

void _setUserDailyAlarm(DateTime time) {
  print('유저 알림을 설정하였습니다. ${time}');

  AndroidAlarmManager.oneShotAt(
    time,
    AlarmIdDailyUser,
    fireDaily,
    alarmClock: true,
    allowWhileIdle: true,
    exact: true,
    wakeup: true,
    rescheduleOnReboot: true,
  );

  var userData = UserDataSingle();
  userData.setDt(time);
}

// _HomePageState 안으로 들어가면 실행 안됨.
void fireDaily() {
  tz.initializeTimeZones();
  print('Daily Alarm Fired at ${DateTime.now()}');
  NotificationService().showNotification(1, "매일 알람", "알람발생했습니다.${DateTime.now()}", 5);

  // 다음(내일) 알람 설정
  // DateTime nextDt = UserDataSingle().getTomorrow();
  // print('다음 알람 설정 ${nextDt}');
  // _cancelAndSet(nextDt);
}

void fireAlarm() {
  tz.initializeTimeZones();
  print('Alarm Fired at ${DateTime.now()}');
  NotificationService().showNotification(1, "시간 알람", "알람발생했습니다.${DateTime.now()}", 5);
}

