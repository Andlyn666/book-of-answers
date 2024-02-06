// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { IMUDConsumer } from "./interfaces/IMUDConsumer.sol";
import { System } from "@latticexyz/world/src/System.sol";
import { TABLE_ID, SYSTEM_ID, MUD_CONSUMER_ADDRESS } from "./constants.sol";
import { Randcast, RandcastData } from "./tables/Randcast.sol";
// solhint-disable-next-line no-global-import

contract RandcastSystem is System {

    function getRandomNumber(uint64 subId, bytes32 entityId, uint32 callbackGas)
        external
        payable
    {
        callbackGas = estimateCallbackGas(callbackGas);
        uint256 msgValue = estimateRequestFee(callbackGas);
        IMUDConsumer(MUD_CONSUMER_ADDRESS).getRandomNumber{value: msgValue}(subId, entityId, address(this), callbackGas);
    }

    function _fulfillRandomness(bytes32 requestId, uint256 randomness, bytes32 entityId) external {
        Randcast.set(TABLE_ID, entityId, requestId, randomness);
    }

    function getRandomnessByEntityId(bytes32 entityId) external view returns (uint256 randomNumber) {
        return Randcast.getRandomness(TABLE_ID, entityId);
    }

    function estimateCallbackGas(uint32 callBackGas) public pure returns (uint32) {
        if (callBackGas < 90000) {
            return 120000;
        }
        return callBackGas + 30000;
    }

    function estimateRequestFee(uint32 callBackGas) public view returns (uint256) {
        return IMUDConsumer(MUD_CONSUMER_ADDRESS).estimateFee(0, callBackGas);
    }
}
