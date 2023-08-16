import 'package:evaranshark_weathercast/screens/weathercast_screen/bloc/forecast_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../models/weather.dart';
import '../../../services/constants.dart';
import '../../../widgets/gpn_bubble.dart';
import '../bloc/forecast_state.dart';

class HourlyForecast extends StatefulWidget {
  const HourlyForecast({
    super.key,
  });

  @override
  State<HourlyForecast> createState() => _HourlyForecastState();
}

class _HourlyForecastState extends State<HourlyForecast> {
  int selectedItemIndex = 0;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: GpnBubble(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Сегодня",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    DateFormat("dd MMMM", "ru_RU").format(DateTime.now()),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 142,
                ),
                child: BlocBuilder<ForecastBloc, ForecastState>(
                  builder: (context, state) => (state is HasForecastData)
                      ? ForecastRoll(
                          selectedIndex: selectedItemIndex,
                          onSelectedIndex: (value) {
                            setState(() {
                              selectedItemIndex = value;
                            });
                          },
                          children: state.data.forecast!.items
                              .map((e) => HourForecastDescription(
                                    time: DateFormat.Hm().format(e.dateTime),
                                    temp: e.mainData.temp.round().toString(),
                                    icon: e.weather.icon,
                                  ))
                              .toList())
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForecastRoll extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelectedIndex;
  final List<HourForecastDescription> children;
  const ForecastRoll({
    super.key,
    required this.children,
    required this.selectedIndex,
    required this.onSelectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: children.map((e) {
          return InkWell(
            onTap: () => onSelectedIndex.call(children.indexOf(e)),
            child: _HourForecastDescriptionWidget(
              time: e.time,
              temp: e.temp,
              imageAsset: _resolveIcon(e.icon),
              active: children.indexOf(e) == selectedIndex,
            ),
          );
        }).toList(),
      ),
    );
  }

  _resolveIcon(IconId icon) => switch (icon) {
        IconId.clear => Assets.sunSm,
        IconId.cloudD => Assets.csunSm,
        IconId.cloudN => Assets.cmoonSm,
        IconId.rain => Assets.crainSm,
        IconId.snow => Assets.csnowSm,
        IconId.thunder => Assets.thunderSm,
      };
}

class HourForecastDescription {
  final String time;
  final String temp;
  final IconId icon;

  HourForecastDescription({
    required this.time,
    required this.temp,
    required this.icon,
  });
}

class _HourForecastDescriptionWidget extends StatelessWidget {
  final String time;
  final String temp;
  final String imageAsset;
  final bool active;
  const _HourForecastDescriptionWidget({
    super.key,
    required this.time,
    required this.temp,
    this.active = false,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 74,
      child: Container(
        decoration: BoxDecoration(
          color: active ? Colors.white.withOpacity(0.4) : Colors.transparent,
          border: active
              ? Border.all(
                  color: Colors.white,
                )
              : null,
          borderRadius: active ? BorderRadius.circular(12.0) : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Image.asset(
                imageAsset,
                width: 32,
                height: 32,
              ),
              Text(
                temp,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
