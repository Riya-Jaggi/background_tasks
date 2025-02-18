import 'dart:async';

import 'package:background_tasks/domain/entities/car_model.dart';
import 'package:background_tasks/domain/usecases/clear_data_use_case.dart';
import 'package:background_tasks/domain/usecases/fetch_last_car_use_case.dart';
import 'package:background_tasks/domain/usecases/insert_car_use_case.dart';
import 'package:background_tasks/presentation/providers/global_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final carProvider = StateNotifierProvider.autoDispose<CarNotifier, CarModel?>(
    (ref) => CarNotifier(
        ref.read(fetchLastCarUseCaseProvider),
        ref.read(insertCarUseCaseProvider),
        ref.read(clearDataUseCaseProvider)));

class CarNotifier extends StateNotifier<CarModel?> {
  final InsertCarUseCase _insertCarUseCase;
  final FetchLastCarUseCase _fetchLastCarUseCase;
  final ClearDataUseCase _clearDataUseCase;
  StreamSubscription<CarModel?>? _subscription;

  CarNotifier(
      this._fetchLastCarUseCase, this._insertCarUseCase, this._clearDataUseCase)
      : super(null) {
    _listemForUpdates();
  }

  Future<void> insertCarEntry(CarModel carModel) async {
    await _insertCarUseCase(carModel);
  }

  void _listemForUpdates() {
    _subscription = _fetchLastCarUseCase().listen((data) {
      state = data;
    });
  }

  void clearData() async {
    await _clearDataUseCase();
  }
}
