import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hava_havai_hiring_challenge/service/api_service.dart';
import 'package:hava_havai_hiring_challenge/models/product_model.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final productProvider = StateNotifierProvider<ProductNotifier, AsyncValue<List<Product>>>((ref) {
  return ProductNotifier(ref.read(apiServiceProvider));
});

class ProductNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final ApiService _apiService;
  final int _pageSize = 10;
  int _currentPage = 0;
  bool _canLoadMore = true;

  ProductNotifier(this._apiService) : super(const AsyncValue.loading()) {
    loadFirstPage();
  }

  Future<void> loadFirstPage() async {
    try {
      state = const AsyncValue.loading();
      _currentPage = 0;
      _canLoadMore = true;
      
      final products = await _apiService.fetchProducts(
        limit: _pageSize,
        skip: 0,
      );
      
      _updateHasMoreFlag(products.length);
      state = AsyncValue.data(products);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> loadMore() async {
    if (!_canLoadMore || state.isLoading) return;

    try {
      final currentProducts = state.value ?? [];
      
      _currentPage++;
      final nextPageOffset = _currentPage * _pageSize;
      
      final newProducts = await _apiService.fetchProducts(
        limit: _pageSize,
        skip: nextPageOffset,
      );

      _updateHasMoreFlag(newProducts.length);
      state = AsyncValue.data([...currentProducts, ...newProducts]);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void _updateHasMoreFlag(int loadedItemsCount) {
    _canLoadMore = loadedItemsCount >= _pageSize;
  }

  Future<void> refresh() async {
    await loadFirstPage();
  }
}