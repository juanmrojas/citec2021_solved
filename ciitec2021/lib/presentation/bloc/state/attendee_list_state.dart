import 'package:ciitec2021/Domain/entity/Visitor.dart';

abstract class AttendeeListState {}

class AttendeeListInitState extends AttendeeListState {
  final List<Atendee> visitorList;

  AttendeeListInitState({this.visitorList});
}
