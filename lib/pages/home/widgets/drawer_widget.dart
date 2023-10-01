import 'package:flutter/material.dart';
import 'package:inventory/providers/index.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().user;
    final photoURL = user?.photoURL ?? 'https://via.placeholder.com/150';

    return NavigationDrawer(
      children: <Widget>[
        CircleAvatar(
          radius: 16.w,
          backgroundColor: Colors.transparent,
          child: ClipOval(child: Image.network(photoURL)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            user?.displayName ?? '',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: InkWell(
            onTap: () => context.read<AuthProvider>().signOut(),
            child: const Row(
              children: [
                Icon(Icons.logout),
                Text('Logout'),
              ],
            ),
          ),
        )
      ],
    );
  }
}
