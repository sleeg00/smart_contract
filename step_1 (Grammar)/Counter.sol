// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;  // 0.8.20 이상 0.9.0 미만 컴파일러 허용

contract Ownable {
     address public owner;

     constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner!");
        _;
    }
}

contract Counter is Ownable{ // Contract 상속
    // 1. DATA
    //   * value : private
    //   * owner : public
    uint256 private value = 0;

    // 2. ACTIONS
    //   * getValue : public 
    //   * increment : public, payable
    //   * reset : public, owner만 호출 가능 
    //   * withdraw : public, owner만 호출 가능

    function getValue() public view returns(uint) {
        return value;
        // view, pure, constant, payable
    }

    function increment() public payable {
        value++;
    }

    function reset() public onlyOwner {
        emit Rest(msg.sender, value);
        value = 0;
    }
    
    function withdraw() public onlyOwner{
        payable(owner).transfer(address(this).balance);
    }

    event Rest(address owner, uint currentValue);

    // 3. EVENTS
    //   * Rest 기록

}
