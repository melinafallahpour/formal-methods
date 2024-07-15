mtype = { deposit, withdraw, check_balance }
chan atm = [0] of { mtype, int }
int balance = 1000 // initial balance
active proctype ATM() {    mtype operation
    int amount
    do    :: atm ? deposit, amount ->
        balance = balance + amount        printf("Deposit successful: new balance = %d\n", balance)
    :: atm ? withdraw, amount ->
        if        :: (balance >= amount) ->
            balance = balance - amount            printf("Withdrawal successful: new balance = %d\n", balance)
        :: else ->            printf("Insufficient funds!\n")
        fi
    :: atm ? check_balance, _ ->        printf("Current balance: %d\n", balance)
    od}
active proctype User() {
    atm ! deposit, 500    atm ! check_balance, 0
    atm ! withdraw, 300
    atm ! check_balance, 0
    atm ! withdraw, 1500    atm ! check_balance, 0
}
