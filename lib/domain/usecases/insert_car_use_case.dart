import 'package:background_tasks/domain/entities/car_model.dart';
import 'package:background_tasks/domain/repositories/car_repo.dart';

class InsertCarUseCase {
  final CarRepo carRepo;

  InsertCarUseCase(this.carRepo);

  Future<void> call(CarModel carModel) async {
    return carRepo.insertCar(carModel);
  }
}
