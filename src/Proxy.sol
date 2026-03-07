// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Proxy {
    uint256 public number;
    struct Contact {
        string name;
        uint256 phone_number;
    }
    mapping(address => Contact) private contacts;

    address private _implementation;
    address private admin;


    event Upgrade(address indexed impl, uint256 timestamp);

    function _isAdmin() internal view {
        require(msg.sender == admin, "Proxy: User Must Be Admin!");
    }

    modifier isAdmin() {
        _isAdmin;
        _;
    }

    constructor(address implementation) {
        _implementation = implementation;
        admin = msg.sender;
        
        emit Upgrade(implementation, block.timestamp);
    }

    function upgradeTo(address newImpl) external isAdmin {
        _isAdmin();
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
