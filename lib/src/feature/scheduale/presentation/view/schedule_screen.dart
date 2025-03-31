import 'package:flutter/material.dart';
import 'package:football_demo/src/feature/scheduale/data/data_sources/teams_dummy.dart';
import 'package:football_demo/src/feature/scheduale/domain/entites/field_entity.dart';
import 'package:football_demo/src/feature/scheduale/domain/entites/schedule_entity.dart';

import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late ScheduleEntity schedule;

  int? draggedIndex;

  @override
  void initState() {
    super.initState();
    final FieldEntity field = FieldEntity(
      title: 'Super Field',
      workingHours: [DateTime(2025, 3, 28, 13, 00), DateTime(2025, 3, 28, 21, 00)],
    );
    schedule = ScheduleEntity(field: field, teams: teamsList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Table(
            border: TableBorder.all(),
            children: [
              for (var i = 0; i < schedule.matches.length; i++)
                TableRow(
                  children: [
                    Draggable<int>(
                      data: i,
                      onDragStarted: () => setState(() => draggedIndex = i),
                      onDragEnd: (_) => setState(() => draggedIndex = null),
                      feedback: Material(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.white,
                          child: Text(
                            schedule.matches[i].teams.isEmpty
                                ? 'Empty Slot'
                                : '${schedule.matches[i].teams.first.name} - ${schedule.matches[i].teams.last.name}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      childWhenDragging: const SizedBox(),
                      child: DragTarget<int>(
                        onAcceptWithDetails: (draggableIndex) {
                          if (schedule.swapTeams(draggableIndex: draggableIndex.data, targetIndex: i)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Center(child: Text('Swapped success', style: TextStyle(color: Colors.green))),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Center(
                                  child: Text('Time conflict detected!', style: TextStyle(color: Colors.red)),
                                ),
                              ),
                            );
                          }
                        },
                        builder: (context, candidateData, rejectedData) {
                          return Container(
                            padding: const EdgeInsets.all(8),
                            color: draggedIndex == i ? Colors.grey[200] : Colors.transparent,
                            child: Text(
                              schedule.matches[i].teams.isEmpty
                                  ? 'Empty Slot'
                                  : '${schedule.matches[i].teams.first.name} - ${schedule.matches[i].teams.last.name}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '${DateFormat('HH:mm').format(schedule.matches[i].slot.starTime)} - '
                        '${DateFormat('HH:mm').format(schedule.matches[i].slot.endTime)}',
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
