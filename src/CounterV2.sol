// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract CounterV2 {
    uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }

    function getNumber() public view returns(uint256) {
        return number;
    }

    function decrement() public {
        number--;
    }
}
