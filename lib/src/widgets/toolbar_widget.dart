import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/drawing_bloc.dart';

class ToolbarWidget extends StatelessWidget {
  const ToolbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              context.read<DrawingBloc>().add(
                const DrawingEvent.clearRequested(),
              );
            },
            icon: const Icon(Icons.clear),
            label: const Text('Clear'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
          BlocBuilder<DrawingBloc, DrawingState>(
            builder: (context, state) {
              return Row(
                children: [
                  if (state.isRecognizing)
                    const Row(
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 8),
                        Text('Recognizing...'),
                      ],
                    )
                  else
                    Text('Strokes: ${state.strokes.length}'),
                  if (state.errorMessage != null) ...[
                    const SizedBox(width: 16),
                    Icon(
                      Icons.error,
                      color: Colors.red[600],
                      size: 16,
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
