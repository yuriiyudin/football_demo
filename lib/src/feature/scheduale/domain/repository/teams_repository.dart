import 'package:dartz/dartz.dart';
import 'package:football_demo/src/core/failure/failure.dart';
import 'package:football_demo/src/feature/scheduale/domain/entites/team_entity.dart';

abstract class TeamsRepository {
  Future<Either<Failure, List<TeamEntity>>> fetchTeams();
}
