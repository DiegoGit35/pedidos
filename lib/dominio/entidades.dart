class Comida {
  String nombre;
  double precio;
  Comida({required this.nombre, required this.precio});

  @override
  bool operator ==(Object other) {
    return (other is Comida && nombre == other.nombre);
  }

  @override
  int get hashCode => nombre.hashCode;

  @override
  String toString() {
    return nombre;
  }
}

class ItemDePedido {
  int cantidad;
  Comida comida;
  ItemDePedido({required this.cantidad, required this.comida});
  double get totalItem => cantidad * comida.precio;

  @override
  String toString() {
    return "$cantidad - ${comida.nombre} - $totalItem";
  }

  @override
  bool operator ==(Object other) {
    return (other is ItemDePedido && comida == other.comida);
  }

  @override
  int get hashCode => comida.hashCode;
}

class Pedido {
  int nroPedido;
  List<ItemDePedido> items = [];

  Pedido(this.nroPedido);

  agregarItem(int cantidad, Comida comida) {
    items.add(ItemDePedido(cantidad: cantidad, comida: comida));
  }

  bool contieneComida(Comida unaComida) {
    return items.any((item) => item.comida == unaComida);
  }
}
