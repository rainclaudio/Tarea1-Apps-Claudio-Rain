import 'package:flutter/material.dart';
import 'package:tarea1/models/models.dart';

// estamos usando solo statless widge

class MensajeCard extends StatelessWidget {
  final Mensaje message;

  const MensajeCard({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        height: 100,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            // _ImageProfile(message: message),
            _ProductBody(
              message: message,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              offset: Offset(0, 6),
              color: Colors.black12,
            )
          ]);
}



class _ProductBody extends StatelessWidget {
  final Mensaje message;
  const _ProductBody({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        // Sacamos esa aberración de mostrar la id y reducimos el tamaño
        height: 100,
        // decoration: _buildBoxDecoration(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            message.titulo,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            message.texto,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          // Text(
          //   product.id != null ? product.id! : '',
          //   style: const TextStyle(
          //     fontSize: 15,
          //     color: Colors.white,
          //   ),
          // ),
        ]),
      ),
    );
  }

  
}

// ignore: unused_element
class _ImageProfile extends StatelessWidget {
  final Mensaje message;
  const _ImageProfile({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 10,);
    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(25),
    //   child: SizedBox(
    //       width: double.infinity,
    //       height: 400,
    //       // si el producto fetcheado no posee imagen, de dejamos una imagen por defecto
    //       child: product.picture == null
    //           // ignore: prefer_const_constructors
    //           ? Image(
    //               image: const AssetImage('assets/no-image.png'),
    //               fit: BoxFit.cover,
    //             )
    //           : FadeInImage(
    //               // todo: productos sin imagenes
    //               placeholder: const AssetImage('assets/jar-loading.gif'),
    //               image: NetworkImage(product.picture!),
    //               fit: BoxFit.cover,
    //             )),
    // );
  }
}
