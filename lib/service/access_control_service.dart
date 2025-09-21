import '../models/employee.dart';
import '../models/room_rule.dart';
import '../models/access_result.dart';

class AccessControlService {
  static List<RoomRule> roomRules = RoomRule.getDefaultRules();

  static List<AccessResult> simulateAccess(List<Employee> employees) {
    List<AccessResult> results = [];
    Map<String, DateTime> lastAccessTime =
        {}; // Track last access time for each employee-room combination

    for (Employee employee in employees) {
      RoomRule? roomRule = roomRules.firstWhere(
        (rule) => rule.room == employee.room,
        orElse: () => throw Exception('Room ${employee.room} not found'),
      );

      String reason = '';
      bool granted = true;

      // Check access level
      if (employee.accessLevel < roomRule.minAccessLevel) {
        granted = false;
        reason =
            'Denied: Below required level (${employee.accessLevel} < ${roomRule.minAccessLevel})';
      }
      // Check if room is open at request time
      else if (!_isRoomOpen(
        employee.requestTime,
        roomRule.openTime,
        roomRule.closeTime,
      )) {
        granted = false;
        reason =
            'Denied: Room closed at ${employee.requestTime} (Open: ${roomRule.openTime}-${roomRule.closeTime})';
      }
      // Check cooldown period
      else if (_isInCooldown(employee, roomRule, lastAccessTime)) {
        granted = false;
        reason =
            'Denied: Still in cooldown period (${roomRule.cooldownMinutes} minutes)';
      } else {
        reason = 'Access granted to ${employee.room}';
        // Update last access time
        lastAccessTime['${employee.id}_${employee.room}'] = _parseTime(
          employee.requestTime,
        );
      }

      results.add(
        AccessResult(
          employeeId: employee.id,
          room: employee.room,
          granted: granted,
          reason: reason,
        ),
      );
    }

    return results;
  }

  static bool _isRoomOpen(
    String requestTime,
    String openTime,
    String closeTime,
  ) {
    DateTime request = _parseTime(requestTime);
    DateTime open = _parseTime(openTime);
    DateTime close = _parseTime(closeTime);

    return request.isAfter(open.subtract(const Duration(minutes: 1))) &&
        request.isBefore(close.add(const Duration(minutes: 1)));
  }

  static bool _isInCooldown(
    Employee employee,
    RoomRule roomRule,
    Map<String, DateTime> lastAccessTime,
  ) {
    String key = '${employee.id}_${employee.room}';
    if (!lastAccessTime.containsKey(key)) {
      return false;
    }

    DateTime lastAccess = lastAccessTime[key]!;
    DateTime currentRequest = _parseTime(employee.requestTime);
    Duration timeDifference = currentRequest.difference(lastAccess);

    return timeDifference.inMinutes < roomRule.cooldownMinutes;
  }

  static DateTime _parseTime(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    // Use today's date for time comparison
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
}
