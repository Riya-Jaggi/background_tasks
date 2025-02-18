import 'package:background_tasks/domain/entities/car_model.dart';

abstract class FirebaseDataSource {
  Future<void> insertCar(CarModel carModel);
  Stream<CarModel?> fetchLastCar();
  Future<void> clearData();
}
