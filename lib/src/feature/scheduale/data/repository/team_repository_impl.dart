import 'package:dartz/dartz.dart';
import 'package:football_demo/src/core/exceptions/api_exception.dart';
import 'package:football_demo/src/core/failure/failure.dart';
import 'package:football_demo/src/feature/scheduale/data/data_sources/teams_local_data_source.dart';
import 'package:football_demo/src/feature/scheduale/domain/entites/team_entity.dart';
import 'package:football_demo/src/feature/scheduale/domain/repository/teams_repository.dart';

class TeamRepositoryImpl implements TeamsRepository {
  TeamsLocalDataSource dataSource;
  TeamRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<TeamEntity>>> fetchTeams() async {
    try {
      final data = await dataSource.fetchTeams();
      return right(data.map((e) => e.toEntity()).toList());
    } on ApiException catch (e, st) {
      return left(Failure(message: 'Api error'));
    }
  }
}
