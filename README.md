# Access Control App

A Flutter application that simulates employee access to secure rooms in a building. This internal tool for HR/security allows managers to test access control rules and see detailed results.

## Features

- **Employee Management**: View a list of employees with their access levels and room requests
- **Room Rules**: Display room access requirements including minimum access levels, time windows, and cooldown periods
- **Access Simulation**: Process employee access requests and determine if access should be granted or denied
- **Detailed Results**: Show comprehensive results with reasons for each access decision
- **Summary Statistics**: Display overall statistics of granted vs denied access requests

## Room Rules

The app implements the following room access rules:

| Room | Min Access Level | Open Time | Close Time | Cooldown (min) |
|------|------------------|-----------|------------|----------------|
| ServerRoom | 2 | 09:00 | 11:00 | 15 |
| Vault | 3 | 09:00 | 10:00 | 30 |
| R&D Lab | 1 | 08:00 | 12:00 | 10 |

## Access Logic

Access is granted when ALL of the following conditions are met:
1. Employee's access level is greater than or equal to the room requirement
2. The room is open at the request time
3. The employee has not accessed the same room within the cooldown period

## Sample Data

The app includes sample employee data with various access levels and request times to demonstrate the access control logic.

## Getting Started

1. Ensure you have Flutter installed
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app

## Project Structure

```
lib/
├── models/           # Data models
│   ├── employee.dart
│   ├── room_rule.dart
│   └── access_result.dart
├── services/         # Business logic
│   └── access_control_service.dart
├── data/            # Sample data
│   └── sample_data.dart
├── widgets/         # UI components
│   ├── employee_list_widget.dart
│   ├── room_rules_widget.dart
│   ├── access_results_widget.dart
│   ├── simulate_button_widget.dart
│   └── summary_widget.dart
├── screens/         # Main screens
│   └── access_control_screen.dart
└── main.dart        # App entry point
```
