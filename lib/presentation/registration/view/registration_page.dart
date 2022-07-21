import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/presentation/registration/bloc/registration_bloc.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(),
      child: const Scaffold(
        body: _RegistrationPageWidget(),
      ),
    );
  }
}

class _RegistrationPageWidget extends StatefulWidget {
  const _RegistrationPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_RegistrationPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<_RegistrationPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('REGISTER'),),
    );
  }
}