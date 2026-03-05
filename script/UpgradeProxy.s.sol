// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {CounterV2} from "../src/CounterV2.sol";
import {Proxy} from "../src/Proxy.sol";

contract UpgradeProxy is Script {
    function run(address proxyAddr) public returns(address){
        vm.startBroadcast();

        CounterV2 counterV2 = new CounterV2();
        Proxy(proxyAddr).upgradeTo(address(counterV2));

        vm.stopBroadcast();
        return address(proxyAddr);
    }
}
