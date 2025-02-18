import 'package:background_tasks/core/services/foreground_service.dart';
import 'package:background_tasks/core/services/isolate_service.dart';
import 'package:background_tasks/core/services/permissions.dart';
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
            return Text(
              carState == null
                  ? "No Cars added. Please select option from below buttons to start adding cars."
                  : "Model : ${carState.modelName},\nTag : ${carState.vehicleTag}\nManufacturing Yeaar : ${carState.year}.\nRecord added in database : ${carState.recordEntryDate}\n Record entry time : ${carState.recordEntryTime}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            );
          }),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () async {
                bool status =
                    await PermissionHandler().askNotificationPermission();
                if (status == true) {
                  WorkmanagerService.scheduleTask();
                } else {
                  displaySnackBar(context);
                }
              },
              child: const Text("Start Inserting Car Data With Work Manager")),
          ElevatedButton(
              onPressed: () async {
                bool status =
                    await PermissionHandler().askNotificationPermission();
                if (status == true) {
                  startForegroundService();
                } else {
                  displaySnackBar(context);
                }
              },
              child: const Text(
                  "Start Inserting Car Data With Foreground Service")),
          ElevatedButton(
              onPressed: () {
                startISolateTask();
              },
              child: const Text("Start Inserting Car Data With Isolate")),
          ElevatedButton(
              onPressed: () {
                ref.read(carProvider.notifier).clearData();
              },
              child: const Text("Clear Data"))
        ],
      )),
    );
  }

  void displaySnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Please grant notification permission"),
    ));
  }
}
