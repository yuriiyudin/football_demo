import 'package:football_demo/src/core/exceptions/api_exception.dart';
import 'package:football_demo/src/feature/scheduale/data/data_sources/teams_dummy.dart';
import 'package:football_demo/src/feature/scheduale/data/models/team_model.dart';

abstract interface class TeamsLocalDataSource {
  Future<List<TeamModel>> fetchTeams();
}

class TeamsLocalDataSourceImpl implements TeamsLocalDataSource {
  @override
  Future<List<TeamModel>> fetchTeams() async {
    // dummy  data, dummy try catch
    try {
      final data = teamsList;
      return data;
    } on ApiException catch (e, st) {
      throw ApiException();
    }
    //... can cover another exceptions or DioExceptions
  }
}
