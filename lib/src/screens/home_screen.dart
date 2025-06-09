import 'package:flutter/material.dart' hide Ink;
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/drawing_bloc.dart';
import '../widgets/output_widget.dart';
import '../widgets/toolbar_widget.dart';
import '../widgets/drawing_canvas_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrawingBloc(),
      child: Scaffold(
        backgroundColor: Colors.grey[25],
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isLandscape = constraints.maxWidth > constraints.maxHeight;

              if (isLandscape) {
                // Landscape layout: Drawing on left, output on right
                return Row(
                  children: [
                    // Drawing section - 60% of width
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Expanded(
                              child: DrawingCanvasWidget(),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 60,
                              child: const ToolbarWidget(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Output section - 40% of width
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        child: const OutputWidget(),
                      ),
                    ),
                  ],
                );
              } else {
                // Portrait layout: Output on top, drawing on bottom
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Output section - 35% of screen
                      Expanded(
                        flex: 35,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: const OutputWidget(),
                        ),
                      ),
                      // Toolbar section - 8% of screen
                      Container(
                        height: 60,
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: const ToolbarWidget(),
                      ),
                      // Drawing section - 57% of screen
                      Expanded(
                        flex: 57,
                        child: Container(
                          margin: const EdgeInsets.only(top: 8.0),
                          child: const DrawingCanvasWidget(),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
