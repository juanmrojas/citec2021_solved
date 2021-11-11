extension CustomizableDatetime on DateTime {
  static DateTime _customDateTime;
  static DateTime get current {
    return _customDateTime ?? DateTime.now().toLocal();
  }

  static set customTime(DateTime customDateTime) {
    _customDateTime = customDateTime;
  }
}
