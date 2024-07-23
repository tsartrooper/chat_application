import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_chat_app/widgets/UserImagePicker.dart';
import 'package:image_picker/image_picker.dart';


final _firebase = FirebaseAuth.instance;
final _imagePicker = ImagePicker();


class AuthScreen extends StatefulWidget{
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState(){
    return _AuthScreenState();
  }
}


class _AuthScreenState extends State<AuthScreen>{
  final _form = GlobalKey<FormState>();

  String _enteredEmail = " ";
  String _enteredPassword = " ";
  String _enteredUserName = " ";
  bool _isLogin = false;
  File? _selectedImage;
  bool _isAuthenticating = false;

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if(!isValid){
      return;
    }
    _form.currentState!.save();

    print(_enteredPassword+" "+_enteredEmail);
    try{
      setState(() {
        _isAuthenticating = true;
      });
      if(_isLogin){
        final userCredentials = await _firebase.signInWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);
      }
      else{
          final userCredentials = await _firebase.createUserWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);
          final storageRef = FirebaseStorage.instance
              .ref()
          .child('user_images')
          .child('${userCredentials.user!.uid}.jpg');

          await storageRef.putFile(_selectedImage!);
          final imageUrl = await storageRef.getDownloadURL();

          await FirebaseFirestore
              .instance.collection('users')
          .doc(userCredentials.user!.uid)
          .set({
            "username" : _enteredUserName,
            "email": _enteredEmail,
            "imageUrl": imageUrl,
          });

        }
    }
    on FirebaseAuthException catch (error){
      if(error.code == 'email-already-in-use'){

      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(error.message ?? 'Authentication failed')
          ));
    }
    setState(() {
      _isAuthenticating = false;
    });

  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Container(
              margin: const EdgeInsets.only(
                top: 30,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              width: 200,
              child: Image.asset('assets/image/chat.png'),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _form,
                    child:Column(
                      mainAxisSize: MainAxisSize.min,
                      children:[
                        if(!_isLogin)
                          UserImagePicker(onPickImage: (pickedImage){
                            _selectedImage = pickedImage;
                          }),
                        if(!_isLogin)
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'User Name'),
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value){
                              if(value == null || value.isEmpty || value.trim().length < 4){
                                return "Please enter a valid user name";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredUserName = value!;
                            },
                          ),

                          TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email Address'),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                          validator: (value){
                            if(value == null || value.isEmpty || !value.contains("@")){
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredEmail = value!;
                            },
                          ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Password'),
                          obscureText: true,
                          validator: (value) {
                            if(value == null || value.isEmpty || value.trim().length < 6){
                              return 'enter a valid password';
                            }
                            return null;
                          },
                          onSaved: (value){
                            _enteredPassword = value!;
                          },
                        ),
                        const SizedBox(height: 12),
                        if(_isAuthenticating)
                          const CircularProgressIndicator(),

                        if(!_isAuthenticating)
                          ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer
                          ),
                          onPressed: _submit,
                          child: Text(_isLogin ? 'Login' : 'Sign Up')
                          ),
                        if(!_isAuthenticating)
                          TextButton(
                            style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primaryContainer),
                              onPressed: (){
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(_isLogin
                                  ? 'Create an account'
                                  : 'I already have an account'),
                          ),
                    ]
                        ),
                    )
                  )

                )

            ),
          ]
        )
      )
    );
  }


}