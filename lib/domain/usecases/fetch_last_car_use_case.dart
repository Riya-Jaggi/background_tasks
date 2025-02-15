import 'package:background_tasks/domain/entities/car_model.dart';
import 'package:background_tasks/domain/repositories/car_repo.dart';

class FetchLastCarUseCase {
  CarRepo carRepo;

  FetchLastCarUseCase(this.carRepo);

  Stream<CarModel?> call() {
    return carRepo.fetchLastCar();
  }
}
