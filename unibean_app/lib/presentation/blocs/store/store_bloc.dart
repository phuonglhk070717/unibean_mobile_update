import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../data/datasource/authen_local_datasource.dart';
import '../../../data/models.dart';
import '../../../domain/repositories.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreRepository storeRepository;
  StoreBloc({required this.storeRepository}) : super(StoreInitial()) {
    on<LoadStoreCampaignVouchers>(_onLoadStoreCampaignVouchers);
    on<LoadStoreTransactions>(_onLoadStoreTransactions);
    on<LoadMoreTransactionStore>(_onLoadMoreTransactions);
    on<ScanVoucherCode>(_onScanVoucherCode);
    on<CreateBonus>(_onCreateBonus);
  }
  var isLoadingMore = false;
  int pageTransaction = 1;

  Future<void> _onLoadStoreTransactions(
      LoadStoreTransactions event, Emitter<StoreState> emit) async {
    emit(StoreTransactionLoading());
    try {
      var apiResponse = await storeRepository.fetchTransactionsStoreId(
          event.page, event.limit, event.typeIds,
          id: event.id);
      bool hasReachedMax = false;
      if (event.typeIds == 0) {
        if (apiResponse!.totalCount <= apiResponse.pageSize) {
          hasReachedMax = true;
        }
        emit(StoreTransactionsLoaded(
          apiResponse.result,
          null,
          null,
          hasReachedMax: hasReachedMax,
        ));
      } else if (event.typeIds == 1) {
        if (apiResponse!.totalCount <= apiResponse.pageSize) {
          hasReachedMax = true;
        }
        emit(StoreTransactionsLoaded(null, apiResponse.result, null,
            hasReachedMax: hasReachedMax));
      } else {
        if (apiResponse!.totalCount <= apiResponse.pageSize) {
          hasReachedMax = true;
        }
        emit(StoreTransactionsLoaded(null, null, apiResponse.result,
            hasReachedMax: hasReachedMax));
      }
    } catch (e) {
      emit(StoreFailed(error: e.toString()));
    }
  }

  Future<void> _onLoadMoreTransactions(
      LoadMoreTransactionStore event, Emitter<StoreState> emit) async {
    try {
      final storeId = await AuthenLocalDataSource.getStoreId();
      if (event.scrollController.position.pixels ==
          event.scrollController.position.maxScrollExtent) {
        isLoadingMore = true;
        pageTransaction++;
        var apiResponse = await storeRepository.fetchTransactionsStoreId(
            pageTransaction, event.limit, event.typeIds,
            id: storeId!);
        if (event.typeIds == 0) {
          if (apiResponse!.result.length == 0) {
            emit(StoreTransactionsLoaded(
                List.from((this.state as StoreTransactionsLoaded).transactions!)
                  ..addAll(apiResponse.result),
                null,
                null,
                hasReachedMax: true));
            pageTransaction = 1;
          } else {
            emit(StoreTransactionsLoaded(
                List.from((this.state as StoreTransactionsLoaded).transactions!)
                  ..addAll(apiResponse.result),
                null,
                null));
          }
        } else if (event.typeIds == 1) {
          if (apiResponse!.result.length == 0) {
            emit(StoreTransactionsLoaded(
                null,
                List.from((this.state as StoreTransactionsLoaded)
                    .activityTransactions!)
                  ..addAll(apiResponse.result),
                null,
                hasReachedMax: true));
            pageTransaction = 1;
          } else {
            emit(StoreTransactionsLoaded(
                null,
                List.from((this.state as StoreTransactionsLoaded)
                    .activityTransactions!)
                  ..addAll(apiResponse.result),
                null));
          }
        } else if (event.typeIds == 2) {
          if (apiResponse!.result.length == 0) {
            emit(StoreTransactionsLoaded(
                null,
                null,
                List.from(
                    (this.state as StoreTransactionsLoaded).bonusTransactions!)
                  ..addAll(apiResponse.result),
                hasReachedMax: true));
            pageTransaction = 1;
          } else {
            emit(StoreTransactionsLoaded(
              null,
              null,
              List.from(
                  (this.state as StoreTransactionsLoaded).bonusTransactions!)
                ..addAll(apiResponse.result),
            ));
          }
        }
      }
    } catch (e) {
      emit(StoreFailed(error: e.toString()));
    }
  }

  Future<void> _onLoadStoreCampaignVouchers(
      LoadStoreCampaignVouchers event, Emitter<StoreState> emit) async {
    emit(StoreCampaignVoucherLoading());
    try {
      var apiResponse = await storeRepository.fetchCampaignVoucherStoreId(
          event.page, event.limit);
      // bool hasReachedMax = false;

      emit(StoreCampaignVoucherLoaded(
          campaignStoreCart:
              CampaignStoreCartModel(campaignVouchers: apiResponse!.result)));
    } catch (e) {
      emit(StoreFailed(error: e.toString()));
    }
  }

  Future<void> _onScanVoucherCode(
      ScanVoucherCode event, Emitter<StoreState> emit) async {
    emit(ScanVoucherLoading());
    try {
      var apiResponse = await storeRepository.postScanVoucherCode(
          storeId: event.storeId,
          voucherCode: event.voucherCode,
          description: event.description,
          state: true);
      var check = apiResponse.keys.first;
      if (check) {
        String result = apiResponse.values.first;
        emit(ScanVoucherSuccess(result: result));
      } else {
        String error = apiResponse.values.first;
        emit(ScanVoucherFailed(error: error));
      }
    } catch (e) {
      emit(StoreFailed(error: e.toString()));
    }
  }

  Future<void> _onCreateBonus(
      CreateBonus event, Emitter<StoreState> emit) async {
    emit(CreateBonusLoading());
    try {
      var apiResponse = await storeRepository.createBonus(
          storeId: event.storeId,
          studentId: event.studentId,
          amount: event.amount,
          description: event.description,
          state: event.state);

      emit(CreateBonusSucess(transactModel: apiResponse!));
    } catch (e) {
      emit(CreateBonusFailed(error: e.toString()));
    }
  }
}
