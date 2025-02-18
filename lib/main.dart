import 'package:background_tasks/core/services/workmanager_service.dart';
import 'package:background_tasks/firebase_options.dart';
import 'package:background_tasks/presentation/screens/car_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



late final FirebaseApp firebaseApp;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  WorkmanagerService.initialize();

  FirebaseCrashlytics.instance.recordFlutterFatalError;
  
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'car_logger_channel',
      channelName: 'Car Logger',
      channelDescription: 'Logs car data every 15 minutes',
     
    ),
    iosNotificationOptions: const IOSNotificationOptions(showNotification: true,
      playSound: true,), foregroundTaskOptions: ForegroundTaskOptions(
      eventAction: ForegroundTaskEventAction.repeat(15 * 60 * 1000),
      autoRunOnBoot: true,
      autoRunOnMyPackageReplaced: true,
      allowWakeLock: true,
      allowWifiLock: true,
    ),
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Background Tasks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CarScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
