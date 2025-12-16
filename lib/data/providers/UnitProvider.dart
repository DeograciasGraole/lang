import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lang/data/providers/auth_notifier.dart';
import 'package:lang/data/services/ApiService.dart';

final unitsProvider = FutureProvider<List<dynamic>>((ref) async {
  final authState = ref.watch(authNotifierprovider);

  // 1. If auth is loading → don't call API yet
  if (authState.isLoading) {
    print("UnitsProvider: Auth is loading...");
    return [];
  }

  // 2. If auth errored → avoid crash
  if (authState.hasError) {
    print("UnitsProvider: Auth has error, returning empty list");
    return [];
  }

  // 3. Auth is loaded → get user
  final user = authState.value;

  if (user == null) {
    print("UnitsProvider: User is null, returning empty list");
    return [];
  }

  // 4. Validate token
  if (user.token.isEmpty) {
    print("UnitsProvider: Token is empty");
    return [];
  }

  print(
    "UnitsProvider: Fetching units for ${user.name}, token: ${user.token.substring(0, 10)}...",
  );

  // 5. Create API service
  final api = ApiService(token: user.token);

  // 6. Fetch units
  try {
    final units = await api.fetchUnits();
    print("UnitsProvider: Successfully fetched ${units.length} units");
    return units;
  } catch (e) {
    print("UnitsProvider: Error fetching units: $e");
    return [];
  }
});
