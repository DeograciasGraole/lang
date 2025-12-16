import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:lang/presentation/onboarding/onboardingscreen.dart';

// final staticStringProvider = Provider((Ref ref) {
//   return 'Hello world';
// });
final CounterProvider = StateProvider((Ref ref) {
  return 0;
});

// final Sta = StateProvider((Ref ref) {
//   return '';
// });

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MaterialApp(home: MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final result = ref.watch(staticStringProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardindScreen(),
      // home: Scaffold(
      //   floatingActionButton: IconButton(
      //     onPressed: () {
      //       ref.read(CounterProvider.notifier).state++;
      //     },
      //     icon: Icon(Icons.add),
      //   ),
      //   body: Center(
      //     child: Consumer(
      //       builder: (BuildContext context, WidgetRef ref, Widget? child) {
      //         final counter = ref.watch(CounterProvider);
      //         return Text(counter.toString());
      //       },
      //       // child: Text(counter.toString()),
      //     ),
      //   ),
      // ),
    );
  }
}

// class StatefulConsumer extends ConsumerStatefulWidget {
//   const StatefulConsumer({super.key});

//   @override
//   ConsumerState<StatefulConsumer> createState() => _StatefulConsumerState();
// }

// class _StatefulConsumerState extends ConsumerState<StatefulConsumer> {
//   late final TextEditingController _controller;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _controller = TextEditingController();
//     _controller.addListener(() {
//       ref.read(Sta.notifier).state = _controller.text;
//     });
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       // home: OnBoardindScreen(),
//       home: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(controller: _controller),
//               const SizedBox(height: 20),
//               Consumer(
//                 builder: (BuildContext context, WidgetRef ref, Widget? child) {
//                   final text = ref.watch(Sta);
//                   return Text('You typed :$text ');
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// final ApiServiceProvider = Provider((_) {
//   return ApiService();
// });

// final LessonFutureProvider = FutureProvider((Ref ref) async {
//   final service = ref.read(ApiServiceProvider);
//   return await service.fetchLessons();
// });

// class MyLessons extends ConsumerWidget {
//   const MyLessons({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final lessonAsync = ref.watch(LessonFutureProvider);
//     final counter = ref.watch(CounterProvider);
//     final crl = ref.read(CounterProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Async Greeting')),
//       // body: lessonAsync.when(
//       //   skipLoadingOnRefresh: false,
//       //   data: (response) {
//       //     final lessons = (response['data'] as List<dynamic>);
//       //     if (lessons.isEmpty) {
//       //       return const Center(child: Text('No list available'));
//       //     }

//       //     return ListView.builder(
//       //       itemCount: lessons.length,
//       //       itemBuilder: (context, index) {
//       //         final lesson = lessons[index] as Map<String, dynamic>;
//       //         return ListTile(
//       //           title: Text(lesson['title'] ?? 'Lesson ${index + 1}'),
//       //           subtitle: Text(lesson['description'] ?? ''),
//       //         );
//       //       },
//       //     );
//       //   },
//       //   loading: () => const Center(child: CircularProgressIndicator()),
//       //   error: (err, stack) => Center(
//       //     child: Column(
//       //       mainAxisAlignment: MainAxisAlignment.center,
//       //       children: [
//       //         const Text('Error: Failed to fetch lessons'),
//       //         const SizedBox(height: 10),
//       //         ElevatedButton(
//       //           onPressed: () {
//       //             ref.refresh(LessonFutureProvider); // This triggers a refetch
//       //           },
//       //           child: const Text('Retry'),
//       //         ),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//       body: Text('Count: $counter '),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: crl.increment,
//             child: Icon(Icons.add),
//           ),
//           FloatingActionButton(
//             onPressed: crl.descrement,
//             child: Icon(Icons.remove),
//           ),
//           FloatingActionButton(
//             onPressed: crl.reset,
//             child: Icon(Icons.refresh),
//           ),
//         ],
//       ),
//     );
//   }
// }
