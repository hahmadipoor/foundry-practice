// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import {Bit} from "../src/Bit.sol";

contract FuzzTest is Test {
    Bit public bit;

    function setUp() public {
        bit = new Bit();
    }

    function testMostSignificantBitManual() public view {
        assertEq(bit.mostSignificantBit(0), 0);
        assertEq(bit.mostSignificantBit(1), 0);
        assertEq(bit.mostSignificantBit(2), 1);
        assertEq(bit.mostSignificantBit(4), 2);
        assertEq(bit.mostSignificantBit(8), 3);
        assertEq(bit.mostSignificantBit(type(uint256).max), 255);
    }

    function testMostSignificantBitFuzz(uint256 x) public view {

        vm.assume(x>0);
        
        //vm.bound(x,1,10);

        uint256 i = bit.mostSignificantBit(x);
        assertEq(i, _mostSignificantBit(x));
    }

    function _mostSignificantBit(uint256 x) private pure returns (uint256) {
        uint256 i = 0;
        while ((x >>= 1) > 0) {
            i++;
        }
        return i;
    }
}