// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface IMUDConsumer {
    function getRandomNumber(uint64 subId, bytes32 entityId, address callBackAddress, uint32 callbackGas) external payable;
    function estimateFee(uint64 subId, uint32 callbackGasLimit) external view returns (uint256 requestFee);
}