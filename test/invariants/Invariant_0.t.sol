// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/MyContract2.sol";

contract IntroInvariantTest is Test {

    MyContract2 private target;

    function setUp() public {
        target = new MyContract2();
    }

    function invariant_flag_is_always_false() public view {
        
        assertEq(target.flag(), false);
    }
}
