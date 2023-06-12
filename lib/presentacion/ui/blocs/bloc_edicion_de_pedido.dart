import 'package:ej_hexa/dominio/entidades.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

enum NombreDeEstadoDeEdicionDePedido {
  inicial,
  falla,
  editandoItemDePedido,
  creandoItemdePedido
}

abstract class EstadoDeEdicionDePedido extends Equatable {
  final NombreDeEstadoDeEdicionDePedido nombre;
  @override
  List<Object?> get props => [nombre];
  const EstadoDeEdicionDePedido(this.nombre);
}

class EstadoEDPConPedidos extends EstadoDeEdicionDePedido {
  final List<ItemDePedido> itemsDePedido;
  final ItemDePedido? itemDePedidoSeleccionado;
  @override
  List<Object?> get props => [nombre, itemsDePedido, itemDePedidoSeleccionado];
  const EstadoEDPConPedidos(
    NombreDeEstadoDeEdicionDePedido nombre, {
    required this.itemsDePedido,
    required this.itemDePedidoSeleccionado,
  }) : super(nombre);
}

class EstadoEDPFalla extends EstadoDeEdicionDePedido {
  final String mensajeDeError;
  const EstadoEDPFalla({required this.mensajeDeError})
      : super(NombreDeEstadoDeEdicionDePedido.falla);

  @override
  List<Object?> get props => [nombre, mensajeDeError];
}

class EdicionDePedido extends Cubit<EstadoDeEdicionDePedido> {
  final List<ItemDePedido> _itemsDePedido = [];
  ItemDePedido? _itemDePedidoSeleccionado;
  EdicionDePedido(super.initialState);

  seleccionarItemDePedido(ItemDePedido itemDePedidoSeleccionado) {
    _itemDePedidoSeleccionado = itemDePedidoSeleccionado;
  }

  comenzandoACrearItemDePedido() {
    emit(EstadoEDPConPedidos(
        NombreDeEstadoDeEdicionDePedido.creandoItemdePedido,
        itemsDePedido: _itemsDePedido,
        itemDePedidoSeleccionado: _itemDePedidoSeleccionado));
  }

  agregarItemDePedido(ItemDePedido nuevoItemDePedido) {
    _itemsDePedido.add(nuevoItemDePedido);
    emit(EstadoEDPConPedidos(NombreDeEstadoDeEdicionDePedido.inicial,
        itemsDePedido: _itemsDePedido,
        itemDePedidoSeleccionado: nuevoItemDePedido));
  }

  actualizarItemDePedido(ItemDePedido itemDePedidoActualizado) {
    _itemDePedidoSeleccionado!.cantidad = itemDePedidoActualizado.cantidad;
    _itemDePedidoSeleccionado!.comida = itemDePedidoActualizado.comida;

    emit(EstadoEDPConPedidos(NombreDeEstadoDeEdicionDePedido.inicial,
        itemDePedidoSeleccionado: _itemDePedidoSeleccionado,
        itemsDePedido: _itemsDePedido));
  }

  comenzarEditarItemDePedidoSeleccionado() {
    if (_itemDePedidoSeleccionado == null) {
      emit(const EstadoEDPFalla(
          mensajeDeError: 'Es necesario que selecciones el pedido a editar'));
      emit(EstadoEDPConPedidos(NombreDeEstadoDeEdicionDePedido.inicial,
          itemsDePedido: _itemsDePedido,
          itemDePedidoSeleccionado: _itemDePedidoSeleccionado));
    } else {
      emit(EstadoEDPConPedidos(
          NombreDeEstadoDeEdicionDePedido.editandoItemDePedido,
          itemDePedidoSeleccionado: _itemDePedidoSeleccionado,
          itemsDePedido: _itemsDePedido));
    }
  }
}
