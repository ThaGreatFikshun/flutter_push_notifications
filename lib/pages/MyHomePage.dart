import 'package:flutter/material.dart';
import 'package:flutter_push_notifications/pages/MySecondScreen.dart';
import 'package:flutter_push_notifications/utils/notification_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final NotificationService notificationService;
  @override
  void initState() {
    notificationService = NotificationService();
    listenToNotificationStream();
    notificationService.initializePlatformNotifications();
    super.initState();
  }

  void listenToNotificationStream() =>
      notificationService.behaviorSubject.listen((payload) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MySecondScreen(payload: payload)));
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TakeMeds"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 100),
            child: Image.asset("assets/images/justwater.png", scale: 0.6),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await notificationService.showScheduledLocalNotification(
                        id: 1,
                        title: "Take Meds",
                        body: "Time to take your meds!",
                        payload: "You just took your meds! Huurray!",
                        hours: 1);
                  },
                  child: const Text("Schedule Notification "))
            ],
          ),
        ],
      ),
    );
  }
}
