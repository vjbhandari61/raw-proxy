// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Proxy {
    uint256 public number;
    address private _implementation;
    address private admin;

    event Upgrade(address indexed impl, uint256 timestamp);

    modifier isAdmin(){
        require(msg.sender == admin, "Proxy: User must be ADMIN!");
        _;
    }

    constructor(address implementation) {
        _implementation = implementation;
        admin = msg.sender;
        
        emit Upgrade(implementation, block.timestamp);
    }

    function upgradeTo(address newImpl) external isAdmin {
        emit Upgrade(newImpl, block.timestamp);
        _implementation = newImpl;
    }

    function ADMIN() external view returns(address) {
        return admin;
    }

    fallback() external {
        address impl = _implementation;
        
        (bool success, bytes memory data) = impl.delegatecall(msg.data);
        require(success);
        
        assembly {
            return(add(data, 32), mload(data))
        }
    }
}
