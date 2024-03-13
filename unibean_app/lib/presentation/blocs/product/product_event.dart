part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();
}

final class LoadProducts extends ProductEvent {
  final int page;
  final int limit;

  LoadProducts({this.page = 1, this.limit = 10});

  @override
  List<Object?> get props => [page, limit];
}
