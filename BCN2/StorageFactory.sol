//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import './SimpleStorage.sol';

contract StorageFactory {
  SimpleStorage[] public simpleStorageArray;

  function createSimpleStorageContract() public {
    //How does storage factory know what simple storage look like
    //either copy whole code of simple storage in this file or use import as above
    SimpleStorage simpleStorage = new SimpleStorage(); //assigning the address of the newly created storage to simpleStorage.
    simpleStorageArray.push(simpleStorage);
  }

  //a function for store function in simplestorage
  function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
    // 1. Get the contract instance (Address + ABI)
    SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];

    // 2. Call the function on that specific contract instance
    simpleStorage.store(_simpleStorageNumber);
  }

  function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) { 
    // 1. Get the contract instance (Address + ABI)
    SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];

    // 2. Call the function on that specific contract instance
    return simpleStorage.retrieve();

    //or inshort simpleStorageArray[_simpleStorageIndex].retrieve(); -> we can use this single line
  }
}