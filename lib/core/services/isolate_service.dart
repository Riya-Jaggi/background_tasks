import 'dart:developer';
import 'dart:isolate';

import 'package:background_tasks/data/data_sources/firebase_data_source_impl.dart';
import 'package:background_tasks/domain/entities/car_model.dart';

void startISolateTask() async {
  final receivePort = ReceivePort();
  await Isolate.spawn(isolateTask, receivePort.sendPort);

  receivePort.listen((carData) async {
    FirebaseDataSourceImpl firebaseDataSourceImpl = FirebaseDataSourceImpl();

    await firebaseDataSourceImpl.insertCar(carData);
    log("Inserted Data to Firebase via foreground Isolate");
  });
}

void isolateTask(SendPort sendPort) async {
  CarModel carModel = CarModel(
      modelName: "Tesla Isolate",
      vehicleTag: "ISO123",
      year: "2025",
      recordEntryDate:
          "${DateTime.now().day} - ${DateTime.now().month} - ${DateTime.now().year}",
      recordEntryTime:
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}");

  // Send data to the main Isolate
  sendPort.send(carModel);
}
