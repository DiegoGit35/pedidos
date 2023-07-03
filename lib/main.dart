import 'package:ej_hexa/aplicacion/adm_pedidos.dart';
import 'package:ej_hexa/datos/adaptadores_de_repositorios.dart';
import 'package:ej_hexa/dominio/repositorios.dart';
import 'package:ej_hexa/presentacion/routes.dart';
import 'package:flutter/material.dart';

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
    return MaterialApp.router(
        title: 'Frutality',
        // theme: Theme.of(context).copyWith(
        //     textTheme: const TextTheme(
        //       displayMedium: TextStyle(
        //           fontFamily: 'AmaticSC',
        //           color: Colors.black,
        //           fontSize: 28,
        //           fontStyle: FontStyle.normal,
        //           fontWeight: FontWeight.bold),
        //       displayLarge: TextStyle(
        //           fontFamily: 'AmaticSC',
        //           color: Colors.black,
        //           fontSize: 42,
        //           fontStyle: FontStyle.normal,
        //           fontWeight: FontWeight.bold),
        //     ),
        //     elevatedButtonTheme: const ElevatedButtonThemeData(
        //         style: ButtonStyle(
        //             textStyle: MaterialStatePropertyAll(TextStyle(
        //                 color: Colors.black,
        //                 fontSize: 36,
        //                 fontWeight: FontWeight.w700,
        //                 fontFamily: 'AmaticSC')),
        //             backgroundColor:
        //                 MaterialStatePropertyAll(Colors.lightGreen),
        //             // overlayColor: MaterialStatePropertyAll(Colors.lightGreen),
        //             // shadowColor: MaterialStatePropertyAll(Colors.transparent),
        //             foregroundColor: MaterialStatePropertyAll(Colors.blue)))

        //     // primarySwatch: Colors.amber,
        //     // primarySwatch: Colors.transparent.withOpacity(opacity),
        //     ),
        routerConfig: pedidosRouter);
  }
}
