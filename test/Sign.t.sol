pragma solidity 0.8.20;

import "forge-std/Test.sol";

contract SignTest is Test {
 
    function testSignature() public pure{

        uint256 privateKeyAlice = 123;
        address aliceAddress = vm.addr(privateKeyAlice);
        uint256 privateKeyBob = 456;
        address bobAddress = vm.addr(privateKeyBob);
        bytes memory message;
        bytes32 messageHash;
        message="Hello";
        messageHash = keccak256(message);
        uint8 v;
        bytes32 r;
        bytes32 s;
 
        (v,r,s) = vm.sign(privateKeyAlice, messageHash);
        address signer = ecrecover(messageHash, v, r, s);
        assertEq(signer, aliceAddress);
        (v,r,s) = vm.sign(privateKeyBob, messageHash);
        signer = ecrecover(messageHash, v, r, s);
        assertTrue(signer != aliceAddress);
    }
}