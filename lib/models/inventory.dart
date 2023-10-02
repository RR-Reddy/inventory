import 'package:cloud_firestore/cloud_firestore.dart';


///
/// Data/Model class for inventory
///
class Inventory {
  final String name;
  final String desc;
  final String userId;
  final String status;
  final String id;

  Inventory({
    required this.name,
    required this.desc,
    required this.userId,
    required this.status,
    required this.id,
  });

  Inventory copyWith({
    String? name,
    String? desc,
    String? userId,
    String? status,
    String? id,
  }) {
    return Inventory(
      name: name ?? this.name,
      desc: desc ?? this.desc,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      id: id ?? this.id,
    );
  }

  factory Inventory.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    final id = snapshot.id;
    return Inventory(
      name: data?['name'],
      status: data?['status'],
      desc: data?['desc'],
      userId: data?['userId'],
      id: id,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'status': status,
      'desc': desc,
      'userId': userId,
    };
  }

  @override
  String toString() {
    return 'Inventory{name: $name, desc: $desc, userId: $userId, status: $status, id: $id}';
  }
}
