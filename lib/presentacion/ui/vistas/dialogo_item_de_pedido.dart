import 'package:ej_hexa/dominio/entidades.dart';
import 'package:ej_hexa/main.dart';
import 'package:flutter/material.dart';

class DialogoItemDePedido extends StatefulWidget {
  const DialogoItemDePedido({super.key});

  @override
  State<DialogoItemDePedido> createState() => _DialogoItemDePedidoState();
}

class _DialogoItemDePedidoState extends State<DialogoItemDePedido> {
  int cantidad = 1;
  Comida? comidaSeleccionada;
  List<Comida> todasLasComidas = repositorioDePedidos.obtenerTodasLasComidas();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const SizedBox(width: 500, child: Text('Item')),
      content: Scaffold(
        body: SizedBox(
          width: 500,
          child: Column(children: [
            TextField(
              decoration: const InputDecoration(hintText: 'Cantidad'),
              onChanged: (value) => cantidad = int.parse(value),
            ),
            DropdownButtonFormField<Comida>(
                isExpanded: true,
                items: todasLasComidas
                    .map((unaComida) => DropdownMenuItem<Comida>(
                        value: unaComida,
                        child: Text(
                          unaComida.nombre,
                        )))
                    .toList(),
                value: comidaSeleccionada,
                onChanged: (unaComida) => {
                      // print(_comidaSeleccionadoString)
                      // _comidaSeleccionado = value
                      setState(() =>
                              //   print(value!.nombre);
                              comidaSeleccionada = unaComida
                          //   _comidaSeleccionado = value;
                          )
                    }),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () => {
                        if (comidaSeleccionada == null)
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Debes seleccionar una comida')))
                          }
                        else
                          {
                            Navigator.of(context).pop(ItemDePedido(
                                cantidad: cantidad,
                                comida: comidaSeleccionada!))
                          },
                      },
                  child: const SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Center(child: Text('Aceptar')),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () => {Navigator.of(context).pop()},
                  child: const SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Center(child: Text('Cancelar')),
                  )),
            ),
            const SizedBox(
              height: 50,
            )
          ]),
        ),
      ),
    );
  }
}
