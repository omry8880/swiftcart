import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftcart/providers/product.dart';

import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/edit-product-screen';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _descFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();

  //local product variables
  String? _title;
  String? _description;
  double? _price;
  String? _imgUrl;

  var _editedProduct = Product(
    id: DateTime.now().toString(),
    description: '',
    imageUrl: '',
    price: 0.0,
    title: '',
  );

  var _isLoading = false;

  Future<void> _saveForm() async {
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    if (ModalRoute.of(context)!.settings.arguments != null) {
      _editedProduct = Product(
          id: ModalRoute.of(context)!.settings.arguments as String,
          title: _title!,
          description: _description!,
          price: _price!,
          imageUrl: _imgUrl!);

      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      _editedProduct = Product(
          id: DateTime.now().toString(),
          title: _title!,
          description: _description!,
          price: _price!,
          imageUrl: _imgUrl!);
      await Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct);
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _descFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      _editedProduct = Provider.of<Products>(context, listen: false)
          .findById(ModalRoute.of(context)!.settings.arguments as String);

      _imageUrlController.text = _imageUrlController.text.isEmpty
          ? _editedProduct.imageUrl
          : _imageUrlController.text;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Product',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                      child: Column(children: [
                    TextFormField(
                        initialValue: _editedProduct.title,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          labelText: 'Title',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).requestFocus(_descFocusNode),
                        onSaved: (newValue) => _title = newValue),
                    TextFormField(
                        initialValue: _editedProduct.description,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                        maxLines: 3,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descFocusNode,
                        onFieldSubmitted: ((value) => FocusScope.of(context)
                            .requestFocus(_priceFocusNode)),
                        onSaved: (newValue) => _description = newValue),
                    TextFormField(
                        initialValue: _editedProduct.price.toString(),
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          labelText: 'Price',
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: ((value) =>
                            FocusScope.of(context).requestFocus()),
                        onSaved: (newValue) =>
                            _price = double.parse(newValue!)),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(top: 8, right: 10),
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          child: _imageUrlController.text.isEmpty
                              ? const Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                )),
                        ),
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              labelText: 'Image URL',
                            ),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            onEditingComplete: () {
                              setState(() {});
                            },
                            onFieldSubmitted: (value) => _saveForm(),
                            onSaved: (newValue) => _imgUrl = newValue,
                          ),
                        )
                      ],
                    ),
                    ElevatedButton(
                        onPressed: ((() {
                          _saveForm();
                        })),
                        child: const Text('Submit'))
                  ]))),
            ),
    );
  }
}
