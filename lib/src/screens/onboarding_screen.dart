import 'package:flutter/material.dart';
import '../widgets/language_toggle_widget.dart';
import '../widgets/onboarding_header_widget.dart';
import '../widgets/status_section_widget.dart';
import '../widgets/onboarding_continue_button.dart';
import '../services/digital_ink_service.dart';
import '../utils/responsive_utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Constants
  static const String _languageCode = 'ja';

  // State variables
  bool _isModelDownloaded = false;
  bool _isDownloading = false;
  String _downloadStatus = '';

  // Digital Ink Service
  final DigitalInkService _digitalInkService = DigitalInkService();

  @override
  void initState() {
    super.initState();
    _checkAndDownloadModel();
  }

  @override
  void dispose() {
    _digitalInkService.dispose();
    super.dispose();
  }

  Future<void> _checkAndDownloadModel() async {
    _updateStatus(isDownloading: true, status: 'checkingModelStatus');

    try {
      // Check if model is already downloaded
      final bool isDownloaded = await _digitalInkService.isModelDownloaded();

      if (isDownloaded) {
        _onModelReady();
      } else {
        await _downloadModel();
      }

      // Initialize the service
      await _digitalInkService.initialize(languageCode: _languageCode);
    } catch (e) {
      _updateStatus(isDownloading: false, status: 'Error: ${e.toString()}');
    }
  }

  Future<void> _downloadModel() async {
    _updateStatus(
      isDownloading: true,
      status: 'downloadingModel',
    );

    try {
      final bool downloadSuccess = await _digitalInkService.downloadModel();

      if (downloadSuccess) {
        _onModelReady();
      } else {
        _updateStatus(
          isDownloading: false,
          status: 'downloadFailed',
        );
      }
    } catch (e) {
      _updateStatus(
        isDownloading: false,
        status: 'downloadFailed',
      );
    }
  }

  void _onModelReady() {
    _updateStatus(
      isDownloaded: true,
      isDownloading: false,
      status: 'modelReady',
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
    final isPhoneLandscape = ResponsiveUtils.isPhoneLandscape(context);

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
                theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.3,
                ),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Language toggle in top right corner
              const Positioned(
                top: 16,
                right: 16,
                child: LanguageToggleWidget(),
              ),
              // Main content - responsive layout
              Padding(
                padding: EdgeInsets.all(
                  isPhoneLandscape
                      ? 16.0
                      : 24.0, // Less padding on iPhone landscape
                ),
                child: isPhoneLandscape
                    ? _buildLandscapeLayout()
                    : _buildPortraitLayout(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const OnboardingHeaderWidget(),
        const SizedBox(height: 48),
        StatusSectionWidget(
          isDownloading: _isDownloading,
          isModelDownloaded: _isModelDownloaded,
          downloadStatus: _downloadStatus,
        ),
        const SizedBox(height: 48),
        OnboardingContinueButton(
          isModelDownloaded: _isModelDownloaded,
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout() {
    return Row(
      children: [
        // Left side - Header (logo, title, subtitle)
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.only(right: 24.0),
            child: const Center(
              child: OnboardingHeaderWidget(),
            ),
          ),
        ),
        // Right side - Status and continue button
        Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StatusSectionWidget(
                isDownloading: _isDownloading,
                isModelDownloaded: _isModelDownloaded,
                downloadStatus: _downloadStatus,
              ),
              const SizedBox(height: 32),
              OnboardingContinueButton(
                isModelDownloaded: _isModelDownloaded,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
