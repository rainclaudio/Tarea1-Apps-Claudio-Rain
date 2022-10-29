
import 'package:provider/provider.dart';

import 'package:tarea1/UI/input_decorations.dart';
import 'package:tarea1/providers/message_provider.dart';
import 'package:tarea1/services/services.dart';

import 'package:tarea1/widgets/widgets.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageService = Provider.of<MensajeService>(context);

    return ChangeNotifierProvider(
      create: (_) => MessageFormProvider(messageService.selectedMessage),
      child: _MessageScreenBody(messageService: messageService),
    );
  }
}

class _MessageScreenBody extends StatelessWidget {
  final MensajeService messageService;
  const _MessageScreenBody({Key? key, required this.messageService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageForm = Provider.of<MessageFormProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: const Text('Nuevo Mensaje'),
          // este es un botón para que nos podamos desloguear
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
          )),
      body: SingleChildScrollView(

          // una vez que hago scroll en la pantalla, el teclado se oculta
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(children: const [
            _MessageForm(),
            SizedBox(
              height: 100,
            )
          ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton.extended(
        // Icono
        // si la imagen está en proceso de guardado, no se ejecuta la función
        onPressed: messageService.isSaving
            ? null
            : () async {
                // Aquí verifica si lo que está en el widget _ProductForm(), es válido. Por favor, echarle un ojo
                messageForm.isValidForm();
                // si no es válido
                if (!messageForm.isValidForm()){ 
                  print('not valid');
                  return;

                }
               
                await messageService.saveOrCreateProduct(messageForm.message);
                // ignore: use_build_context_synchronously
                return Navigator.of(context).pop();
              },
        // Icono: si la imagen está en proceso de guardado, el icono cambia a status loading
        label: messageService.isSaving ? const Text('') : const Text('Guardar'),
        icon: messageService.isSaving
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(Icons.save_outlined),
      ),
    );
  }
}

class _MessageForm extends StatelessWidget {
  const _MessageForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageForm = Provider.of<MessageFormProvider>(context);
    final message = messageForm.message;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: messageForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: message.titulo,
                onChanged: (value) => message.titulo = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'el nombre es obligatorio';
                  }
                  return null;
                },
                decoration: InputsDecorations.authInputDecoration(
                    hintText: 'Título del mensaje', labelText: 'Título'),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 420,
                child: TextFormField(
                  maxLines: 420,
                  keyboardType: TextInputType.number,
                  initialValue: message.texto,
                  onChanged: (value) => message.texto = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'por favor añada contenido';
                    }
                    return null;
                  },
                  decoration: InputsDecorations.authInputDecoration(
                      hintText: 'descripción del mensaje',
                      labelText: 'Descripción'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
            blurRadius: 5,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 5))
      ],
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)));
}
