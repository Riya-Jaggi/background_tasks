import 'package:background_tasks/data/data_sources/firebase_data_source.dart';
import 'package:background_tasks/data/data_sources/firebase_data_source_impl.dart';
import 'package:background_tasks/data/repositories_impl/car_repo_impl.dart';
import 'package:background_tasks/domain/repositories/car_repo.dart';
import 'package:background_tasks/domain/usecases/fetch_last_car_use_case.dart';
import 'package:background_tasks/domain/usecases/insert_car_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Firebase data source provider
final firebaseDataSourceProvider =
    Provider.autoDispose<FirebaseDataSource>((ref) {
  return FirebaseDataSourceImpl();
});

// Car repo provider
final carRepoProvider = Provider.autoDispose<CarRepo>((ref) {
  return CarRepoImpl(ref.read(firebaseDataSourceProvider));
});

// Insert car use case provider
final insertCarUseCaseProvider = Provider.autoDispose<InsertCarUseCase>((ref) {
  return InsertCarUseCase(ref.read(carRepoProvider));
});

// Fetch last car use case provider
final fetchLastCarUseCaseProvider =
    Provider.autoDispose<FetchLastCarUseCase>((ref) {
  return FetchLastCarUseCase(ref.read(carRepoProvider));
});
