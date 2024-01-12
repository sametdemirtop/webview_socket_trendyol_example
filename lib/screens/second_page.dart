import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:bravo_shopgo_example/models/product/product_color_model.dart';
import 'package:bravo_shopgo_example/models/product/product_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../bloc/url/url_bloc.dart';
import '../models/product/product_model.dart';
import '../services/web_socket_services.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final StreamController<TrendyolProduct> _streamController =
      StreamController<TrendyolProduct>();
  final StreamController<int> _intStreamController = StreamController<int>();
  WebSocketChannel? _channel;
  UrlBloc? _urlBloc;

  @override
  void initState() {
    initAll();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_channel!.closeCode == null) {
      _channel!.sink.close();
    }
  }

  String getConvertUrl(String url) {
    if (url.contains("?")) {
      int questionMarkIndex = url.indexOf("?");
      String result = url.substring(0, questionMarkIndex);
      return result;
    } else {
      return url;
    }
  }

  initAll() async {
    _urlBloc = BlocProvider.of<UrlBloc>(context);
    log("url: ${_urlBloc!.state.url}");
    _intStreamController.add(0);
    String? token = await const FlutterSecureStorage().read(key: "token");
    _channel = await WebSocketService().connectToWebSocket(token!);
    _channel!.sink.add(json.encode({
      "service": "trendyol",
      "product_url": getConvertUrl(_urlBloc!.state.url)
    }));
    _channel!.stream.listen((event) {
      log("event: ${jsonEncode(event)}");
      TrendyolProduct? trendyolProduct = convertJsonToTrendyolProduct(event);
      _streamController.add(trendyolProduct);
    });
  }

  TrendyolProduct convertJsonToTrendyolProduct(dynamic json) {
    Map<String, dynamic> jsonMap = jsonDecode(json);
    return TrendyolProduct.fromJson(jsonMap);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        Navigator.pushNamed(context, "/");
      },
      child: StreamBuilder<TrendyolProduct>(
        stream: _streamController.stream.asBroadcastStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.grey.shade100,
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: const Icon(Icons.arrow_back_ios_outlined),
                      onTap: () {
                        Navigator.pushNamed(context, "/");
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SvgPicture.network(
                            snapshot.data?.data.brandLogo ?? ""),
                      ),
                    ),
                   const SizedBox.shrink(),
                  ],
                ),
              ),
              body: buildBody(snapshot.data),
            );
          } else {
            return Container(
              color: Colors.grey.shade100,
              child: Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.grey.shade100,
              )),
            );
          }
        },
      ),
    );
  }

  buildBody(TrendyolProduct? trendyolProduct) {
    return StreamBuilder<int>(
        stream: _intStreamController.stream.asBroadcastStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            var productSizes = trendyolProduct?.data.productSizes;
            var index = snapshot.data ?? 0;

            return Container(
              color: Colors.grey.shade100,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, top: 10),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1, 0.1),
                                spreadRadius: 0.1),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 20,
                              child: Image.network(trendyolProduct!
                                  .data.productColors[snapshot.data!].image),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            Row(
                              children: [
                                Icon(
                                  Icons.commit,
                                  color: Colors.grey.shade500,
                                  size: 15,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        80),
                                Text(
                                  (" ${trendyolProduct.data.productCategory[trendyolProduct.data.productCategory.length - 2]} Kategorisinde"),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 80),
                            Text(
                              trendyolProduct.data.productName,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade500),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 80),
                            Row(
                              children: [
                                Text(
                                  "Total Price: ${productSizes?[index].price ?? 300}",
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1, 0.1),
                              spreadRadius: 0.1),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Color",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${trendyolProduct.data.productColors.length} Different Color",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 0.8,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 20,
                            height: MediaQuery.of(context).size.height / 5,
                            child: ListView.builder(
                              itemCount:
                                  trendyolProduct.data.productColors.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                ProductColor indexColor =
                                    trendyolProduct.data.productColors[index];
                                return InkWell(
                                  onTap: indexColor.available == "1"  ?  () {
                                    _intStreamController.add(index);
                                  } : (){},
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: SizedBox(
                                        width: 80.0,
                                        height: 100.0,
                                        child: Image.network(indexColor.image,color: indexColor.available == "1"  ? null : Colors.white.withOpacity(0.4)),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1, 0.1),
                              spreadRadius: 0.1),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              "Size",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            thickness: 0.8,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 20,
                            height: MediaQuery.of(context).size.height / 16,
                            child: ListView.builder(
                              itemCount:
                                  trendyolProduct.data.productSizes.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                ProductSize indexSize =
                                    trendyolProduct.data.productSizes[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          strokeAlign: 0.6,
                                          color: indexSize.available == "1"
                                              ? Colors.grey.shade700
                                              : Colors.black26),
                                    ),
                                    width: 55.0,
                                    height: 30.0,
                                    child: Center(
                                      child: Text(indexSize.size,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: indexSize.available == "1"
                                                  ? Colors.grey.shade700
                                                  : Colors.black26,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
