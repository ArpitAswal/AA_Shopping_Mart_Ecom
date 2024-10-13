import 'dart:convert';
import 'package:aa_shopping_mart/DataModel/products_model.dart';
import 'package:aa_shopping_mart/Widgets/rectTween.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddInfo extends StatelessWidget {
  const  AddInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: GestureDetector(
        onTap: () {

        },
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Colors.grey[200],
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: const Icon(
              Icons.add_rounded,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}

const String _heroAddTodo = 'add-todo-hero';
final titleKey = GlobalKey<FormState>();
final priceKey = GlobalKey<FormState>();
final descriptionKey = GlobalKey<FormState>();
final imageKey = GlobalKey<FormState>();
final categoryKey = GlobalKey<FormState>();
final rateKey = GlobalKey<FormState>();
final countKey = GlobalKey<FormState>();
final List<ProductModel> list=[];

class PopupCard extends StatelessWidget {
  PopupCard({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController countController = TextEditingController();

  void dispose(){
   titleController.dispose();
   priceController.dispose();
   descriptionController.dispose();
   imageController.dispose();
   categoryController.dispose();
   rateController.dispose();
   countController.dispose();
  }

   bool prodError=false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Colors.teal[50],
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                  child: Form(
                    key: titleKey,
                    child: TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: '*Name',
                          labelStyle:
                              const TextStyle(color: Colors.red, fontSize: 15),
                          hintText: "'Product Name'",
                          hintStyle:
                              const TextStyle(color: Colors.blue, fontSize: 15),
                          suffixIcon: IconButton(
                              onPressed: () {
                                titleController.text = '';
                              },
                              icon: const Icon(Icons.clear)),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15)),
                      cursorColor: Colors.blue,
                      //autofocus: true,
                      onFieldSubmitted: (value) {
                        titleKey.currentState!.save();
                        titleController.text = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This required field should not be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                  child: Form(
                    key: priceKey,
                    child: TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: '*Price',
                          labelStyle:
                              const TextStyle(color: Colors.red, fontSize: 15),
                          hintText: "'Product Price'",
                          hintStyle:
                              const TextStyle(color: Colors.blue, fontSize: 15),
                          suffixIcon: IconButton(
                              onPressed: () {
                                priceController.text = '';
                              },
                              icon: const Icon(Icons.clear)),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15)),
                      cursorColor: Colors.blue,
                      //autofocus: true,
                      onFieldSubmitted: (value) {
                        priceKey.currentState!.save();
                        priceController.text = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This required field should not be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                  child: Form(
                    key: descriptionKey,
                    child: TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: '*Description',
                          labelStyle:
                              const TextStyle(color: Colors.red, fontSize: 15),
                          hintText: "'Product Description'",
                          hintStyle:
                              const TextStyle(color: Colors.blue, fontSize: 15),
                          suffixIcon: IconButton(
                              onPressed: () {
                                descriptionController.text = '';
                              },
                              icon: const Icon(Icons.clear)),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15)),
                      cursorColor: Colors.blue,
                      //autofocus: true,
                      onFieldSubmitted: (value) {
                        descriptionKey.currentState!.save();
                        descriptionController.text = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This required field should not be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                  child: Form(
                    key: imageKey,
                    child: TextFormField(
                      controller: imageController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: '*Image',
                          labelStyle:
                              const TextStyle(color: Colors.red, fontSize: 15),
                          hintText: "'Product Image Url'",
                          hintStyle:
                              const TextStyle(color: Colors.blue, fontSize: 15),
                          suffixIcon: IconButton(
                              onPressed: () {
                                imageController.text = '';
                              },
                              icon: const Icon(Icons.clear)),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15)),
                      cursorColor: Colors.blue,
                      //autofocus: true,
                      onFieldSubmitted: (value) {
                        imageKey.currentState!.save();
                        imageController.text = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This required field should not be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                  child: Form(
                    key: categoryKey,
                    child: TextFormField(
                      controller: categoryController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: '*Category',
                          labelStyle:
                              const TextStyle(color: Colors.red, fontSize: 15),
                          hintText: "'Product Category Type'",
                          hintStyle:
                              const TextStyle(color: Colors.blue, fontSize: 15),
                          suffixIcon: IconButton(
                              onPressed: () {
                                categoryController.text = '';
                              },
                              icon: const Icon(Icons.clear)),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15)),
                      cursorColor: Colors.blue,
                      //autofocus: true,
                      onFieldSubmitted: (value) {
                        categoryKey.currentState!.save();
                        categoryController.text = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This required field should not be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel')),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (titleKey.currentState!.validate() &&
                              priceKey.currentState!.validate() &&
                              descriptionKey.currentState!.validate() &&
                              imageKey.currentState!.validate() &&
                              categoryKey.currentState!.validate()) {
                            addProduct();
                            if(prodError==false){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Product add Successfully')),
                              );
                            }
                            else if(prodError==true){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('This product is not added')),
                              );
                              throw Exception('Failed to create product.');
                            }
                            Navigator.of(context).pop();
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('There is some error')),
                            );
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> addProduct() async{
    list.clear();
    final body={
      'title': titleController.text.toString(),
      'price': double.parse(priceController.text),
      'description': descriptionController.text.toString(),
      'image': imageController.text.toString(),
      'category': categoryController.text.toString(),
      'rating':{
        'rate':1.5,
        'count':126
      }
    };
    const url='https://fakestoreapi.com/products';
    final uri= Uri.parse(url);
    final response= await http.post(uri,body: jsonEncode(body),
        headers: {'Content-Type': 'application/json; charset=UTF-8'});

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      list.add(ProductModel.fromJson(data));
     // productsList.addAll(list);
    }
    else{
      prodError=true;
    }
    for(int i=0;i<list.length;i++){
      debugPrint('productId=${list[i].id.toString()}');
    }
  }
}
