//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FallbackExample {
  uint256 public result;

  receive() external payable {
    // This code will now automatically execute when the contract receives plain Ether
    result = 1;
  }


  //If This contract does NOT have a receive() function. this fallback will handle plain Ether transfers.
  // It will also handle calls to non-existent functions.
  fallback() external payable {
    result = 2;
  }
}

// ether is sent to contract

//           is msg.data empty?
//                /    \
//               yes   no
//               /       \
//            receive()?   fallback() 
//             /     \
//            yes    no
//            /        \
//          receive()   fallback()