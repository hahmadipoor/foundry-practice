// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console.sol";
//import {ERC20} from "../src/ERC20.sol";
import "../src/Token.sol";
/*
source .env
forge script script/Token.s.sol:TokenScript --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvvv
*/

contract TokenScript is Script {
    function setUp() public {}

    function run() public {
        uint256 privateKey = vm.envUint("DEV_PRIVATE_KEY");
        address account = vm.addr(privateKey);

        console.log("Account", account);

        vm.startBroadcast(privateKey);
        Token token = new Token("Test Foundry", "TEST_FOUNDRY", 18);
        token.mint(account, 100);
        vm.stopBroadcast();
    }
}
