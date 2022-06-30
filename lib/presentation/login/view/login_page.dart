import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _LoginPageWidget(),
    );
  }
}

class _LoginPageWidget extends StatelessWidget {
  const _LoginPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(flex: 64),
        Center(
          child: Text(
            "Вход",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
        ),
        Spacer(flex: 88),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: TextField(
            decoration: InputDecoration(hintText: 'Почта'),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: TextField(
            decoration: InputDecoration(hintText: 'Пароль'),
          ),
        ),
        SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => debugPrint('Нажали на кнопку Войти'),
              child: Text("Войти"),
            ),
          ),
        ),
        SizedBox(height: 24),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Ещё нет аккаунта?"),
            TextButton(
              onPressed: () => debugPrint('Нажали на кнопку Создать'),
              child: Text('Создать'),
            ),
          ],
        ),
        SizedBox(height: 8),
        TextButton(
          onPressed: () => debugPrint('Нажали на кнопку Не помню пароль'),
          child: Text('Не помню пароль'),
        ),
        Spacer(flex: 284),
      ],
    );
  }
}
