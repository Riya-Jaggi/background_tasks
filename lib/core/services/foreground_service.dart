import 'dart:async';
import 'dart:developer';

import 'package:background_tasks/data/data_sources/firebase_data_source_impl.dart';
import 'package:background_tasks/domain/entities/car_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

// The callback function should always be a top-level or static function.
@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {
  // Called when the task is started.
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    log('onStart(starter: ${starter.name})');
    start();
  }

  // Called based on the eventAction set in ForegroundTaskOptions.
  @override
  void onRepeatEvent(DateTime timestamp) {
    // Send data to main isolate.
    final Map<String, dynamic> data = {
      "timestampMillis": timestamp.millisecondsSinceEpoch,
    };
    addDataToFireBase();
    FlutterForegroundTask.sendDataToMain(data);
  }

  // Called when the task is destroyed.
  @override
  Future<void> onDestroy(DateTime timestamp) async {
    log('onDestroy');
  }

  // Called when data is sent using `FlutterForegroundTask.sendDataToTask`.
  @override
  void onReceiveData(Object data) {
    log('onReceiveData: $data');
  }

  // Called when the notification button is pressed.
  @override
  void onNotificationButtonPressed(String id) {
    log('onNotificationButtonPressed: $id');
  }

  // Called when the notification itself is pressed.
  @override
  void onNotificationPressed() {
    log('onNotificationPressed');
  }

  // Called when the notification itself is dismissed.
  @override
  void onNotificationDismissed() {
    log('onNotificationDismissed');
  }
}

Future<void> startForegroundService() async {
  await FlutterForegroundTask.startService(
      notificationTitle: "Car Background Task",
      notificationText: "Inserting Entry To Firebase every 15 min",
      callback: startCallback);
}

void stopForegroundService() async {
  await FlutterForegroundTask.stopService();
}

void start() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  log("Foreground Service Started");
  
}

void addDataToFireBase() async {
  FirebaseDataSourceImpl firebaseDataSourceImpl = FirebaseDataSourceImpl();

  CarModel carModel = CarModel(
      modelName: "Tesla Foreground Service",
      vehicleTag: "XYZ123",
      year: "2024",
      recordEntryDate:
          "${DateTime.now().day} - ${DateTime.now().month} - ${DateTime.now().year}",
      recordEntryTime:
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}");

  await firebaseDataSourceImpl.insertCar(carModel);

  log("Inserted Data to Firebase via foreground service");
}
