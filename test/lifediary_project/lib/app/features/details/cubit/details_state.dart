part of 'details_cubit.dart';

@immutable
class DetailsState {
  const DetailsState(
      {required this.itemModel,
      required this.isLoading,
      required this.errorMessage,
      required this.saved,
      required this.fontWeight,});

  final ItemModel? itemModel;
  final bool isLoading;
  final String errorMessage;
  final bool saved;
  final int fontWeight;
}
