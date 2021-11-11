import 'package:equatable/equatable.dart';

class Atendee extends Equatable {
  String name;
  String lastName;
  int visitorType;
  bool isPreAuthorized;

  Atendee({this.name, this.lastName, this.visitorType, this.isPreAuthorized});
}
