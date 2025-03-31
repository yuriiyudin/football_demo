import 'package:football_demo/src/feature/scheduale/data/data_sources/teams_local_data_source.dart';
import 'package:football_demo/src/feature/scheduale/data/repository/team_repository_impl.dart';
import 'package:football_demo/src/feature/scheduale/domain/repository/teams_repository.dart';
import 'package:football_demo/src/feature/scheduale/domain/usecases/fetch_teams_usecase.dart';
import 'package:football_demo/src/feature/scheduale/presentation/bloc/teams_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  initTeamsBloc();
}

//----------------------------//

/* Teams Bloc */
void initTeamsBloc() {
  sl
    // data
    ..registerLazySingleton<TeamsLocalDataSource>(() => TeamsLocalDataSourceImpl())
    // repo
    ..registerLazySingleton<TeamsRepository>(() => TeamRepositoryImpl(dataSource: sl()))
    // usecases
    ..registerLazySingleton(() => FetchTeamsUsecase(repo: sl()))
    // bloc
    ..registerLazySingleton(() => TeamsBloc(fetchTeamsUsecase: sl()));
}
