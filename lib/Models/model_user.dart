class ModelUser{
  int amount;
  final String name;

  addAmount(int amount) {
    this.amount = this.amount + amount;
  }

  ModelUser(this.amount, this.name);
}