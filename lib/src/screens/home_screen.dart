import 'package:flutter/material.dart' hide Ink;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/drawing_bloc.dart';
import '../services/digital_ink_service.dart';
import '../widgets/output_widget.dart';
import '../widgets/toolbar_widget.dart';
import '../widgets/drawing_canvas_widget.dart';
import '../widgets/drawing_toolbar_widget.dart';
import '../models/drawing_settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final DigitalInkService _digitalInkService;
  late final DrawingBloc _drawingBloc;
  DrawingSettings _drawingSettings = const DrawingSettings();

  @override
  void initState() {
    super.initState();
    _digitalInkService = DigitalInkService();
    _drawingBloc = DrawingBloc(digitalInkService: _digitalInkService);

    _initializeService();
  }

  Future<void> _initializeService() async {
    try {
      await _digitalInkService.initialize();
    } catch (e) {
      debugPrint('Failed to initialize Digital Ink Service: $e');
    }
  }

  void _onDrawingSettingsChanged(DrawingSettings newSettings) {
    setState(() {
      _drawingSettings = newSettings;
    });
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
                            // Drawing toolbar above canvas in landscape
                            Container(
                              height: 60,
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: DrawingToolbarWidget(
                                settings: _drawingSettings,
                                onSettingsChanged: _onDrawingSettingsChanged,
                              ),
                            ),
                            Expanded(
                              child: DrawingCanvasWidget(
                                settings: _drawingSettings,
                              ),
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
                // Portrait layout: Output on top, toolbar, drawing, drawing toolbar
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Output section - 30% of screen
                      Expanded(
                        flex: 30,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: const OutputWidget(),
                        ),
                      ),
                      // Toolbar section - 10% of screen
                      Container(
                        height: 60,
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: const ToolbarWidget(),
                      ),
                      // Drawing section - 40% of screen
                      Expanded(
                        flex: 40,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          child: DrawingCanvasWidget(
                            settings: _drawingSettings,
                          ),
                        ),
                      ),
                      // Drawing toolbar section - 10% of screen
                      Container(
                        height: 60,
                        margin: const EdgeInsets.only(top: 4.0),
                        child: DrawingToolbarWidget(
                          settings: _drawingSettings,
                          onSettingsChanged: _onDrawingSettingsChanged,
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
