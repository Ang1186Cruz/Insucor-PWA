import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/customers.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:email_validator/email_validator.dart';

class EditcustomerScreen extends StatefulWidget {
  static const routeName = './edit-customers';

  @override
  _EditcustomerScreenState createState() => _EditcustomerScreenState();
}

class _EditcustomerScreenState extends State<EditcustomerScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();

  CustomerOne _editedcustomer = CustomerOne(
      id: '',
      nombre: '',
      empresa:
          ''); //(id: null, title: '', price: 0, description: '', imageUrl: '');
  var _initValues = {
    'nombre': '',
    'empresa': '',
    'telefono': '',
    'direccion': '',
    'code': '',
    'idLista': '',
    'mail': ''
  };

  var _isInit = true;
  var _isLoading = true;

  @override
  void initState() {
    //_imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final customerId = ModalRoute.of(context).settings.arguments as String;
      if (customerId != null) {
        Provider.of<Customers>(context).refreshCustomer(customerId).then((_) {
          setState(() {
            _editedcustomer = Provider.of<Customers>(context, listen: false)
                .findById(customerId);
            _initValues = {
              'nombre': _editedcustomer.nombre,
              'empresa': _editedcustomer.empresa,
              'telefono': _editedcustomer.telefono,
              'direccion': _editedcustomer.direccion,
              'code': _editedcustomer.code,
              'idLista': _editedcustomer.idLista,
              'mail': _editedcustomer.mail,
            };
          });
          _isLoading = false;
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    //_imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    if (_editedcustomer.id != null) {
      await Provider.of<Customers>(context, listen: false)
          .updateCustomer(_editedcustomer.id, _editedcustomer);
      setState(() {
        _isLoading = false;
      });
      Alert(
        context: context,
        type: AlertType.success,
        title: "EXITOSO!!",
        desc: "El cliente fue editado con exito!!",
        buttons: [
          DialogButton(
            child: Text(
              "Aceptar",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            width: 100,
          )
        ],
      ).show();
    } else {
      try {
        await Provider.of<Customers>(context, listen: false)
            .addCustomer(_editedcustomer);
        Navigator.of(context).pop();
      } catch (exception) {
        await showDialog<Null>(
            context: context,
            builder: (innerContext) => AlertDialog(
                  title: Text('A OCURRIDO UN ERROR'),
                  content: Text(exception.toString()),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('GUARDADO EXITOSAMENTE !!!'),
                      onPressed: () {
                        Navigator.of(innerContext).pop();
                      },
                    )
                  ],
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Cliente'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['nombre'],
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Es requerido el campo';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedcustomer = CustomerOne(
                          id: _editedcustomer.id,
                          nombre: value,
                          empresa: _editedcustomer.empresa,
                          telefono: _editedcustomer.telefono,
                          direccion: _editedcustomer.direccion,
                          code: _editedcustomer.code,
                          idLista: _editedcustomer.idLista,
                          mail: _editedcustomer.mail,
                        );
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                    ),

                    TextFormField(
                      initialValue: _initValues['empresa'],
                      decoration: InputDecoration(
                        labelText: 'Empresa',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Es requerido el campo';
                        }
                        if (value.length < 5) {
                          return '¡Debe tener al menos 5 caracteres o más!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedcustomer = CustomerOne(
                          id: _editedcustomer.id,
                          nombre: _editedcustomer.nombre,
                          empresa: value,
                          telefono: _editedcustomer.telefono,
                          direccion: _editedcustomer.direccion,
                          code: _editedcustomer.code,
                          idLista: _editedcustomer.idLista,
                          mail: _editedcustomer.mail,
                        );
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                    ),

                    TextFormField(
                      initialValue: _initValues['telefono'],
                      decoration: InputDecoration(
                        labelText: 'Telefono-WhatsApp',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Es requerido el campo';
                        }
                        if ((value.length < 9) || (value.length > 12)) {
                          return 'El telefono debe estar entre 9 a 12';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Por favor solo ingrese numeros';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedcustomer = CustomerOne(
                          id: _editedcustomer.id,
                          nombre: _editedcustomer.nombre,
                          empresa: _editedcustomer.empresa,
                          telefono: value,
                          direccion: _editedcustomer.direccion,
                          code: _editedcustomer.code,
                          idLista: _editedcustomer.idLista,
                          mail: _editedcustomer.mail,
                        );
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                    ),

                    TextFormField(
                      initialValue: _initValues['direccion'],
                      decoration: InputDecoration(
                        labelText: 'Direccion',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Es requerido el campo';
                        }
                        if (value.length < 5) {
                          return '¡Debe tener al menos 5 caracteres o más!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedcustomer = CustomerOne(
                          id: _editedcustomer.id,
                          nombre: _editedcustomer.nombre,
                          empresa: _editedcustomer.empresa,
                          telefono: _editedcustomer.telefono,
                          direccion: value,
                          code: _editedcustomer.code,
                          idLista: _editedcustomer.idLista,
                          mail: _editedcustomer.mail,
                        );
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                    ),

                    TextFormField(
                      readOnly: true,
                      initialValue: _initValues['code'],
                      decoration: InputDecoration(
                        labelText: 'Codigo',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Es requerido el campo';
                        }
                        if (value.length < 3) {
                          return '¡Debe tener al menos 3 caracteres o más!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedcustomer = CustomerOne(
                          id: _editedcustomer.id,
                          nombre: _editedcustomer.nombre,
                          empresa: _editedcustomer.empresa,
                          telefono: _editedcustomer.telefono,
                          direccion: _editedcustomer.direccion,
                          code: value,
                          idLista: _editedcustomer.idLista,
                          mail: _editedcustomer.mail,
                        );
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['mail'],
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Es requerido el campo';
                        }
                        if (value.length < 5) {
                          return '¡Debe tener al menos 5 caracteres o más!';
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'No tiene el formato del mail';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedcustomer = CustomerOne(
                          id: _editedcustomer.id,
                          nombre: _editedcustomer.nombre,
                          empresa: _editedcustomer.empresa,
                          telefono: _editedcustomer.telefono,
                          direccion: _editedcustomer.direccion,
                          code: _editedcustomer.code,
                          idLista: _editedcustomer.idLista,
                          mail: value,
                        );
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                    ),
                    // DropdownButtonFormField(
                    //       value: _editedcustomer.idLista,
                    //       isExpanded: true,
                    //       decoration: InputDecoration(labelText: "Lista Precio"),
                    //       items: <DropdownMenuItem<String>>[
                    //         DropdownMenuItem(
                    //           child: Text("Lista 1"),
                    //           value: "1",
                    //         ),
                    //         DropdownMenuItem(
                    //           child: Text("Lista 2"),
                    //           value: "2",
                    //         ),
                    //         DropdownMenuItem(
                    //           child: Text("Lista 3"),
                    //           value: "3",
                    //         ),
                    //         DropdownMenuItem(
                    //           child: Text("Lista 4"),
                    //           value: "4",
                    //         ),
                    //         DropdownMenuItem(
                    //           child: Text("Lista 5"),
                    //           value: "5",
                    //         ),
                    //         DropdownMenuItem(
                    //           child: Text("Lista 6"),
                    //           value: "6",
                    //         ),
                    //         DropdownMenuItem(
                    //           child: Text("Lista 7"),
                    //           value: "7",
                    //         ),
                    //         DropdownMenuItem(
                    //           child: Text("Lista 9"),
                    //           value: "9",
                    //         )
                    //       ],
                    //       onChanged: (String value) {
                    //         setState(() {
                    //           _editedcustomer.idLista = value;
                    //         });
                    //       },
                    //        onSaved: (value) {
                    //           _editedcustomer = CustomerOne(
                    //             id: _editedcustomer.id,
                    //             nombre: _editedcustomer.nombre,
                    //             empresa: _editedcustomer.empresa,
                    //             telefono: _editedcustomer.telefono,
                    //             direccion: _editedcustomer.direccion,
                    //             code: _editedcustomer.code,
                    //             idLista: value,
                    //           );
                    //         },
                    //     ),

                    // TextFormField(
                    //   initialValue: _initValues['idLista'],
                    //   decoration: InputDecoration(
                    //     labelText: 'Lista Precio',
                    //   ),
                    //   textInputAction: TextInputAction.next,
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return 'Es requerido el campo';
                    //     }
                    //     return null;
                    //   },
                    //   onSaved: (value) {
                    //     _editedcustomer = CustomerOne(
                    //       id: _editedcustomer.id,
                    //       nombre: _editedcustomer.nombre,
                    //       empresa: _editedcustomer.empresa,
                    //       telefono: _editedcustomer.telefono,
                    //       direccion: _editedcustomer.direccion,
                    //       code: _editedcustomer.code,
                    //       idLista: value,
                    //     );
                    //   },
                    //   onFieldSubmitted: (_) {
                    //     FocusScope.of(context).requestFocus(_priceFocusNode);
                    //   },
                    // ),

                    // TextFormField(
                    //   initialValue: _initValues['price'],
                    //   decoration: InputDecoration(
                    //     labelText: 'Price',
                    //   ),
                    //   textInputAction: TextInputAction.next,
                    //   keyboardType: TextInputType.number,
                    //   focusNode: _priceFocusNode,
                    //   onSaved: (value) {
                    //     _editedcustomer = customer(
                    //       id: _editedcustomer.id,
                    //       title: _editedcustomer.title,
                    //       description: _editedcustomer.description,
                    //       price: double.parse(value),
                    //       imageUrl: _editedcustomer.imageUrl,
                    //       isAgregate: _editedcustomer.isAgregate,
                    //     );
                    //   },
                    //   onFieldSubmitted: (_) {
                    //     FocusScope.of(context)
                    //         .requestFocus(_descriptionFocusNode);
                    //   },
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return 'Please provide a price!';
                    //     }
                    //     if (double.tryParse(value) == null) {
                    //       return 'Please enter a valid number!';
                    //     }
                    //     if (double.parse(value) <= 0) {
                    //       return 'Please enter a number greater than 0';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // TextFormField(
                    //   initialValue: _initValues['description'],
                    //   decoration: InputDecoration(
                    //     labelText: 'Description',
                    //   ),
                    //   maxLines: 3,
                    //   keyboardType: TextInputType.multiline,
                    //   focusNode: _descriptionFocusNode,
                    //   onSaved: (value) {
                    //     _editedcustomer = customer(
                    //       id: _editedcustomer.id,
                    //       title: _editedcustomer.title,
                    //       description: value,
                    //       price: _editedcustomer.price,
                    //       imageUrl: _editedcustomer.imageUrl,
                    //       isAgregate: _editedcustomer.isAgregate,
                    //     );
                    //   },
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return 'Please provide a description!';
                    //     }
                    //     if (value.length < 10) {
                    //       return 'Should be at least 10 character or more!';
                    //     }
                    //     return null;
                    //   },
                    // ),

                    /*   Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child:
                                      Image.network(_imageUrlController.text),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Image URL',
                            ),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onSaved: (value) {
                              _editedcustomer = customer(
                                id: _editedcustomer.id,
                                title: _editedcustomer.title,
                                description: _editedcustomer.description,
                                price: _editedcustomer.price,
                                imageUrl: value,
                                isAgregate: _editedcustomer.isAgregate,
                              );
                            },
                            onFieldSubmitted: (value) => _saveForm(),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a valid image url!';
                              }
                              if (!value.startsWith('http') ||
                                  !value.startsWith('https')) {
                                return 'Please enter a valid url!';
                              }
                              // if(!value.endsWith('.png') || !value.endsWith('.jpg') || !value.endsWith('.jpeg')) {
                              //   return 'Please enter a valid image url!';
                              // }
                              return null;
                            },
                            onEditingComplete: () {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  */
                  ],
                ),
              ),
            ),
    );
  }
}
