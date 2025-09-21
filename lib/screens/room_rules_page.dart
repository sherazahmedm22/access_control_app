import 'package:flutter/material.dart';
import '../models/room_rule.dart';

class RoomRulesPage extends StatelessWidget {
  const RoomRulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final roomRules = RoomRule.getDefaultRules();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Rules'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.green[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Room Access Requirements',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Total: ${roomRules.length} rooms configured',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  ...roomRules.map((rule) => _buildRoomCard(rule)).toList(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(RoomRule rule) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getRoomColor(rule.room).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getRoomIcon(rule.room),
                    color: _getRoomColor(rule.room),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rule.room,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Minimum Access Level: ${rule.minAccessLevel}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    'Open Time',
                    rule.openTime,
                    Icons.access_time,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildInfoCard(
                    'Close Time',
                    rule.closeTime,
                    Icons.access_time_filled,
                    Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildInfoCard(
              'Cooldown Period',
              '${rule.cooldownMinutes} minutes',
              Icons.timer,
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRoomColor(String room) {
    switch (room) {
      case 'ServerRoom':
        return Colors.blue;
      case 'Vault':
        return Colors.red;
      case 'R&D Lab':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getRoomIcon(String room) {
    switch (room) {
      case 'ServerRoom':
        return Icons.dns;
      case 'Vault':
        return Icons.lock;
      case 'R&D Lab':
        return Icons.science;
      default:
        return Icons.room;
    }
  }
}
