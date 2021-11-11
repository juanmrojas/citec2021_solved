import 'package:ciitec2021/Domain/entity/Visitor.dart';
import 'package:ciitec2021/Domain/usecase/get_visitors_list.dart';
import 'package:ciitec2021/core/usecase.dart';
import 'package:ciitec2021/presentation/bloc/event/attendee_list_event.dart';
import 'package:ciitec2021/presentation/bloc/attendee_list_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetAttendeeList extends Mock implements GetAttendeeList {}

MockGetAttendeeList _mockGetAttendeeList;
AttendeeListBloc _subject;

void main() {
  setUp(() {
    _mockGetAttendeeList = MockGetAttendeeList();
    _subject = AttendeeListBloc(getAttendeeList: _mockGetAttendeeList);
  });

  test("init_assertsNullState", () {
    expect(_subject.state, equals(null));
  });

  test("mapEventToState_showPreAuthorized_returnsPreAutorizedAttendeeList",
      () async {
    AttendeeListInitEvent visitorListInitEvent = AttendeeListInitEvent();
    when(_mockGetAttendeeList.call(any))
        .thenAnswer((_) async => Right(_provideAttendeeList()));

    _subject.add(visitorListInitEvent);
    await untilCalled(_mockGetAttendeeList.call(NoParams()));

    verify(_mockGetAttendeeList.call(NoParams()));
  });
}

List<Atendee> _provideAttendeeList() {
  List<Atendee> attendeeList = [];
  attendeeList.add(Atendee(isPreAuthorized: true));
  attendeeList.add(Atendee(isPreAuthorized: true));
  attendeeList.add(Atendee(isPreAuthorized: false));
  return attendeeList;
}
