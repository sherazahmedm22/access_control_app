import 'package:flutter/material.dart';
import '../models/access_result.dart';

class AccessResultsWidget extends StatelessWidget {
  final List<AccessResult> results;

  const AccessResultsWidget({Key? key, required this.results})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Access Simulation Results',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final result = results[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: ListTile(
                    leading: Icon(
                      result.granted ? Icons.check_circle : Icons.cancel,
                      color: result.granted ? Colors.green : Colors.red,
                    ),
                    title: Text(
                      '${result.employeeId} - ${result.room}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      result.reason,
                      style: TextStyle(
                        color: result.granted
                            ? Colors.green[700]
                            : Colors.red[700],
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: result.granted
                            ? Colors.green[100]
                            : Colors.red[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        result.granted ? 'GRANTED' : 'DENIED',
                        style: TextStyle(
                          color: result.granted
                              ? Colors.green[800]
                              : Colors.red[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
