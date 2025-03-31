import 'package:equatable/equatable.dart';

class FieldEntity {
  final String title;
  final List<DateTime> workingHours;
  final List<AvailableSlot> availableSlots = [];

  FieldEntity({required this.title, required this.workingHours}) {
    generateSlots();
  }

  // Generate available slots for field
  void generateSlots() {
    // Maximum slots for field
    final maxSlotForDay = workingHours.last.difference(workingHours.first).inMinutes ~/ 70;

    //Start time
    DateTime startWorkingHours = workingHours.first;

    for (var i = 0; i < maxSlotForDay; i++) {
      availableSlots.add(
        AvailableSlot(starTime: startWorkingHours, endTime: startWorkingHours.add(Duration(minutes: 70))),
      );
      startWorkingHours = startWorkingHours.add(Duration(minutes: 70));
    }
  }
}

class AvailableSlot extends Equatable {
  final DateTime starTime;
  final DateTime endTime;
  const AvailableSlot({required this.starTime, required this.endTime});

  @override
  List<Object?> get props => [starTime, endTime];
}
