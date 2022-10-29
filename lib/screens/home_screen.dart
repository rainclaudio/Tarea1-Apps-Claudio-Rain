import 'package:tarea1/services/services.dart';
import 'package:tarea1/widgets/widgets.dart';
import 'package:tarea1/models/models.dart';
import 'package:tarea1/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    final messagesService = Provider.of<MensajeService>(context);

    final authService = Provider.of<AuthService>(context, listen: false);

    if (messagesService.isLoading) return const LoadingScreen();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Super Messages'),
          // este es un botón para que nos podamos desloguear
          leading: IconButton(
            icon: const Icon(Icons.login_outlined),
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ),
        
        body: ListView.builder(
            itemCount: messagesService.messages.length,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
                // onTap: () {
                //   productsService.selectedProduct =
                //       productsService.products[index].copy();
                //   Navigator.pushNamed(context, 'product');
                // },
                // child: ProductCard(
                //   product: productsService.products[index],
                // )
                child: MensajeCard(message: messagesService.messages[index]))),
        floatingActionButton: AddProduct(messageService: messagesService,authService: authService, ));
  }
}

class AddProduct extends StatelessWidget {


  const AddProduct({
    Key? key,
    required this.messageService,
    required this.authService
  }) : super(key: key);

  final MensajeService messageService;
  final AuthService authService;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        // creación de un dummy product
        messageService.selectedMessage = Mensaje(login: authService.email,texto: '',titulo: '');
        Navigator.pushNamed(context, 'message');
      },
    );
  }
}
