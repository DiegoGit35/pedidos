import 'package:ej_hexa/dominio/entidades.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

enum NombreDeEstadoDeEdicionDePedido {
  mostrandoPedido,
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

class EEPMostrandoFalla extends EstadoDeEdicionDePedido {
  final String mensajeDeError;
  const EEPMostrandoFalla({required this.mensajeDeError})
      : super(NombreDeEstadoDeEdicionDePedido.falla);

  @override
  List<Object?> get props => [nombre, mensajeDeError];
}

class EEPCreandoOEditandoPedido extends EstadoDeEdicionDePedido {
  final List<ItemDePedido> itemsDePedido;
  final ItemDePedido? itemDePedidoSeleccionado;

  const EEPCreandoOEditandoPedido(
      {required NombreDeEstadoDeEdicionDePedido estado,
      required this.itemsDePedido,
      this.itemDePedidoSeleccionado})
      : super(estado);
  @override
  List<Object?> get props => [nombre, itemsDePedido, itemDePedidoSeleccionado];
}

class BlocEdicionDePedido extends Cubit<EstadoDeEdicionDePedido> {
  Pedido pedido;
  ItemDePedido? itemDePedidoSeleccionado;

  BlocEdicionDePedido({required this.pedido})
      : super(EEPCreandoOEditandoPedido(
            estado: NombreDeEstadoDeEdicionDePedido.mostrandoPedido,
            itemsDePedido: pedido.items));

  seleccionarItemDePedido(ItemDePedido nuevoItemDePedidoSeleccionado) {
    itemDePedidoSeleccionado = nuevoItemDePedidoSeleccionado;

    EEPCreandoOEditandoPedido(
        itemDePedidoSeleccionado: itemDePedidoSeleccionado,
        estado: NombreDeEstadoDeEdicionDePedido.mostrandoPedido,
        itemsDePedido: pedido.items);
  }

  comenzandoACrearItemDePedido() {
    emit(EEPCreandoOEditandoPedido(
        estado: NombreDeEstadoDeEdicionDePedido.creandoItemdePedido,
        itemsDePedido: pedido.items,
        itemDePedidoSeleccionado: itemDePedidoSeleccionado));
  }

  agregarItemDePedido(ItemDePedido nuevoItemDePedido) {
    pedido.items.add(nuevoItemDePedido);
    emit(EEPCreandoOEditandoPedido(
        estado: NombreDeEstadoDeEdicionDePedido.mostrandoPedido,
        itemsDePedido: pedido.items,
        itemDePedidoSeleccionado: nuevoItemDePedido));
  }

  actualizarItemDePedido(ItemDePedido itemDePedidoActualizado) {
    itemDePedidoSeleccionado!.cantidad = itemDePedidoActualizado.cantidad;
    itemDePedidoSeleccionado!.comida = itemDePedidoActualizado.comida;

    emit(EEPCreandoOEditandoPedido(
        estado: NombreDeEstadoDeEdicionDePedido.mostrandoPedido,
        itemDePedidoSeleccionado: itemDePedidoSeleccionado,
        itemsDePedido: pedido.items));
  }

  comenzarEditarItemDePedidoSeleccionado() {
    if (itemDePedidoSeleccionado == null) {
      emit(const EEPMostrandoFalla(
          mensajeDeError: 'Es necesario que selecciones el pedido a editar'));
      emit(EEPCreandoOEditandoPedido(
          estado: NombreDeEstadoDeEdicionDePedido.mostrandoPedido,
          itemsDePedido: pedido.items,
          itemDePedidoSeleccionado: itemDePedidoSeleccionado));
    } else {
      emit(EEPCreandoOEditandoPedido(
          estado: NombreDeEstadoDeEdicionDePedido.editandoItemDePedido,
          itemDePedidoSeleccionado: itemDePedidoSeleccionado,
          itemsDePedido: pedido.items));
    }
  }
}
