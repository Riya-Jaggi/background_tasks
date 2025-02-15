import 'package:background_tasks/data/data_sources/firebase_data_source.dart';
import 'package:background_tasks/domain/entities/car_model.dart';
import 'package:background_tasks/domain/repositories/car_repo.dart';

class CarRepoImpl implements CarRepo {
  final FirebaseDataSource firebaseDataSource;

  CarRepoImpl(this.firebaseDataSource);

  @override
  Stream<CarModel?> fetchLastCar()  {
    return firebaseDataSource.fetchLastCar();
  }

  @override
  Future<void> insertCar(CarModel carModel) async {
    await firebaseDataSource.insertCar(carModel);
  }
}
