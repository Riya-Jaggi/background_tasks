import 'dart:developer';

import 'package:background_tasks/data/data_sources/firebase_data_source_impl.dart';
import 'package:background_tasks/domain/entities/car_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

const String taskName = "backgroundTask";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask(
    (taskName, inputData) async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

      FirebaseDataSourceImpl firebaseDataSourceImpl = FirebaseDataSourceImpl();

      CarModel carModel = CarModel(
          modelName: "Tesla Work Manager",
          vehicleTag: "XYZ123",
          year: "2024",
          recordEntryDate:
              "${DateTime.now().day} - ${DateTime.now().month} - ${DateTime.now().year}",
          recordEntryTime:
              "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}");

      await firebaseDataSourceImpl.insertCar(carModel);

      log("Inserted Data to Firebase via foreground Workmanager");

      return Future.value(true);
    },
  );
}

class WorkmanagerService {
  static void initialize() {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  }

  static void scheduleTask() {
    Workmanager().registerPeriodicTask(
      "1",
      taskName,
      frequency: const Duration(minutes: 15),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }
}
