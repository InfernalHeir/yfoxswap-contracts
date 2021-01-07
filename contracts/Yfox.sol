// SPDX-Lisense-Identifier: MIT;

pragma solidity ^0.6.6;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Yfox is ERC20 {
    constructor(
      string memory _tokenName,
      string memory _tokenSymbol,
      uint _supply
      ) ERC20(_tokenName,_tokenSymbol) public {
          _mint(msg.sender,_supply);
      }
}