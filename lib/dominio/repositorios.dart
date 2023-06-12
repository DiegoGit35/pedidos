import 'package:ej_hexa/dominio/entidades.dart';

abstract class RepositorioDePedidos {
  guardarPedido(Pedido unPedido);
  guardarComida(Comida unaComida);
  List<Pedido> obtenerPedidosQueContengaDeterminadaComida(Comida unaComida);
  List<Comida> obtenerTodasLasComidas();
  List<Pedido> obtenerTodosLosPedidos();
  int obtenerProximoNumeroDePedido();
}
