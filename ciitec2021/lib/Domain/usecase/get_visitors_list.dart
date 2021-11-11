import 'package:ciitec2021/Domain/entity/Visitor.dart';
import 'package:ciitec2021/Domain/repository/visitors_repository.dart';
import 'package:ciitec2021/core/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:ciitec2021/error/failure.dart';
import 'package:meta/meta.dart';

class GetAttendeeList extends UseCase<List<Atendee>, NoParams> {
  AttendeeRepository attendeeRepository;
  GetAttendeeList({@required this.attendeeRepository});

  @override
  Future<Either<Failure, List<Atendee>>> call(NoParams params) async {
    return await attendeeRepository.fetchAttendeeList();
  }
}
