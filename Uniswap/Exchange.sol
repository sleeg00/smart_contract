// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;  // 0.8.20 이상 0.9.0 미만 컴파일러 허용

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenA is ERC20 {
    constructor() ERC20("TokenA", "A") {
        _mint(msg.sender, 50 * 10);
    }
}
contract Exchange is ERC20{
    address public tokenAddress;

    constructor() ERC20("Uniswap LP", "UNI-LP"){
        tokenAddress = tokenAddress;
    }

    function addLiquidity() public payable {
        uint etherAmount = msg.value;
        uint tokenAmount = etherAmount;

        TokenA tokenContract = TokenA(tokenAddress);
        tokenContract.transferFrom(msg.sender, address(this), tokenAmount);
        // TrasnferFrom : 내 토큰을 빼서 해당 컨트랙트에 전송한다.
        // 나의 토큰 빼기 balances[msg.sender] -= tokenAmount
        // 나의 토큰 CA에 넣기 (유동성 제공) balances[Exchange CA) += tokenAmount;
        _mint(msg.sender, etherAmount);
        // LP 토큰 발행
    }

    function removeLiquidity(uint lpTokenAmount) public {
        _burn(msg.sender, lpTokenAmount);
        uint etherAmount = lpTokenAmount;
        uint tokenAmount = lpTokenAmount;

        payable(msg.sender).transfer(etherAmount);
        // msg.sender(EOA)에게 이더 전송
        TokenA tokenContract = TokenA(tokenAddress);
        tokenContract.transfer(msg.sender, tokenAmount);
        // Transfer => 해당 컨트랙트의 value 만큼 잔액을 msg.sender에게 전송한다.
        // 유동성 풀 제거
        // 내 CA에 토큰 다시 넣기 blanaces[msg.sneder(EOA)] += tokenAmount;
        // 유동성 풀의 토큰 제거 balances[Exchange CA] -= tokenAmount;
    }

    // 사용자가 이더 -> 토큰으로 바꿈
    function etherToTokenSwap() public payable {
        uint etherAmount = msg.value;
        uint tokenAmount = etherAmount;
        // 1 : 1 비율로 고정
        TokenA tokenContract = TokenA(tokenAddress); // TokenA 컨트랙트 인스턴스 생성
        tokenContract.transfer(msg.sender, tokenAmount); // TokenA의 trasnfer 생성
        // trasfer
        // balances[Exchange CA] -= tokenAmount;
        // balances[msg.sender(EOA)] += tokenAmount;
    }

    // 사용자가 토큰 -> 이더로 바꿈
    function tokenToEtherSwap(uint tokenAmount) public{
        TokenA tokenContract = TokenA(tokenAddress);
        tokenContract.transferFrom(msg.sender, address(this), tokenAmount);
        //transferFrom
        // balances[Exchange CA] += tokenAmount;
        // balances[msg.sender(EOA)] -= tokenAmount;
        // allowances[msg.sender(EOA)][Exchange CA] -= amount;
        uint etherAmount = tokenAmount;
        payable(msg.sender).transfer(etherAmount);
    }
}