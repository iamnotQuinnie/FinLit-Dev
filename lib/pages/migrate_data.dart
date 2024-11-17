import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_name/pages/firestore_service.dart'; // Import your Firestore service

class MigrateData extends StatefulWidget {
  const MigrateData({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MigrateDataState createState() => _MigrateDataState();
}

class _MigrateDataState extends State<MigrateData> {
  final FirestoreServiceImport _firestoreService = FirestoreServiceImport();

  Future<void> _migrateData() async {
    // Load JSON data from assets
    final String jsonData = await rootBundle.loadString('assets/Unit4.json');
    final Map<String, dynamic> data = jsonDecode(jsonData);
    
    // Extract unitId from JSON structure
    final unitId = data['unit']; // Use the 'unit' key in your JSON

    // Iterate through lessons and add to Firestore
    for (final lesson in data['lessons']) {
      await _firestoreService.addLesson(unitId, lesson);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Migrate Data'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _migrateData,
          child: const Text('Migrate Data to Firestore'),
        ),
      ),
    );
  }
}
