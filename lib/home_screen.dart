
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:notificaciones/notification_services.dart';
import "package:http/http.dart" as http;
class HomeScreen extends StatefulWidget{
  const HomeScreen({Key?key}): super(key: key);
  @override
  State<HomeScreen>createState()=>_HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
  
  NotificationServices notificationServices=NotificationServices();
  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit();
    notificationServices.getDeviceToken().then((value){
      print("Device token");
      print(value);
    });
    
  }
  @override
 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
          title: const Text("Avisos"),
          centerTitle: true,
    ),
    body: Center(
      child: ElevatedButton(
              onPressed: () {{
                  notificationServices.getDeviceToken().then((value) async {
                    var movil =
                        "f_wK1HScQFejlZuIjiviHy:APA91bGWJS85oFonLCa9Lzrz4x-kj_eraSeGR63HzSBz8fVDC7fiMASQdhi0R-9zFtcOUmTlfH_NYZsRgNdMRFmgbpLgF3VrWhFIflPZuRZmsqzcUplPqbABdC2uUhblPA0FhnBO5ELp";
                    var wear =
                        "cqBualvTTRusvv6ovIxty2:APA91bH8k4buRcmpSMJ5BpVlx35DkZMfCGkkAJ-KeF8oQVV71bjb4q7X045-x1X9yE6WrTw88oqVsG10inLIt0e4IsIUnCMMZA-pIZCzna5HsnHCtmztQOEpZ4Vn9e2Z552Ixk9dM2hp";
                    var data = {
                      "to":wear,
                      "priority": "high",
                      "notification": {
                        "title": "Soy una notificacion",
                        "body": "Hola, te estoy notificando",
                      },
                      "data": {
                        "type": "msj",
                        "id": "123456"
                      }
                    };
                    await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
                        body: jsonEncode(data),
                        headers: {
                          "Content-Type": "application/json; charset=UTF-8",
                          "Authorization":
                              "key=AAAAmgy-pyo:APA91bG307pi52mGzpqppAqvbbseehu9Xwa82_1XISrEqWltfMi2hfGpfgdNN63zzVqjoIFApVsUxWIFgMUz_V-QmX8EhBs5lVu0xb3AnOFZd_dfVgzIif6994pNydigrJgIvf5yp9kZ"
                        });
                  });
                }
              },
              child: const Text('Notificar'),
            ),
    ),
  );
}
}