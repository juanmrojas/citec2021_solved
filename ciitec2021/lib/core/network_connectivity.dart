import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:meta/meta.dart';

abstract class NetworkConnectivity {
  Future<bool> get isConnected;
}

class NetworkConnectivityImpl implements NetworkConnectivity {
  final DataConnectionChecker dataConnectionChecker;

  NetworkConnectivityImpl({@required this.dataConnectionChecker});

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;
}
