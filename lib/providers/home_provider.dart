import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inventory/models/inventory.dart';
import 'package:inventory/providers/index.dart';
import 'package:inventory/service/index.dart';

class HomeProvider extends ChangeNotifier {
  final AuthProvider authProvider;
  final DataService dataService;

  int get selectedTabIndex => _selectedTabIndex;
  var _selectedTabIndex = 0;

  final searchInputCtrl = TextEditingController(text: '');

  /// owned inventory list's
  StreamSubscription? selfInventorySub;

  List<Inventory> get inventoryList => _inventoryList;
  List<Inventory> _inventoryList = [];

  List<Inventory> get inventoryFilteredList => _inventoryFilteredList;
  var _inventoryFilteredList = <Inventory>[];

  /// ready to buy inventory list's
  StreamSubscription? buyInventorySub;

  List<Inventory> get buyList => _buyList;
  List<Inventory> _buyList = [];

  List<Inventory> get buyFilteredList => _buyFilteredList;
  var _buyFilteredList = <Inventory>[];

  HomeProvider({
    required this.authProvider,
    required this.dataService,
  }) {
    searchInputCtrl.addListener(_filterInventoryData);
    searchInputCtrl.addListener(_filterBuyData);
  }

  void refreshData() {
    selfInventorySub?.cancel();
    selfInventorySub = dataService
        .getInventory(selfUserId: authProvider.user?.uid ?? '')
        .listen((list) {
      _inventoryList = list;
      _filterInventoryData();
    });

    buyInventorySub?.cancel();
    buyInventorySub = dataService
        .getInventory(selfUserId: authProvider.user?.uid ?? '', isForBuy: true)
        .listen((list) {
      _buyList = list;
      _filterBuyData();
    });
  }

  void _filterInventoryData() {
    if (searchInputCtrl.text.length < 3) {
      _inventoryFilteredList = inventoryList;
      notifyListeners();
      return;
    }

    _inventoryFilteredList = inventoryList
        .where((item) =>
            item.name.contains(searchInputCtrl.text) ||
            item.desc.contains(searchInputCtrl.text))
        .toList();
    notifyListeners();
  }

  void _filterBuyData() {
    if (searchInputCtrl.text.length < 3) {
      _buyFilteredList = buyList;
      notifyListeners();
      return;
    }

    _buyFilteredList = buyList
        .where((item) =>
            item.name.contains(searchInputCtrl.text) ||
            item.desc.contains(searchInputCtrl.text))
        .toList();
    notifyListeners();
  }

  void updateTabIndex(int tabIndex) {
    _selectedTabIndex = tabIndex;
    notifyListeners();
  }

  void clearSearchInput() {
    searchInputCtrl.text = '';
    notifyListeners();
  }

  void deleteInventory(Inventory inventory) {
    dataService.deleteInventory(inventory);
  }

  void buyInventory(Inventory inventory) {
    dataService.buyInventory(
      inventory: inventory,
      selfUserId: authProvider.user?.uid ?? '',
    );
  }

  @override
  void dispose() {
    selfInventorySub?.cancel();
    searchInputCtrl.dispose();
    searchInputCtrl.removeListener(_filterInventoryData);
    searchInputCtrl.removeListener(_filterBuyData);
    super.dispose();
  }
}
