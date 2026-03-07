// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract CounterV2 {
    uint256 public number;
    struct Contact {
        string name;
        uint256 phone_number;
        bool active;
    }
    mapping(address => Contact) private contacts;


    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function setContact(string memory name, uint256 phone_num) public {
        contacts[msg.sender] = Contact(name, phone_num, true);
    }

    function getContact() public view returns(Contact memory){
        return contacts[msg.sender];
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

