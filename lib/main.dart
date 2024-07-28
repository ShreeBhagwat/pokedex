import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:pokedex/repo/hive_repo.dart';
import 'package:pokedex/theme/styles.dart';
import 'package:pokedex/ui/home_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  HiveRepo().registerHiveAdapter();
  runApp(const ProviderScope(child: Pokedex()));
}

class Pokedex extends StatelessWidget {
  const Pokedex({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final themeNotifier = ref.watch(themeProvider);
        return MaterialApp(
          theme: Styles.themeData(themeNotifier, context),
          home: const HomeScreen(),
        );
      },
    );
  }
}
