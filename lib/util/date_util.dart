class DateUtil {

  // static DateTime UserDt = DateTime.now();
  static var UserDt;

  static DateTime getTomorrow() {
    print('DateUtil.getTomorrow, before Day : ${UserDt.day} Minute : ${UserDt.minute}');
    UserDt = UserDt.add(const Duration(days: 1));
    print('DateUtil.getTomorrow, after  Day : ${UserDt.day} Minute : ${UserDt.minute}');
    UserDt = DateTime(UserDt.year, UserDt.month, UserDt.day, UserDt.hour, UserDt.minute, UserDt.second, 0, 0);
    return UserDt;
  }

  /**
   * Day 만 1일 더한 날짜시간 얻기
   */
  static DateTime getTimeAfterDay(DateTime time) {
    print('DateUtil.getTimeAfterDay, before Day : ${time.day} Minute : ${time.minute}');
    time = time.add(const Duration(days: 1));
    print('DateUtil.getTimeAfterDay, after  Day : ${time.day} Minute : ${time.minute}');
    DateTime dtNew = DateTime(time.year, time.month, time.day, time.hour, time.minute, time.second, 0, 0);
    return dtNew;
  }

  static DateTime getTimeAfterSecs() {
    DateTime dt = DateTime.now();
    dt = dt.add(Duration(seconds: 5));
    return dt;
  }

  static void setUserDt(DateTime time) {
    UserDt = time;
    print('DateUtile.setUserDt ${UserDt}');
  }
}