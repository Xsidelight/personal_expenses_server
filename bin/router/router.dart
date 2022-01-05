import 'dart:convert';
import 'dart:io';

import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

final router = Router()
  ..get('/expenses', _getExpenses)
  ..get('/expense/<id>', _getExpenseByID)
  ..post('/add-expense', _addExpense)
  ..delete('/delete-expense/<id>', _deleteExpense)
  ..put('/update-expense', _updateExpense);

final List allExpenses =
    json.decode(File('bin/data/expenses.json').readAsStringSync());

Response _getExpenses(Request request) {
  return Response.ok(json.encode(allExpenses),
      headers: {'Content-Type': 'application/json'});
}

Response _getExpenseByID(Request request, String id) {
  final parsedId = int.tryParse(id);
  final expense =
      allExpenses.firstWhere((expense) => expense['id'] == parsedId, orElse: () => null);

  if (expense != null) {
    return Response.ok(json.encode(expense),
        headers: {'Content-Type': 'application/json'});
  }
  return Response.notFound('Expense not found!');
}

Future<Response> _addExpense(Request request) async {
  final payload = await request.readAsString();
  allExpenses.add(json.decode(payload));
  return Response.ok(payload, headers: {'Content-Type': 'application/json'});
}

Response _deleteExpense(Request request, String id) {
  final parsedId = int.tryParse(id);
  allExpenses.removeWhere((expense) => expense['id'] == parsedId);
  return Response.ok('Expense Deleted');
}

Future<Response> _updateExpense(Request request) async {
  final payload = await request.readAsString();
  final expense = json.decode(payload);
  final parsedId = expense['id'];
  allExpenses[allExpenses.indexWhere((element) => element['id'] == parsedId)] = expense;
  return Response.ok('Expense Updated');
}
