import 'package:date_format/date_format.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataSingle {

  static final UserDataSingle _instance = UserDataSingle._internal();
  DateTime notSettedDt = DateTime(1900);
  static DateTime settedDt = DateTime(1900);

  late final _prefs;
  static const String kUserDt = 'kUserDt';

  factory UserDataSingle() {
    return _instance;
  }

  UserDataSingle._internal() {
    _fetchSp();
  }

  //DateTime dt = DateTime.parse('2020-01-02 03:04:05');
  _fetchSp() async {
    _prefs = await SharedPreferences.getInstance();
    Set<String> keys = _prefs.getKeys();
    keys.forEach((k) {
      if (k.compareTo(k) == 0) settedDt = DateTime.parse(_prefs.getString(k));
    });

  }

  DateTime getDt() {
    String value = _prefs.getString(kUserDt);
    if (value.isNotEmpty) return DateTime.parse(value);
    else return notSettedDt;
  }

  Future<void> setDt(DateTime dt) async {
    // formatDate(dt, [HH, ':', nn, ':', ss]);
    _prefs = await SharedPreferences.getInstance();

    settedDt = dt;
    String sDt = formatDate(dt, [yyyy, '-', MM, '-', dd, ' ', HH, ':', nn, ':', ss]);
    print('UserDataSingle.setDt, ${sDt}');
    _prefs.remove(kUserDt);
    _prefs.setString(kUserDt, sDt);
  }



  DateTime getTomorrow() {
    // UserDt = UserDt.add(const Duration(days: 1));
    // UserDt = DateTime(UserDt.year, UserDt.month, UserDt.day, UserDt.hour, UserDt.minute, UserDt.second, 0, 0);

    DateTime dt = getDt();
    print('UserDataSingle.getTomorrow, before Day : ${dt.day} Minute : ${dt.minute}');
    dt = dt.add(const Duration(days: 1));
    return dt;
  }
}