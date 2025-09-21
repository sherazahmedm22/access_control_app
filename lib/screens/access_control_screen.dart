import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../models/access_result.dart';
import '../data/sample_data.dart';
import '../services/access_control_service.dart';
import '../widgets/employee_list_widget.dart';
import '../widgets/room_rules_widget.dart';
import '../widgets/access_results_widget.dart';
import '../widgets/simulate_button_widget.dart';
import '../widgets/summary_widget.dart';

class AccessControlScreen extends StatefulWidget {
  const AccessControlScreen({Key? key}) : super(key: key);

  @override
  State<AccessControlScreen> createState() => _AccessControlScreenState();
}

class _AccessControlScreenState extends State<AccessControlScreen> {
  List<Employee> employees = [];
  List<AccessResult> results = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  void _loadEmployees() {
    setState(() {
      employees = SampleData.getEmployees();
    });
  }

  void _simulateAccess() async {
    setState(() {
      isLoading = true;
    });

    // Simulate processing delay
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      results = AccessControlService.simulateAccess(employees);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Access Control System'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const RoomRulesWidget(),
            EmployeeListWidget(employees: employees),
            SimulateButtonWidget(
              onPressed: _simulateAccess,
              isLoading: isLoading,
            ),
            SummaryWidget(results: results),
            AccessResultsWidget(results: results),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
