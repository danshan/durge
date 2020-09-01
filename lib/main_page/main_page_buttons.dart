import 'package:durge/main_page/outbound_mode.dart';
import 'package:durge/main_page/policy_groups.dart';
import 'package:flutter/material.dart';

class MainPageButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: OutboundModeBtn(),
            ),
            Expanded(
              child: PolicyGroupsBtn(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Expanded(
                child: RaisedButton(
                  child: Text("Outbount Mode"),
                  onPressed: () {},
                ),
              ),
            ),
            Container(
              child: Expanded(
                child: RaisedButton(
                  child: Text("Policy Groups"),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
