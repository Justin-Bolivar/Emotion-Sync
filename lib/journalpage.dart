// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:convert';
import 'colors.dart';

class JournalPage extends StatefulWidget {
  final String selectedDate;
  final int selectedID;

  JournalPage({required this.selectedDate, required this.selectedID});

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  Future<Map<String, dynamic>> fetchJournalEntry() async {
    String url =
        'http://127.0.0.1:8000/panic/${widget.selectedID}/deleteUpdateEntry/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load journal entry');
    }
  }

  Map<String, int> calculateEmotionPercentages(List<dynamic> emotions) {
    Map<String, int> percentages = {};
    for (var emotion in emotions) {
      String label = emotion['label'];
      double score = emotion['score'];
      int percentage = (score * 100).round();
      if (percentage > 0) {
        percentages[label] = percentage;
      }
    }
    return percentages;
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('MMMM\n d').format(now);
    final String formattedTime = DateFormat('h:mm a').format(now);

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchJournalEntry(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: primary));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Map<String, int> emotionPercentages =
                calculateEmotionPercentages(snapshot.data!['emotions'][0]);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${DateFormat('MMMM').format(now)}\n',
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: primary,
                                  ),
                                ),
                                TextSpan(
                                  text: '${DateFormat('d').format(now)}\n',
                                  style: const TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: primary,
                                  ),
                                ),
                                TextSpan(
                                  text: '$formattedTime\n',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: black,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                '${snapshot.data!['thoughts']}',
                                style: const TextStyle(color: white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          PieChart(
                            ringStrokeWidth: 30,
                            dataMap: emotionPercentages.map((key, value) =>
                                MapEntry(key, value.toDouble())),
                            chartType: ChartType.ring,
                            legendOptions: const LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.bottom,
                              showLegends: true,
                              legendTextStyle: TextStyle(
                                color: primary,
                              ),
                            ),
                            chartRadius:
                                MediaQuery.of(context).size.width / 1.5,
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
