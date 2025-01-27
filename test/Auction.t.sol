pragma solidity 0.8.20;

import "forge-std/Test.sol";
import {Auction} from "../src/Auction.sol";

contract AuctionTest is Test {
    Auction public auction;
    uint256 private startAt;

    function setUp() public {
        auction = new Auction();
        startAt = block.timestamp;
    }

    function testBidFailsBeforeStartTime() public {
        vm.expectRevert(bytes("not auction time"));
        auction.bid();
    }

    function testBid() public {
        vm.warp(startAt + 1 days);
        auction.bid();
    }

    function testBidFailsAfterEndTime() public {
        vm.expectRevert(bytes("not auction time"));
        vm.warp(startAt + 2 days);
        auction.bid();
    }

    function testTimestamp() public {
        uint256 t = block.timestamp;
        // set block.timestamp to t + 100
        skip(100);
        assertEq(block.timestamp, t + 100);

        // set block.timestamp to t + 100 - 100;
        rewind(100);
        assertEq(block.timestamp, t);
    }

    function testBlockNumber() public {
        uint256 b = block.number;
        // set block number to 11
        vm.roll(11);
        assertEq(block.number, 11);
    }
}