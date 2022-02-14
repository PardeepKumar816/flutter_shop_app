import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _form = GlobalKey<FormState>();
  final _priceFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _imageUrlFocusNode = FocusNode();
  final TextEditingController _imageUrlController = TextEditingController();
  var _editedProduct =
      Product(id: '', price: 0, description: '', imageUrl: '', title: '');

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;
    Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    _form.currentState!.save();
  }

  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Products'),
          actions: [
            IconButton(
              onPressed: () {
                _saveForm();
                Navigator.pop(context);
              },
              icon: Icon(Icons.save),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == '') return 'Please Provide a value';
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: value!,
                        price: _editedProduct.price,
                        description: _editedProduct.description,
                        imageUrl: _editedProduct.imageUrl);
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocusNode,
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: double.parse(value.toString()),
                        imageUrl: _editedProduct.imageUrl);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a Price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please Enter a Valid number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'The number be greater than 0';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  focusNode: _descriptionFocusNode,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: value!,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter description';
                    }
                    if (value.length < 10) {
                      return 'The description must be more than 10 lines';
                    }
                  },
                  onFieldSubmitted: (_) {
                    _descriptionFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? const Center(child: Text('Enter a Url'))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: FittedBox(
                                child: Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image Url'),
                        focusNode: _imageUrlFocusNode,
                        controller: _imageUrlController,
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: value!);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter image Url';
                          }
                          if (!value.startsWith('http') ||
                              !value.startsWith('https')) {
                            return 'Please enter a valid Url';
                          }
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
        //Column(
        //   children: [
        //     TextFormField(
        //       decoration: InputDecoration(labelText: 'Title'),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        //       child: TextField(
        //         decoration: InputDecoration(labelText: 'Price'),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(20.0),
        //       child: TextField(
        //         decoration: InputDecoration(labelText: 'Description'),
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}
