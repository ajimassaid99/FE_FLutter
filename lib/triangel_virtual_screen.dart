import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:triangel_virtual/result.dart';

class TriangleVirtualScreen extends StatefulWidget {
  const TriangleVirtualScreen({super.key});

  @override
  _TriangleVirtualScreenState createState() => _TriangleVirtualScreenState();
}

class _TriangleVirtualScreenState extends State<TriangleVirtualScreen> {
  List<String> allSymptoms = [];
  List<Map<String, dynamic>> selectedSymptoms = [
    {'symptom': null}
  ];
  String overallDuration = ''; // Durasi keseluruhan

  @override
  void initState() {
    super.initState();
    fetchSymptoms();
  }

  // Fungsi untuk mengambil data gejala dari endpoint
  Future<void> fetchSymptoms() async {
    final url = Uri.parse('http://192.168.80.206:3000/gejala');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          allSymptoms = List<String>.from(data['all_symptoms']);
          allSymptoms.removeRange(0, 5); // Menghapus item 0-4
        });
      } else {
        throw Exception('Failed to load symptoms');
      }
    } catch (e) {
      print('Error fetching symptoms: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil data gejala')),
      );
    }
  }

  void _addSymptom() {
    if (selectedSymptoms.length < 10) {
      setState(() {
        selectedSymptoms.add({'symptom': null});
      });
    }
  }

  void _removeSymptom(int index) {
    if (selectedSymptoms.length > 2) {
      setState(() {
        selectedSymptoms.removeAt(index);
      });
    }
  }

  Future<void> _submit() async {
    final selectedSymptomsList = selectedSymptoms
        .map((symptom) => symptom['symptom'])
        .where((symptom) => symptom != null)
        .toList();

    if (selectedSymptomsList.length < 2 || overallDuration.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pilih minimal 2 gejala dan isi durasi')),
      );
      return;
    }

    // Navigasi ke ResultScreen dengan gejala dan durasi
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          symptoms: selectedSymptomsList,
          duration: int.parse(overallDuration),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Triangle Virtual'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Gejala dan Durasi Keseluruhan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: selectedSymptoms.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        // Dropdown untuk memilih gejala
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedSymptoms[index]['symptom'],
                            hint: Text('Pilih Gejala'),
                            items: allSymptoms.map((symptom) {
                              return DropdownMenuItem(
                                value: symptom,
                                child: Text(symptom),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedSymptoms[index]['symptom'] = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Tombol hapus gejala
                        IconButton(
                          icon: Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () => _removeSymptom(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // Tombol tambah gejala
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _addSymptom,
                  child: Text('Tambah Gejala'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Input untuk durasi keseluruhan
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Durasi Keseluruhan (hari)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  overallDuration = '2';
                });
              },
            ),
            const SizedBox(height: 20),
            // Tombol submit di bagian bawah
            Center(
              child: ElevatedButton(
                onPressed: _submit,
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
