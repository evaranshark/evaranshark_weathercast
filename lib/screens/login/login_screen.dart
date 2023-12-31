import 'package:email_validator/email_validator.dart';
import 'package:evaranshark_weathercast/repositories/style_repo.dart';
import 'package:evaranshark_weathercast/screens/login/bloc/user_bloc.dart';
import 'package:evaranshark_weathercast/screens/login/widgets/login_form.dart';
import 'package:evaranshark_weathercast/screens/weathercast_screen/bloc/forecast_bloc.dart';
import 'package:evaranshark_weathercast/screens/weathercast_screen/bloc/forecast_event.dart';
import 'package:evaranshark_weathercast/services/constants.dart';
import 'package:evaranshark_weathercast/widgets/change_theme_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<StyleRepo>(
      builder: (context, value, child) =>
          Theme(data: value.theme.light, child: child!),
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
              Navigator.of(context).pushReplacementNamed('/weathercast');
              context.read<ForecastBloc>().add(FetchWeather());
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
                const SafeArea(
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: _LoginForm(),
                  ),
                ),
              ],
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
    return const Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              LoginForm(),
              SizedBox(
                height: 10,
              ),
              EvaBubble(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 24.0,
                  ),
                  child: ChangeThemeWidget(),
                ),
              ),
            ],
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
  final TextEditingController emailController = TextEditingController(),
      passwordControler = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _GPNHeaders(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: TextFormField(
                    enabled: (userState is! Loading),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите Email";
                      }
                      if (!EmailValidator.validate(value)) {
                        return "Некорректный Email";
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                      label: Text("EMail"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: PasswordField(
                    enabled: (userState is! Loading),
                    controller: passwordControler,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите пароль";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0, top: 24.0),
                  child: FilledButton(
                    onPressed: (userState is Loading)
                        ? null
                        : () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (_formKey.currentState!.validate()) {
                              context.read<UserBloc>().add(EmailLogin(
                                  email: emailController.text,
                                  password: passwordControler.text));
                            }
                          },
                    child: Text(
                      "Войти",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const Spacer(),
                ChangeThemeWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final bool enabled;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const PasswordField({
    super.key,
    this.controller,
    this.validator,
    this.enabled = true,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: hidePassword,
      decoration: InputDecoration(
        label: const Text("Пароль"),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 40,
          maxWidth: 40,
        ),
        suffixIcon: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () => setState(() {
              hidePassword = !hidePassword;
            }),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                hidePassword ? Assets.eyeOff : Assets.eye,
                width: 24,
                height: 24,
              ),
            ),
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
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Вход",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            "Введите данные для входа",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.greyText),
          ),
        ],
      ),
    );
  }
}
