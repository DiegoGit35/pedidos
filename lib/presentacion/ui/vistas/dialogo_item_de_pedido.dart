import 'package:ej_hexa/dominio/entidades.dart';
import 'package:ej_hexa/main.dart';
import 'package:flutter/material.dart';

class DialogoItemDePedido extends StatefulWidget {
  final ItemDePedido itemDePedidoAEditar;
  const DialogoItemDePedido({required this.itemDePedidoAEditar, super.key});

  @override
  State<DialogoItemDePedido> createState() => _DialogoItemDePedidoState();
}

class _DialogoItemDePedidoState extends State<DialogoItemDePedido> {
  List<Comida> todasLasComidas = repositorioDePedidos.obtenerTodasLasComidas();
  _DialogoItemDePedidoState();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const SizedBox(width: 500, child: Text('Item')),
      content: Scaffold(
        body: SizedBox(
          width: 500,
          child: Column(children: [
            TextField(
              controller: TextEditingController.fromValue(TextEditingValue(
                  text: widget.itemDePedidoAEditar.cantidad.toString())),
              decoration: const InputDecoration(hintText: 'Cantidad'),
              onChanged: (value) =>
                  widget.itemDePedidoAEditar.cantidad = int.parse(value),
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
                value: widget.itemDePedidoAEditar.comida,
                onChanged: (unaComida) => {
                      if (unaComida != null)
                        {
                          setState(() =>
                              widget.itemDePedidoAEditar.comida = unaComida)
                        },
                    }),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () =>
                      {Navigator.of(context).pop(widget.itemDePedidoAEditar)},
                  child: const SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Center(child: Text('Aceptar')),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () => {Navigator.of(context).pop(Null)},
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
