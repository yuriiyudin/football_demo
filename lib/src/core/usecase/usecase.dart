import 'package:dartz/dartz.dart';
import 'package:football_demo/src/core/failure/failure.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
