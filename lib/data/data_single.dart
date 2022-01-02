class UserDataSingle {

  static final UserDataSingle _instance = UserDataSingle._internal();
  static DateTime dt = DateTime.now();
  int day = 0;

  factory UserDataSingle() {
    return _instance;
  }

  UserDataSingle._internal() {
    ;
  }

  void setDay(int d) {
    day = d;
    print('UserDataSingle.setDay, day : ${day}');
  }

  DateTime getTomorrow() {
    // print('DateUtil.getTomorrow, before Day : ${UserDt.day} Minute : ${UserDt.minute}');
    // UserDt = UserDt.add(const Duration(days: 1));
    // print('DateUtil.getTomorrow, after  Day : ${UserDt.day} Minute : ${UserDt.minute}');
    // UserDt = DateTime(UserDt.year, UserDt.month, UserDt.day, UserDt.hour, UserDt.minute, UserDt.second, 0, 0);
    // return UserDt;
    print('UserDataSingle.getTomorrow, day : ${day}, before Day : ${dt.day} Minute : ${dt.minute}');
    dt = dt.add(const Duration(days: 1));
    return dt;
  }
}