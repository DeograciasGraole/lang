import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:lang/data/models/user_model.dart';
import 'package:lang/data/providers/tokenSave.dart';
import 'package:lang/data/providers/UnitProvider.dart';
import 'package:lang/data/services/ApiService.dart';

final authNotifierprovider = AsyncNotifierProvider<AuthNotifier, User?>(() {
  return AuthNotifier();
});
final tokenProvider = StateProvider<String?>((ref) => null);

class AuthNotifier extends AsyncNotifier<User?> {
  late final ApiService _apiService;

  @override
  FutureOr<User?> build() {
    _apiService = ApiService();
    return null;
  }

  Future<void> register(String name, String email, String password) async {
    state = const AsyncValue.loading();

    try {
      final response = await _apiService.register(name, email, password);

      final token = response['token'];
      final userData = response['user'];

      if (userData == null || token == null) {
        throw Exception(response['message'] ?? "Registration failed");
      }

      // ✅ Save token into ApiService
      print("Register token: $token");
      ref.read(tokenNotifierProvider.notifier).setToken(token);
      // _apiService.setToken(token);

      final user = User.fromJson({...userData, "token": token});
      state = AsyncValue.data(user);

      // Invalidate units provider to refetch units after registration
      ref.invalidate(unitsProvider);
    } catch (e, st) {
      _handleDioError(e, st, "Registration failed");
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();

    try {
      final response = await _apiService.login(email, password);

      final token = response['token'];
      final userData = response['user'];

      if (userData == null || token == null) {
        throw Exception(response['message'] ?? "Login failed");
      }

      // ✅ Save token into ApiService
      ref.read(tokenNotifierProvider.notifier).setToken(token);
      // _apiService.setToken(token);

      final user = User.fromJson({...userData, "token": token});
      state = AsyncValue.data(user);

      // Invalidate units provider to refetch units after login
      ref.invalidate(unitsProvider);
    } catch (e, st) {
      _handleDioError(e, st, "Login failed");
    }
  }

  Future<void> loginGoogle(String email, String password) async {
    state = const AsyncValue.loading();

    try {
      final response = await _apiService.loginWithGoogle();

      final token = response['token'];
      final userData = response['user'];

      if (userData == null || token == null) {
        throw Exception(response['message'] ?? "Login failed");
      }

      // ✅ Save token into ApiService
      ref.read(tokenNotifierProvider.notifier).setToken(token);
      // _apiService.setToken(token);

      final user = User.fromJson({...userData, "token": token});
      state = AsyncValue.data(user);
    } catch (e, st) {
      _handleDioError(e, st, "Login failed");
    }
  }

  Future<void> logout() async {
    if (state.value == null) return;

    try {
      await _apiService.logout(state.value!.token);
    } catch (e) {
      print("Logout error: $e");
    }

    // _apiService.clearToken(); // ✅ clear token after logout
    ref.read(tokenNotifierProvider.notifier).clearToken();
    state = const AsyncValue.data(null);
  }

  void _handleDioError(Object e, StackTrace st, String message) {
    if (e is DioException) {
      // Extract error message from API response
      String errorMessage = message;

      if (e.response?.data != null) {
        final responseData = e.response!.data;

        // Try to extract validation errors (Laravel format)
        if (responseData is Map<String, dynamic>) {
          // Check for 'message' field
          if (responseData.containsKey('message')) {
            errorMessage = responseData['message'].toString();
          }
          // Check for 'errors' field (Laravel validation errors)
          else if (responseData.containsKey('errors')) {
            final errors = responseData['errors'];
            if (errors is Map) {
              // Get first error message from validation errors
              final firstError = errors.values.first;
              if (firstError is List && firstError.isNotEmpty) {
                errorMessage = firstError.first.toString();
              } else if (firstError is String) {
                errorMessage = firstError;
              }
            }
          }
        }
      }

      switch (e.response?.statusCode) {
        case 401:
          state = AsyncValue.error(
            errorMessage.contains(message)
                ? "Unauthorized. Please check your credentials."
                : errorMessage,
            StackTrace.current,
          );
          break;
        case 422:
          // Validation errors - show the extracted message
          state = AsyncValue.error(
            errorMessage.contains(message)
                ? "Please check your input and try again."
                : errorMessage,
            StackTrace.current,
          );
          break;
        case 400:
          state = AsyncValue.error(
            errorMessage.contains(message)
                ? "Bad request. Please check your input."
                : errorMessage,
            StackTrace.current,
          );
          break;
        case 409:
          state = AsyncValue.error(
            errorMessage.contains(message)
                ? "This email is already registered."
                : errorMessage,
            StackTrace.current,
          );
          break;
        case 500:
          state = AsyncValue.error(
            "Server error. Please try again later.",
            StackTrace.current,
          );
          break;
        default:
          // Show network error or extracted message
          final networkError =
              e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout ||
              e.type == DioExceptionType.sendTimeout ||
              e.type == DioExceptionType.connectionError;

          if (networkError) {
            String connectionMsg = "Cannot connect to server. ";
            if (e.type == DioExceptionType.connectionError) {
              connectionMsg +=
                  "Please ensure:\n"
                  "• Laravel server is running (php artisan serve)\n"
                  "• Server is on port 8000\n"
                  "• For Android Emulator: use http://10.0.2.2:8000/api\n"
                  "• For iOS Simulator: use http://127.0.0.1:8000/api";
            } else {
              connectionMsg +=
                  "Check your internet connection or server status.";
            }
            state = AsyncValue.error(connectionMsg, StackTrace.current);
          } else {
            state = AsyncValue.error(
              errorMessage.contains(message)
                  ? "$message: ${e.message ?? 'Unknown error'}"
                  : errorMessage,
              StackTrace.current,
            );
          }
      }
    } else {
      state = AsyncValue.error("$message: $e", st);
    }
  }
}
