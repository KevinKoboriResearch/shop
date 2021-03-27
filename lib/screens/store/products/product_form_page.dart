import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shop_app/app/models/product_model.dart';
import 'package:shop_app/app/utils/my_flutter_app_icons.dart';
import 'package:shop_app/app/utils/constants.dart';
import 'package:shop_app/app/styles/product_styles.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shop_app/app/validators/product_validators.dart';
// import 'package:shop_app/ui/widgets/product_sizes.dart';
import 'package:shop_app/app/functions/flushbar.dart';

class ProductFormPage extends StatefulWidget {
  final reqCompanyTitle;
  final reqCategoryTitle;
  final reqProduct;
  ProductFormPage(this.reqCompanyTitle, this.reqCategoryTitle, this.reqProduct);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _descriptionFocusNode = FocusNode();
  final _coinFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _promotionFocusNode = FocusNode();
  // final _sizesFocusNode = FocusNode();

  final _subtitleFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();
  // final _typeFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _deviceIsLoading = false;
  double zz = 23542234;
  bool _isLoading = false;
  bool _enableField = true;
  Marker deviceMaker;
  Marker userMarker;
  List<Marker> deviceMarkers = [];
  final auth = FirebaseAuth.instance;

  final ImagePicker _picker = ImagePicker();
  dynamic _decodedProfileImage;
  bool _uploadingImage = false;
  String sourceImagem;
  // List allImagesSelectedFile = [];
  List<dynamic> allImagesSelectedFile = [];
  // List<Map<String, Object>> allImagesSelectedFile = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _coinFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _promotionFocusNode.dispose();
    // _sizesFocusNode.dispose();
    _subtitleFocusNode.dispose();
    _titleFocusNode.dispose();
    // _typeFocusNode.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      if (widget.reqProduct != null) {
        _formData['id'] = widget.reqProduct.id;
        _formData['coin'] = widget.reqProduct.data()['coin'];
        _formData['companyTitle'] = widget.reqProduct.data()['companyTitle'];
        _formData['categoryTitle'] = widget.reqProduct.data()['categoryTitle'];
        _formData['description'] = widget.reqProduct.data()['description'];
        _formData['enabled'] = widget.reqProduct.data()['enabled'];
        _formData['images'] = widget.reqProduct.data()['images'];
        _formData['interested'] = widget.reqProduct.data()['interested'];
        _formData['price'] = widget.reqProduct.data()['price'].toString();
        _formData['promotion'] =
            widget.reqProduct.data()['promotion'].toString();
        _formData['rating'] = widget.reqProduct.data()['rating'];
        _formData['sizes'] = widget.reqProduct.data()['sizes'];
        _formData['subtitle'] = widget.reqProduct.data()['subtitle'];
        _formData['dateModified'] = widget.reqProduct.data()['dateModified'];
        // _formData['type'] = widget.reqProduct.data()['type'];
      } else {
        _formData['id'] = "";
        _formData['coin'] = 'R\$';
        _formData['companyTitle'] = widget.reqCompanyTitle;
        _formData['categoryTitle'] = widget.reqCategoryTitle;
        _formData['description'] = "";
        _formData['enabled'] = true;
        _formData['images'] = [];
        _formData['interested'] = [];
        _formData['price'] = "0.00";
        _formData['promotion'] = "0.00";
        _formData['rating'] = [];
        _formData['sizes'] = [];
        _formData['subtitle'] = "";
        _formData['title'] = "";
        // _formData['dateModified'] = "";
      }
    }
  }

  Future<void> _saveForm() async {
    var isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    }

    if (allImagesSelectedFile.length == 0) {
      showFlushbar(
          context, 'Atenção!', 'É necessário inserir ao menos uma imagem!');
      return;
    }

    _formKey.currentState.save();

    var productForm = ProductModel(
      id: _formData['id'],
      companyTitle: _formData['companyTitle'],
      categoryTitle: _formData['categoryTitle'],
      coin: _formData['coin'],
      description: _formData['description'],
      enabled: _formData['enabled'],
      images: [],
      interested: _formData['interested'],
      price: double.parse(_formData['price']),
      promotion: double.parse(_formData['promotion']),
      rating: _formData['rating'],
      sizes: _formData['sizes'],
      subtitle: _formData['subtitle'],
      title: _formData['title'],
      // dateModified: _formData['dateModified'],
      // type: _formData['type'],
    );

    setState(() {
      _deviceIsLoading = true;
    });
    // var widget.reqCompanyTitle = 'bwBiNTo7yOIUYehamSmD';

    Future productImagesUpdate(companyTitle, categoryTitle, productTitle,
        allImagesSelectedFile) async {
      for (int i = 0; i < allImagesSelectedFile.length; i++) {
        if (allImagesSelectedFile[i] is String) continue;

        var uploadTask = FirebaseStorage.instance
            .ref()
            .child(companyTitle)
            .child(categoryTitle)
            .child(productTitle)
            .child(DateTime.now().millisecondsSinceEpoch.toString())
            .putFile(allImagesSelectedFile[i]);
        await uploadTask.whenComplete(() async {
          var downloadUrl = await (await uploadTask).ref.getDownloadURL();
          var val = await decodeImageFromList(
              allImagesSelectedFile[i].readAsBytesSync());
          allImagesSelectedFile[i] = {
            'height': val.height,
            'url': downloadUrl,
            'width': val.width,
          };
        });
      }
    }

    try {
      if (_formData['id'] != "") {
        //   // await productImagesUpdate(widget.reqCompanyTitle, _formData['id'],
        //   //     allImagesSelectedFile); //productImagesUpdate(product.documentID);
        //   // print('6\n666\n666\n6666\n66666\n666666\n6666666\n66666666\n' +
        //   //     allImagesSelectedFile.toString());
        //   // await ProductsCollection()
        //   //     .productInsert(widget.reqCompanyTitle, productForm, allImagesSelectedFile);
        //   // // await product.reference.updateData(unsavedData);
      } else {
        // DocumentReference dr =
        await productImagesUpdate(
            productForm.companyTitle,
            productForm.categoryTitle,
            productForm.title,
            allImagesSelectedFile);
        var productRef = await FirebaseFirestore.instance
            // .collection('companies')
            // .doc(widget.reqCompanyTitle)
            // .collection('products')
            // .add({
            .collection('remottelyCompanies')
            .doc(productForm.companyTitle) //.doc('tapanapanterahs') //
            .collection('productCategories')
            .doc(productForm.categoryTitle) //.doc('Tabacos') //
            .collection('products')
            // .doc(productForm.title)
            // .set({
            .add({
          'categoryTitle': productForm.categoryTitle,
          'companyTitle': productForm.companyTitle,
          'coin': productForm.coin,
          'description': productForm.description,
          'enabled': productForm.enabled,
          'images': allImagesSelectedFile,
          'interested': [],
          'price': productForm.price,
          'promotion': productForm.promotion,
          'sizes': productForm.sizes,
          'rating': _formData['rating'],
          'subtitle': productForm.subtitle,
          'title': productForm.title,
          'quantity': productForm.quantity,
          'dateTime': DateTime.now().millisecondsSinceEpoch.toString(),
        });
        await FirebaseFirestore.instance
            .collection('remottelyProducts')
            .doc(productRef.id)
            .set({
          'productReference': productRef.path,
        });
      }
    } catch (error) {
      showFlushbar(context, 'Erro ao inserir item!', '$error');
      // showModalBottomSheet(
      //   context: context,
      //   builder: (_) => Container(
      //     height: 140,
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [Text('error: ' + error.toString())],
      //     ),
      //   ),
      // );
      // await showDialog<Null>(
      //   context: context,
      //   builder: (ctx) => AlertDialog(
      //     title: Text('Ocorreu um erro!'),
      //     content: Text('Ocorreu um erro pra salvar o produto!'),
      //     actions: <Widget>[
      //       FlatButton(
      //         child: Text('Fechar'),
      //         onPressed: () => Navigator.of(context).pop(),
      //       ),
      //     ],
      //   ),
      // );
    } finally {
      setState(() {
        _deviceIsLoading = false;
        allImagesSelectedFile = [];
        Navigator.of(context).pop();
        // allImagesSelectedFile = [];
        // _formData.clear();
      });
    }
  }

  Future _getImage() async {
    PickedFile selectedImage;
    switch (sourceImagem) {
      case "camera":
        selectedImage = await _picker.getImage(source: ImageSource.camera);
        break;
      case "gallery":
        selectedImage = await _picker.getImage(source: ImageSource.gallery);
        break;
    }

    File croppedImage = await ImageCropper.cropImage(
      sourcePath: selectedImage.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      maxWidth: 720,
      maxHeight: 720,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: Colors.transparent,
        toolbarTitle: "Imagem",
        backgroundColor: Colors.white,
        cropFrameColor: AppColors.astratosDarkGreyColor,
        toolbarWidgetColor: AppColors.astratosDarkGreyColor,
        activeControlsWidgetColor: AppColors.accentColor,
      ),
    );

    setState(() {
      allImagesSelectedFile.add(File(croppedImage.path));
    });
    if (allImagesSelectedFile.length >= 5) {
      Navigator.of(context).pop();
      FocusScope.of(context).requestFocus(_titleFocusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.astronautCanvasColor,
      body: _deviceIsLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Container(
                width: 500,
                child: CustomScrollView(
                  slivers: [
                    kIsWeb
                        ? SliverAppBar(
                            backgroundColor: Colors.transparent,
                            toolbarHeight: 20,
                            elevation: 0,
                            leading: Container(),
                            title: Container(),
                            actions: [],
                          )
                        : SliverToBoxAdapter(),
                    SliverAppBar(
                      floating: true,
                      snap: true,
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      toolbarHeight: 52,
                      expandedHeight: 52,
                      // leading: Container(),
                      // leadingWidth: 0,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: false,
                        titlePadding:
                            EdgeInsets.fromLTRB(52.0, 0.0, 12.0, 12.0),
                        title: Row(
                          children: [
                            // InkWell(
                            //   child: Icon(
                            //     Icons.arrow_back,
                            //     size: 20,
                            //     color: Colors.grey[800],
                            //   ),
                            //   onTap: () {
                            //     Navigator.of(context).pop();
                            //   },
                            // ),
                            // SizedBox(width: 16),
                            // SizedBox(width: 28),
                            Text(widget.reqCompanyTitle,
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800])),
                            Spacer(),
                            // InkWell(
                            //   onTap: () {
                            //     _saveForm();
                            //   },
                            //   child: Padding(
                            //     padding:
                            //         const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
                            //     child: NeumorphicIcon(
                            //       MyFlutterApp.floppy,
                            //       size: 32,
                            //       style: NeumorphicStyle(
                            //         depth: 1,
                            //         color: Colors.grey[800],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    // kIsWeb
                    //           ? SliverAppBar(
                    //               backgroundColor: Colors.transparent,
                    //               toolbarHeight: 20,
                    //               elevation: 0,
                    //               leading: Container(),
                    //               title: Container(),
                    //               actions: [],
                    //             )
                    //           : SliverToBoxAdapter(),
                    //       SliverAppBar(
                    //         floating: true,
                    //         snap: true,
                    //         backgroundColor: Colors.white,
                    //         elevation: 0.0,
                    //         toolbarHeight: 40,
                    //         expandedHeight: 40,
                    //         leading: Container(),
                    //         leadingWidth: 0,
                    //         flexibleSpace: FlexibleSpaceBar(
                    //           centerTitle: false,
                    //           titlePadding:
                    //               EdgeInsets.fromLTRB(14.0, 0.0, 12.0, 0.0),
                    //           title: Row(
                    //             children: [
                    //               Text(
                    //                   'tapanapanterahs', // snapshotProducts.hasData
                    //                   //     ? snapshotProducts.data.docs[0]
                    //                   //         ['companyTitle']
                    //                   //     : '',
                    //                   style: TextStyle(
                    //                       fontSize: 28,
                    //                       fontWeight: FontWeight.bold,
                    //                       color: Colors.grey[800])),
                    //               Spacer(),
                    //               InkWell(
                    //                 onTap: () {
                    //                   // toggleDrawer();
                    //                   Scaffold.of(context).openDrawer();
                    //                 },
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.fromLTRB(
                    //                       0.0, 6.0, 0.0, 0.0),
                    //                   child: Transform(
                    //                     alignment: Alignment.center,
                    //                     transform: Matrix4.rotationY(math.pi),
                    //                     child: Icon(Icons.menu),
                    //                     // child: NeumorphicIcon(
                    //                     //   MyFlutterApp.sort,
                    //                     //   size: 32,
                    //                     //   style: NeumorphicStyle(
                    //                     //     depth: 1,
                    //                     //     color: AppColors.textColor,
                    //                     //   ),
                    //                     // ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // allImagesSelectedFile is List<File> &&
                                allImagesSelectedFile.length != 0
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: kIsWeb
                                            ? 500
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                64,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              allImagesSelectedFile.length,
                                          itemBuilder: (context, index) {
                                            return Image.file(
                                              allImagesSelectedFile[index],
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  64,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      )
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: kIsWeb
                                            ? 500
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                64,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/background.png"),
                                                fit: BoxFit.cover)),
                                      ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  padding: const EdgeInsets.only(
                                    top: 8.0,
                                    left: 16.0,
                                    right: 16.0,
                                    bottom: 8.0,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          ElevatedButton(
                                            child: Text(
                                              allImagesSelectedFile.length >= 5
                                                  ? 'Limite de fotos atingido'
                                                  : 'Adicionar Foto',
                                              style: TextStyle(
                                                color: allImagesSelectedFile
                                                            .length >=
                                                        5
                                                    ? AppColors.blackColor
                                                    : AppColors.accentColor,
                                              ),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  if (states.contains(
                                                      MaterialState.pressed)) {
                                                    return allImagesSelectedFile
                                                                .length >=
                                                            5
                                                        ? Colors.grey
                                                        : Colors.deepOrange;
                                                  }
                                                  return allImagesSelectedFile
                                                              .length >=
                                                          5
                                                      ? Colors.grey
                                                      : Colors
                                                          .black; //Color(0xffDDDDDD); // Use the component's default.
                                                },
                                              ),
                                            ),
                                            onPressed:
                                                allImagesSelectedFile.length >=
                                                        5
                                                    ? () {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                _titleFocusNode);
                                                      }
                                                    : () {
                                                        // _uploadingImage
                                                        //     ? null
                                                        //     :
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: (_) =>
                                                              Container(
                                                            height: 100,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    SizedBox(
                                                                        width:
                                                                            26),
                                                                    Container(
                                                                      width: 50,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              // _deleteImage();
                                                                            },
                                                                            child:
                                                                                NeumorphicIcon(
                                                                              MyFlutterApp.trash_1,
                                                                              size: 40,
                                                                              style: NeumorphicStyle(
                                                                                depth: 1,
                                                                                color: AppColors.textColor,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                              'Todos'),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 46,
                                                                    ),
                                                                    Container(
                                                                      width: 50,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              sourceImagem = "camera";
                                                                              _getImage();
                                                                            },
                                                                            child:
                                                                                NeumorphicIcon(
                                                                              // MyFlutterApp2
                                                                              //     .camera,
                                                                              Icons.menu,
                                                                              size: 40,
                                                                              style: NeumorphicStyle(
                                                                                depth: 1,
                                                                                color: AppColors.textColor,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                              'Câmera'),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 46,
                                                                    ),
                                                                    Container(
                                                                      width: 50,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              sourceImagem = "gallery";
                                                                              _getImage();
                                                                            },
                                                                            child:
                                                                                NeumorphicIcon(
                                                                              // MyFlutterApp2
                                                                              //     .picture,
                                                                              Icons.menu,
                                                                              size: 40,
                                                                              style: NeumorphicStyle(
                                                                                depth: 1,
                                                                                color: AppColors.textColor,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                              'Galeria'),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        initialValue: _formData['title']
                                            .toString(), //'teste',
                                        textInputAction: TextInputAction.next,
                                        focusNode: _titleFocusNode,
                                        style: ProductStyles().inputTextStyle(),
                                        decoration: ProductStyles()
                                            .inputTextDecoration('Título',
                                                'Camiseta de Malha Azul...'),
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context)
                                              .requestFocus(_subtitleFocusNode);
                                        },
                                        validator: (value) {
                                          return ProductValidators()
                                              .validateTitle(value);
                                        },
                                        onSaved: (value) =>
                                            _formData['title'] = value,
                                      ),
                                      TextFormField(
                                        initialValue: _formData['subtitle']
                                            .toString(), //'teste',
                                        // autofocus: true,
                                        textInputAction: TextInputAction.next,
                                        focusNode: _subtitleFocusNode,
                                        style: ProductStyles().inputTextStyle(),
                                        decoration: ProductStyles()
                                            .inputTextDecoration('Subtítulo',
                                                'Lançamento/Ultima unidade/exclusivo...'),
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context)
                                              .requestFocus(_priceFocusNode);
                                        },
                                        onSaved: (value) =>
                                            _formData['subtitle'] = value,
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 8, 0),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                            layoutBehavior:
                                                ButtonBarLayoutBehavior
                                                    .constrained,
                                            minWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: DropdownButton<String>(
                                              value: _formData['coin'],
                                              icon: const Icon(
                                                  Icons.arrow_downward,
                                                  color: Colors.black),
                                              iconSize: 24,
                                              elevation: 0,
                                              dropdownColor: Colors.black,
                                              focusNode: _coinFocusNode,
                                              style: const TextStyle(
                                                  color: AppColors.accentColor),
                                              underline: Container(
                                                height: 0,
                                              ),
                                              items: <String>[
                                                'R\$',
                                                'US\$',
                                                '€'
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  _formData['coin'] = newValue;
                                                });
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _priceFocusNode);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(color: Colors.grey, thickness: 1),
                                      TextFormField(
                                        initialValue:
                                            double.parse(_formData['price'])
                                                .toStringAsFixed(2),
                                        // autofocus: true,
                                        focusNode: _priceFocusNode,
                                        textInputAction: TextInputAction.next,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        style: ProductStyles().inputTextStyle(),
                                        decoration: ProductStyles()
                                            .inputTextDecoration(
                                                'Preço atual',
                                                'Valor do produto/serviço'),
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context).requestFocus(
                                              _promotionFocusNode);
                                        },
                                        validator: (val) {
                                          return ProductValidators()
                                              .validateCurrency(val);
                                        },
                                        onSaved: (value) {
                                          // double val = double.tryParse(value);
                                          if (value != null) {
                                            _formData['price'] = value;
                                          } else {
                                            _formData['price'] = 0.00;
                                          }
                                        },
                                      ),
                                      TextFormField(
                                        initialValue:
                                            double.parse(_formData['price'])
                                                .toStringAsFixed(2),
                                        // autofocus: true,
                                        focusNode: _promotionFocusNode,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        style: ProductStyles().inputTextStyle(),
                                        decoration: ProductStyles()
                                            .inputTextDecoration(
                                                'Preço original / valor antigo, sem promoção',
                                                'Insira o valor sem o desconto aqui!'),
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context).requestFocus(
                                              _descriptionFocusNode);
                                        },
                                        // validator: (val) {
                                        //   return ProductValidators()
                                        //       .validateCurrency(val);
                                        // },
                                        onSaved: (value) {
                                          // double val = double.tryParse(value);
                                          if (value != '') {
                                            _formData['promotion'] = value;
                                          } else {
                                            _formData['promotion'] = 0.00;
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      // P e PP/36 a 44
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Tamanhos",
                                            style: TextStyle(
                                              fontSize: 12,
                                              letterSpacing: 2,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors
                                                  .astratosDarkGreyColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      // ProductSizes(
                                      //   context: context,
                                      //   initialValue: _formData[
                                      //       'sizes'], //snapshot.data["sizes"],
                                      //   onSaved: (value) =>
                                      //       _formData['sizes'] = value,
                                      //   validator: (s) {
                                      //     return null;
                                      //   },
                                      // ),
                                      Divider(color: Colors.grey, thickness: 1),
                                      TextFormField(
                                        initialValue: _formData['description'],
                                        // autofocus: true,
                                        minLines: 1,
                                        maxLines: 12,
                                        keyboardType: TextInputType.multiline,
                                        focusNode: _descriptionFocusNode,
                                        style: TextStyle(
                                          letterSpacing: 2,
                                          color: AppColors.accentColor,
                                        ),
                                        decoration: ProductStyles()
                                            .inputTextDecoration('Descrição',
                                                'Entregamos por todo DF, de segunda a sábado...'),
                                        validator: (value) {
                                          return null;
                                        },
                                        onSaved: (value) =>
                                            _formData['description'] = value,
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  if (states.contains(
                                                      MaterialState.pressed))
                                                    return Colors.blue;
                                                  return Colors
                                                      .blue; //Color(0xffDDDDDD); // Use the component's default.
                                                },
                                              ),
                                            ),
                                            onPressed: () {
                                              _saveForm();
                                            },
                                            child: Text('Salvar'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
