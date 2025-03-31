import 'package:dartz/dartz.dart';
import 'package:football_demo/src/core/failure/failure.dart';
import 'package:football_demo/src/core/usecase/usecase.dart';
import 'package:football_demo/src/feature/scheduale/domain/entites/team_entity.dart';
import 'package:football_demo/src/feature/scheduale/domain/repository/teams_repository.dart';

class FetchTeamsUsecase implements Usecase<List<TeamEntity>, NoParams> {
  final TeamsRepository repo;
  FetchTeamsUsecase({required this.repo});
  @override
  Future<Either<Failure, List<TeamEntity>>> call(NoParams params) async {
    final result = await repo.fetchTeams();
    return result;
  }
}
