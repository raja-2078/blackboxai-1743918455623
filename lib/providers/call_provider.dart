import 'package:flutter_riverpod/flutter_riverpod.dart';

class CallState {
  final String proficiencyLevel;
  final String genderPreference;

  CallState({
    this.proficiencyLevel = '',
    this.genderPreference = '',
  });

  CallState copyWith({
    String? proficiencyLevel,
    String? genderPreference,
  }) {
    return CallState(
      proficiencyLevel: proficiencyLevel ?? this.proficiencyLevel,
      genderPreference: genderPreference ?? this.genderPreference,
    );
  }
}

class CallNotifier extends StateNotifier<CallState> {
  CallNotifier() : super(CallState());

  void setProficiencyLevel(String level) {
    state = state.copyWith(proficiencyLevel: level);
  }

  void setGenderPreference(String gender) {
    state = state.copyWith(genderPreference: gender);
  }

  void reset() {
    state = CallState();
  }
}

/// Manages voice call state including:
/// - Proficiency level selection
/// - Gender preference
/// - Call connection status
final callProvider = StateNotifierProvider<CallNotifier, CallState>((ref) {
  return CallNotifier();
});