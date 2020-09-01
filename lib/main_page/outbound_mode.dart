import 'package:flutter/material.dart';

class OutboundModeBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.cyan.shade500,
      child: Column(
        children: [
          Icon(Icons.swap_vert, color: Colors.white),
          Text("Outbound Mode", style: TextStyle(color: Colors.white)),
        ],
      ),
      onPressed: () {},
    );
  }
}
