import 'package:background_tasks/data/data_sources/firebase_data_source.dart';
import 'package:background_tasks/domain/entities/car_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDataSourceImpl implements FirebaseDataSource {
  final DatabaseReference _databaseReference = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: "https://backgroundtasks-default-rtdb.firebaseio.com/")
      .ref("cars");

  @override
  Stream<CarModel?> fetchLastCar() {
    return FirebaseDatabase.instance
        .ref("cars")
        .limitToLast(1)
        .onValue
        .map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        final latestCarData = data.values.first;
        return CarModel(
            modelName: latestCarData['modelName'],
            vehicleTag: latestCarData['vehicleTag'],
            year: latestCarData['year'],
            recordEntryDate: latestCarData['recordEntryDate'],
            recordEntryTime: latestCarData['recordEntryTime']);
      }
      return null;
    });
  }

  @override
  Future<void> insertCar(CarModel carModel) async {
    await _databaseReference.push().set({
      'modelName': carModel.modelName,
      'year': carModel.year,
      'vehicleTag': carModel.vehicleTag,
      'recordEntryDate': carModel.recordEntryDate,
      'recordEntryTime': carModel.recordEntryTime
    });
  }
}
