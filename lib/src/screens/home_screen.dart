import 'package:flutter/material.dart' hide Ink;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/drawing_bloc.dart';
import '../services/digital_ink_service.dart';
import '../widgets/output_widget.dart';
import '../widgets/toolbar_widget.dart';
import '../widgets/drawing_canvas_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final DigitalInkService _digitalInkService;
  late final DrawingBloc _drawingBloc;

  @override
  void initState() {
    super.initState();
    _digitalInkService = DigitalInkService();
    _drawingBloc = DrawingBloc(digitalInkService: _digitalInkService);

    // Initialize the service asynchronously
    _initializeService();
  }

  Future<void> _initializeService() async {
    try {
      await _digitalInkService.initialize();
    } catch (e) {
      // Handle initialization error
      debugPrint('Failed to initialize Digital Ink Service: $e');
    }
  }

  @override
  void dispose() {
    _drawingBloc.close();
    _digitalInkService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _drawingBloc,
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
                            SizedBox(
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
