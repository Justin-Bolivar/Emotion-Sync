import 'package:emotion_sync/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WriteJournalPage extends StatefulWidget {
  @override
  _WriteJournalPageState createState() => _WriteJournalPageState();
}

class _WriteJournalPageState extends State<WriteJournalPage> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _sendPostRequest() async {
    String url = 'http://127.0.0.1:8000/panic/create/';
    final String text = _controller.text;
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('MMMM\n d').format(now);
    final String formattedTime = DateFormat('h:mm a').format(now);
    final String dateString = '$formattedDate';
    final String timeString = ' $formattedTime';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'date': dateString,
            'time': timeString,
            'isPanic': true,
            'thoughts': text,
          },
        ),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Journal Successfully Posted'),
            backgroundColor: success,
          ),
        );
      } else {
        throw Exception('Failed to Post Journal Try Again');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send POST request: $e'),
          backgroundColor: error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    //final String formattedDate = DateFormat('MMMM\n d').format(now);
    final String formattedTime = DateFormat('h:mm a').format(now);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
      ),
      backgroundColor: white,
      body: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: RichText(
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
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: TextField(
              controller: _controller,
              maxLines: 10,
              expands: false,
              decoration: InputDecoration(
                hintText: 'Breath, Write and start...',
                hintStyle: const TextStyle(
                  color: white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                filled: true,
                fillColor: primary,
              ),
              style: const TextStyle(
                fontSize: 16,
                color: white,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              color: secondary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: IconButton(
                icon: const Icon(
                  Icons.send,
                  size: 30,
                ),
                color: white,
                onPressed: _sendPostRequest,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
