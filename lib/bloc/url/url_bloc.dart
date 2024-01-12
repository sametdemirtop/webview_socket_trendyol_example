import 'package:bravo_shopgo_example/bloc/url/url_event.dart';
import 'package:bravo_shopgo_example/bloc/url/url_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UrlBloc extends Bloc<UrlEvent, UrlState> {
  UrlBloc() : super(const UrlInitial(initialUrl: "https://www.trendyol.com")) {
    on<ChangeUrl>((event, emit) {
      emit(MyUrlState(urlValue: event.url));
    });
  }
}
