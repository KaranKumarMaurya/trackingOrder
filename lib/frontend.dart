import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tracking/homePage.dart';
import 'dart:async';
import 'dart:convert';

import 'package:tracking/main.dart';

class TrackPath extends StatefulWidget {
  TrackPath({required this.current_step, required this.cancel});
  final int current_step;
  final String cancel;

  // TrackPath(this.current_step, this.message);

  @override
  TrackPathState createState() => TrackPathState();
}

class TrackPathState extends State<TrackPath> {
  List<Step> steps = [
    const Step(
      title: Text(
        'Order is under processing',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text('Your item is under process',
          style: TextStyle(color: Colors.blue)),
      isActive: true,
      state: StepState.complete,
    ),
    const Step(
      title: Text(
        'Ordered and Approved',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text('Your item has been placed\nsuccessfully',
          style: TextStyle(color: Colors.blue)),
      isActive: true,
      state: StepState.complete,
    ),
    const Step(
      title: Text(
        'Packed',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text('Your item has been picked\nup by courier partner',
          style: TextStyle(color: Colors.blue)),
      isActive: true,
      state: StepState.complete,
    ),
    const Step(
      title: Text(
        'Shipped',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text('Your item is about to reach to you',
          style: TextStyle(color: Colors.blue)),
      state: StepState.complete,
      isActive: true,
    ),
    const Step(
      title: Text(
        'Delivered',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text('Your item has been delivered',
          style: TextStyle(color: Colors.blue)),
      state: StepState.complete,
      isActive: true,
    ),
  ];

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("Order has been cancelled Successfully"),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('OK'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            height: 850,
            child: Card(
              elevation: 20,
              child: Center(
                child: Column(
                  children: [
                    Stepper(
                      controlsBuilder:
                          (BuildContext context, ControlsDetails details) {
                        return SizedBox();
                      },
                      currentStep: widget.current_step,
                      steps: steps,
                      type: StepperType.vertical,
                    ),
                    MaterialButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          if (widget.current_step != 4) {
                            Future<Future> fetchAlbum() async {
                              final response = await http.delete(
                                Uri.parse(
                                    'https://api.trackingmore.com/v2/trackings/ups/1Z12345E6605272234'),
                                headers: {
                                  'Content-Type': "application/json",
                                  'Trackingmore-Api-Key':
                                      "a4afa7db-9216-4752-b174-6c1f9839d589"
                                },
                              );

                              if (response.statusCode == 200) {
                                // If the server did return a 200 OK response,
                                // then parse the JSON.
                                print(response.body);
                                return showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildPopupDialog(context),
                                );
                              } else {
                                // If the server did not return a 200 OK response,
                                // then throw an exception.
                                throw Exception('Failed ');
                              }
                            }
                          }
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomePage()));
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
