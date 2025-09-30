//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

//both contract and wallet can hold fund , contract is nearly same to wallet
contract FundMe {

  uint256 public minimumUsd = 50 * 1e18;

  address[] public funders;
  mapping(address => uint256) public addressToAmountFunded;

  function fund() public payable {
    //Want to be able to set a minimum fund amount in USD
    // 1. How do we send ETH to this contract 
    require(getConversionRate(msg.value) >= minimumUsd, "Didn't send enough"); //msg is a global keyword, 1e18 = value of 1 eth in wei, //require is checker -> if first is true then continue otherwise revert : undo any action before and send back the remaining gas
    //initially we were using 1e18 instead of minimumUsd but now we are using this but we need some conversion 
    // its an external thing -> oracle problem , need solution -> decentralized oracle networks, chainlink is plug n play :)
     funders.push(msg.sender); //msg.sender -> sender of the transaction
     addressToAmountFunded[msg.sender] = msg.value;
  }

  //function to convert eth to usd
  function getPrice() public view returns (uint256) {
    //will be using chainlink price feed
    //ABI + Address
    //0x694AA1769357215DE4FAC081bf1f309aDC325306 -> ETH/USD address under sepolia testnet
    // for abi either we can create new file for interface, or can just copy content in this file or we can import directly from github like above
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    (, int256 price,,,) = priceFeed.latestRoundData();
    //ETH in terms of USD
    //3000.00000000 -> 8 decimal places
    return uint256(price*1e10); // to match the number of decimal places 
  }

  function getVersion() public view returns (uint256) {
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    return priceFeed.version();
  }

  function getConversionRate(uint256 ethAmount) public view returns (uint256) {
    uint256 ethPrice = getPrice();
    //3000-000000000000000000 = ETH/USD price
    //1_000000000000000000 ETH
    uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; // _36 / _18 == _18
    return ethAmountInUsd;
  }

  
  //function withdraw() {}
}