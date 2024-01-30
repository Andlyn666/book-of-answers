// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { IMUDConsumer } from "./interfaces/IMUDConsumer.sol";
import { System } from "@latticexyz/world/src/System.sol";
import { TABLE_ID, SYSTEM_ID } from "./constants.sol";
import { Randcast, RandcastData } from "./tables/Randcast.sol";
// solhint-disable-next-line no-global-import

contract RandcastSystem is System {

    function getRandomNumber(uint64 subId, bytes32 entityId)
        external
        payable
    {
        address consumer = address(0x700b6A60ce7EaaEA56F065753d8dcB9653dbAD35);
        IMUDConsumer(consumer).getRandomNumber(subId, entityId, address(this));
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness, bytes32 entityId) external {
        Randcast.set(TABLE_ID, entityId, requestId, randomness);
    }

    function getRandomnessByEntityId(bytes32 entityId) external view returns (uint256 randomNumber) {
        return Randcast.getRandomness(TABLE_ID, entityId);
    }
}
