import 'package:flutter/material.dart';
import '../models/employee.dart';

class EmployeeListWidget extends StatelessWidget {
  final List<Employee> employees;

  const EmployeeListWidget({super.key, required this.employees});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Employee Access Requests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getAccessLevelColor(employee.accessLevel),
                    child: Text(
                      employee.accessLevel.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(employee.id),
                  subtitle: Text('Room: ${employee.room}'),
                  trailing: Text(
                    employee.requestTime,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getAccessLevelColor(int accessLevel) {
    switch (accessLevel) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
