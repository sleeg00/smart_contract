// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;  // 0.8.20 이상 0.9.0 미만 컴파일러 허용

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Exchange {
    uint public number;
    constructor(uint _number) {
        number = _number;
    }
}

contract Factory {

    mapping(uint => address) public addressToExchanges;
    mapping(address => uint) public exchangeToNumber;

    function createExchange(uint number) public returns (address) {
        Exchange created = new Exchange(number);
        addressToExchanges[number] = address(created);
        exchangeToNumber[address(created)] = number;
        
        return address(created);
    }
}

