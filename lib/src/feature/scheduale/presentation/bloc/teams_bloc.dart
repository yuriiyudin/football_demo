import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_demo/src/core/usecase/usecase.dart';
import 'package:football_demo/src/feature/scheduale/domain/usecases/fetch_teams_usecase.dart';
import 'package:football_demo/src/feature/scheduale/presentation/bloc/teams_event.dart';
import 'package:football_demo/src/feature/scheduale/presentation/bloc/teams_state.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  final FetchTeamsUsecase _fetchTeamsUsecase;
  TeamsBloc({required FetchTeamsUsecase fetchTeamsUsecase})
    : _fetchTeamsUsecase = fetchTeamsUsecase,
      super(TeamsState.initial()) {
    on(_onFetchTeamsEvent);
  }

  Future<void> _onFetchTeamsEvent(FetchTeamsEvent event, Emitter<TeamsState> emit) async {
    emit(state.copyWith(teamsStateStatus: TeamsStateStatus.loading));

    final result = await _fetchTeamsUsecase.call(NoParams());

    result.fold(
      (l) => emit(state.copyWith(teamsStateStatus: TeamsStateStatus.failure, message: l.message)),
      (r) => emit(state.copyWith(teamsStateStatus: TeamsStateStatus.success, teams: r)),
    );
  }
}
