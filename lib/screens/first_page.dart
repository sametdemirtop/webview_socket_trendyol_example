import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../bloc/url/url_bloc.dart';
import '../bloc/url/url_event.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  WebViewController? _controller;

  bool isProductUrl(String url) {
    return url.contains("-p-");
  }

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            if (isProductUrl(request.url)) {
              BlocProvider.of<UrlBloc>(context)
                  .add(ChangeUrl(url: request.url));
              await Navigator.pushNamed(context, "/secondPage");
              return NavigationDecision.navigate;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.trendyol.com'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBlocBuilderBody(),
    );
  }

  buildAppBar() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(10), child: Container());
  }

  buildBlocBuilderBody() {
    return WebViewWidget(controller: _controller!);
  }
}
