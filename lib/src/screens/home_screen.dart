import 'package:flutter/material.dart' hide Ink;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/drawing_bloc.dart';
import '../services/digital_ink_service.dart';
import '../utils/responsive_utils.dart';
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
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isLandscape = constraints.maxWidth > constraints.maxHeight;

              // Different toolbar heights for iPhone landscape vs other devices
              final toolbarHeight = ResponsiveUtils.isPhoneLandscape(context)
                  ? ResponsiveUtils.scaleButtonSize(
                      context,
                      45,
                    ) // Much smaller for iPhone landscape
                  : ResponsiveUtils.scaleButtonSize(
                      context,
                      60,
                    ); // Normal size for other devices

              final margin = ResponsiveUtils.scalePadding(context, 8.0);

              if (isLandscape) {
                // Landscape layout: Drawing on left, output on right
                return Row(
                  children: [
                    // Drawing section - 60% of width
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.all(margin),
                        child: Column(
                          children: [
                            // Drawing toolbar above canvas in landscape
                            Container(
                              height: toolbarHeight,
                              margin: EdgeInsets.only(bottom: margin),
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
                            SizedBox(height: margin),
                            SizedBox(
                              height: toolbarHeight,
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
                        margin: EdgeInsets.all(margin),
                        child: const OutputWidget(),
                      ),
                    ),
                  ],
                );
              } else {
                // Portrait layout: Output on top, toolbar, drawing, drawing toolbar
                return Padding(
                  padding: EdgeInsets.all(margin),
                  child: Column(
                    children: [
                      // Output section - 30% of screen
                      Expanded(
                        flex: 30,
                        child: Container(
                          margin: EdgeInsets.only(bottom: margin),
                          child: const OutputWidget(),
                        ),
                      ),
                      // Toolbar section - responsive height
                      Container(
                        height: toolbarHeight,
                        margin: EdgeInsets.symmetric(vertical: margin / 2),
                        child: const ToolbarWidget(),
                      ),
                      // Drawing section - 40% of screen
                      Expanded(
                        flex: 40,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: margin / 2),
                          child: DrawingCanvasWidget(
                            settings: _drawingSettings,
                          ),
                        ),
                      ),
                      // Drawing toolbar section - responsive height
                      Container(
                        height: toolbarHeight,
                        margin: EdgeInsets.only(top: margin / 2),
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
