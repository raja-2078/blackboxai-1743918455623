import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../components/custom_dropdown.dart';
import '../../../providers/call_provider.dart';

class VoiceCallOptionsScreen extends ConsumerStatefulWidget {
  const VoiceCallOptionsScreen({super.key});

  @override
  ConsumerState<VoiceCallOptionsScreen> createState() => _VoiceCallOptionsScreenState();
}

class _VoiceCallOptionsScreenState extends ConsumerState<VoiceCallOptionsScreen> {
  final List<String> proficiencyLevels = [
    'Beginner',
    'Intermediate',
    'Native/Expert'
  ];
  final List<String> genderPreferences = [
    'Male',
    'Female',
    'Other/Choose not to say'
  ];

  @override
  Widget build(BuildContext context) {
    final callState = ref.watch(callProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Call Options'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select your preferences',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            CustomDropdown(
              label: 'English Proficiency Level',
              value: callState.proficiencyLevel.isNotEmpty ? callState.proficiencyLevel : null,
              items: proficiencyLevels,
              onChanged: (value) {
                ref.read(callProvider.notifier).setProficiencyLevel(value);
              },
            ),
            const SizedBox(height: 16),
            CustomDropdown(
              label: 'Gender Preference',
              value: callState.genderPreference.isNotEmpty ? callState.genderPreference : null,
              items: genderPreferences,
              onChanged: (value) {
                ref.read(callProvider.notifier).setGenderPreference(value);
              },
            ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.call),
                label: const Text('Start Voice Call'),
                onPressed: () {
                  if (callState.proficiencyLevel.isNotEmpty &&
                      callState.genderPreference.isNotEmpty) {
                    context.go('/voice-call');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select all options'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}