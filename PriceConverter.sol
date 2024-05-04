// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    // function withdraw() public {}

    function getPrice () internal view returns (uint256){
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        ( , int256 price, , ,) = priceFeed.latestRoundData();
        // Price of ETH in terms of USD with 10 decimal places
        // Multiply by 1e10 to keep the 10 decimal places
        return uint256(price ) * 1e10;   
    }   

    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        // 1 ETH
        // 2000_000000000000000000
        // msg.value.getConversionRate()
        uint256 ethPrice = getPrice();
        // 100000000000000000 * 100000000000000000 = 10000000000000000000000000000000000
        // $2000 = 1 ETH
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function getVersion() internal view returns(uint256){
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}