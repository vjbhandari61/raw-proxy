// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {CounterV1} from "../src/CounterV1.sol";
import {Proxy} from "../src/Proxy.sol";

contract DeployProxy is Script {
    function run() public returns(address){
        vm.startBroadcast();

        CounterV1 counter = new CounterV1();
        Proxy _proxy = new Proxy(address(counter));

        vm.stopBroadcast();
        return address(_proxy);
    }
}
