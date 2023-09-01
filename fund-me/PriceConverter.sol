// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

library PriceConverter { // no state variables nor sending ether, all functions must be internal
    function getConversionRate(uint256 ethAmount, uint256 ethPrice) internal pure returns(uint256) {
        return ethPrice * ethAmount / 1e18;
    }
}