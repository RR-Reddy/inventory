
import 'package:flutter/material.dart';
import 'package:inventory/extensions/index.dart';
import 'package:inventory/pages/add_edit_inventory/add_edit_inventory_provider.dart';
import 'package:inventory/pages/add_edit_inventory/widgets/index.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DescInputWidget extends StatelessWidget {
  const DescInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const LeadingInputIconWidget(icon: Icons.note_alt_outlined),
        SizedBox(width: 2.w),
        const Expanded(child: _InputWidget()),
      ],
    );
  }
}

class _InputWidget extends StatelessWidget {
  const _InputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AddEditInventoryProvider>();
    return TextField(
      scrollPadding: context.scrollPadding,
      controller: provider.descCtrl,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Description',
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      maxLength: 100,
      maxLines: 2,
    );
  }
}