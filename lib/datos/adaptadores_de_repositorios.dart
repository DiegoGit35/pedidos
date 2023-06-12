import 'package:ej_hexa/dominio/repositorios.dart';

import '../dominio/entidades.dart';

class AdaptadorMemoriaRepositorioPedidos implements RepositorioDePedidos {
  final List<Pedido> _pedidos = [];
  final List<Comida> _comidas = [
    Comida(nombre: 'Milanesa', precio: 2500),
    Comida(nombre: 'Hamburguesa', precio: 1800),
    Comida(nombre: 'Pancho', precio: 500)
  ];

  @override
  guardarPedido(Pedido unPedido) {
    _pedidos.add(unPedido);
  }

  @override
  List<Pedido> obtenerPedidosQueContengaDeterminadaComida(Comida unaComida) {
    return _pedidos
        .where((pedido) => pedido.contieneComida(unaComida))
        .toList();
  }

  @override
  guardarComida(Comida unaComida) {
    _comidas.add(unaComida);
  }

  @override
  List<Comida> obtenerTodasLasComidas() {
    return _comidas;
  }

  @override
  List<Pedido> obtenerTodosLosPedidos() {
    return _pedidos;
  }

  @override
  int obtenerProximoNumeroDePedido() {
    return _pedidos.length;
  }
}
