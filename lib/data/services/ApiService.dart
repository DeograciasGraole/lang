import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lang/data/models/lessonContent.dart';
import 'package:lang/data/models/lessons_model.dart';

final class ApiService {
  String? token;
  ApiService({this.token});
  final Dio _dio = Dio(
    BaseOptions(
      // IMPORTANT: Choose the correct baseUrl based on your testing environment
      //
      // For Android Emulator (recommended for testing):
      baseUrl: "http://10.0.2.2:8000/api",
      //
      // For iOS Simulator:
      // baseUrl: "http://127.0.0.1:8000/api",
      //
      // For real Android/iOS device, use your computer's local IP:
      // Find your IP: Windows (ipconfig) or Mac/Linux (ifconfig)
      // Example: baseUrl: "http://192.168.1.100:8000/api",
      //
      // For production server:
      // baseUrl: "https://api-xr2s.onrender.com/api",
      //
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {"Accept": "application/json"},
    ),
  );

  //Fecht units
  Future<List<dynamic>> fetchUnits() async {
    print("Fetching units with token: $token");

    // Check if token is available
    if (token == null || token!.isEmpty) {
      throw Exception("Authentication required. Please log in first.");
    }

    try {
      final response = await _dio.get(
        '/units',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.data; // assuming this is a list of units
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 401) {
        print(
          "Fetch units error: Unauthorized - Token may be invalid or expired",
        );
        throw Exception("Authentication failed. Please log in again.");
      }
      print("Fetch units error: $e");
      rethrow;
    }
  }

  // Fetch lessons
  Future<List<Lesson>> fetchLessonsByUnit(int unitId) async {
    try {
      final response = await _dio.get(
        "/units/$unitId/lessons",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // Safely cast to a List<dynamic> first
      final dataList = response.data['data'] as List<dynamic>;

      // Now map each item into Lesson
      final lessons = dataList
          .map((json) => Lesson.fromJson(json as Map<String, dynamic>))
          .toList();

      print("Result ********* $lessons");
      return lessons;
    } catch (e) {
      print("Fetch lessons error: $e");
      rethrow;
    }
  }

  Future<List<LessonContent>> fetchLessonsContentByLessonUnit(
    int unitId,
    int lesson,
  ) async {
    try {
      final response = await _dio.get(
        "/units/$unitId/lessons/$lesson",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // print("Response data: ${response.data}"); // Debug log

      final data = response.data['data'];

      // If the API returns a single object
      if (data is Map<String, dynamic>) {
        return [LessonContent.fromJson(data)];
      }

      // If the API returns a list
      if (data is List) {
        return data.map((json) => LessonContent.fromJson(json)).toList();
      }

      return data;
      // print(data);
      // If something unexpected
      // throw Exception("Unexpected data format: ${response.data}");
    } catch (e) {
      print("Fetch lessons error: $e");
      rethrow;
    }
  }

  //Register
  Future<Map<String, dynamic>> userProgress(
    int lessonId,
    bool completed,
    int percentage,
  ) async {
    try {
      final response = await _dio.post(
        '/progress',
        data: {
          "lesson_id": lessonId,
          "completed": completed,
          "progress_percentage": percentage,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response.data as Map<String, dynamic>);
      return response.data as Map<String, dynamic>;
    } catch (e) {
      print("Login error: $e");
      rethrow;
    }
  }

  //Register
  Future<Map<String, dynamic>> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      print("Attempting registration to: ${_dio.options.baseUrl}/register");
      final response = await _dio.post(
        '/register',
        data: {"name": username, "email": email, "password": password},
      );
      print("Registration response: ${response.data}");
      return response.data as Map<String, dynamic>;
    } catch (e) {
      if (e is DioException) {
        print("=== REGISTRATION ERROR DEBUG ===");
        print("Status Code: ${e.response?.statusCode}");
        print("Error Data: ${e.response?.data}");
        print("Error Message: ${e.message}");
        print("Error Type: ${e.type}");
        print("Base URL: ${_dio.options.baseUrl}");
        print("Request URL: ${_dio.options.baseUrl}/register");

        // Provide helpful error messages based on error type
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          print("⚠️ CONNECTION ISSUE DETECTED:");
          print("   - Is your Laravel server running? (php artisan serve)");
          print("   - Is the server running on port 8000?");
          print("   - For Android Emulator, use: http://10.0.2.2:8000/api");
          print("   - For iOS Simulator, use: http://127.0.0.1:8000/api");
          print("   - For real device, use your computer's IP address");
        }
        print("=================================");
      } else {
        print("Registration error: $e");
      }
      rethrow;
    }
  }

  //Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {"email": email, "password": password},
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      print("Login error: $e");
      rethrow;
    }
  }

  //Logout
  Future<void> logout(String token) async {
    try {
      await _dio.post(
        '/logout',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
    } catch (e) {
      print("Logout error: $e");
    }
  }

  Future<Map<String, dynamic>> loginWithGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw Exception("User canceled Google sign-in");

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;
      if (idToken == null) throw Exception("Failed to get Google ID token");
      print("Google ID Token: $idToken");
      print("Google User Email: ${googleUser.email}");
      print("Google User Name: ${googleUser.displayName}");
      print("password: ${googleAuth.accessToken}");
      // Send ID token to Laravel API
      final response = await _dio.post(
        '/google-login',
        data: {"token": idToken},
      );

      // Save token for future API requests
      token = response.data['token'];

      return response.data as Map<String, dynamic>;
    } catch (e) {
      print("Google Sign-In error: $e");
      rethrow;
    }
  }
}
