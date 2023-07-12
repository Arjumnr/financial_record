class ModelTransactions {
  int amount;
  final String name;
  final String note;
  final DateTime date;
  final String type;

  addAmount(int amount) {
    this.amount = this.amount + amount;
  }

  ModelTransactions(this.amount, this.note, this.date, this.type, this.name);
}
