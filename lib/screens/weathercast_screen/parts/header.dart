import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../models/weather.dart';
import '../../../widgets/change_theme_widget.dart';
import '../../login/bloc/user_bloc.dart';
import '../bloc/forecast_bloc.dart';
import '../bloc/forecast_event.dart';
import '../bloc/forecast_state.dart';

class ForecastHeader extends StatelessWidget {
  const ForecastHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const LocationText(),
          PopupMenuButton(
            icon: const Icon(Icons.settings_outlined),
            onSelected: (value) async {
              if (value == 1) {
                context.read<UserBloc>().add(Logout());
              }
              if (value == 2) {
                context.read<ForecastBloc>().add(FetchWeather());
              }
              if (value == 3) {
                var box = await Hive.openBox<Weather>("forecast");
                await box.clear();
                await box.close();
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: ChangeThemeWidget(),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("Выйти"),
                ),
                if (kDebugMode)
                  const PopupMenuItem<int>(
                    value: 2,
                    child: Text("Get Data"),
                  ),
                if (kDebugMode)
                  const PopupMenuItem<int>(
                    value: 3,
                    child: Text("Clear box"),
                  ),
              ];
            },
          ),
        ],
      ),
    );
  }
}

class LocationText extends StatelessWidget {
  const LocationText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 24,
        ),
        const SizedBox(
          width: 10,
        ),
        BlocBuilder<ForecastBloc, ForecastState>(builder: (context, state) {
          return Text(
              (state is HasForecastData) ? state.data.locationName! : "");
        }),
      ],
    );
  }
}
