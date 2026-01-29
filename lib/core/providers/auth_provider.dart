import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

/// Authentication state
class AuthState {
  final bool isAuthenticated;
  final String? publicKey;
  final String? privateKey;
  final String? displayName;

  const AuthState({
    this.isAuthenticated = false,
    this.publicKey,
    this.privateKey,
    this.displayName,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    String? publicKey,
    String? privateKey,
    String? displayName,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      publicKey: publicKey ?? this.publicKey,
      privateKey: privateKey ?? this.privateKey,
      displayName: displayName ?? this.displayName,
    );
  }
}

/// Auth state notifier
@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
    return const AuthState();
  }

  /// Sign in with private key
  Future<void> signIn({required String privateKey}) async {
    // TODO: Implement actual Nostr key validation and public key derivation
    // For now, just set authenticated state
    state = state.copyWith(
      isAuthenticated: true,
      privateKey: privateKey,
      publicKey: 'npub...', // TODO: Derive from private key
      displayName: 'User', // TODO: Fetch from Nostr
    );
  }

  /// Sign up with name and bio
  Future<void> signUp({required String name, required String bio}) async {
    // TODO: Implement actual Nostr key generation and profile creation
    // For now, just set authenticated state
    state = state.copyWith(
      isAuthenticated: true,
      displayName: name,
      publicKey: 'npub...', // TODO: Generate keys
      privateKey: 'nsec...', // TODO: Generate keys
    );
  }

  /// Sign out
  void signOut() {
    state = const AuthState();
  }
}
