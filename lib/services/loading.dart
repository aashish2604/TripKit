import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height*0.09,
                width: height*0.09,
                child: CircularProgressIndicator(
                  color: Colors.orange,
                  strokeWidth: height*0.01,
                ),
              ),
              SizedBox(height: height*0.01),
              Text('Loading',style: TextStyle(fontSize: height*0.04),)
            ],
          ),
        ),
      ),
    );
  }
}
