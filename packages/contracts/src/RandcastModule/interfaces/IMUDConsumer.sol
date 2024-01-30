// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface IMUDConsumer {
    function getRandomNumber(uint64 subId, bytes32 entityId, address callBackAddress) external;
}