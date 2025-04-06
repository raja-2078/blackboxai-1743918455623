import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';

class PreferencesNotifier extends StateNotifier<PreferencesState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, String> _defaults = {
    'theme': 'System Default',
    'language': 'en',
  };

  PreferencesNotifier(this.ref) : super(PreferencesState(
    preferences: _defaults,
    isLoading: true,
  )) {
    _loadPreferences();
  }

  final Ref ref;

  Future<void> _loadPreferences() async {
    try {
      final user = ref.read(authServiceProvider).currentUser;
      if (user != null) {
        final doc = await _firestore.collection('userPreferences').doc(user.uid).get();
        if (doc.exists) {
          state = state.copyWith(
            preferences: Map<String, String>.from(doc.data() as Map<String, dynamic>),
            isLoading: false,
          );
          return;
        }
      }
      state = state.copyWith(
        preferences: _defaults,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        preferences: _defaults,
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> updatePreference(String key, String value) async {
    state = state.copyWith(isSaving: true);
    try {
      final user = ref.read(authServiceProvider).currentUser;
      if (user != null) {
        await _firestore.collection('userPreferences').doc(user.uid).set(
          {key: value},
          SetOptions(merge: true),
        );
      }
      state = state.copyWith(
        preferences: {...state.preferences, key: value},
        isSaving: false,
      );
      if (key == 'theme') {
        ref.read(themeProvider.notifier).state = value;
      } else if (key == 'language') {
        ref.read(localizationProvider.notifier).state = value;
      }
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        error: e.toString(),
      );
      rethrow;
    }
  }
}

class PreferencesState {
  final Map<String, String> preferences;
  final bool isLoading;
  final bool isSaving;
  final String? error;

  PreferencesState({
    required this.preferences,
    this.isLoading = false,
    this.isSaving = false,
    this.error,
  });

  PreferencesState copyWith({
    Map<String, String>? preferences,
    bool? isLoading,
    bool? isSaving,
    String? error,
  }) {
    return PreferencesState(
      preferences: preferences ?? this.preferences,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      error: error ?? this.error,
    );
  }
}

final preferencesProvider = StateNotifierProvider<PreferencesNotifier, PreferencesState>((ref) {
  return PreferencesNotifier(ref);
});