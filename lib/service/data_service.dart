import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/models/inventory.dart';
import 'package:inventory/utils/log_utils.dart';

///
/// [DataService] can be used for create/edit/delete data in [FirebaseFirestore]
///
class DataService {
  late final FirebaseFirestore db;

  DataService({FirebaseFirestore? db}) {
    this.db = db ?? FirebaseFirestore.instance;
  }

  Future<bool> addInventory(Inventory inventory) async {
    try {
      await db.collection('inventory').add(inventory.toFirestore());
      return true;
    } catch (e, st) {
      LogUtils.logError(this, e, st);
      return false;
    }
  }

  Future<bool> buyInventory({
    required Inventory inventory,
    required String selfUserId,
  }) async {
    final updatedInventory = inventory.copyWith(userId: selfUserId);

    try {
      await db
          .collection('inventory')
          .doc(inventory.id)
          .set(updatedInventory.toFirestore());
      return true;
    } catch (e, st) {
      LogUtils.logError(this, e, st);
      return false;
    }
  }

  Future<bool> deleteInventory(Inventory inventory) async {
    try {
      await db.collection('inventory').doc(inventory.id).delete();
      return true;
    } catch (e, st) {
      LogUtils.logError(this, e, st);
      return false;
    }
  }

  Stream<List<Inventory>> getInventory({
    required String selfUserId,
    bool isForBuy = false,
  }) {
    return db
        .collection("inventory")
        .where("userId",
            isEqualTo: isForBuy ? null : selfUserId,
            isNotEqualTo: isForBuy ? selfUserId : null)
        .snapshots()
        .map(
      (event) {
        return event.docs.map(
          (doc) {
            final data = doc.data();

            return Inventory(
              name: data['name'],
              desc: data['desc'],
              userId: data['userId'],
              status: data['status'],
              id: doc.id,
            );
          },
        ).toList();
      },
    );
  }
}
