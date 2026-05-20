import 'package:flutter/material.dart';

class DriversContent extends StatefulWidget {
  const DriversContent({super.key});

  @override
  State<DriversContent> createState() => _DriversContentState();
}

class _DriversContentState extends State<DriversContent> {
  final List<Map<String, dynamic>> drivers = [
    {
      "name": "Carlos Ruiz",
      "license": "D12345678",
      "vehicle": "ABC-123",
      "bpm": 92,
      "speed": 92,
      "blinks": 28,
      "status": "CRITICAL",
      "color": Colors.redAccent,
    },
    {
      "name": "Juan Pérez",
      "license": "D87654321",
      "vehicle": "XYZ-789",
      "bpm": 78,
      "speed": 65,
      "blinks": 18,
      "status": "WARNING",
      "color": Colors.amber,
    },
    {
      "name": "Luis Morales",
      "license": "D1223344",
      "vehicle": "LMN-456",
      "bpm": 72,
      "speed": 58,
      "blinks": 12,
      "status": "NORMAL",
      "color": Colors.greenAccent,
    },
  ];

  void _showDriverDialog({Map<String, dynamic>? driver, int? index}) {
    final nameController = TextEditingController(text: driver?['name'] ?? '');

    final licenseController = TextEditingController(
      text: driver?['license'] ?? '',
    );

    final vehicleController = TextEditingController(
      text: driver?['vehicle'] ?? '',
    );

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1F24),
          title: Text(
            driver == null ? "Add Driver" : "Edit Driver",
            style: const TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _input(nameController, "Name"),
              const SizedBox(height: 12),
              _input(licenseController, "License"),
              const SizedBox(height: 12),
              _input(vehicleController, "Vehicle"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white54),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final data = {
                  "name": nameController.text,
                  "license": licenseController.text,
                  "vehicle": vehicleController.text,
                  "bpm": 70,
                  "speed": 60,
                  "blinks": 12,
                  "status": "NORMAL",
                  "color": Colors.greenAccent,
                };

                setState(() {
                  if (driver == null) {
                    drivers.add(data);
                  } else {
                    drivers[index!] = data;
                  }
                });

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Widget _input(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF121212),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _deleteDriver(int index) {
    setState(() {
      drivers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _searchBar(),
          const SizedBox(height: 20),
          ...List.generate(
            drivers.length,
            (index) => _driverCard(drivers[index], index),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1F24),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.white54),
                hintText: "Search drivers...",
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => _showDriverDialog(),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1F24),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _driverCard(Map<String, dynamic> driver, int index) {
    final Color statusColor = driver['color'];

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161A1F),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: statusColor.withOpacity(0.25)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFF2A2A2A),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF161A1F),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      driver['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "License: ${driver['license']}",
                      style: const TextStyle(color: Colors.white54),
                    ),
                    Text(
                      "Vehicle: ${driver['vehicle']}",
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  driver['status'],
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _metric("BPM", "${driver['bpm']}", statusColor),
              _metric("Speed", "${driver['speed']} km/h", statusColor),
              _metric("Blinks", "${driver['blinks']}/min", statusColor),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () =>
                    _showDriverDialog(driver: driver, index: index),
                icon: const Icon(Icons.edit_rounded, color: Colors.amber),
              ),
              IconButton(
                onPressed: () => _deleteDriver(index),
                icon: const Icon(Icons.delete_rounded, color: Colors.redAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metric(String title, String value, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
