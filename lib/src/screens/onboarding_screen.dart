import 'package:flutter/material.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Constants
  static const String _languageCode = 'ja';
  static const String _appTitle = 'Nikko Digital Ink';
  static const String _appSubtitle = 'Japanese Character Recognition';

  // State variables
  bool _isModelDownloaded = false;
  bool _isDownloading = false;
  String _downloadStatus = 'Checking model status...';

  // ML Kit components
  DigitalInkRecognizer? _recognizer;
  DigitalInkRecognizerModelManager? _modelManager;

  @override
  void initState() {
    super.initState();
    _checkAndDownloadModel();
  }

  @override
  void dispose() {
    _recognizer?.close();
    super.dispose();
  }

  Future<void> _checkAndDownloadModel() async {
    _updateStatus(isDownloading: true, status: 'Checking model status...');

    try {
      _modelManager = DigitalInkRecognizerModelManager();

      final bool isDownloaded = await _modelManager!.isModelDownloaded(
        _languageCode,
      );

      if (isDownloaded) {
        _onModelReady();
      } else {
        await _downloadModel();
      }

      // Initialize recognizer after model is ready
      _recognizer = DigitalInkRecognizer(languageCode: _languageCode);
    } catch (e) {
      _updateStatus(isDownloading: false, status: 'Error: ${e.toString()}');
    }
  }

  Future<void> _downloadModel() async {
    _updateStatus(
      isDownloading: true,
      status: 'Downloading AI Model, please wait...',
    );

    final bool downloadSuccess = await _modelManager!.downloadModel(
      _languageCode,
    );

    if (downloadSuccess) {
      _onModelReady();
    } else {
      _updateStatus(
        isDownloading: false,
        status: 'Failed to download model. Please try again.',
      );
    }
  }

  void _onModelReady() {
    _updateStatus(
      isDownloaded: true,
      isDownloading: false,
      status: 'Model ready! You can now proceed.',
    );
  }

  void _updateStatus({
    bool? isDownloaded,
    bool? isDownloading,
    required String status,
  }) {
    setState(() {
      if (isDownloaded != null) _isModelDownloaded = isDownloaded;
      if (isDownloading != null) _isDownloading = isDownloading;
      _downloadStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                theme.colorScheme.surface,
                theme.colorScheme.surfaceVariant.withOpacity(0.3),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeader(),
                const SizedBox(height: 48),
                _buildStatusSection(),
                const SizedBox(height: 48),
                _buildContinueButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final theme = Theme.of(context);

    return Column(
      children: [
        Icon(
          Icons.brush,
          size: 80,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(height: 32),
        Text(
          _appTitle,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          _appSubtitle,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSection() {
    final theme = Theme.of(context);

    return Column(
      children: [
        if (_isDownloading) ...[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
        ],
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _downloadStatus,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: _isModelDownloaded
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: _isModelDownloaded ? () => context.goNamed('home') : null,
        style: FilledButton.styleFrom(
          backgroundColor: _isModelDownloaded
              ? const Color.fromARGB(255, 74, 135, 233)
              : theme.colorScheme.outline,
          foregroundColor: _isModelDownloaded
              ? Colors.white
              : theme.colorScheme.onSurface.withOpacity(0.6),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          _isModelDownloaded ? 'Get Started' : 'Please Wait...',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
