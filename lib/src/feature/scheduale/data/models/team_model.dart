// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:football_demo/src/feature/scheduale/domain/entites/team_entity.dart';

class TeamModel {
  final String name;
  final DateTime prefferedStartTime;
  final DateTime prefferedEndTime;
  TeamModel({required this.name, required this.prefferedStartTime, required this.prefferedEndTime});

  TeamEntity toEntity() {
    return TeamEntity(name: name, prefferedStartTime: prefferedStartTime, prefferedEndTime: prefferedEndTime);
  }
}
