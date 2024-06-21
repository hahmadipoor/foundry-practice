// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "../interfaces/IMyERC20.sol";

contract GaslessTokenTransfer {
    
    function send(address token, address sender, address receiver, uint256 amount, uint256 fee, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external {
        
        IMyERC20(token).permit(sender, address(this), amount + fee, deadline, v, r, s);
        IMyERC20(token).transferFrom(sender, receiver, amount);
        IMyERC20(token).transferFrom(sender, msg.sender, fee);
    }
}