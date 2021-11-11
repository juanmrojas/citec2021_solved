import 'package:ciitec2021/Data/model/visitor_model.dart';

abstract class DataSource {
  Future<List<AtendeeModel>> execute();
}
