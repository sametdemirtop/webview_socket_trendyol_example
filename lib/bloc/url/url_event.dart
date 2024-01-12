
import 'package:flutter/foundation.dart';

@immutable
abstract class UrlEvent {}


class ChangeUrl extends UrlEvent {
  final String url;
  ChangeUrl({required this.url});
}


