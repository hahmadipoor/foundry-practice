pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {Wallet} from "../src/Wallet.sol";

contract WalletTest is Test {

    Wallet public wallet;
    uint256 initialBalOfWallet;
    uint256 initialBalOfWalletTest;
    uint256 currentBalOfWallet;
    uint256 currentBalOfWalletTest;

    address person1Address = address(0x1);
    address person2Address = address(0x2);

    function setUp() public {

        initialBalOfWalletTest=address(this).balance;
        console.log("initial Bal Of WalletTest ",initialBalOfWalletTest);
        console.log("no wallet is created yet, so no balance of wallet");
        wallet = new Wallet{value: 1e18}();
        currentBalOfWalletTest=address(this).balance;
        initialBalOfWallet=address(wallet).balance;
        console.log("current Bal Of WalletTest ",initialBalOfWalletTest);
        console.log("initial Bal Of Wallet ",initialBalOfWalletTest);
    }

    function _send(uint256 amount) private {

        (bool ok,) = address(wallet).call{value: amount}("");
        require(ok, "send ETH failed");
    }

    function testSendEth() public {

        deal(person1Address, 123);
        vm.prank(person1Address);
        _send(123);

        hoax(person2Address, 456);
        _send(456);

        currentBalOfWallet=address(wallet).balance;
        assertEq(currentBalOfWallet, initialBalOfWallet + 123 + 456);
    }

    function testFailWithdrawNotOwner() public {

        vm.prank(person1Address);
        wallet.withdraw(1);
    }

     function testWithdrawNotOwner() public {

        vm.prank(address(1));
        vm.expectRevert(bytes("caller is not owner"));
        wallet.withdraw(1);
    }

    function testWithdraw() public {

        uint256 walletBalanceBefore = address(wallet).balance;
        uint256 walletTestBalanceBefore = address(this).balance;
        console.log(walletBalanceBefore);
        console.log(walletTestBalanceBefore);
        wallet.withdraw(1);
        uint256 walletBalanceAfter = address(wallet).balance;
        uint256 walletTestBalanceAfter = address(this).balance;
        console.log(walletBalanceAfter);
        console.log(walletTestBalanceAfter);
        assertEq(walletBalanceAfter, walletBalanceBefore - 1);
        assertEq(walletTestBalanceAfter, walletTestBalanceBefore + 1);
    }

    receive() external payable {
        
    }
}
