import 'package:ej_hexa/aplicacion/adm_pedidos.dart';
import 'package:ej_hexa/datos/adaptadores_de_repositorios.dart';
import 'package:ej_hexa/dominio/repositorios.dart';
import 'package:ej_hexa/presentacion/ui/vistas/vista_pedidos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Definir adaptadores de repositorios
RepositorioDePedidos repositorioDePedidos =
    AdaptadorMemoriaRepositorioPedidos();

// Definir Blocs/Cubits (Operaciones)

AdministracionDePedidos blocAdministracionDePedidos = AdministracionDePedidos(
    const EstadoADPInicial(pedidos: [], pedidoSeleccionado: null));

// Arranque del sistema
void main() async {
  runApp(const AdministracionDePedidosApp());
}

// Definición de la clase cuya instancia representa la aplicación

class AdministracionDePedidosApp extends StatelessWidget {
  const AdministracionDePedidosApp({Key? key}) : super(key: key);

// Con BlocProvider permitimos que la pantalla de pedidos (VistaPedidos)
// pueda estar escuchando los cambios de estado del bloc AdministracionDePedidos,
// para ello en vista pedidos tendremos que tener un BlocBuilder, un BlocListener
// o un BlocConsumer
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider<AdministracionDePedidos>(
            create: (context) => blocAdministracionDePedidos,
            child: const VistaPedidos()));
  }
}
