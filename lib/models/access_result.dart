class AccessResult {
  final String employeeId;
  final String room;
  final bool granted;
  final String reason;

  AccessResult({
    required this.employeeId,
    required this.room,
    required this.granted,
    required this.reason,
  });
}
