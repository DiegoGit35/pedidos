import 'package:ej_hexa/dominio/entidades.dart';
import 'package:ej_hexa/presentacion/ui/blocs/bloc_edicion_de_pedido.dart';
import 'package:ej_hexa/presentacion/ui/vistas/dialogo_item_de_pedido.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VistaDeEdicionDePedido extends StatefulWidget {
  const VistaDeEdicionDePedido({super.key});

  @override
  State<VistaDeEdicionDePedido> createState() => _VistaDeEdicionDePedidoState();
}

class _VistaDeEdicionDePedidoState extends State<VistaDeEdicionDePedido> {
  final int _total = 0;
  late EdicionDePedido blocEdicionDePedido;
  @override
  Widget build(BuildContext context) {
    blocEdicionDePedido = BlocProvider.of<EdicionDePedido>(context);
    Future<ItemDePedido?> mostrarDialogoDeItemDePedido() async {
      return await showDialog<ItemDePedido?>(
          context: context,
          builder: (BuildContext context) {
            return const DialogoItemDePedido();
          });
    }

    Future<void> crearItemDePedido() async {
      ItemDePedido? itemDePedidoONada = await mostrarDialogoDeItemDePedido();
      if (itemDePedidoONada != null) {
        blocEdicionDePedido.agregarItemDePedido(itemDePedidoONada);
      }
    }

    Future<ItemDePedido?> editarItemDePedido() async {
      return await showDialog<ItemDePedido?>(
          context: context,
          builder: (BuildContext context) {
            return const DialogoItemDePedido();
          });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edición de pedido')),
      body: BlocConsumer<EdicionDePedido, EstadoDeEdicionDePedido>(
          builder: ((context, state) {
        state as EstadoEDPConPedidos;
        return Column(
          children: [
            const Text("Comidas: "),
            ListView(
                shrinkWrap: true,
                children: state.itemsDePedido
                    .map((unItem) => SizedBox(
                        height: 50, width: 200, child: Text(unItem.toString())))
                    .toList()),
            Text('Total: $_total'),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: blocEdicionDePedido
                      .comenzarEditarItemDePedidoSeleccionado,
                  child: const SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Center(child: Text('Editar  item')))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: blocEdicionDePedido.comenzandoACrearItemDePedido,
                  child: const SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Center(child: Text('Agregar  item')))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () => {},
                  child: const SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Center(child: Text('Regresar')))),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        );
      }), listener: (context, state) {
        switch (state.nombre) {
          case NombreDeEstadoDeEdicionDePedido.editandoItemDePedido:
            editarItemDePedido();
            break;
          case NombreDeEstadoDeEdicionDePedido.creandoItemdePedido:
            crearItemDePedido();
            break;
          default:
        }
      }),
    );
  }
}
