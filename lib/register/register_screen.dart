
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/home/home_layout.dart';

import 'package:socialapp/register/register_cubit.dart';
import 'package:socialapp/register/register_states.dart';
import 'package:socialapp/shared/cache_helper.dart';
import 'package:socialapp/shared/components.dart';

class RegisterScreen extends StatelessWidget {
  var emailController= TextEditingController();
  var passController= TextEditingController();
  var nameController= TextEditingController();
  var phoneController= TextEditingController();
  var formKey=GlobalKey<FormState>();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
          listener: (context,state){
            if (state is RegisterCreateUserSuccessState){
              CacheHelper.saveData(
                  key: 'uId',
                  value: state.uId).then((value) {
                navigateTo(context, const HomeLayout());
              });
            }
          },
          builder: (context,state){
            var cubit =RegisterCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Register',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                          const SizedBox(height: 10,),
                          const Text('Register now to communicate with others',style: TextStyle(color: Colors.grey),),
                          const SizedBox(height:20),
                          TextFormField(
                            controller: nameController,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'This field can\'t be empty';
                              }else{
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                                labelText: 'name',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder()
                            ),
                          ),
                          const SizedBox(height:20),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'This field can\'t be empty';
                              }else{
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                                labelText: 'Email address',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder()
                            ),
                          ),
                          const SizedBox(height: 15,),
                          TextFormField(
                            controller: passController,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'This field can\'t be empty';
                              }else{
                                return null;
                              }
                            },
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                labelText: 'password',
                                prefixIcon: Icon(Icons.lock),
                                border: const OutlineInputBorder()
                            ),
                          ),
                          const SizedBox(height:20),
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'This field can\'t be empty';
                              }else{
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                                labelText: 'Phone number',
                                prefixIcon: Icon(Icons.email),
                                border: const OutlineInputBorder()
                            ),
                          ),
                          const SizedBox(height: 15,),
                          ConditionalBuilder(
                            condition:state is! RegisterLoadingState ,
                            builder: (context)=> Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    color: Colors.teal
                                ),
                                child: MaterialButton(onPressed: (){
                                  if(formKey.currentState!.validate()){
                                    cubit.userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passController.text,
                                        phone: phoneController.text);
                                  }
                                },child: const Text('Register',style: const TextStyle(color: Colors.white),),)),
                            fallback: (context)=>const Center(child: CircularProgressIndicator()),

                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );}
      ),
    );
  }
}
