import 'package:evaranshark_weathercast/models/weather.dart';
import 'package:evaranshark_weathercast/repositories/style_repo.dart';
import 'package:evaranshark_weathercast/screens/weathercast_screen/bloc/forecast_bloc.dart';
import 'package:evaranshark_weathercast/screens/weathercast_screen/parts/header.dart';
import 'package:evaranshark_weathercast/services/constants.dart';
import 'package:evaranshark_weathercast/widgets/change_theme_widget.dart';
import 'package:evaranshark_weathercast/widgets/gpn_bubble.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:system_settings/system_settings.dart';

import '../../services/helpers.dart';
import '../login/bloc/user_bloc.dart';
import 'bloc/forecast_event.dart';
import 'bloc/forecast_state.dart';
import 'parts/forecast_details.dart';
import 'parts/hourly_forecast.dart';
import 'parts/weather_description.dart';
import 'parts/weather_image.dart';

class WeathercastScreen extends StatelessWidget {
  const WeathercastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StyleRepo>(
      builder: (context, value, child) {
        return Theme(
          data: value.theme.dark,
          child: child!,
        );
      },
      child: BlocListener<UserBloc, UserState>(
        listener: (context, _) {
          Navigator.of(context).pushReplacementNamed('/');
        },
        listenWhen: (previous, current) => current is NoUser,
        child: Scaffold(
          body: Builder(builder: (context) {
            return BlocListener<ForecastBloc, ForecastState>(
              listener: (context, state) {
                if (state is PermissionsError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                    action: const SnackBarAction(
                        label: "Перейти", onPressed: SystemSettings.app),
                    behavior: SnackBarBehavior.floating,
                  ));
                  return;
                }

                if (state is ForecastError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text((state).message),
                    behavior: SnackBarBehavior.floating,
                  ));
                }
              },
              listenWhen: (previous, current) {
                return current is ForecastError;
              },
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.accent, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return BlocBuilder<ForecastBloc, ForecastState>(
                        builder: (context, forecastState) {
                      if (forecastState is FetchingPosition) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (forecastState is ForecastLoading) {
                        return const ForecastLoadingLayout();
                      }

                      return RefreshIndicator.adaptive(
                        onRefresh: () async {
                          context.read<ForecastBloc>().add(FetchWeather());
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: constraints.maxHeight,
                            ),
                            child: Center(
                              child: BlocBuilder<ForecastBloc, ForecastState>(
                                  builder: (context, forecastState) {
                                if (forecastState is NoData) {
                                  return const Center(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Нет данных для отображения"),
                                      Text("Потяните вниз для обновления"),
                                    ],
                                  ));
                                }
                                return const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 24.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ForecastHeader(),
                                      Expanded(child: WeatherImage()),
                                      WeatherDesc(),
                                      HourlyForecast(),
                                      ForecastDetails(),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      );
                    });
                  }),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class ForecastLoadingLayout extends StatefulWidget {
  const ForecastLoadingLayout({super.key});

  @override
  State<ForecastLoadingLayout> createState() => _ForecastLoadingLayoutState();
}

class _ForecastLoadingLayoutState extends State<ForecastLoadingLayout>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 60,
            ),
            child: LoadingContainer(
              controller: controller,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 180,
                maxHeight: 180,
              ),
              child: LoadingContainer(
                controller: controller,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 150,
                maxHeight: 150,
              ),
              child: LoadingContainer(
                controller: controller,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 220,
              ),
              child: LoadingContainer(
                controller: controller,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 80,
              ),
              child: LoadingContainer(
                controller: controller,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class LoadingContainer extends StatefulWidget {
  final AnimationController controller;

  const LoadingContainer({super.key, required this.controller});

  @override
  State<LoadingContainer> createState() => _LoadingContainerState();
}

class _LoadingContainerState extends State<LoadingContainer>
    with SingleTickerProviderStateMixin {
  final Tween<double> multiplier = Tween<double>(begin: 0.0, end: 1.0);
  late final Animation<double> animation;
  @override
  void initState() {
    super.initState();
    animation = multiplier.animate(widget.controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.2),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              left: 0,
              child: Container(
                width: (constraints.maxWidth * animation.value),
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withAlpha(10),
                      Colors.white.withAlpha(60),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
