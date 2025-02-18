import 'package:background_tasks/domain/entities/car_model.dart';

abstract class CarRepo {
  Future<void> insertCar(CarModel carModel);
  Stream<CarModel?> fetchLastCar();
  Future<void> clearData();
}
