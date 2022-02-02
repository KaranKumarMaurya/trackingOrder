import 'package:flutter/material.dart';

class TrackPath extends StatefulWidget {
  TrackPath({required this.current_step});
  final int current_step;

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
                child: Stepper(
                  controlsBuilder:
                      (BuildContext context, ControlsDetails details) {
                    return SizedBox();
                  },
                  currentStep: widget.current_step,
                  steps: steps,
                  type: StepperType.vertical,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
