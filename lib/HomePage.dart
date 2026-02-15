import 'package:flutter/material.dart';
import 'widgets/gradient_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          title: const Text("Theme Test Page"),
          centerTitle: true,
        ),

        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Text(
                "Welcome to Lumin",
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: 24),

              const TextField(
                decoration: InputDecoration(
                  hintText: "Email address",
                  prefixIcon: Icon(Icons.email),
                ),
              ),

              const SizedBox(height: 16),

              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {},
                child: const Text("Create Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
