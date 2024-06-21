// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "forge-std/Test.sol";
import {MyContract} from "../src/MyContract.sol";

contract MyContractTest is Test {

    MyContract public myContract;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    function setUp() public {
        myContract = new MyContract();
    }

    function testEmitTransferEvent() public {
       
        vm.expectEmit(true, true, false, true);
        emit Transfer(address(this), address(123), 456);
        myContract.transfer(address(this), address(123), 456);
        vm.expectEmit(true, false, false, false);
        emit Transfer(address(this), address(0x1), 456);
        myContract.transfer(address(this), address(0x2), 222);
    }

    function testEmitManyTransferEvent() public {

        address[] memory to = new address[](2);
        to[0] = address(0x111);
        to[1] = address(0x222);
        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 1;
        amounts[1] = 2;

        for (uint256 i = 0; i < to.length; i++) {
            vm.expectEmit(true, true, false, true);
            emit Transfer(address(this), to[i], amounts[i]);
        }
        myContract.transferMany(address(this), to, amounts);
    }

    // function testFailFunc1() public view {
    //     myContract.func1();
    // }

    // function testFunc1Revert() public{
    //     vm.expectRevert();
    //     myContract.func1();
    // }

    // function testFunc2Revert() public {
    //     vm.expectRevert();
    //     myContract.func2();
    // }

    // function testFunc1RequireMessage() public {
    //     vm.expectRevert(bytes("there was an error"));
    //     myContract.func1();
    // }

    // function func2CustomError() public {
    //     vm.expectRevert(MyContract.NotAuthorized.selector);
    //     myContract.func2();
    // }

    // // Add label to assertions
    // function testErrorLabel() public {
    //     assertEq(uint256(1), uint256(1), "Label 1");
    //     assertEq(true, false, "Label 2");
    //     assertEq(uint256(1), uint256(1), "Label 3");
    // }
}





