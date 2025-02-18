import 'package:background_tasks/domain/repositories/car_repo.dart';

class ClearDataUseCase {
  CarRepo carRepo;

  ClearDataUseCase(this.carRepo);

  Future<void> call() {
    return carRepo.clearData();
  }
}