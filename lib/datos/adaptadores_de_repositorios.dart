import 'package:ej_hexa/dominio/repositorios.dart';

import '../dominio/entidades.dart';

class AdaptadorMemoriaRepositorioPedidos implements RepositorioDePedidos {
  final List<Pedido> _pedidos = [];
  final List<Comida> _comidas = [
    Comida(nombre: 'Entraña de Res', precio: 4000),
    Comida(nombre: 'Ravioles al Disco', precio: 3600),
    Comida(nombre: 'Bondiola de Cerdo', precio: 4500),
    Comida(nombre: 'Pamplona de Pollo Rellena', precio: 3800),
    Comida(nombre: 'Chirpirones Rellenos', precio: 3200),
    Comida(nombre: 'Picada', precio: 2500),
    Comida(nombre: 'Pasteles Fritos', precio: 4200),
    Comida(nombre: 'Brusquetas de Jamon y Queso', precio: 2500),
    Comida(nombre: 'Sorrentinos', precio: 3000),
    Comida(nombre: 'Molleja', precio: 3200),
    Comida(nombre: 'Flan Casero', precio: 1500),
    Comida(nombre: 'Strudel de Manzana', precio: 1600),
    Comida(nombre: 'Volcan de Chocolate', precio: 2000),
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
