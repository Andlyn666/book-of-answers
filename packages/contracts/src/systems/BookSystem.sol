// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import { System } from "@latticexyz/world/src/System.sol";
import { IRandcastSystem } from "../codegen/world/IRandcastSystem.sol";
import { SystemSwitch } from "@latticexyz/world-modules/src/utils/SystemSwitch.sol";
import { SYSTEM_ID, NAMESPACE_ID } from "../RandcastModule/constants.sol";
import { ROOT_NAMESPACE_ID } from "@latticexyz/world/src/constants.sol";
import { IWorld } from "../codegen/world/IWorld.sol";

contract BookSystem is System {

    function getRandomness(uint64 subId, bytes32 entityId, uint32 callbackGas) external {
        SystemSwitch.call(
            SYSTEM_ID, abi.encodeCall(IRandcastSystem.getRandomNumber, (subId, entityId, callbackGas))
        );
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness, bytes32 entityId) external {
        SystemSwitch.call(
            SYSTEM_ID,
            abi.encodeCall(IRandcastSystem._fulfillRandomness, (requestId, randomness, entityId))
        );
    }

    function getRandomnessByKey(bytes32 entityId) external returns (uint256 randomness) {
        return abi.decode(SystemSwitch.call(
            SYSTEM_ID, abi.encodeCall(IRandcastSystem.getRandomnessByEntityId, (entityId))
        ), (uint256));
    }
}