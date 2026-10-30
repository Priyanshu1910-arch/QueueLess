import 'package:flutter/material.dart';


class UiHelper {

  static Widget CustomTextField ({ required TextEditingController controller , required String hintText , IconData ? iconData , bool toHide = false,
      FocusNode? focusNode , TextInputType? keyboardType , TextInputAction? textInputAction , ValueChanged<String>? onSubmitted ,  VoidCallback? onTap,  }) {

    return Padding(padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 2),
     child: TextField(
       controller: controller,
       focusNode: focusNode,
       obscureText: toHide,
       keyboardType: keyboardType,
       textInputAction: textInputAction,
       onSubmitted: onSubmitted,
       onTap: onTap,

       decoration: InputDecoration(
         hintText: hintText  , suffixIcon: iconData != null ? Icon(iconData) : null , border: OutlineInputBorder(borderRadius:  BorderRadius.circular(25) ) ),
     ),
    );
  }

  static CustomButton( VoidCallback voidCallBack, String text, ) {
    return ElevatedButton( onPressed: voidCallBack,
      style: ElevatedButton.styleFrom( backgroundColor: Colors.blue,  foregroundColor: Colors.white, fixedSize: const Size(200, 50), ),
      child: Text(text),
    );
  }

  static Future<void> CustomAlertBox(
      BuildContext context,
      String text, {
        VoidCallback? onPressed,
      }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                if (onPressed != null) {
                  onPressed();
                }
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

 static Future<String?> chooseCurrency ( BuildContext context , String selectedCurrency ) async {
    String tempCurrency = selectedCurrency;
    return await showDialog(context: context, builder: (context) {
      return StatefulBuilder(builder:  (context , internalBuilder ){
        return AlertDialog(

          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text("Cancel")),
            TextButton(onPressed: (){
              Navigator.pop(context , tempCurrency);
            }, child: const Text("OK")),
          ],

          title: const Text("Choose your currency"),
          content: SizedBox(
            height: 300, width: double.maxFinite,

            child: ListView(
              children: [

                RadioGroup(
                groupValue: tempCurrency,
                    onChanged: (String? value) {
                  internalBuilder((){
                    tempCurrency = value!;
                  });

                },
                    child: Column(
                  children: const[
                    RadioListTile(value: "INR" , title: Text("INR - Indian Rupee"),),
                    RadioListTile(value: "USD" , title: Text("USD - US Dollar"),),
                    RadioListTile(value: "EUR" , title: Text("EUR - Euro"),),
                  ],
                )


                )

              ],
            ),
          ),
        );
      });

    });


 }

 static Widget TransactionTile ( IconData iconData , Color iconColor , String title , String amount  ){

    return ListTile(

      leading: CircleAvatar(
        backgroundColor: iconColor,
        child: Icon(iconData , color: Colors.white,),
      ),

      title: Text(title ,style:  TextStyle( color: Colors.white,)),

      trailing: Text(amount , style: TextStyle(fontSize: 18 , color: Colors.grey),),

    );


 }


  static Widget transactionTile1(
      IconData iconData,
      Color iconColor,
      String title,
      String amount,
      double percentage,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CircleAvatar(
            radius: 20,
            backgroundColor: iconColor,
            child: Icon(iconData, color: Colors.white),
          ),

          const SizedBox(width: 12),

          Expanded(
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),

                    Text(
                      amount,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 2),

                Row(
                  children: [

                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: percentage,
                          minHeight: 8,
                          backgroundColor: Colors.grey.shade700,
                          valueColor: AlwaysStoppedAnimation(iconColor),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Text(
                      "${(percentage * 100).toStringAsFixed(1)}%",
                      style: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



}


















