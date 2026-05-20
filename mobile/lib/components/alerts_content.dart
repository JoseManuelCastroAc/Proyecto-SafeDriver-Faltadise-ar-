import 'package:flutter/material.dart';

class AlertsContent extends StatefulWidget {
  const AlertsContent({super.key});

  @override
  State<AlertsContent> createState() => _AlertsContentState();
}

class _AlertsContentState extends State<AlertsContent> {
  String selectedFilter = "ALL";

  final List<Map<String, dynamic>> alerts = [
    {
      "title": "Fatigue Detected",
      "driver": "Carlos Ruiz",
      "vehicle": "ABC-123",
      "time": "14:32",
      "status": "CRITICAL",
      "color": Colors.redAccent,
    },
    {
      "title": "High Speed",
      "driver": "Juan Pérez",
      "vehicle": "XYZ-789",
      "time": "14:28",
      "status": "WARNING",
      "color": Colors.amber,
    },
    {
      "title": "Normal Operation",
      "driver": "Luis Morales",
      "vehicle": "LMN-456",
      "time": "14:10",
      "status": "NORMAL",
      "color": Colors.greenAccent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredAlerts = selectedFilter == "ALL"
        ? alerts
        : alerts.where((a) => a['status'] == selectedFilter).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              _filterChip("ALL"),
              _filterChip("CRITICAL"),
              _filterChip("WARNING"),
              _filterChip("NORMAL"),
            ],
          ),
          const SizedBox(height: 20),
          ...filteredAlerts.map((alert) => _alertCard(alert)),
        ],
      ),
    );
  }

  Widget _filterChip(String value) {
    final bool selected = selectedFilter == value;

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedFilter = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF39D353) : const Color(0xFF1A1F24),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: selected ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }

  Widget _alertCard(Map<String, dynamic> alert) {
    final Color color = alert['color'];

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161A1F),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 80,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Driver: ${alert['driver']}",
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  "Vehicle: ${alert['vehicle']}",
                  style: const TextStyle(color: Colors.white54),
                ),
                const SizedBox(height: 8),
                Text(
                  alert['time'],
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              alert['status'],
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
