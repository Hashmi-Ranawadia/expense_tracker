class ExpenseModel {
  final int id;
  final String category;
  final double amount;
  final String date;
  final String description;

  ExpenseModel({
    required this.id,
    required this.category,
    required this.amount,
    required this.date,
    required this.description,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> json) => ExpenseModel(
    id: json["id"],
    category: json['category'],
    amount: json["amount"],
    date: json["date"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "category": category,
    "amount": amount,
    "date": date,
    "description": description,
  };
}
