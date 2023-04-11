// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

contract VulnerableContract {

  mapping(address => uint) public balances;

  function deposit() external payable {
    balances[msg.sender] += msg.value;
  }

  function withdraw(uint256 amount) external {
    require(balances[msg.sender] >= amount, "Insufficient balance");
    (bool success, ) = msg.sender.call{value: amount}("");
    require(success, "failed call");
    // Comment this line to enable reentrancy
    balances[msg.sender] -= amount;
    // Uncomment the following lines to enable reentrancy:
    //
    // unchecked {
    //   balances[msg.sender] -= amount;
    // }
  }

  function balanceOf(address owner) external view returns (uint) {
    return balances[owner];
  }
}
