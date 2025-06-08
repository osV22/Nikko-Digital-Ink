import 'package:flutter/material.dart';

class ToolbarWidget extends StatelessWidget {
  const ToolbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            print('erase called');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 12.0,
            ),
          ),
          child: const Text(
            'Erase',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
