// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract MyContract {

   event Transfer(address indexed from, address indexed to, uint256 amount);

    function transfer(address from, address to, uint256 amount) external {
        emit Transfer(from, to, amount);
    }

    function transferMany(address from, address[] calldata to, uint256[] calldata amounts) external {
        
        for (uint256 i = 0; i < to.length; i++) {
            emit Transfer(from, to[i], amounts[i]);
        }
    }

    // error NotAuthorized();

    // function func1() external pure {
    //     require((1==2), "there was an error");
    // }

    // function func2() external pure{
    //     revert NotAuthorized();
    // }
}