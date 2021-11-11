import 'package:ciitec2021/Domain/usecase/get_visitors_list.dart';
import 'package:ciitec2021/core/usecase.dart';
import 'package:ciitec2021/presentation/bloc/event/attendee_list_event.dart';
import 'package:ciitec2021/presentation/bloc/state/attendee_list_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class AttendeeListBloc extends Bloc<AttendeeListEvent, AttendeeListState> {
  final GetAttendeeList getAttendeeList;
  AttendeeListBloc({@required this.getAttendeeList}) : super(null);
  @override
  Stream<AttendeeListState> mapEventToState(AttendeeListEvent event) async* {
    if (event is AttendeeListInitEvent) {
      final successOrFailure = await getAttendeeList.call(NoParams());
      yield successOrFailure.fold(
          (l) => null, (r) => AttendeeListInitState(visitorList: r));
    }
  }
}
