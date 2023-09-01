// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { DataConsumerV3 } from "./DataConsumerV3.sol";


contract FundMe is DataConsumerV3 {
    address constant internal ETH_USD = 0x694AA1769357215DE4FAC081bf1f309aDC325306; // on sepolia

    constructor() DataConsumerV3(ETH_USD) {}

    function fund() public payable {
        require(msg.value > 1e18, "not enough ETH");
    }

    function getPrice() public view returns(uint) {
        (, int256 price,,,) = dataFeed.latestRoundData();
        return uint(price * 1e10);
    }
}
