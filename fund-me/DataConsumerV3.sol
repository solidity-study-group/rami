// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "../chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract DataConsumerV3 {
    AggregatorV3Interface internal dataFeed;

    constructor(address _pair) {
        dataFeed = AggregatorV3Interface(
            _pair
        );
    }

    /**
     * Returns the latest answer.
     */
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
