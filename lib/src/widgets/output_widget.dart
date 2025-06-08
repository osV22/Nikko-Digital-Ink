import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/drawing_bloc.dart';

class OutputWidget extends StatelessWidget {
  const OutputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recognized Text:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<DrawingBloc, DrawingState>(
              builder: (context, state) {
                return TextField(
                  controller: TextEditingController(text: state.recognizedText),
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: 'Draw Japanese characters below...',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
