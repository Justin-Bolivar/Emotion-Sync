// ignore_for_file: avoid_print, library_private_types_in_public_api, use_key_in_widget_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:emotion_sync/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'journalpage.dart';
import 'writepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<String> dates = [];
  List<int> ids = [];
  List<String> topEmotions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDates();
  }

  Future<void> _fetchDates() async {
    String url = 'http://127.0.0.1:8000/panic/getListOfJournals/';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        dates = data.map((item) => item['date'] as String).toList();
        ids = data.map((item) => item['id'] as int).toList();
        topEmotions = data.map((item) {
          var topEmotion = item['emotions'][0][0];
          var percentage = (topEmotion['score'] * 100).round().toString();
          return '${topEmotion['label']} ($percentage%)';
        }).toList();
      } else {
        print('Failed to load dates: ${response.statusCode}');
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching dates: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                SizedBox(
                  width: 400,
                  child: Center(
                    child: Column(
                      children: [
                        Center(
                          child: Column(children: [
                            const Text('Recent Journals',
                                style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: secondary)),
                            const SizedBox(height: 20.0),
                            ...List.generate(dates.length, _buildJournalCard),
                            const SizedBox(height: 100.0),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: SizedBox(
          width: 80,
          height: 80,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WriteJournalPage()),
              );
            },
            backgroundColor: secondary,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add,
              size: 60,
              color: Color(0xFFFFFBF0),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildJournalCard(int index) {
    final dateParts = dates[index].split(' ');
    String month = "Month";
    String day = "Day";

    if (dateParts.length >= 2) {
      month = dateParts[0];
      day = dateParts[1];
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JournalPage(
                  selectedDate: dates[index], selectedID: ids[index]),
            ),
          );
        },
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(24.0),
          ),
          width: 320,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 20.0),
                _buildDateColumn(month, day),
                const SizedBox(width: 20.0),
                Text(
                  topEmotions[index],
                  style: const TextStyle(
                    fontSize: 19.0,
                    color: Color(0xFFFFFBF0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateColumn(String month, String day) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            Text(
              month,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFBF0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 5.0),
              child: Text(
                day,
                style: const TextStyle(
                  fontSize: 40.0,
                  color: Color(0xFFFFFBF0),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
