import 'package:ciitec2021/Domain/entity/Visitor.dart';
import 'package:ciitec2021/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AttendeeRepository {
  Future<Either<Failure, List<Atendee>>> fetchAttendeeList();
  bool isDataStale();
}
