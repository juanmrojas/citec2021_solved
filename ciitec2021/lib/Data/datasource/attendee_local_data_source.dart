import 'package:ciitec2021/Data/model/visitor_model.dart';
import 'package:ciitec2021/Data/model/attendee_response.dart';
import 'package:ciitec2021/Domain/repository/data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

class AttendeeLocalDataSource extends DataSource {
  final SharedPreferences sharedPreferences;

  AttendeeLocalDataSource({@required this.sharedPreferences});

  @override
  Future<List<AtendeeModel>> execute() async {
    if (sharedPreferences.containsKey("CIITEC_CACHE")) {
      return toAttendeeListFromJson(
          sharedPreferences.getString("CIITEC_CACHE"));
    }
    return List.empty();
  }
}
