// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;  // 0.8.20 이상 0.9.0 미만 컴파일러 허용

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NTF is ERC721 {
    constructor() ERC721("My NFT", "My NFT") {
        _mint(msg.sender, 1);
        _mint(msg.sender, 9999);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://images.seonghyeon.com/nft/";
    }
}