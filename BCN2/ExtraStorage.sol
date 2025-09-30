//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import './SimpleStorage.sol';

contract ExtraStorage is SimpleStorage {
  // +5
  // virtual override -> need to add virtual for overridable fncn and override to override the fncn

  function store(uint256 _favoriteNumber) public override {
    favoriteNumber = _favoriteNumber + 5;
  }
}