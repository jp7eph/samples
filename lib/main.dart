import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/word.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sample'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: Consumer(
            builder: (context, ref, child) {
              final wordState = ref.watch(wordProvider);
              return ListView(
                restorationId: 'word_list',
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                children: [
                  for (var word in wordState)
                    Card(
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(word.word),
                                    IconButton(
                                      onPressed: () => ref
                                          .read(wordProvider.notifier)
                                          .toggleFavorite(target: word.word),
                                      icon: wordState
                                              .firstWhere((element) =>
                                                  element.word == word.word)
                                              .isFavorite
                                          ? const Icon(Icons.favorite)
                                          : const Icon(Icons.favorite_border),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(word.word),
                            IconButton(
                              onPressed: () => ref
                                  .read(wordProvider.notifier)
                                  .toggleFavorite(target: word.word),
                              icon: word.isFavorite
                                  ? const Icon(Icons.favorite)
                                  : const Icon(Icons.favorite_border),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => ref.read(wordProvider.notifier).add(),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
