import 'package:flutter/material.dart';

class CommonPanel extends StatelessWidget {
  const CommonPanel({Key key, @required this.title, @required this.child})
      : assert(title != null),
        assert(child != null),
        super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(this.title, style: TextStyle(color: Colors.black45)),
        Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: new BorderRadius.circular(5.0)),
          child: child,
        ),
      ],
    );
  }
}
