import 'package:ciitec2021/Data/model/visitor_model.dart';
import 'package:ciitec2021/Domain/repository/data_source.dart';

class AttendeeRemoteDataSource extends DataSource {
  @override
  Future<List<AtendeeModel>> execute() async {
    List<AtendeeModel> visitorList = [];
    visitorList.add(AtendeeModel(
        name: "Juan",
        lastName: "Rojas",
        isPreAuthorized: true,
        visitorType: 1));
    visitorList.add(AtendeeModel(
        name: "Guillermo",
        lastName: "Fierro",
        isPreAuthorized: true,
        visitorType: 1));
    visitorList.add(AtendeeModel(
        name: "Paty",
        lastName: "Galvan",
        isPreAuthorized: true,
        visitorType: 1));
    visitorList.add(AtendeeModel(
        name: "Luis", lastName: "Lao", isPreAuthorized: true, visitorType: 1));
    return visitorList;
  }
}
