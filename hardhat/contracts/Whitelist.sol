// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Whitelist {

    uint8 public maxAddresses;
    uint8 public addressesWhitelisted;
    mapping(address => bool) isWhiteListed;


    constructor(uint8 _maxAddresses) {
        maxAddresses = _maxAddresses;
    }

    function addAddressToWhitelist() public {
        require(!isWhiteListed[msg.sender], "sender already whitelisted");
        require(addressesWhitelisted < maxAddresses, "more addresses cannot be whitelisted");
        isWhiteListed[msg.sender] = true;
        addressesWhitelisted += 1;
    }
}

