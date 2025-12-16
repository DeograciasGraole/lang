import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorage = const FlutterSecureStorage();

class AuthNotifier extends StateNotifier<String?> {
  AuthNotifier() : super(null) {
    _loadToken();
  }

  Future<void> _loadToken() async {
    final savedToken = await secureStorage.read(key: 'token');
    state = savedToken;
  }

  Future<void> setToken(String token) async {
    state = token;
    await secureStorage.write(key: 'token', value: token);
  }

  Future<void> clearToken() async {
    state = null;
    await secureStorage.delete(key: 'token');
  }
}

// ✅ Works perfectly with Riverpod legacy
final tokenNotifierProvider = StateNotifierProvider<AuthNotifier, String?>(
  (ref) => AuthNotifier(),
);
