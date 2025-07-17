import 'dart:io';
import 'dart:math';

void main() {
  // Create bank account
  String? name;
  String? accountNumber;
  String? accountType;
  String? initialBalance;
  int balance = 0;

  print(
    'Pls Enter the name, account number, account type , initial balance in order !',
  );
  name = stdin.readLineSync();
  accountNumber = stdin.readLineSync();
  accountType = stdin.readLineSync();
  initialBalance = stdin.readLineSync();

  if (!validateInputs(name, accountNumber, accountType, initialBalance)) {
    print('Something wrong in one of the inputs, please try again.');
    return;
  }

  balance = int.parse(initialBalance!);

  print('account has been created');
  showMenu();

  String userOption = stdin.readLineSync()!;
  handleMenuOption(userOption, name!, accountNumber!, accountType!, balance);
}

bool validateInputs(
  String? name,
  String? accountNumber,
  String? accountType,
  String? initialBalance,
) {
  bool allIsTrue = true;

  if (initialBalance != null && int.tryParse(initialBalance) != null) {
    print('Initial Balance has been accepted');
  } else {
    print('something wrong in the initial balance input');
    allIsTrue = false;
  }

  if (accountNumber != null && int.tryParse(accountNumber) != null) {
    print('account numbr has been accepted');
  } else {
    print('something wrong in the account number input');
    allIsTrue = false;
  }

  if (accountType != null && int.tryParse(accountType) == null) {
    if (accountType == 'checking' || accountType == 'savings') {
      print('account type has been accepted as $accountType');
    } else {
      print(
        'Reject invalid account types (only "savings" or "checking" allowed).',
      );
      allIsTrue = false;
    }
  } else {
    print(
      'Reject invalid account types (only "savings" or "checking" allowed).',
    );
    allIsTrue = false;
  }

  if (name != null && int.tryParse(name) == null) {
    print('name has been accepted');
  } else {
    print('something wrong in the name input');
    allIsTrue = false;
  }

  return allIsTrue;
}

void showMenu() {
  print('''Menu Options:

1. Deposit
2. Withdraw
3. Predict Future Balance (Profit Model)
4. View Account Summary
5. Exit''');
}

void handleMenuOption(
  String userOption,
  String name,
  String accountNumber,
  String accountType,
  int balance,
) {
  if (userOption == '1') {
    balance = deposit(balance);
    showMenu();
    String nextOption = stdin.readLineSync()!;
    handleMenuOption(nextOption, name, accountNumber, accountType, balance);
  } else if (userOption == '2') {
    balance = withdraw(balance);
    showMenu();
    String nextOption = stdin.readLineSync()!;
    handleMenuOption(nextOption, name, accountNumber, accountType, balance);
  } else if (userOption == '3') {
    predictFutureBalance(balance);
    showMenu();
    String nextOption = stdin.readLineSync()!;
    handleMenuOption(nextOption, name, accountNumber, accountType, balance);
  } else if (userOption == '4') {
    showAccountSummary(name, accountNumber, accountType, balance);
    showMenu();
    String nextOption = stdin.readLineSync()!;
    handleMenuOption(nextOption, name, accountNumber, accountType, balance);
  } else if (userOption == '5') {
    return;
  } else {
    print('Invalid option.');
    showMenu();
    String nextOption = stdin.readLineSync()!;
    handleMenuOption(nextOption, name, accountNumber, accountType, balance);
  }
}

int deposit(int balance) {
  print('Add a deposit:');
  String? depositInput = stdin.readLineSync();
  int? depositAmount = int.tryParse(depositInput ?? '');
  if (depositAmount == null || depositAmount < 0) {
    print('Reject negative amounts for deposits and withdrawals.');
    return balance;
  }
  return balance + depositAmount;
}

int withdraw(int balance) {
  print('Take the withdraw:');
  String? withdrawInput = stdin.readLineSync();
  int? withdrawAmount = int.tryParse(withdrawInput ?? '');
  if (withdrawAmount == null || withdrawAmount < 0) {
    print('Reject negative amounts for deposits and withdrawals.');
    return balance;
  }
  return balance - withdrawAmount;
}

void predictFutureBalance(int balance) {
  print('Enter annual interest rate (e.g., 0.05 for 5%):');
  String? rateInput = stdin.readLineSync();
  print('Enter number of years:');
  String? yearsInput = stdin.readLineSync();

  double? rate = double.tryParse(rateInput ?? '');
  int? years = int.tryParse(yearsInput ?? '');

  // Validation: Number of years and profit rate must be zero or positive
  if (rate != null && years != null && rate >= 0 && years >= 0) {
    double futureBalance = balance * (pow(1 + rate, years)).toDouble();
    print(
      'Predicted future balance after $years years: ${futureBalance.toStringAsFixed(2)}',
    );
  } else {
    print(
      'Invalid input: Number of years and profit rate must be zero or positive.',
    );
  }
}

void showAccountSummary(
  String name,
  String accountNumber,
  String accountType,
  int balance,
) {
  print('Account Summary:');
  print('Name: $name');
  print('Account Number: $accountNumber');
  print('Account Type: $accountType');
  print('Current Balance: $balance');
}
