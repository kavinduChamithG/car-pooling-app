import 'package:flutter/material.dart';

class RideTabPage extends StatefulWidget {
  const RideTabPage({Key? key}) : super(key: key);

  @override
  State<RideTabPage> createState() => _RideTabPageState();
}

class _RideTabPageState extends State<RideTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Rides"
      ),
    );
  }
}
