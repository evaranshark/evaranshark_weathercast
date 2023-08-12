import 'package:evaranshark_weathercast/repositories/style_repo.dart';
import 'package:evaranshark_weathercast/screens/login/bloc/user_bloc.dart';
import 'package:evaranshark_weathercast/screens/login/widgets/login_form.dart';
import 'package:evaranshark_weathercast/services/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<StyleRepo>(
      builder: (context, value, child) => Theme(
          data: value.useGPNTheme ? GPNTheme.theme : EvaransharkTheme.theme,
          child: child!),
      child: BlocProvider<UserBloc>(
        create: (context) => UserBloc(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is HasError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.error.toString()),
                  behavior: SnackBarBehavior.floating,
                ));
              }
              if (state is HasUser) {
                Navigator.of(context).pushNamed('/weathercast');
              }
            },
            child: Consumer<StyleRepo>(
              builder: (context, value, child) {
                return value.useGPNTheme ? const _GPNLoginScreen() : child!;
              },
              child: Stack(
                children: [
                  SizedBox(
                    width: size.width,
                    height: size.height,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/background.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Scaffold(
                    backgroundColor: Colors.transparent,
                    body: _LoginForm(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LoginForm(
            onLogin: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("login actions")),
            ),
          ),
        ),
      ),
    );
  }
}

class _GPNLoginScreen extends StatefulWidget {
  const _GPNLoginScreen({super.key});

  @override
  State<_GPNLoginScreen> createState() => _GPNLoginScreenState();
}

class _GPNLoginScreenState extends State<_GPNLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _GPNHeaders(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text("EMail"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Войти",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GPNHeaders extends StatelessWidget {
  const _GPNHeaders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Вход",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }
}
