import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/di/service_locator.dart';
import 'package:gift_manager/navigation/route_generator.dart';
import 'package:gift_manager/presentation/theme/theme.dart';
import 'package:gift_manager/simple_bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      // themeMode: ThemeMode.light,
      onGenerateRoute: generateRoute(),
    );
  }
}
