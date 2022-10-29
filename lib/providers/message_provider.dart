import 'package:flutter/material.dart';
import 'package:tarea1/models/models.dart';

class MessageFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
// una nueva instancia para alojar el valor del producto seleccionado
  Mensaje message;
  // importante que este valor sea una copia y no el original PORQUE TODOS LOS ELEMENTOS SE PASAN POR REFERENCIA
  MessageFormProvider(this.message);

  updateAviability(bool value) {
    // print(value);
    // product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    // print(product.name);
    // print(product.price);
    // print(product.available);
    return formKey.currentState?.validate() ?? false;
  }
}
