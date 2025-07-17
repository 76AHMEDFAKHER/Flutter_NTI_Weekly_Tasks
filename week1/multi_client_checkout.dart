import 'dart:io';

void main() {
  bool conitnueOp = true;
  bool mainop = true;
  while (mainop) {
    greeting();
    showMenu();
    String productNumber;
    String quantity;
    String name;
    String number;
    double subtotal = 0;
    while (conitnueOp) {
      print('Enter product number to add to cart (0 to finish):');
      productNumber = stdin.readLineSync()!;
      if (productNumber == '0') {
        conitnueOp = false;
        break;
      }

      print('Enter Quantity:');
      quantity = stdin.readLineSync()!;

      int? prodNum = int.tryParse(productNumber);
      int? qty = int.tryParse(quantity);

      int price = 0;
      if (prodNum != null && qty != null) {
        if (prodNum == 1)
          price = 100;
        else if (prodNum == 2)
          price = 50;
        else if (prodNum == 3)
          price = 300;
        else if (prodNum == 4)
          price = 20;
        else if (prodNum == 5)
          price = 150;
        else
          price = 0;

        subtotal += price * qty;
      }
    }
    print('Please enter your name:${name = stdin.readLineSync()!}');

    print('Please enter your phone : ');
    number = stdin.readLineSync()!;

    double taxes = calculateTax(subtotal);
    subtotal += taxes;
    calculateDiscount(subtotal, taxes);
    String delivery;
    print(
      'Do you want delivery? (yes/no): ${delivery = stdin.readLineSync()!}',
    );
    if (delivery == 'yes') {
      String dis;
      print('Enter delivery distance in km: ${dis = stdin.readLineSync()!}');
      double distance = double.parse(dis);

      print('Delivery fee: ${calculateDeliveryFee(distance)}');
      subtotal += calculateDeliveryFee(distance);
      goodBye(subtotal, name);
    } else {
      goodBye(subtotal, name);
    }
  }
}

void greeting() {
  print('Welcome to the store!');
}

void showMenu() {
  print(r'''Welcome to the store!
Available products:
1. Keyboard - $100
2. Mouse - $50
3. Monitor - $300
4. USB Cable - $20
5. Headphones - $150''');
}

double calculateTax(double subtotal) {
  double taxes = 0.13 * subtotal;

  return taxes;
}

void calculateDiscount(double subtotal, double taxes) {
  print('Subtotal :\$ $subtotal');
  print('Tax (13%): \$ $taxes');

  double discount = 0;
  print('Discount: \$ $discount');
  return;
}

double calculateDeliveryFee(double distance) {
  double fees = 0;
  while (distance > 0) {
    fees += 1.8;
    distance--;
  }
  return fees;
}

void goodBye(double total, String name) {
  print('-----------------------');
  print('Total amount to pay:$total');
  print('Thank you for shopping with us, $name!');
  print('-----------------------');
  print('Ready for next customer');
}
