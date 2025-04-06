import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/auth_service.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authServiceProvider).currentUser;
    final preferences = ref.watch(preferencesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  user?.email?.substring(0, 1).toUpperCase() ?? 'G',
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Account Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildProfileItem(
                      context,
                      'Email',
                      user?.email ?? 'Not available',
                      Icons.email,
                    ),
                    const Divider(),
                    _buildProfileItem(
                      context,
                      'Account Created',
                      user?.metadata.creationTime?.toString() ?? 'Unknown',
                      Icons.calendar_today,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Preferences',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildPreferenceItem(
                      context,
                      'Language',
                      'English',
                      Icons.language,
                    ),
                    const Divider(),
                    _buildPreferenceItem(
                      context,
                      'Theme',
                      'System Default',
                      Icons.color_lens,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(
        value,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildPreferenceItem(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Text(value),
      onTap: () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Edit $title Preference'),
          content: DropdownButtonFormField<String>(
            value: value,
            items: [
              DropdownMenuItem(
                value: 'System Default',
                child: Text('System Default'),
              ),
              DropdownMenuItem(
                value: 'Light',
                child: Text('Light'),
              ),
              DropdownMenuItem(
                value: 'Dark',
                child: Text('Dark'),
              ),
            ],
            onChanged: (newValue) {
              if (newValue != null) {
                // Save preference to Firestore or SharedPreferences
                if (title == 'Theme') {
                  // TODO: Implement theme preference saving
                  // This would typically save to Firestore or SharedPreferences
                  // and update the app theme state
                } else if (title == 'Language') {
                  // TODO: Implement language preference saving
                }
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$title preference updated to $newValue')),
                );
                // Refresh the UI
                if (mounted) setState(() {});
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
      },
    );
  }
}