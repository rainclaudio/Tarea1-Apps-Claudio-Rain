import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarea1/screens/screens.dart';
import 'package:tarea1/services/services.dart';
void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      
      providers:[
        ChangeNotifierProvider(create: (_) => ProductService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => MensajeService())
      ],
      child: const MyApp()
    
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productos App',
      initialRoute: 'login',
      routes: {
        'login': (_) => const LoginScreen(),
        'home': (_) => const HomeScreen(),
        'message': (_) => const MessageScreen()
      },
      theme:
          ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white),
    );
  }
}
