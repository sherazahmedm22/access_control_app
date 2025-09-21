import 'package:flutter/material.dart';
import '../models/room_rule.dart';

class RoomRulesWidget extends StatelessWidget {
  const RoomRulesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final roomRules = RoomRule.getDefaultRules();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Room Rules',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Room')),
                DataColumn(label: Text('Min Level')),
                DataColumn(label: Text('Open Time')),
                DataColumn(label: Text('Close Time')),
                DataColumn(label: Text('Cooldown (min)')),
              ],
              rows: roomRules.map((rule) {
                return DataRow(
                  cells: [
                    DataCell(Text(rule.room)),
                    DataCell(Text(rule.minAccessLevel.toString())),
                    DataCell(Text(rule.openTime)),
                    DataCell(Text(rule.closeTime)),
                    DataCell(Text(rule.cooldownMinutes.toString())),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
