import 'package:connectivity_plus/connectivity_plus.dart';

ConnectionListner? _connectionListner;

ConnectionListner get connectionListner {
  _connectionListner ??= ConnectionListner();
  return _connectionListner!;
}

class ConnectionListner {
  final checker = Connectivity();
  bool isOnline = false;
  bool isWifi = false;
  ConnectionChange downloadConnectionListner = (isOnline) {};
  ConnectionChange pageConnectionListner = (isOnline) {};
  ConnectionChange secondpageConnectionListner = (isOnline) {};
  ConnectionListner() {
    checker.onConnectivityChanged.listen((result) {
      // print('eventttt: $result');
      if (result == ConnectivityResult.mobile) {
        isOnline = true;
      } else if (result == ConnectivityResult.wifi) {
        isOnline = true;
        isWifi = true;
      } else {
        isOnline = false;
        isWifi = false;
      }
      downloadConnectionListner(isOnline);
      pageConnectionListner(isOnline);
      secondpageConnectionListner(isOnline);
    });
  }
}

typedef ConnectionChange = void Function(bool isOnline);
