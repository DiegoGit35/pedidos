import 'package:ej_hexa/dominio/entidades.dart';
import 'package:ej_hexa/main.dart';
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
  late BlocEdicionDePedido blocEdicionDePedido;
  int indiceDeItemDePedidoSeleccionado = 0;
  @override
  Widget build(BuildContext context) {
    blocEdicionDePedido = BlocProvider.of<BlocEdicionDePedido>(context);
    Future<ItemDePedido?> mostrarDialogoDeItemDePedido(
        ItemDePedido itemDePedido) async {
      return await showDialog<ItemDePedido?>(
          context: context,
          builder: (BuildContext context) {
            return DialogoItemDePedido(
              itemDePedidoAEditar: itemDePedido,
            );
          });
    }

    Future<void> crearItemDePedido() async {
      ItemDePedido? itemDePedidoONada = await mostrarDialogoDeItemDePedido(
          ItemDePedido(
              cantidad: 1,
              comida: repositorioDePedidos.obtenerTodasLasComidas()[0]));
      if (itemDePedidoONada != null) {
        blocEdicionDePedido.agregarItemDePedido(itemDePedidoONada);
      }
    }

    Future<void> editarItemDePedido(
        ItemDePedido itemDepedidoSeleccionado) async {
      ItemDePedido? itemDePedidoONada = await showDialog<ItemDePedido?>(
          context: context,
          builder: (BuildContext context) {
            return DialogoItemDePedido(
                itemDePedidoAEditar: itemDepedidoSeleccionado);
          });
      if (itemDePedidoONada != null) {
        blocEdicionDePedido.actualizarItemDePedido(itemDePedidoONada);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edición de pedido')),
      body: BlocConsumer<BlocEdicionDePedido, EstadoDeEdicionDePedido>(
          builder: ((context, state) {
        state as EEPCreandoOEditandoPedido;
        return Column(
          children: [
            const Text("Comidas: "),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    selected: state.itemsDePedido[index] ==
                        context
                            .watch<BlocEdicionDePedido>()
                            .itemDePedidoSeleccionado,
                    title: Text(state.itemsDePedido[index].toString()),
                    onTap: () {
                      setState(() {
                        BlocProvider.of<BlocEdicionDePedido>(context)
                            .seleccionarItemDePedido(
                                state.itemsDePedido[index]);
                      });
                    },
                  );
                },
                itemCount: state.itemsDePedido.length,
              ),
            ),
            Text(
                'Total:${context.watch<BlocEdicionDePedido>().pedido.getTotal()}'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: context
                              .watch<BlocEdicionDePedido>()
                              .pedido
                              .getTotal() ==
                          0
                      ? blocEdicionDePedido
                          .comenzarEditarItemDePedidoSeleccionado
                      : () =>
                          ScaffoldMessenger.of(context).showSnackBar(snackBar),
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
            state as EEPCreandoOEditandoPedido;
            editarItemDePedido(state.itemDePedidoSeleccionado!);
            break;
          case NombreDeEstadoDeEdicionDePedido.creandoItemdePedido:
            state as EEPCreandoOEditandoPedido;
            crearItemDePedido();
            break;
          default:
        }
      }),
    );
  }
}

const snackBar = SnackBar(
  content: Text('No hay un pedido seleccionado!'),
);
