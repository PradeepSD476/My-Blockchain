//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import './PriceConverter.sol';

error NotOwner(); //custom errors

//both contract and wallet can hold fund , contract is nearly same to wallet
contract FundMe {

  using PriceConverter for uint256;

  uint256 public constant MINIMUM_USD = 50 * 1e18; //adding constant saves gas

  address[] public funders;
  mapping(address => uint256) public addressToAmountFunded;

  function fund() public payable {
    //Want to be able to set a minimum fund amount in USD
    // 1. How do we send ETH to this contract 
    require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough"); //msg is a global keyword, 1e18 = value of 1 eth in wei, //require is checker -> if first is true then continue otherwise revert : undo any action before and send back the remaining gas
    //initially we were using 1e18 instead of MINIMUM_USD but now we are using this but we need some conversion 
    // its an external thing -> oracle problem , need solution -> decentralized oracle networks, chainlink is plug n play :)
     funders.push(msg.sender); //msg.sender -> sender of the transaction
     addressToAmountFunded[msg.sender] += msg.value;
  }

  address public immutable i_owner;

  constructor() {
    i_owner = msg.sender;
  }

  function withdraw() public onlyOwner {
    //for loop, for(//start, //end, //step amount)
    // for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) 
    // {
    //   address funder = funders[funderIndex];
    //   addressToAmountFunded[funder] = 0;
    // }
    //reset the array
    funders = new address[](0);

    //actually withdraw the funds

    //transfer set at 2300 gas and in case it fails throws error, automatic reverts when fails
    //send set at 2300 gas and in case it fails returns bool
    //call forward all gas or set gas, returns bool
    // payable(msg.sender).transfer(address(this).balance); //payable(msg.sender) = payable address, msg.sender = address


    //send
    // bool sendSuccess = payable(msg.sender).send(address(this).balance);
    // require(sendSuccess, "Send failed");

    //call
    (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
    require(callSuccess, "Call failed");
    
  }

  //modifier
  modifier onlyOwner {
    if(msg.sender != i_owner){ //gas efficient
      revert NotOwner();
    }
    // require(msg.sender == i_owner, "sender is not owner"); //run rqr and then move to rest.
    _; //doing the rest of the code , move ahead
  }

  //what if someone send this contract ETH without calling the fund function

  receive() external payable {
    fund();
  }

  fallback() external payable {
    fund();
  }
}