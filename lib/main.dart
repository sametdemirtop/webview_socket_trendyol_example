import 'dart:developer';

import 'package:bravo_shopgo_example/routes/ongenerate_routes.dart';
import 'package:bravo_shopgo_example/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'bloc/url/url_bloc.dart';
import 'models/take_response_model.dart';
import 'models/user_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final apiService = ApiService("https://api.bravoshopgo.com");
  User exampleUser = User(username: "test_user", password: "61b2szWzvrgEZ46");
  TokenResponse token =
      await apiService.getToken(exampleUser.username, exampleUser.password);
  log("token: ${token.access}");
  const FlutterSecureStorage().write(key: "token", value: token.access);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UrlBloc()),
      ],
      child: const MaterialApp(
        title: 'BravoShopGo',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.routeGenerator,
      ),
    );
  }
}
