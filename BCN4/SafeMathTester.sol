//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

contract SafeMathTester {
  uint8 public bigNumber = 255; //checked , but before 8.0 it ran on the concept of unchecked

  function add() public {
    bigNumber = bigNumber + 1; //shows error , so we add unchecked keyword
    //unchecked {bigNumber = bigNumber + 1;} //gas efficient
  }
}