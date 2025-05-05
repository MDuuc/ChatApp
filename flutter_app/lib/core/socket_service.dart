import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  late IO.Socket _socket;
  final FlutterSecureStorage storage = FlutterSecureStorage();

  SocketService._internal(){
    initSocket();
  }

  Future<void> initSocket() async {
    String token = await storage.read(key: 'token') ?? '';
    _socket = IO.io(
      'http://10.0.2.2:5000',
      IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .setExtraHeaders({'Authorization': 'Bearer $token'})
        .build(),
    );
    socket.connect();
    socket.onConnect((_) {
      print('Socket connected: ${socket.id}');
    });
    socket.onDisconnect((_) {
      print('Socket disconnected');
    });
  }

  IO.Socket get socket => _socket;
}