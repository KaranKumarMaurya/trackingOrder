import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tracking/frontend.dart';

Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse(
        'https://api.trackingmore.com/v2/trackings/ups/1Z12345E6605272234'),
    headers: {
      'Content-Type': "application/json",
      'Trackingmore-Api-Key': "a4afa7db-9216-4752-b174-6c1f9839d589"
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return Album.fromJson(jsonDecode(response.body)['data']);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String status;
  final String tracking_number;

  const Album({required this.status, required this.tracking_number});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      status: json['status'],
      tracking_number: json['tracking_number'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Track Your Order',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Track Your Order'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.status == 'notfound') {
                  return TrackPath(current_step: 0);
                } else if (snapshot.data!.status == 'pending') {
                  return TrackPath(current_step: 1);
                } else if (snapshot.data!.status == 'transit') {
                  return TrackPath(current_step: 2);
                } else if (snapshot.data!.status == 'pickup') {
                  return TrackPath(current_step: 3);
                } else if (snapshot.data!.status == 'delivered') {
                  return TrackPath(current_step: 4);
                } else {
                  return Text("not found");
                }
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
