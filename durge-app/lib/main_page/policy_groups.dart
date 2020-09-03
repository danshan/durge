import 'package:flutter/material.dart';

class PolicyGroupsBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Column(
        children: [
          Icon(Icons.alt_route),
          Text("Policy Groups")
        ],
      ),
      onPressed: () {},
    );
  }
}
