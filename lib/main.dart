import 'package:evaranshark_weathercast/repositories/style_repo.dart';
import 'package:evaranshark_weathercast/screens/login/login_screen.dart';
import 'package:evaranshark_weathercast/screens/weathercast_screen/weathercast_screen.dart';
import 'package:evaranshark_weathercast/services/locator.dart';
import 'package:evaranshark_weathercast/services/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'repositories/forecast/forecast_repo.dart';
import 'screens/login/bloc/user_bloc.dart';
import 'screens/weathercast_screen/bloc/forecast_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initServices();
  EvaransharkTheme.initTheme();
  GPNTheme.initTheme();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StyleRepo>(
      create: (context) => StyleRepo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(),
          ),
          BlocProvider<ForecastBloc>(
            create: (context) =>
                ForecastBloc(locator.get<ForecastRepository>()),
          ),
        ],
        child: MaterialApp(
          routes: {
            '/weathercast': (context) => WeathercastScreen(),
          },
          home: const LoginScreen(),
        ),
      ),
    );
  }
}
