// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract DataConsumerV3 {
    AggregatorV3Interface internal dataFeed;

    address internal constant ETH_USD = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
    constructor() {
        dataFeed = AggregatorV3Interface(
            ETH_USD
        );
    }

    function getLatestData() public view returns (int) {
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }
}