import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../services/constants.dart';
import '../../../widgets/gpn_bubble.dart';
import '../bloc/forecast_bloc.dart';
import '../bloc/forecast_state.dart';

class ForecastDetails extends StatelessWidget {
  const ForecastDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: GpnBubble(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<ForecastBloc, ForecastState>(
                  buildWhen: (previous, current) => current is HasForecastData,
                  builder: (context, forecastState) {
                    return ForecastDetailsItem(
                      svgIconAsset: Assets.wind,
                      value: (forecastState is HasForecastData)
                          ? "${forecastState.data.wind.speed} м/с"
                          : "",
                      description: (forecastState is HasForecastData)
                          ? "Ветер ${forecastState.data.wind.direction}"
                          : "",
                    );
                  }),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<ForecastBloc, ForecastState>(
                  buildWhen: (previous, current) => current is HasForecastData,
                  builder: (context, forecastState) {
                    return ForecastDetailsItem(
                      svgIconAsset: Assets.drop,
                      value: (forecastState is HasForecastData)
                          ? "${forecastState.data.mainData.humidity} %"
                          : "",
                      description: (forecastState is HasForecastData)
                          ? "${forecastState.data.mainData.humidityDesc} влажность"
                          : "",
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ForecastDetailsItem extends StatelessWidget {
  final String svgIconAsset;
  final String value, description;
  const ForecastDetailsItem({
    super.key,
    required this.svgIconAsset,
    required this.value,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: SvgPicture.asset(svgIconAsset),
              ),
              const Spacer(),
              Expanded(
                flex: 5,
                child: Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white.withOpacity(0.2)),
                ),
              ),
            ],
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 5,
          child: Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
