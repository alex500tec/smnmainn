/*
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smn/MainApp.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'Notificaciones de alta importancia',
    description: 'Este canal es usado para notificaciones de la APP del clima',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    initPushNotifications();
    initLocalNotifications();
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(manejaMensajes);

    FirebaseMessaging.onMessageOpenedApp.listen(manejaMensajes);

    FirebaseMessaging.onBackgroundMessage(manejaMensajeMinimizado);

    FirebaseMessaging.onMessage.listen((mensaje) {
      final notificacion = mensaje.notification;
      if (notificacion == null) return;
      _localNotifications.show(
          notificacion.hashCode,
          notificacion.title,
          notificacion.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  _androidChannel.id, _androidChannel.name,
                  channelDescription: _androidChannel.description,
                  icon: '@drawable/ic_launcher')),
          payload: jsonEncode(mensaje.toMap()));
    });
  }

  void manejaMensajes(RemoteMessage? mensaje) {
    if (mensaje == null) return;
    //navigatorKey.currentState?.pushNamed();
  }

  Future<void> manejaMensajeMinimizado(RemoteMessage mensaje) async {
    print('Titulo: ${mensaje.notification?.title}');
    print('Cuerpo: ${mensaje.notification?.body}');
    print('Datos: ${mensaje.data}');
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@drawable/ic_launcher');

    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(settings,
        onDidReceiveBackgroundNotificationResponse:
            ((NotificationResponse respuesta) {
      final payload = respuesta.payload;
      final mensaje = RemoteMessage.fromMap(jsonDecode(payload!));

      manejaMensajes(mensaje);
    }));
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> mostrarNotificacionLocal({
    required String titulo,
    required String cuerpo,
    Map<String, dynamic>? data,
  }) async {
    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      titulo,
      cuerpo,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          importance: Importance.max,
          priority: Priority.high,
          icon: '@drawable/ic_launcher',
        ),
      ),
      payload: jsonEncode(data ?? {}),
    );
  }
}
*/