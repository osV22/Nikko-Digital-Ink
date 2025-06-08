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
    return Scaffold(
      body: SafeArea(
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
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Icon(Icons.brush, size: 80, color: Colors.blue),
        const SizedBox(height: 32),
        const Text(
          _appTitle,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const Text(
          _appSubtitle,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildStatusSection() {
    return Column(
      children: [
        if (_isDownloading) ...[
          const CircularProgressIndicator(),
          const SizedBox(height: 24),
        ],
        Text(
          _downloadStatus,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: _isModelDownloaded ? Colors.green : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isModelDownloaded ? () => context.goNamed('home') : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isModelDownloaded ? Colors.green : Colors.grey,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          _isModelDownloaded ? 'Get Started' : 'Please Wait...',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
