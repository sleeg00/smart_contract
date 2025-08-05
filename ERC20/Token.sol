// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;  // 0.8.20 이상 0.9.0 미만 컴파일러 허용

contract MyFirstToken {
    string public name = "SeongHyeon Wrapped Ether";
    string public symbol = "shWETH";
    uint public decimals = 18;
    uint totalSupply = 0;

    mapping(address owner => uint amount) public balances;
    mapping(address owner => mapping(address spender => uint)) public allowances;

    event Transfer(address indexed _rom, address indexed to, uint256 _alue);
    event Approval(address indexed owner, address indexed spender, uint256 amount);

    function balanceOf(address owner) public view returns (uint amount) {
        return balances[owner];
    }
    
    function transfer(address to, uint amount) public returns (bool success) {
        address owner = msg.sender;
        require(balances[owner] >= amount);

        balances[owner] -= amount;
        balances[to] += amount;

        emit Transfer(owner, to, amount);
        return true;
    } 

    function transferFrom(address owner, address to, uint amount) public returns (bool success) {
        address spender = msg.sender;
        require(balances[owner] >= amount);
        require(allowances[owner][spender] >= amount);

        balances[owner] -= amount;
        balances[to] += amount;
        allowances[owner][spender] -= amount;
        
        emit Transfer(owner, to, amount);
        return true;
    }

    function approve(address spender, uint amount) public returns (bool sucess) {
        address owner = msg.sender;
        allowances[owner][spender] = amount;

        emit Approval(owner, spender, amount);
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint amount) {
        return allowances[owner][spender];
    }

    function deposit() public payable returns (bool success) {
        address owner = msg.sender;
        uint amount = msg.value;

        balances[owner] += amount;
        totalSupply += amount;

        emit Transfer(address(0), owner, amount);
        return true;
    }

    function withdraw(uint amount) public returns (bool success) {
        address owner = msg.sender;

        require(balances[owner] >= amount);
        balances[owner] -= amount;
        totalSupply -= amount;
        payable(owner).transfer(amount);

        emit Transfer(owner, address(0), amount);
        return true;
    }
}