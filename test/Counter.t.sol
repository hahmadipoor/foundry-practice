// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Test, console, stdError} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    function testFailDec() public {
        counter.decrement();
    }

    function testDecUnderflow() public {
        vm.expectRevert(stdError.arithmeticError);
        counter.decrement();
    }
}
