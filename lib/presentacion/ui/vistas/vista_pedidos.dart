import 'package:ej_hexa/aplicacion/adm_pedidos.dart';
import 'package:ej_hexa/main.dart';
import 'package:ej_hexa/presentacion/ui/blocs/bloc_edicion_de_pedido.dart';
import 'package:ej_hexa/presentacion/ui/vistas/vista_de_edicion_de_pedido.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VistaPedidos extends StatelessWidget {
  const VistaPedidos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Administración de pedidos')),
        body: BlocConsumer<AdministracionDePedidos,
                EstadoDeAdministracionDePedidos>(
            bloc: blocAdministracionDePedidos,
            builder: ((builderContext, state) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Pedidos:',
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    ListView(
                        shrinkWrap: true,
                        children: state.nombre ==
                                NombreDeEstadoDeAdministracionDePedidos.inicial
                            ? (state as EstadoADPInicial)
                                .pedidos
                                .map((unPedido) => SizedBox(
                                    height: 50,
                                    width: 200,
                                    child: Text(unPedido.toString())))
                                .toList()
                            : []),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () => blocAdministracionDePedidos
                              .comenzarCreacionDePedido(),
                          child: const SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Crear pedido',
                                ),
                              ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () => blocAdministracionDePedidos
                              .comenzarEdicionDePedidoSeleccionado(),
                          child: const SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Editar pedido',
                                ),
                              ))),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ]);
            }),
            listener: (context, state) {
              if (state.nombre ==
                  NombreDeEstadoDeAdministracionDePedidos.editandoPedido) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builderContext) =>
                            BlocProvider<EdicionDePedido>(
                                create: (context) => EdicionDePedido(
                                    const EstadoEDPConPedidos(
                                        NombreDeEstadoDeEdicionDePedido.inicial,
                                        itemsDePedido: [],
                                        itemDePedidoSeleccionado: null)),
                                child: const VistaDeEdicionDePedido())));
              } else if (state.nombre ==
                  NombreDeEstadoDeAdministracionDePedidos.falla) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text((state as EstadoADPFalla).mensajeDeError)));
              }
            }));
  }
}
