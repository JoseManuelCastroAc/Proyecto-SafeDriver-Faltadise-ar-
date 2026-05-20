import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final String dato;
  final Icon icon;
  final bool isPassword;
  const InputWidget({
    super.key,
    required this.dato,
    required this.icon,
    required this.isPassword,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: TextField(
            obscureText: widget.isPassword,
            decoration: InputDecoration(
              hintText: "Introduce tu ${widget.dato}",
              border: OutlineInputBorder(),
              prefixIcon: widget.icon,
            ),
          ),
        ),
      ],
    );
  }
}
