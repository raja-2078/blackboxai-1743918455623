import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/localization_service.dart';
import '../../components/translated_text.dart';
import '../../providers/preferences_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(localizationProvider);
    final state = ref.watch(preferencesProvider);
    final preferences = state.preferences;
    final isLoading = state.isLoading;
    final isSaving = state.isSaving;

    if (state.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error!),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const TranslatedText('settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.language),
              title: const TranslatedText('language'),
              subtitle: Text(LocalizationService.getLanguageName(language)),
              onTap: () => _showLanguageDialog(context, ref),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: const TranslatedText('theme'),
              subtitle: Text(preferences['theme'] ?? 'System Default'),
              onTap: () => _showThemeDialog(context, ref),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const TranslatedText('language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: LocalizationService.supportedLocales.map((locale) {
            return ListTile(
              title: Text(LocalizationService.getLanguageName(locale.languageCode)),
              onTap: () {
                ref.read(localizationProvider.notifier).state = locale.languageCode;
                ref.read(preferencesProvider.notifier).updatePreference('language', locale.languageCode);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}