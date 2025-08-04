// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;  // 0.8.20 이상 0.9.0 미만 컴파일러 허용

contract Grammar {
    // mapping(key => value)
    mapping(address => bool) blacklist;
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowances;
    // EOA Address -> Uniswap Exchange CA -> 1,000

    function setBlacklist(address _address) public {
        blacklist[_address] = true;
    }
}
