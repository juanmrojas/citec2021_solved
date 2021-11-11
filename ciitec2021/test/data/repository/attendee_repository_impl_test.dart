import 'package:ciitec2021/Data/datasource/attendee_local_data_source.dart';
import 'package:ciitec2021/Data/datasource/attendee_remote_data_source.dart';
import 'package:ciitec2021/Data/model/attendee_response.dart';
import 'package:ciitec2021/Data/repository/visitors_repository_impl.dart';
import 'package:ciitec2021/core/network_connectivity.dart';
import 'package:ciitec2021/presentation/utils/date_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../lib/core/response_reader.dart';

class MockAttendeeRemoteDataSource extends Mock
    implements AttendeeRemoteDataSource {}

class MockAttendeeLocalDataSource extends Mock
    implements AttendeeLocalDataSource {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockNetworkConnectivity extends Mock implements NetworkConnectivity {}

MockAttendeeRemoteDataSource _mockAttendeeRemoteDataSource;
MockAttendeeLocalDataSource _mockAttendeeLocalDataSource;
MockSharedPreferences _mockSharedPreferences;
MockNetworkConnectivity _mockNetworkConnectivity;
AttendeeRepositoryImpl _subject;

void main() {
  setUp(() {
    _mockAttendeeRemoteDataSource = MockAttendeeRemoteDataSource();
    _mockAttendeeLocalDataSource = MockAttendeeLocalDataSource();
    _mockSharedPreferences = MockSharedPreferences();
    _mockNetworkConnectivity = MockNetworkConnectivity();

    _subject = AttendeeRepositoryImpl(
        attendeeRemoteDataSource: _mockAttendeeRemoteDataSource,
        attendeeLocalDataSource: _mockAttendeeLocalDataSource,
        sharedPreferences: _mockSharedPreferences,
        networkConnectivity: _mockNetworkConnectivity);
  });

  test(
      "fetchAttendeeList_hasNetworkConnectivityButCacheIsEmpty_updatesCacheAndReturnsNetworkData",
      () async {
    var visitorList =
        toAttendeeListFromJson(responseReader('get_attendee_list.json'));
    when(_mockNetworkConnectivity.isConnected).thenAnswer((_) async => false);
    when(_mockSharedPreferences.containsKey("CIITEC_CACHE"))
        .thenAnswer((_) => false);
    when(_mockAttendeeRemoteDataSource.execute())
        .thenAnswer((_) async => visitorList);

    await _subject.fetchAttendeeList();

    verify(_mockSharedPreferences.setString(
        "CIITEC_CACHE", toJsonFromAttendeeList(visitorList)));
    verify(_mockAttendeeRemoteDataSource.execute());
  });

  test(
      "fetchAttendeeList_hasNetworkConnectivityAndCacheIsNotStale_returnsLocalData",
      () async {
    var visitorList =
        toAttendeeListFromJson(responseReader('get_attendee_list.json'));
    when(_mockNetworkConnectivity.isConnected).thenAnswer((_) async => true);
    when(_mockSharedPreferences.containsKey("CIITEC_CACHE"))
        .thenAnswer((_) => true);
    when(_mockSharedPreferences.getString("CIITEC_CACHE"))
        .thenAnswer((_) => responseReader('get_attendee_list.json'));
    when(_mockAttendeeLocalDataSource.execute())
        .thenAnswer((_) async => visitorList);
    when(_mockSharedPreferences.containsKey("CIITEC_LAST_UPDATED"))
        .thenAnswer((_) => true);
    when(_mockSharedPreferences.getString("CIITEC_LAST_UPDATED"))
        .thenAnswer((_) => "2021-11-07 18:00:00");
    CustomizableDatetime.customTime = DateTime.parse("2021-11-07 18:07:00");

    await _subject.fetchAttendeeList();

    verify(_mockAttendeeLocalDataSource.execute());
  });

  test(
      "fetchAttendeeList_hasNetworkConnectivityAndCacheIsStale_updatesCacheAndReturnsFromNetwork",
      () async {
    var visitorList =
        toAttendeeListFromJson(responseReader('get_attendee_list.json'));
    when(_mockNetworkConnectivity.isConnected).thenAnswer((_) async => true);
    when(_mockSharedPreferences.containsKey("CIITEC_CACHE"))
        .thenAnswer((_) => true);
    when(_mockSharedPreferences.getString("CIITEC_CACHE"))
        .thenAnswer((_) => responseReader('get_attendee_list.json'));
    when(_mockAttendeeRemoteDataSource.execute())
        .thenAnswer((_) async => visitorList);
    when(_mockSharedPreferences.containsKey("CIITEC_LAST_UPDATED"))
        .thenAnswer((_) => true);
    when(_mockSharedPreferences.getString("CIITEC_LAST_UPDATED"))
        .thenAnswer((_) => "2021-11-07 18:00:00");
    CustomizableDatetime.customTime = DateTime.parse("2021-11-07 18:17:00");

    await _subject.fetchAttendeeList();

    verify(_mockAttendeeRemoteDataSource.execute());
  });

  test("fetchAttendeeList_doesNotHaveNetworkConnectivity_returnsCacheData",
      () async {
    when(_mockNetworkConnectivity.isConnected).thenAnswer((_) async => false);
    when(_mockSharedPreferences.getString("CIITEC_CACHE"))
        .thenAnswer((_) => responseReader('get_attendee_list.json'));

    await _subject.fetchAttendeeList();

    verify(_mockAttendeeLocalDataSource.execute());
  });
}
