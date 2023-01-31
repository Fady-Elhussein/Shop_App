

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class CheckInternetConnection extends StatefulWidget {
  @override
  _CheckInternetConnection createState() => _CheckInternetConnection();

}

class _CheckInternetConnection extends State<CheckInternetConnection> {
  var _connectivityResult = ConnectivityResult.none;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _isConnected ?
                const Text("Connected to Internet")
              : const Text("No Internet Connection"),
        ),
      ),
    );
  }

  void _checkInternetConnection() async {
    _connectivityResult = await Connectivity().checkConnectivity();
    if (_connectivityResult == ConnectivityResult.mobile ||
        _connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        _isConnected = true;
      });
    }
  }
}
