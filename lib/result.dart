import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final List symptoms;
  final int duration;

  const ResultScreen({Key? key, required this.symptoms, required this.duration})
      : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String? penyakit = 'Flu Biasa'; // Hardcoded value for "penyakit"
  String? tingkatPenyakit = 'Ringan'; // Hardcoded value for "tingkatPenyakit"
  bool isLoading = false; // Set to false since we're not fetching data

  @override
  void initState() {
    super.initState();
    // Comment out or remove fetchPrediction since we're using hardcoded values
    // fetchPrediction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Prediksi'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator() // Indicator won't show as isLoading is false
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Prediksi Penyakit:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    penyakit ?? 'Data tidak tersedia',
                    style:
                        const TextStyle(fontSize: 20, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Tingkat Keparahan:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    tingkatPenyakit ?? 'Data tidak tersedia',
                    style:
                        const TextStyle(fontSize: 20, color: Colors.redAccent),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Kembali'),
                  ),
                ],
              ),
      ),
    );
  }
}
