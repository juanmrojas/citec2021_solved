import 'package:ciitec2021/Data/datasource/attendee_local_data_source.dart';
import 'package:ciitec2021/Data/datasource/attendee_remote_data_source.dart';
import 'package:ciitec2021/Data/repository/visitors_repository_impl.dart';
import 'package:ciitec2021/Domain/repository/visitors_repository.dart';
import 'package:ciitec2021/Domain/usecase/get_visitors_list.dart';
import 'package:ciitec2021/core/network_connectivity.dart';
import 'package:ciitec2021/presentation/bloc/attendee_list_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

final builder = GetIt.instance;

Future<void> init() async {
  // Bloc
  builder.registerLazySingleton(
      () => AttendeeListBloc(getAttendeeList: builder()));

  // Domain
  builder.registerLazySingleton(
      () => GetAttendeeList(attendeeRepository: builder()));

  builder.registerLazySingleton<AttendeeRepository>(() =>
      AttendeeRepositoryImpl(
          attendeeRemoteDataSource: builder(),
          attendeeLocalDataSource: builder(),
          sharedPreferences: builder(),
          networkConnectivity: builder()));

  builder.registerLazySingleton(() => AttendeeRemoteDataSource());
  builder.registerLazySingleton(() => DataConnectionChecker());

  builder.registerLazySingleton<NetworkConnectivity>(
      () => NetworkConnectivityImpl(dataConnectionChecker: builder()));

  final sharedPreferences = await SharedPreferences.getInstance();
  builder.registerLazySingleton(() => sharedPreferences);
  builder.registerLazySingleton(
      () => AttendeeLocalDataSource(sharedPreferences: builder()));
}
