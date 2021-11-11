import 'package:ciitec2021/Domain/entity/Visitor.dart';
import 'package:ciitec2021/Domain/repository/visitors_repository.dart';
import 'package:ciitec2021/Domain/usecase/get_visitors_list.dart';
import 'package:ciitec2021/core/usecase.dart';
import 'package:ciitec2021/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAttendeeRepository extends Mock implements AttendeeRepository {}

void main() {
  GetAttendeeList _subject;
  MockAttendeeRepository _mockAttendeeRepository;

  setUp(() {
    _mockAttendeeRepository = MockAttendeeRepository();
    _subject = GetAttendeeList(attendeeRepository: _mockAttendeeRepository);
  });

  test("call_returnVisitorList", () async {
    var attendeeList = _getAttendeeList();
    when(_mockAttendeeRepository.fetchAttendeeList())
        .thenAnswer((_) async => Right<Failure, List<Atendee>>(attendeeList));

    var result = await _subject.call(NoParams());

    expect(result, Right<Failure, List<Atendee>>(attendeeList));
    verify(_mockAttendeeRepository.fetchAttendeeList());
  });
}

List<Atendee> _getAttendeeList() {
  List<Atendee> attendeeList = <Atendee>[];
  attendeeList.add(Atendee(
      name: "Juan", lastName: "Perez", visitorType: 1, isPreAuthorized: true));
  attendeeList.add(Atendee(
      name: "John", lastName: "Doe", visitorType: 2, isPreAuthorized: true));
  return attendeeList;
}
