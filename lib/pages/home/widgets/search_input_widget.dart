import 'package:flutter/material.dart';
import 'package:inventory/providers/index.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchInput = context
        .select<HomeProvider, String>((p) => p.searchInputCtrl.text.trim());
    final homeProvider = context.read<HomeProvider>();
    return SizedBox(
      height: 5.h,
      child: TextField(
        controller: homeProvider.searchInputCtrl,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Search',
          suffixIcon: searchInput.isNotEmpty
              ? IconButton(
                  onPressed: () => homeProvider.clearSearchInput(),
                  icon: const Icon(Icons.clear),
                )
              : null,
        ),
      ),
    );
  }
}
