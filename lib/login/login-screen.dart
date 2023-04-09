
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/shared/cache_helper.dart';


import '../home/home_layout.dart';
import '../register/register_screen.dart';
import '../shared/components.dart';
import 'login_cubit.dart';
import 'login_states.dart';

class LoginScreen extends StatelessWidget  {
  var emailController= TextEditingController();
  var passController= TextEditingController();
  var formKey=GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
          listener: (context,state){
            if(state is LoginErrorState){
              showToast(text: state.error, state: ToastStates.ERROR);
            }
            if(state is LoginSuccessState){
              CacheHelper.saveData(key: 'uId', value: state.uId)
                  .then((value){
                    navigateTo(context, const HomeLayout());
              });
            }
          },
          builder: (context,state){
            var cubit =LoginCubit.get(context);
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
                        Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                        SizedBox(height: 10,),
                        Text('Login to communicate with others',style: TextStyle(color: Colors.grey),),
                        SizedBox(height:20),
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
                          obscureText: cubit.isSeen? true:false,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    cubit.changeVisibility();
                                  },
                                  icon: Icon(cubit.suffix)),
                              labelText: 'password',
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder()
                          ),
                        ),
                        const SizedBox(height: 15,),
                        ConditionalBuilder(
                          condition:state is! LoginLoadingState ,
                          builder: (context)=> Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Colors.teal
                              ),
                              child: MaterialButton(onPressed: (){
                                if(formKey.currentState!.validate()){
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passController.text,
                                  );
                                }
                              },child: const Text('Login',style: TextStyle(color: Colors.white),),)),
                          fallback: (context)=>const Center(child: CircularProgressIndicator()),

                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account'),
                            const SizedBox(width: 10,),
                            TextButton(onPressed: (){
                              navigateTo(context,RegisterScreen());
                            }, child:  const Text('Register Now'))
                          ],)

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
