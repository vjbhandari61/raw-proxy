// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

import {Proxy} from "../src/Proxy.sol";
import {CounterV1} from "../src/CounterV1.sol";
import {CounterV2} from "../src/CounterV2.sol";

contract DeployAndTest is Test {
    address owner = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    CounterV1 counterV1;
    CounterV2 counterV2;
    Proxy proxy;

    function _deploymentHelper() public {
        vm.startPrank(owner);

        counterV1 = new CounterV1();
        counterV2 = new CounterV2();
        proxy = new Proxy(address(counterV1));

        console.log(proxy.ADMIN());
        vm.stopPrank();
    }

    function _initializeHelperV1() public {
        CounterV1(address(proxy)).setNumber(20);
    }

    function _setContactHelper() public {
        CounterV1(address(proxy)).setContact("Vijay", 79023475322);
    }

    function _upgradeHelper() public {
        vm.prank(owner);
        proxy.upgradeTo(address(counterV2));
    }

    function test_CounterV1SetNumber() public {
        _deploymentHelper();
        _initializeHelperV1();

        assertEq(CounterV1(address(proxy)).number(), 20);
        assertEq(counterV1.number(), 0);
    }

    function test_CounterV1IncrementNumber() public {
        _deploymentHelper();
        _initializeHelperV1();

        CounterV1(address(proxy)).increment();
        assertEq(CounterV1(address(proxy)).number(), 21);
        assertEq(counterV1.number(), 0);
    }

    function test_CounterV2Decrement() public {
        _deploymentHelper();
        _initializeHelperV1();
        _upgradeHelper();
        
        CounterV2(address(proxy)).decrement();
        assertEq(CounterV2(address(proxy)).number(), 19);
        assertEq(counterV2.number(), 0);
    }

    function test_CounterV1SetContact() public {
        _deploymentHelper();
        _setContactHelper();

        CounterV1.Contact memory contact = CounterV1(address(proxy)).getContact();

        assertEq(contact.name, "Vijay");
        assertEq(contact.phone_number, 79023475322);
    }

    function test_CounterV2GetContact() public {
        _deploymentHelper();
        _setContactHelper();

        _upgradeHelper();

        CounterV2.Contact memory contact = CounterV2(address(proxy)).getContact();
        
        assertEq(contact.name, "Vijay");
        assertEq(contact.phone_number, 79023475322);
        assertEq(contact.active, false);
    }
}