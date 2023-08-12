import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login/bloc/user_bloc.dart';

class WeathercastScreen extends StatelessWidget {
  const WeathercastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, _) {
          Navigator.of(context).pushNamed('/');
        },
        listenWhen: (previous, current) => current is NoUser,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<UserBloc, UserState>(
                  buildWhen: (previous, current) => current is HasUser,
                  builder: (context, state) {
                    if ((state as HasUser).user.photoURL != null) {
                      return Container(
                        width: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color: Theme.of(context).primaryColor,
                          ),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              state.user.photoURL!,
                            ),
                          ),
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
          body: Builder(builder: (context) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(Logout());
                      },
                      child: Text("Выйти"),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
