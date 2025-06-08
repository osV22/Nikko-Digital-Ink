import 'package:flutter/material.dart';
import '../widgets/output_widget.dart';
import '../widgets/toolbar_widget.dart';
import '../widgets/drawing_canvas_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // First section - 40% of screen for OutputWidget
          Expanded(
            flex: 4,
            child: OutputWidget(),
          ),
          // Middle section - 10% of screen for Toolbar
          Expanded(
            flex: 1,
            child: ToolbarWidget(),
          ),
          // Bottom section - 40% of screen for Drawing Canvas
          Expanded(
            flex: 4,
            child: DrawingCanvasWidget(),
          ),
        ],
      ),
    );
  }
}
