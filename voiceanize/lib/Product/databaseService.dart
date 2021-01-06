import 'package:cloud_firestore/cloud_firestore.dart';

import 'item.dart';
import 'newItem.dart';

class DatabaseService{
  final CollectionReference inventory = Firestore.instance.collection('inventory');
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Item(
          doc.data['name'] ?? '',
          doc.data['category'] ?? '',
          doc.data['aisle'] ?? '',
          doc.data['quantity'] ?? 0,
          doc.data['price'] ?? 0.0,
          doc.data['url'] ?? '',  
          doc.data['notes'] ?? '',
          doc.documentID,
        );
    }).toList();
  }

  Future addItemData(NewItem newItem) async{
    return await inventory.add({'name' : newItem.name, 'category': newItem.category, 'aisle': newItem.aisle , 'quantity': double.parse(newItem.quantity), 'price': double.parse(newItem.price), 'url': newItem.url, 'notes': newItem.notes});
  }

  Future editItemData(NewItem newItem) async{
    return await inventory.document(newItem.uid).setData({'name' : newItem.name, 'category': newItem.category, 'aisle': newItem.aisle , 'quantity': double.parse(newItem.quantity), 'price': double.parse(newItem.price), 'url': newItem.url, 'notes': newItem.notes, 'uid': newItem.uid, });
  }

  Future deleteItemData(String uid) async{
    return await inventory.document(uid).delete();
  }

  Future<String> checkDupName(String val) async{
    final QuerySnapshot dupNameDoc = await inventory.where('name', isEqualTo: val).limit(1).getDocuments();
    if (dupNameDoc.documents.length == 1) {
      return 'Duplicate Name';
    }
    else {
      return null;
    }
  }

  Stream<List<Item>> get items {
    return inventory.snapshots().map(_itemListFromSnapshot);
  }
}

