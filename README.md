# Simple reentrancy attack
> A simple reentrancy attack demonstration

There are two contracts in this repo:

1. `VulnerableContract` - To deposit and withdraw funds
2. `AttackerContract` - To perform reentrancy attack

The attack can be executed by changing

```solidity
function withdraw(uint256 amount) external {
  require(balances[msg.sender] >= amount, "Insufficient balance");
  (bool success, ) = msg.sender.call{value: amount}("");
  require(success, "failed call");
  balances[msg.sender] -= amount;
}
```

in `VulnerableContract` to:

```solidity
function withdraw(uint256 amount) external {
  require(balances[msg.sender] >= amount, "Insufficient balance");
  (bool success, ) = msg.sender.call{value: amount}("");
  require(success, "failed call");
  unchecked {
    balances[msg.sender] -= amount;
  }
}
```

### Executing the attack

Run

```
$ forge test -vvv
```

Verbosity level option is used to get execution traces.
