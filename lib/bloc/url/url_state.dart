import 'package:flutter/foundation.dart';

@immutable
abstract class UrlState {
  final String url;
  const UrlState({required this.url});
}
class UrlInitial extends UrlState {
  const UrlInitial({required String initialUrl}) : super(url: initialUrl);
}

class MyUrlState extends UrlState {
  const MyUrlState({required String urlValue}) : super(url: urlValue);
}