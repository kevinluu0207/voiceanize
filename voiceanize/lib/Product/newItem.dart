import 'package:flutter/material.dart';

import 'item.dart';

class NewItem {
  Item item;
  String name = '';
  String category = '';
  String aisle = '';
  String quantity = '';
  String price = '';
  String url = '';
  String notes = '';
  String uid = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController aisleController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  void editItemFormat(item) {
    name = item.name;
    category = item.category;
    aisle = item.aisle;
    quantity = item.quantity.toString();
    price = item.price.toString();
    url = item.url;
    notes = item.notes;
    uid = item.uid;
  }

  void formatAdd() {
    name = name.trim();
    if(name.length >= 1) {
      name = name[0].toUpperCase() + name.substring(1); 
    }
    else {
      name = name[0].toUpperCase(); 
    }
    category = category.trim();
    if(category.length >= 1) {
      category = category[0].toUpperCase() + category.substring(1); 
    }
    else if(category.length == 1) {
      category = category[0].toUpperCase(); 
    }
    aisle = aisle.trim();
    if(aisle.length >= 1) {
      aisle = aisle[0].toUpperCase() + aisle.substring(1); 
    }
    else if(aisle.length == 1) {
      aisle = aisle[0].toUpperCase(); 
    }
    quantity.trim() == '' ? quantity = '0' : quantity =quantity.trim();
    price.trim() == '' ? price = '0' : price = price.trim();
    url = url.trim();
    notes = notes.trim();
  }

  void formatEdit() {
    name.trim() == '' ? name = item.name : name = name.trim();
    if(name.length >= 1) {
      name = name[0].toUpperCase() + name.substring(1); 
    }
    else {
      name = name[0].toUpperCase(); 
    }
    category.trim() == '' ? category = item.category : category = category.trim();
    if(category.length >= 1) {
      category = category[0].toUpperCase() + category.substring(1); 
    }
    
    else if(category.length == 1) {
      category = category[0].toUpperCase(); 
    }
    aisle.trim() == '' ? aisle = item.aisle : aisle = aisle.trim();
    if(aisle.length >= 1) {
      aisle = aisle[0].toUpperCase() + aisle.substring(1); 
    }
    else if(aisle.length == 1) {
      aisle = aisle[0].toUpperCase(); 
    }
    quantity.trim() == null ? quantity = item.quantity.toString(): quantity = quantity.trim();
    price.trim() == null ? price = item.price.toString() : price = price.trim();
    url.trim() == null ? url = item.url : url = url.trim();
    notes.trim() == null ? notes = item.notes : notes = notes.trim();
  }
}