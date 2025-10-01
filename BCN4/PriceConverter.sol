//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// library can't have state variables and also can't send ethers
library PriceConverter { // all the functions inside the library need to be internal

  //function to convert eth to usd
  function getPrice() internal view returns (uint256) {
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

  function getVersion() internal view returns (uint256) {
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    return priceFeed.version();
  }

  function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
    uint256 ethPrice = getPrice();
    //3000-000000000000000000 = ETH/USD price
    //1_000000000000000000 ETH
    uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; // _36 / _18 == _18
    return ethAmountInUsd;
  }
}