import 'package:equatable/equatable.dart';
import 'package:football_demo/src/feature/scheduale/data/models/team_model.dart';
import 'package:football_demo/src/feature/scheduale/domain/entites/field_entity.dart';

class ScheduleEntity {
  final FieldEntity field;
  final List<TeamModel> teams;
  List<Match> _matches = [];

  List<Match> get matches => _matches;

  ScheduleEntity({required this.field, required this.teams}) {
    generateMatches();
  }

  void generateMatches() {
    // Every team  get one slot in game event
    for (var i = 0; i < teams.length; i++) {
      final availableSlot = field.availableSlots[i];
      if (teams[i].prefferedStartTime.isBefore(field.workingHours.first) &&
          teams[i].prefferedEndTime.isAfter(field.workingHours.last)) {
        continue;
      } else {
        final match = Match(teams: {teams[i]}, slot: availableSlot);
        _matches.add(match);
      }
    }

    // Set opponents
    for (var i = 0; i < teams.length; i++) {
      if (teams[i].prefferedStartTime.isBefore(field.workingHours.first) &&
          teams[i].prefferedEndTime.isAfter(field.workingHours.last)) {
        continue;
      } else {
        final team = teams[i];
        bool added = false;
        _matches =
            _matches.map((match) {
              if (match.teams.length != 2 && !match.teams.contains(team) && !added) {
                added = true;
                teams.remove(team);
                i--;
                return Match(teams: {...match.teams, team}, slot: match.slot);
              } else {
                return match;
              }
            }).toList();
        bool needShafle = false;
        while (true) {
          for (var i = 0; i < _matches.length - 1; i++) {
            if (_matches[i].teams.any((team) => _matches[i + 1].teams.contains(team))) {
              needShafle = true;
              break;
            }
          }
          if (needShafle) {
            _matches.shuffle();
            _matches.sort((a, b) => a.slot.starTime.compareTo(b.slot.endTime));
            needShafle = false;
          } else {
            break;
          }
        }
      }
    }
  }

  bool swapTeams({required int draggableIndex, required int targetIndex}) {
    //check before real swap
    final tempSchedule = List.of(_matches);
    tempSchedule[draggableIndex] = _matches[targetIndex];
    tempSchedule[targetIndex] = _matches[draggableIndex];

    for (var i = 0; i < tempSchedule.length - 1; i++) {
      if (tempSchedule[i].teams.any((team) => tempSchedule[i + 1].teams.contains(team))) {
        return false;
      }
    }
    // real swap
    final temp = _matches[draggableIndex];
    _matches[draggableIndex] = _matches[targetIndex];
    _matches[targetIndex] = temp;
    return true;
  }
}

class Match extends Equatable {
  final Set<TeamModel> teams;
  final AvailableSlot slot;
  const Match({required this.teams, required this.slot});

  @override
  List<Object?> get props => [teams];
}
