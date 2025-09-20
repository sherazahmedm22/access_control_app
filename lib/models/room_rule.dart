class RoomRule {
  final String room;
  final int minAccessLevel;
  final String openTime;
  final String closeTime;
  final int cooldownMinutes;

  RoomRule({
    required this.room,
    required this.minAccessLevel,
    required this.openTime,
    required this.closeTime,
    required this.cooldownMinutes,
  });

  // Static data based on the room rules table
  static List<RoomRule> getDefaultRules() {
    return [
      RoomRule(
        room: 'ServerRoom',
        minAccessLevel: 2,
        openTime: '09:00',
        closeTime: '11:00',
        cooldownMinutes: 15,
      ),
      RoomRule(
        room: 'Vault',
        minAccessLevel: 3,
        openTime: '09:00',
        closeTime: '10:00',
        cooldownMinutes: 30,
      ),
      RoomRule(
        room: 'R&D Lab',
        minAccessLevel: 1,
        openTime: '08:00',
        closeTime: '12:00',
        cooldownMinutes: 10,
      ),
    ];
  }
}
