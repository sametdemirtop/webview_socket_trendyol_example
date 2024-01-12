import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  Future<WebSocketChannel> connectToWebSocket(String token) async {
    final channel = IOWebSocketChannel.connect(
      "wss://api.bravoshopgo.com/ws/api/v1/?token=$token",
      headers: {
        "origin": "https://api.bravoshopgo.com",
      },
    );

    return channel;
  }


}