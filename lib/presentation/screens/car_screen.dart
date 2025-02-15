import 'package:background_tasks/core/services/foreground_service.dart';
import 'package:background_tasks/core/services/isolate_service.dart';
import 'package:background_tasks/core/services/workmanager_service.dart';
import 'package:background_tasks/presentation/providers/car_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarScreen extends ConsumerWidget {
  const CarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Car Background Task",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Consumer(builder: (context, ref, child) {
            final carState = ref.watch(carProvider);
            return Text(carState == null
                ? "No Cars added. Please select option from below buttons to start adding cars."
                : "Last Car : ${carState.modelName}, ${carState.vehicleTag} manufactured in ${carState.year}. \nRecord added in database on ${carState.recordEntryDate} at ${carState.recordEntryTime}.");
          }),
          ElevatedButton(
              onPressed: () {
                WorkmanagerService.scheduleTask();
              },
              child: const Text("Start Inserting Car Data With Work Manager")),
          ElevatedButton(
              onPressed: () {
                startForegroundService();
              },
              child: const Text(
                  "Start Inserting Car Data With Foreground Service")),
          ElevatedButton(
              onPressed: () {
                startISolateTask();
              },
              child: const Text("Start Inserting Car Data With Isolate"))
        ],
      )),
    );
  }
}
