import 'package:ciitec2021/Domain/entity/Visitor.dart';
import 'package:meta/meta.dart';

class AtendeeModel extends Atendee {
  AtendeeModel(
      {@required String name,
      @required String lastName,
      @required bool isPreAuthorized,
      @required int visitorType})
      : super(name: name, lastName: lastName, visitorType: visitorType);

  factory AtendeeModel.fromJson(Map<String, dynamic> json) {
    return AtendeeModel(
        name: json["name"],
        lastName: json["lastName"],
        isPreAuthorized: (json["isPreAuthorized"] as bool),
        visitorType: (json["visitorType"] as num).toInt());
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'isPreAuthorized': isPreAuthorized,
      'visitorType': visitorType
    };
  }
}
