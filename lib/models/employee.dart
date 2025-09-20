class Employee {
  final String id;
  final int accessLevel;
  final String requestTime;
  final String room;

  Employee({
    required this.id,
    required this.accessLevel,
    required this.requestTime,
    required this.room,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      accessLevel: json['access_level'],
      requestTime: json['request_time'],
      room: json['room'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'access_level': accessLevel,
      'request_time': requestTime,
      'room': room,
    };
  }
}
