// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract CounterV1 {
    uint256 public number;
    struct Contact {
        string name;
        uint256 phone_number;
    }
    mapping(address => Contact) private contacts;


    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function setContact(string memory name, uint256 phone_num) public {
        contacts[msg.sender] = Contact(name, phone_num);
    }

    function getContact() public view returns(Contact memory){
        return contacts[msg.sender];
    }


    function increment() public {
        number++;
    }
}
