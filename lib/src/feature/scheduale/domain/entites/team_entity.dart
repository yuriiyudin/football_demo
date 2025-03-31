import 'package:equatable/equatable.dart';

class TeamEntity extends Equatable {
  final String name;
  final DateTime prefferedStartTime;
  final DateTime prefferedEndTime;
  const TeamEntity({required this.name, required this.prefferedStartTime, required this.prefferedEndTime});

  @override
  List<Object?> get props => [name];
}
