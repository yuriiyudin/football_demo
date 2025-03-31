import 'package:football_demo/src/feature/scheduale/domain/entites/team_entity.dart';

enum TeamsStateStatus { initial, loading, success, failure }

class TeamsState {
  final TeamsStateStatus teamsStateStatus;
  final List<TeamEntity> teams;
  final String? message;
  TeamsState({required this.teamsStateStatus, required this.teams, this.message});

  factory TeamsState.initial() {
    return TeamsState(teamsStateStatus: TeamsStateStatus.initial, teams: []);
  }

  TeamsState copyWith({TeamsStateStatus? teamsStateStatus, List<TeamEntity>? teams, String? message}) {
    return TeamsState(
      teamsStateStatus: teamsStateStatus ?? this.teamsStateStatus,
      teams: teams ?? this.teams,
      message: message,
    );
  }
}
