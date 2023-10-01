
import 'package:flutter/material.dart';
import 'package:inventory/pages/add_edit_inventory/add_edit_inventory_provider.dart';
import 'package:inventory/pages/add_edit_inventory/widgets/index.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NameInputWidget extends StatelessWidget {
  const NameInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const LeadingInputIconWidget(icon: Icons.account_circle_outlined),
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
      autofocus: true,
      controller: provider.nameCtrl,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Title',
      ),
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      maxLength: 20,
    );
  }
}