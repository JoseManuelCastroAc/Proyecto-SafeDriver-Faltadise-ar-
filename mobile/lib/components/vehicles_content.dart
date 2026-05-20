import 'package:flutter/material.dart';

class VehiclesContent extends StatefulWidget {
  const VehiclesContent({super.key});

  @override
  State<VehiclesContent> createState() => _VehiclesContentState();
}

class _VehiclesContentState extends State<VehiclesContent> {
  final List<Map<String, dynamic>> vehicles = [
    {
      "plate": "ABC-123",
      "model": "Tesla Model 3",
      "driver": "Carlos Ruiz",
      "speed": 92,
      "status": "CRITICAL",
      "color": Colors.redAccent,
      "connected": true,
    },
    {
      "plate": "XYZ-789",
      "model": "Toyota Hilux",
      "driver": "Juan Pérez",
      "speed": 65,
      "status": "WARNING",
      "color": Colors.amber,
      "connected": true,
    },
    {
      "plate": "LMN-456",
      "model": "Ford Ranger",
      "driver": "Luis Morales",
      "speed": 58,
      "status": "NORMAL",
      "color": Colors.greenAccent,
      "connected": true,
    },
    {
      "plate": "QWE-654",
      "model": "Hino 300",
      "driver": "Andrés Vega",
      "speed": 50,
      "status": "NORMAL",
      "color": Colors.greenAccent,
      "connected": true,
    },
  ];

  final TextEditingController _searchController =
      TextEditingController();

  String searchQuery = "";

  void _showVehicleDialog({
    Map<String, dynamic>? vehicle,
    int? index,
  }) {
    final plateController = TextEditingController(
      text: vehicle?['plate'] ?? '',
    );

    final modelController = TextEditingController(
      text: vehicle?['model'] ?? '',
    );

    final driverController = TextEditingController(
      text: vehicle?['driver'] ?? '',
    );

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1F24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            vehicle == null
                ? "Add Vehicle"
                : "Edit Vehicle",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _input(
                  plateController,
                  "Plate",
                ),
                const SizedBox(height: 14),
                _input(
                  modelController,
                  "Model",
                ),
                const SizedBox(height: 14),
                _input(
                  driverController,
                  "Driver",
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF39D353),
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                final data = {
                  "plate":
                      plateController.text.trim(),
                  "model":
                      modelController.text.trim(),
                  "driver":
                      driverController.text.trim(),
                  "speed": 60,
                  "status": "NORMAL",
                  "color": Colors.greenAccent,
                  "connected": true,
                };

                setState(() {
                  if (vehicle == null) {
                    vehicles.add(data);
                  } else {
                    vehicles[index!] = data;
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

  Widget _input(
    TextEditingController controller,
    String hint,
  ) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.white54,
        ),
        filled: true,
        fillColor: const Color(0xFF121212),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void _deleteVehicle(int index) {
    setState(() {
      vehicles.removeAt(index);
    });
  }

  int get connectedVehicles =>
      vehicles
          .where(
            (v) => v['connected'] == true,
          )
          .length;

  @override
  Widget build(BuildContext context) {
    final filteredVehicles = vehicles
        .where(
          (vehicle) =>
              vehicle['plate']
                  .toString()
                  .toLowerCase()
                  .contains(
                    searchQuery.toLowerCase(),
                  ) ||
              vehicle['model']
                  .toString()
                  .toLowerCase()
                  .contains(
                    searchQuery.toLowerCase(),
                  ) ||
              vehicle['driver']
                  .toString()
                  .toLowerCase()
                  .contains(
                    searchQuery.toLowerCase(),
                  ),
        )
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _searchBar(),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            itemCount: filteredVehicles.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.58,
            ),
            itemBuilder: (context, index) {
              return _vehicleCard(
                filteredVehicles[index],
                vehicles.indexOf(
                  filteredVehicles[index],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          _systemFooter(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 14,
            ),
            decoration: BoxDecoration(
              color:
                  const Color(0xFF1A1F24),
              borderRadius:
                  BorderRadius.circular(14),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration:
                  const InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.search,
                  color: Colors.white54,
                ),
                hintText:
                    "Search vehicles...",
                hintStyle: TextStyle(
                  color: Colors.white54,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () =>
              _showVehicleDialog(),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color:
                  const Color(0xFF1A1F24),
              borderRadius:
                  BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _vehicleCard(
    Map<String, dynamic> vehicle,
    int index,
  ) {
    final Color statusColor =
        vehicle['color'];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF161A1F),
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color:
              statusColor.withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Align(
            alignment:
                Alignment.topRight,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: statusColor
                        .withOpacity(0.7),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 75,
            decoration: BoxDecoration(
              color:
                  const Color(0xFF20252B),
              borderRadius:
                  BorderRadius.circular(
                      14),
            ),
            child: const Center(
              child: Icon(
                Icons
                    .directions_car_filled_rounded,
                color: Colors.white70,
                size: 42,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            vehicle['plate'],
            maxLines: 1,
            overflow:
                TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            vehicle['model'],
            maxLines: 1,
            overflow:
                TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Driver",
            style: TextStyle(
              color: Colors.white38,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            vehicle['driver'],
            maxLines: 1,
            overflow:
                TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color:
                  statusColor.withOpacity(
                0.15,
              ),
              borderRadius:
                  BorderRadius.circular(
                      10),
            ),
            child: Center(
              child: Text(
                vehicle['status'],
                style: TextStyle(
                  color: statusColor,
                  fontWeight:
                      FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () =>
                    _showVehicleDialog(
                  vehicle: vehicle,
                  index: index,
                ),
                child: Container(
                  padding:
                      const EdgeInsets
                          .all(8),
                  decoration:
                      BoxDecoration(
                    color: Colors.amber
                        .withOpacity(
                            0.15),
                    borderRadius:
                        BorderRadius
                            .circular(
                                10),
                  ),
                  child: const Icon(
                    Icons.edit_rounded,
                    color:
                        Colors.amber,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () =>
                    _deleteVehicle(
                        index),
                child: Container(
                  padding:
                      const EdgeInsets
                          .all(8),
                  decoration:
                      BoxDecoration(
                    color: Colors.red
                        .withOpacity(
                            0.15),
                    borderRadius:
                        BorderRadius
                            .circular(
                                10),
                  ),
                  child: const Icon(
                    Icons.delete_rounded,
                    color:
                        Colors.redAccent,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _systemFooter() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF161A1F),
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: Colors.greenAccent
              .withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.verified_user_rounded,
            color: Colors.white70,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Text(
                  "$connectedVehicles of ${vehicles.length} vehicles connected",
                  style:
                      const TextStyle(
                    color: Colors.white,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "All systems operational",
                  style: TextStyle(
                    color:
                        Colors.greenAccent,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons
                .signal_cellular_alt_rounded,
            color: Colors.greenAccent,
          ),
        ],
      ),
    );
  }
}