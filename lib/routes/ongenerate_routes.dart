import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../screens/first_page.dart';
import '../screens/second_page.dart';

class RouteGenerator {
  static Route<dynamic>? _createRoute(
      Widget nextWidget) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(
        builder: (context) => nextWidget,
      );
    }
    else {
      return MaterialPageRoute(
        builder: (context) => nextWidget,
      );
    }
  }

  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _createRoute(const FirstPage());
      case '/secondPage':
        return _createRoute(const SecondPage());
        default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Error 404'),
            ),
            body: const Center(
              child: Text('Page Not Found'),
            ),
          ),
        );
    }
  }
}