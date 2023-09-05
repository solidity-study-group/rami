// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { DataConsumerV3 } from "./DataConsumerV3.sol";
import { PriceConverter } from "./PriceConverter.sol";


contract FundMe is DataConsumerV3 {
    // using PriceConverter for uint256; 
    address constant internal ETH_USD = 0x694AA1769357215DE4FAC081bf1f309aDC325306; // on sepolia

    constructor() DataConsumerV3(ETH_USD) {}

    uint256 public minUsd = 5e18;
    address[] public funders;
    mapping(address funder => uint amount) funderToAmount;

    function fund() public payable {
        require(PriceConverter.getConversionRate(getPrice(), msg.value) >= minUsd, "not enough ETH");
        funders.push(msg.sender);
        funderToAmount[msg.sender] += msg.value;
    }

    function getPrice() public view returns(uint) {
        (, int256 price,,,) = priceFeed.latestRoundData();
        return uint(price * 1e10);
    }

    function getVersion() public view returns(uint256) {
        return priceFeed.version();
    }

    function withdraw() public {
        // reseting, noticed check-effects interactions pattern
        uint length = funders.length;
        for(uint i; i<length;) { // gas-efficioont loop
            funderToAmount[funders[i]] = 0;
            unchecked { ++i; } 
        }

        funders = new address[](0); 
        
        // withdraw funds
        (bool success,) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "call failed");

    }   
}
