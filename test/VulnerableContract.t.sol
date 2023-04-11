// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/VulnerableContract.sol";
import "../src/AttackerContract.sol";

contract VulnerableContractTest is Test {
    VulnerableContract public vulnerableContract;
    AttackerContract public attackerContract;

    function setUp() public {
        vulnerableContract = new VulnerableContract();
        attackerContract = new AttackerContract(address(vulnerableContract));
    }

    function testAttack() public {
      address alice = payable(makeAddr("alice"));
      address bob = payable(makeAddr("bob"));

      vm.deal(alice, 2 ether);
      vm.deal(bob, 2 ether);

      vm.prank(alice);
      vulnerableContract.deposit{value: 2 ether}();

      vm.prank(bob);
      vulnerableContract.deposit{value: 2 ether}();

      assertEq(address(vulnerableContract).balance, 4 ether);
      attackerContract.attack{value: 1 ether}();
      assertEq(address(vulnerableContract).balance, 0 ether);
      assertEq(address(attackerContract).balance, 5 ether);
    }
}

