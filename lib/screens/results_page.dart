import 'package:flutter/material.dart';
import '../models/access_result.dart';
import '../widgets/access_results_widget.dart';
import '../widgets/summary_widget.dart';

class ResultsPage extends StatelessWidget {
  final List<AccessResult> results;

  const ResultsPage({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    int grantedCount = results.where((r) => r.granted).length;
    int deniedCount = results.length - grantedCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulation Results'),
        backgroundColor: Colors.purple[700],
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _showShareDialog(context),
            tooltip: 'Share Results',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.purple[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Access Control Results',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Processed ${results.length} requests • ${grantedCount} granted • ${deniedCount} denied',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SummaryWidget(results: results),
                  AccessResultsWidget(results: results),
                  const SizedBox(height: 16),
                  _buildActionButtons(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Simulation'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _runNewSimulation(context),
              icon: const Icon(Icons.refresh),
              label: const Text('Run Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _runNewSimulation(BuildContext context) {
    // Navigate back to simulation page
    Navigator.pop(context);
  }

  void _showShareDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Share Results'),
          content: const Text(
            'This feature would allow you to export or share the simulation results. '
            'In a real application, this could generate reports or send results via email.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
