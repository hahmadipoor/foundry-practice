// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "solmate/tokens/ERC20.sol";

contract Token is ERC20("name", "symbol", 16) {}

import "@openzeppelin/contracts/access/Ownable.sol";

contract TestOZ is Ownable(address(this)) {}
