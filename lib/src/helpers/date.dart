class CustomDate {
  static final List<String> monthName = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String formatD(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    String d = date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();
    return d;
  }

  static String parseMDY(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    String d = monthName[date.month] +
        ' ' +
        date.day.toString() +
        ', ' +
        date.year.toString();
    return d;
  }
}
